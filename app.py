"""
LegendLua Key Dashboard
Uses PostgreSQL (via DATABASE_URL env var) for persistent key storage.
Falls back to keys.json if no DATABASE_URL is set (local dev).
"""

from flask import Flask, request, jsonify, render_template_string, Response
import json, os, re
from datetime import datetime, timedelta, timezone

app = Flask(__name__)
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
LUA_FILE   = os.path.join(SCRIPT_DIR, "LegendLuaHub.lua")
KEYS_FILE  = os.path.join(SCRIPT_DIR, "keys.json")  # local fallback only

DATABASE_URL = os.environ.get("DATABASE_URL", "")

TIERS = {
    "1day":    {"label": "1 Day",    "days": 1},
    "3day":    {"label": "3 Days",   "days": 3},
    "7day":    {"label": "7 Days",   "days": 7},
    "1month":  {"label": "1 Month",  "days": 30},
    "3month":  {"label": "3 Months", "days": 90},
    "6month":  {"label": "6 Months", "days": 180},
    "1year":   {"label": "1 Year",   "days": 365},
    "lifetime":{"label": "Lifetime", "days": None},
}

# ── Database setup ────────────────────────────────────────────────────────────
def get_db():
    """Get a PostgreSQL connection."""
    import psycopg2
    import psycopg2.extras
    url = DATABASE_URL
    # Railway gives postgres:// but psycopg2 needs postgresql://
    if url.startswith("postgres://"):
        url = url.replace("postgres://", "postgresql://", 1)
    conn = psycopg2.connect(url)
    return conn

def init_db():
    """Create the keys table if it doesn't exist."""
    if not DATABASE_URL:
        return
    try:
        conn = get_db()
        cur  = conn.cursor()
        cur.execute("""
            CREATE TABLE IF NOT EXISTS keys (
                key             TEXT PRIMARY KEY,
                tier            TEXT NOT NULL,
                tier_label      TEXT NOT NULL,
                days            INTEGER,
                activated       BOOLEAN DEFAULT FALSE,
                activated_at    TIMESTAMPTZ,
                expires_at      TIMESTAMPTZ,
                locked_user     TEXT,
                locked_user_at  TIMESTAMPTZ,
                created_at      TIMESTAMPTZ DEFAULT NOW()
            )
        """)
        conn.commit()
        cur.close()
        conn.close()
        print("[LegendLua] Database initialized.")
    except Exception as e:
        print(f"[LegendLua] DB init error: {e}")

# ── Key storage helpers ───────────────────────────────────────────────────────
def use_db():
    return bool(DATABASE_URL)

def load_key(key):
    """Load a single key's data. Returns dict or None."""
    if use_db():
        try:
            import psycopg2.extras
            conn = get_db()
            cur  = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
            cur.execute("SELECT * FROM keys WHERE key = %s", (key,))
            row = cur.fetchone()
            cur.close(); conn.close()
            if row is None:
                return None
            d = dict(row)
            # Normalize datetimes to ISO strings for compatibility
            for f in ("activated_at", "expires_at", "locked_user_at", "created_at"):
                if d.get(f) and hasattr(d[f], "isoformat"):
                    d[f] = d[f].isoformat()
            return d
        except Exception as e:
            print(f"[DB] load_key error: {e}")
            return None
    else:
        keys = _load_json()
        return keys.get(key)

def save_key(key, data):
    """Save/update a single key's data."""
    if use_db():
        try:
            conn = get_db()
            cur  = conn.cursor()
            cur.execute("""
                INSERT INTO keys
                    (key, tier, tier_label, days, activated, activated_at,
                     expires_at, locked_user, locked_user_at, created_at)
                VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
                ON CONFLICT (key) DO UPDATE SET
                    activated      = EXCLUDED.activated,
                    activated_at   = EXCLUDED.activated_at,
                    expires_at     = EXCLUDED.expires_at,
                    locked_user    = EXCLUDED.locked_user,
                    locked_user_at = EXCLUDED.locked_user_at
            """, (
                key,
                data.get("tier"),
                data.get("tier_label"),
                data.get("days"),
                data.get("activated", False),
                data.get("activated_at"),
                data.get("expires_at"),
                data.get("locked_user"),
                data.get("locked_user_at"),
                data.get("created_at", datetime.now(timezone.utc).isoformat()),
            ))
            conn.commit()
            cur.close(); conn.close()
        except Exception as e:
            print(f"[DB] save_key error: {e}")
    else:
        keys = _load_json()
        keys[key] = data
        _save_json(keys)

def key_exists(key):
    if use_db():
        return load_key(key) is not None
    return key in _load_json()

def _load_json():
    if os.path.exists(KEYS_FILE):
        with open(KEYS_FILE, "r") as f:
            return json.load(f)
    return {}

def _save_json(keys):
    with open(KEYS_FILE, "w") as f:
        json.dump(keys, f, indent=2)

# ── Expiry helper ─────────────────────────────────────────────────────────────
def check_expiry(key_data):
    if key_data["tier"] == "lifetime":
        return True, "Lifetime"
    if not key_data["activated"]:
        return True, "Not yet activated"
    expires_at = key_data["expires_at"]
    if not expires_at:
        return True, "Lifetime"
    if isinstance(expires_at, str):
        expires_at = datetime.fromisoformat(expires_at)
    if expires_at.tzinfo is None:
        expires_at = expires_at.replace(tzinfo=timezone.utc)
    now = datetime.now(timezone.utc)
    if now > expires_at:
        return False, "Expired"
    remaining = expires_at - now
    days  = remaining.days
    hours = remaining.seconds // 3600
    if days > 0:
        return True, f"{days}d {hours}h remaining"
    return True, f"{hours}h remaining"

def get_base_url():
    scheme = request.headers.get("X-Forwarded-Proto", "http")
    return f"{scheme}://{request.host}"

# ── Lua loader ────────────────────────────────────────────────────────────────
def build_lua(key, tier_label, expires_str):
    if not os.path.exists(LUA_FILE):
        return f'error("[LegendLua] Script file missing on server.")'
    with open(LUA_FILE, "r", encoding="utf-8") as f:
        lua = f.read()
    header = f"-- LegendLua Hub | Key: {key} | Tier: {tier_label} | Expires: {expires_str}\n"
    lua = lua.replace('local KEY = "KEY_HERE"', f'local KEY = "{key}"', 1)
    return header + lua

# ── HTML ──────────────────────────────────────────────────────────────────────
HTML = r"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1"/>
<title>LegendLua — Key Portal</title>
<link href="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&family=Orbitron:wght@600;900&display=swap" rel="stylesheet"/>
<style>
  :root{--bg:#05070d;--surface:#0c1220;--border:#1a2a4a;--accent:#00d4ff;--accent2:#7b2fff;--text:#c8e0ff;--dim:#3a5070;--success:#00ff9d;--danger:#ff4466;}
  *{margin:0;padding:0;box-sizing:border-box}
  body{background:var(--bg);color:var(--text);font-family:'Share Tech Mono',monospace;min-height:100vh;display:flex;flex-direction:column;align-items:center;padding:40px 20px;background-image:radial-gradient(ellipse 80% 50% at 50% -20%,rgba(0,212,255,.08),transparent),radial-gradient(ellipse 60% 40% at 80% 80%,rgba(123,47,255,.06),transparent);}
  body::before{content:'';position:fixed;inset:0;background:repeating-linear-gradient(0deg,transparent,transparent 2px,rgba(0,0,0,.08) 2px,rgba(0,0,0,.08) 4px);pointer-events:none;z-index:999;}
  .logo{font-family:'Orbitron',sans-serif;font-size:clamp(1.6rem,5vw,3rem);font-weight:900;letter-spacing:.12em;text-transform:uppercase;background:linear-gradient(135deg,var(--accent),var(--accent2));-webkit-background-clip:text;-webkit-text-fill-color:transparent;margin-bottom:6px;}
  .tagline{color:var(--dim);font-size:.8rem;letter-spacing:.25em;margin-bottom:48px}
  .card{background:var(--surface);border:1px solid var(--border);border-radius:12px;padding:36px;width:100%;max-width:680px;box-shadow:0 0 40px rgba(0,212,255,.04),0 0 80px rgba(0,0,0,.4);position:relative;overflow:hidden;margin-bottom:24px;}
  .card::before{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent,var(--accent),var(--accent2),transparent);}
  label{display:block;font-size:.7rem;letter-spacing:.2em;color:var(--dim);margin-bottom:8px;text-transform:uppercase}
  .input-row{display:flex;gap:12px;margin-bottom:20px}
  input[type=text]{flex:1;background:#080e1a;border:1px solid var(--border);color:var(--text);font-family:'Share Tech Mono',monospace;font-size:.95rem;padding:12px 16px;border-radius:8px;outline:none;transition:border-color .2s,box-shadow .2s;}
  input[type=text]:focus{border-color:var(--accent);box-shadow:0 0 0 2px rgba(0,212,255,.15)}
  input[type=text]::placeholder{color:var(--dim)}
  .btn{padding:12px 22px;border:none;border-radius:8px;cursor:pointer;font-family:'Orbitron',sans-serif;font-size:.75rem;font-weight:600;letter-spacing:.1em;text-transform:uppercase;transition:all .2s;white-space:nowrap;}
  .btn-primary{background:linear-gradient(135deg,var(--accent),var(--accent2));color:#fff}
  .btn-primary:hover{opacity:.85;transform:translateY(-1px);box-shadow:0 4px 20px rgba(0,212,255,.3)}
  #status{padding:14px 18px;border-radius:8px;font-size:.85rem;margin-bottom:20px;display:none;border-left:3px solid;}
  #status.success{background:rgba(0,255,157,.06);border-color:var(--success);color:var(--success)}
  #status.error{background:rgba(255,68,102,.06);border-color:var(--danger);color:var(--danger)}
  .key-info{background:#080e1a;border:1px solid var(--border);border-radius:8px;padding:16px 20px;margin-bottom:20px;display:none;}
  .key-info .row{display:flex;justify-content:space-between;font-size:.8rem;margin-bottom:6px}
  .key-info .row:last-child{margin-bottom:0}
  .key-info .label-k{color:var(--dim)}
  .key-info .value-k{color:var(--accent)}
  .key-info .value-k.ok{color:var(--success)}
  .key-info .value-k.ex{color:var(--danger)}
  .divider{border:none;border-top:1px solid var(--border);margin:24px 0}
  .loadstring-section{display:none}
  .ls-label{font-size:.7rem;letter-spacing:.2em;color:var(--dim);text-transform:uppercase;margin-bottom:10px;display:block;}
  .ls-desc{font-size:.78rem;color:var(--dim);margin-bottom:12px;line-height:1.6}
  .ls-desc span{color:var(--accent)}
  .loadstring-box{background:#030508;border:1px solid var(--border);border-radius:8px;padding:16px 20px;font-size:.82rem;line-height:1.6;color:#00ff9d;word-break:break-all;cursor:pointer;transition:border-color .2s;}
  .loadstring-box:hover{border-color:var(--accent)}
  .copy-hint{display:block;margin-top:8px;font-size:.65rem;color:var(--dim);letter-spacing:.1em;text-align:right;}
  .how-card{background:var(--surface);border:1px solid var(--border);border-radius:12px;padding:28px 36px;width:100%;max-width:680px;position:relative;overflow:hidden;}
  .how-card::before{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent,var(--accent2),var(--accent),transparent);}
  .how-title{font-family:'Orbitron',sans-serif;font-size:.8rem;letter-spacing:.2em;color:var(--accent);margin-bottom:20px;}
  .step{display:flex;gap:16px;margin-bottom:16px;align-items:flex-start}
  .step:last-child{margin-bottom:0}
  .step-num{min-width:28px;height:28px;border-radius:50%;background:linear-gradient(135deg,var(--accent),var(--accent2));display:flex;align-items:center;justify-content:center;font-family:'Orbitron',sans-serif;font-size:.7rem;font-weight:900;color:#fff;}
  .step-text{font-size:.82rem;color:var(--text);line-height:1.6;padding-top:4px}
  .step-text b{color:var(--accent)}
  .footer{margin-top:40px;font-size:.7rem;color:var(--dim);letter-spacing:.15em;text-align:center}
</style>
</head>
<body>
<div class="logo">LegendLua</div>
<div class="tagline">// SCRIPT PORTAL v1.0 //</div>
<div class="card">
  <label for="keyInput">Enter Your License Key</label>
  <div class="input-row">
    <input type="text" id="keyInput" placeholder="LegendLua-XXXX-XXXX-XXXX" autocomplete="off" spellcheck="false"/>
    <button class="btn btn-primary" onclick="submitKey()">Activate</button>
  </div>
  <div id="status"></div>
  <div class="key-info" id="keyInfo">
    <div class="row"><span class="label-k">KEY</span><span class="value-k" id="infoKey">-</span></div>
    <div class="row"><span class="label-k">TIER</span><span class="value-k" id="infoTier">-</span></div>
    <div class="row"><span class="label-k">STATUS</span><span class="value-k" id="infoStatus">-</span></div>
  </div>
  <div class="loadstring-section" id="loadstringSection">
    <hr class="divider"/>
    <span class="ls-label">// Your Executor Script</span>
    <p class="ls-desc">Copy the loadstring below and paste it into your executor.<br/>It will <span>automatically use your key</span> — no editing needed.</p>
    <div class="loadstring-box" id="loadstringBox" onclick="copyLoadstring()">
      <span id="loadstringText"></span>
      <span class="copy-hint" id="copyHint">click to copy</span>
    </div>
  </div>
</div>
<div class="how-card">
  <div class="how-title">// HOW TO USE</div>
  <div class="step"><div class="step-num">1</div><div class="step-text">Enter your <b>LegendLua key</b> above and click <b>Activate</b></div></div>
  <div class="step"><div class="step-num">2</div><div class="step-text">Copy the <b>loadstring</b> that appears — your key is already baked in</div></div>
  <div class="step"><div class="step-num">3</div><div class="step-text">Open Roblox and your executor, paste and <b>execute</b> the loadstring</div></div>
  <div class="step"><div class="step-num">4</div><div class="step-text">Hub loads automatically. Press <b>RightShift</b> to toggle the UI</div></div>
</div>
<div class="footer">LegendLua &copy; 2025 &mdash; All rights reserved</div>
<script>
async function submitKey() {
  const key = document.getElementById('keyInput').value.trim();
  if (!key) return showStatus('Please enter a key.', 'error');
  showStatus('Verifying key...', 'success');
  const res  = await fetch('/submit', {method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({key})});
  const data = await res.json();
  if (!data.success) {
    showStatus(data.message, 'error');
    document.getElementById('keyInfo').style.display = 'none';
    document.getElementById('loadstringSection').style.display = 'none';
    return;
  }
  showStatus('Key authenticated successfully.', 'success');
  document.getElementById('keyInfo').style.display = 'block';
  document.getElementById('infoKey').textContent   = data.key;
  document.getElementById('infoTier').textContent  = data.tier_label;
  const st = document.getElementById('infoStatus');
  st.textContent = data.expires_status;
  st.className   = 'value-k ' + (data.expires_status === 'Expired' ? 'ex' : 'ok');
  document.getElementById('loadstringSection').style.display = 'block';
  document.getElementById('loadstringText').textContent = data.loadstring;
}
function showStatus(msg, type) {
  const el = document.getElementById('status');
  el.textContent = msg; el.className = type; el.style.display = 'block';
}
function copyLoadstring() {
  navigator.clipboard.writeText(document.getElementById('loadstringText').textContent).then(() => {
    const hint = document.getElementById('copyHint');
    const box  = document.getElementById('loadstringBox');
    hint.textContent = 'Copied!'; box.style.borderColor = 'var(--success)';
    setTimeout(() => { hint.textContent = 'click to copy'; box.style.borderColor = ''; }, 2000);
  });
}
</script>
</body>
</html>
"""

# ── Routes ────────────────────────────────────────────────────────────────────
@app.route("/")
def index():
    return render_template_string(HTML)

@app.route("/submit", methods=["POST"])
def submit():
    data = request.get_json()
    key  = (data.get("key") or "").strip()

    key_data = load_key(key)
    if key_data is None:
        return jsonify({"success": False, "message": "Key not found. Please check and try again."})

    # Activate on first use — start the expiry timer NOW
    if not key_data["activated"]:
        key_data["activated"]    = True
        key_data["activated_at"] = datetime.now(timezone.utc).isoformat()
        if key_data["days"]:
            key_data["expires_at"] = (datetime.now(timezone.utc) + timedelta(days=key_data["days"])).isoformat()
        else:
            key_data["expires_at"] = None
        save_key(key, key_data)

    valid, expires_status = check_expiry(key_data)
    if not valid:
        return jsonify({"success": False, "message": f"This key has expired ({key_data['tier_label']} tier)."})

    base = get_base_url()
    loadstring = f'loadstring(game:HttpGet("{base}/hub?key={key}",true))()'

    return jsonify({
        "success": True, "key": key,
        "tier_label": key_data["tier_label"],
        "expires_status": expires_status,
        "loadstring": loadstring,
    })

@app.route("/hub", methods=["GET"])
def hub():
    key = request.args.get("key", "").strip()
    if not key:
        return Response('error("[LegendLua] No key provided.")', mimetype="text/plain", status=403)

    key_data = load_key(key)
    if key_data is None:
        return Response('error("[LegendLua] Invalid key. Get one at the LegendLua portal.")', mimetype="text/plain", status=403)

    valid, expires_status = check_expiry(key_data)
    if not valid:
        return Response(f'error("[LegendLua] Key expired ({key_data["tier_label"]} tier).")', mimetype="text/plain", status=403)

    expires_str = "Never (Lifetime)" if key_data["tier"] == "lifetime" else (key_data.get("expires_at") or "")[:10]
    return Response(build_lua(key, key_data["tier_label"], expires_str), mimetype="text/plain")

@app.route("/verify", methods=["POST"])
def verify():
    data    = request.get_json()
    key     = (data.get("key")    or "").strip()
    user_id = (data.get("userId") or "").strip()

    if not key or not user_id:
        return jsonify({"success": False, "message": "Missing key or userId."})

    key_data = load_key(key)
    if key_data is None:
        return jsonify({"success": False, "message": "Key not found. Get a valid key at the portal."})

    valid, expires_status = check_expiry(key_data)
    if not valid:
        return jsonify({"success": False, "message": f"Your key has expired ({key_data['tier_label']} tier)."})

    if not key_data.get("locked_user"):
        key_data["locked_user"]    = user_id
        key_data["locked_user_at"] = datetime.now(timezone.utc).isoformat()
        save_key(key, key_data)
    elif key_data["locked_user"] != user_id:
        return jsonify({"success": False, "message": "This key is already linked to another Roblox account."})

    return jsonify({"success": True, "tier": key_data["tier_label"], "expires": expires_status})


# ── Admin ─────────────────────────────────────────────────────────────────────
ADMIN_PASSWORD = "CertifiedAccessLOL"

ADMIN_HTML = r"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1"/>
<title>LegendLua — Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&family=Orbitron:wght@600;900&display=swap" rel="stylesheet"/>
<style>
  :root{--bg:#05070d;--surface:#0c1220;--border:#1a2a4a;--accent:#00d4ff;--accent2:#7b2fff;--text:#c8e0ff;--dim:#3a5070;--success:#00ff9d;--danger:#ff4466;--warn:#ffaa00;}
  *{margin:0;padding:0;box-sizing:border-box}
  body{background:var(--bg);color:var(--text);font-family:'Share Tech Mono',monospace;min-height:100vh;display:flex;flex-direction:column;align-items:center;padding:40px 20px;background-image:radial-gradient(ellipse 80% 50% at 50% -20%,rgba(0,212,255,.08),transparent);}
  body::before{content:'';position:fixed;inset:0;background:repeating-linear-gradient(0deg,transparent,transparent 2px,rgba(0,0,0,.08) 2px,rgba(0,0,0,.08) 4px);pointer-events:none;z-index:999;}
  .logo{font-family:'Orbitron',sans-serif;font-size:clamp(1.2rem,4vw,2rem);font-weight:900;letter-spacing:.12em;background:linear-gradient(135deg,var(--accent),var(--accent2));-webkit-background-clip:text;-webkit-text-fill-color:transparent;margin-bottom:4px;}
  .sub{color:var(--warn);font-size:.75rem;letter-spacing:.25em;margin-bottom:40px;}
  .card{background:var(--surface);border:1px solid var(--border);border-radius:12px;padding:32px;width:100%;max-width:560px;position:relative;overflow:hidden;margin-bottom:20px;}
  .card::before{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent,var(--warn),transparent);}
  .section-title{font-family:'Orbitron',sans-serif;font-size:.75rem;letter-spacing:.2em;color:var(--warn);margin-bottom:20px;}
  label{display:block;font-size:.68rem;letter-spacing:.18em;color:var(--dim);margin-bottom:6px;text-transform:uppercase;}
  input,select{width:100%;background:#080e1a;border:1px solid var(--border);color:var(--text);font-family:'Share Tech Mono',monospace;font-size:.9rem;padding:11px 14px;border-radius:8px;outline:none;margin-bottom:16px;transition:border-color .2s;}
  input:focus,select:focus{border-color:var(--accent);}
  select option{background:#080e1a;}
  .row{display:flex;gap:12px;align-items:flex-end;}
  .row .field{flex:1;}
  .row .field-sm{width:120px;}
  .btn{padding:11px 20px;border:none;border-radius:8px;cursor:pointer;font-family:'Orbitron',sans-serif;font-size:.72rem;font-weight:600;letter-spacing:.1em;text-transform:uppercase;transition:all .2s;white-space:nowrap;width:100%;}
  .btn-primary{background:linear-gradient(135deg,var(--accent),var(--accent2));color:#fff;}
  .btn-primary:hover{opacity:.85;transform:translateY(-1px);}
  .btn-danger{background:rgba(255,68,102,.15);border:1px solid var(--danger);color:var(--danger);}
  .btn-danger:hover{background:rgba(255,68,102,.25);}
  #genStatus{padding:12px 16px;border-radius:8px;font-size:.82rem;margin-top:12px;display:none;border-left:3px solid;}
  #genStatus.success{background:rgba(0,255,157,.06);border-color:var(--success);color:var(--success);}
  #genStatus.error{background:rgba(255,68,102,.06);border-color:var(--danger);color:var(--danger);}
  .keys-out{background:#030508;border:1px solid var(--border);border-radius:8px;padding:14px 16px;margin-top:12px;font-size:.8rem;line-height:1.9;color:#00ff9d;display:none;max-height:220px;overflow-y:auto;word-break:break-all;}
  .copy-all{margin-top:8px;width:100%;padding:8px;border:1px solid var(--border);border-radius:6px;background:transparent;color:var(--dim);font-family:'Share Tech Mono',monospace;font-size:.72rem;cursor:pointer;transition:all .2s;letter-spacing:.1em;}
  .copy-all:hover{border-color:var(--accent);color:var(--accent);}
  /* Key list table */
  .keys-table{width:100%;border-collapse:collapse;font-size:.75rem;margin-top:4px;}
  .keys-table th{color:var(--dim);text-align:left;padding:6px 10px;border-bottom:1px solid var(--border);font-weight:normal;letter-spacing:.1em;font-size:.68rem;}
  .keys-table td{padding:8px 10px;border-bottom:1px solid #0d1825;color:var(--text);vertical-align:middle;}
  .keys-table tr:last-child td{border-bottom:none;}
  .badge{padding:2px 8px;border-radius:4px;font-size:.68rem;font-family:'Orbitron',sans-serif;}
  .badge-ok{background:rgba(0,255,157,.1);color:var(--success);border:1px solid rgba(0,255,157,.2);}
  .badge-exp{background:rgba(255,68,102,.1);color:var(--danger);border:1px solid rgba(255,68,102,.2);}
  .badge-pending{background:rgba(0,212,255,.08);color:var(--accent);border:1px solid rgba(0,212,255,.15);}
  .badge-lifetime{background:rgba(123,47,255,.15);color:#b98fff;border:1px solid rgba(123,47,255,.3);}
  .del-btn{background:none;border:none;color:var(--danger);cursor:pointer;font-size:.8rem;padding:2px 6px;border-radius:4px;transition:background .15s;}
  .del-btn:hover{background:rgba(255,68,102,.15);}
  #keysLoading{color:var(--dim);font-size:.8rem;padding:20px 0;text-align:center;}
  .search-row{display:flex;gap:10px;margin-bottom:14px;}
  .search-row input{margin-bottom:0;flex:1;}
  /* Login screen */
  #loginScreen{width:100%;max-width:380px;}
  #mainScreen{width:100%;max-width:860px;display:none;flex-direction:column;align-items:center;}
  .login-card{background:var(--surface);border:1px solid var(--border);border-radius:12px;padding:36px;position:relative;overflow:hidden;}
  .login-card::before{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent,var(--warn),transparent);}
  #loginErr{color:var(--danger);font-size:.8rem;margin-top:8px;display:none;}
  .two-col{display:grid;grid-template-columns:1fr 1fr;gap:16px;width:100%;max-width:860px;}
  @media(max-width:640px){.two-col{grid-template-columns:1fr;}.row{flex-direction:column;}.row .field-sm{width:100%;}}
</style>
</head>
<body>

<!-- LOGIN SCREEN -->
<div id="loginScreen">
  <div class="logo" style="margin-bottom:4px">LegendLua</div>
  <div class="sub">// ADMIN PANEL //</div>
  <div class="login-card">
    <div class="section-title">Authentication Required</div>
    <label>Admin Password</label>
    <input type="password" id="pwInput" placeholder="Enter password" onkeydown="if(event.key==='Enter')doLogin()"/>
    <button class="btn btn-primary" onclick="doLogin()">Enter</button>
    <div id="loginErr">Incorrect password.</div>
  </div>
</div>

<!-- MAIN SCREEN -->
<div id="mainScreen">
  <div class="logo" style="margin-bottom:4px">LegendLua</div>
  <div class="sub">// ADMIN PANEL //</div>

  <div class="two-col">
    <!-- Generate keys card -->
    <div class="card">
      <div class="section-title">Generate Keys</div>
      <label>Tier</label>
      <select id="tierSelect">
        <option value="1day">1 Day</option>
        <option value="3day">3 Days</option>
        <option value="7day">7 Days</option>
        <option value="1month" selected>1 Month</option>
        <option value="3month">3 Months</option>
        <option value="6month">6 Months</option>
        <option value="1year">1 Year</option>
        <option value="lifetime">Lifetime</option>
      </select>
      <div class="row">
        <div class="field">
          <label>Amount</label>
          <input type="number" id="countInput" value="1" min="1" max="100" style="margin-bottom:0"/>
        </div>
        <div class="field-sm">
          <button class="btn btn-primary" onclick="generateKeys()" style="margin-bottom:0">Generate</button>
        </div>
      </div>
      <div id="genStatus"></div>
      <div class="keys-out" id="keysOut"></div>
      <button class="copy-all" id="copyAllBtn" onclick="copyAll()" style="display:none">Copy All Keys</button>
    </div>

    <!-- Stats card -->
    <div class="card">
      <div class="section-title">Overview</div>
      <div id="statsContent" style="color:var(--dim);font-size:.8rem;">Loading...</div>
    </div>
  </div>

  <!-- Keys list card -->
  <div class="card" style="max-width:860px;width:100%;margin-top:0;">
    <div class="section-title">All Keys</div>
    <div class="search-row">
      <input type="text" id="searchInput" placeholder="Search by key, tier, user..." oninput="filterKeys()" style="margin-bottom:0"/>
      <button class="btn btn-danger" style="width:auto;padding:11px 18px" onclick="loadKeys()">Refresh</button>
    </div>
    <div id="keysLoading">Loading keys...</div>
    <div id="keysTableWrap" style="display:none;overflow-x:auto;">
      <table class="keys-table">
        <thead><tr>
          <th>KEY</th><th>TIER</th><th>STATUS</th><th>EXPIRES</th><th>LOCKED TO</th><th></th>
        </tr></thead>
        <tbody id="keysBody"></tbody>
      </table>
    </div>
  </div>
</div>

<script>
let SESSION_PW = '';
let ALL_KEYS = [];

function doLogin() {
  const pw = document.getElementById('pwInput').value;
  fetch('/admin/login', {
    method: 'POST',
    headers: {'Content-Type':'application/json'},
    body: JSON.stringify({password: pw})
  }).then(r => r.json()).then(d => {
    if (d.success) {
      SESSION_PW = pw;
      document.getElementById('loginScreen').style.display = 'none';
      document.getElementById('mainScreen').style.display = 'flex';
      loadKeys();
      loadStats();
    } else {
      document.getElementById('loginErr').style.display = 'block';
    }
  });
}

function authHeaders() {
  return {'Content-Type':'application/json','X-Admin-Password': SESSION_PW};
}

async function generateKeys() {
  const tier  = document.getElementById('tierSelect').value;
  const count = parseInt(document.getElementById('countInput').value) || 1;
  const st    = document.getElementById('genStatus');
  const out   = document.getElementById('keysOut');
  const copyBtn = document.getElementById('copyAllBtn');

  st.textContent = 'Generating...';
  st.className = 'success'; st.style.display = 'block';
  out.style.display = 'none'; copyBtn.style.display = 'none';

  const res  = await fetch('/admin/generate', {
    method: 'POST',
    headers: authHeaders(),
    body: JSON.stringify({tier, count})
  });
  const data = await res.json();

  if (!data.success) {
    st.textContent = data.message; st.className = 'error';
    return;
  }

  st.textContent = `Generated ${data.keys.length} key(s) successfully.`;
  out.innerHTML  = data.keys.join('<br/>');
  out.style.display = 'block';
  copyBtn.style.display = 'block';
  loadKeys(); loadStats();
}

function copyAll() {
  const keys = document.getElementById('keysOut').innerText;
  navigator.clipboard.writeText(keys).then(() => {
    document.getElementById('copyAllBtn').textContent = 'Copied!';
    setTimeout(() => document.getElementById('copyAllBtn').textContent = 'Copy All Keys', 2000);
  });
}

async function loadStats() {
  const res  = await fetch('/admin/stats', {headers: authHeaders()});
  const data = await res.json();
  if (!data.success) return;
  const s = data.stats;
  document.getElementById('statsContent').innerHTML = `
    <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">
      <div style="background:#080e1a;border:1px solid var(--border);border-radius:8px;padding:14px;">
        <div style="color:var(--dim);font-size:.65rem;letter-spacing:.15em;margin-bottom:6px">TOTAL KEYS</div>
        <div style="font-family:'Orbitron',sans-serif;font-size:1.4rem;color:var(--accent)">${s.total}</div>
      </div>
      <div style="background:#080e1a;border:1px solid var(--border);border-radius:8px;padding:14px;">
        <div style="color:var(--dim);font-size:.65rem;letter-spacing:.15em;margin-bottom:6px">ACTIVE</div>
        <div style="font-family:'Orbitron',sans-serif;font-size:1.4rem;color:var(--success)">${s.active}</div>
      </div>
      <div style="background:#080e1a;border:1px solid var(--border);border-radius:8px;padding:14px;">
        <div style="color:var(--dim);font-size:.65rem;letter-spacing:.15em;margin-bottom:6px">UNUSED</div>
        <div style="font-family:'Orbitron',sans-serif;font-size:1.4rem;color:var(--accent2)">${s.unused}</div>
      </div>
      <div style="background:#080e1a;border:1px solid var(--border);border-radius:8px;padding:14px;">
        <div style="color:var(--dim);font-size:.65rem;letter-spacing:.15em;margin-bottom:6px">EXPIRED</div>
        <div style="font-family:'Orbitron',sans-serif;font-size:1.4rem;color:var(--danger)">${s.expired}</div>
      </div>
    </div>`;
}

async function loadKeys() {
  document.getElementById('keysLoading').style.display = 'block';
  document.getElementById('keysTableWrap').style.display = 'none';
  const res  = await fetch('/admin/keys', {headers: authHeaders()});
  const data = await res.json();
  if (!data.success) { document.getElementById('keysLoading').textContent = 'Failed to load.'; return; }
  ALL_KEYS = data.keys;
  renderKeys(ALL_KEYS);
}

function renderKeys(keys) {
  const tbody = document.getElementById('keysBody');
  tbody.innerHTML = '';
  keys.forEach(k => {
    const statusBadge = k.status === 'Active'   ? `<span class="badge badge-ok">Active</span>`
                      : k.status === 'Expired'  ? `<span class="badge badge-exp">Expired</span>`
                      : k.status === 'Lifetime' ? `<span class="badge badge-lifetime">Lifetime</span>`
                      :                           `<span class="badge badge-pending">Unused</span>`;
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td style="font-size:.72rem;color:#5a9abf">${k.key}</td>
      <td>${k.tier_label}</td>
      <td>${statusBadge}</td>
      <td style="color:var(--dim);font-size:.72rem">${k.expires || '-'}</td>
      <td style="color:var(--dim);font-size:.72rem;max-width:120px;overflow:hidden;text-overflow:ellipsis">${k.locked_user || '-'}</td>
      <td><button class="del-btn" onclick="deleteKey('${k.key}')">✕</button></td>`;
    tbody.appendChild(tr);
  });
  document.getElementById('keysLoading').style.display = 'none';
  document.getElementById('keysTableWrap').style.display = 'block';
}

function filterKeys() {
  const q = document.getElementById('searchInput').value.toLowerCase();
  if (!q) { renderKeys(ALL_KEYS); return; }
  renderKeys(ALL_KEYS.filter(k =>
    k.key.toLowerCase().includes(q) ||
    k.tier_label.toLowerCase().includes(q) ||
    (k.locked_user||'').toLowerCase().includes(q) ||
    k.status.toLowerCase().includes(q)
  ));
}

async function deleteKey(key) {
  if (!confirm(`Delete key ${key}?`)) return;
  const res  = await fetch('/admin/delete', {
    method: 'POST', headers: authHeaders(),
    body: JSON.stringify({key})
  });
  const data = await res.json();
  if (data.success) { loadKeys(); loadStats(); }
  else alert(data.message);
}
</script>
</body>
</html>
"""

def check_admin(req):
    pw = req.headers.get("X-Admin-Password") or (req.get_json(silent=True) or {}).get("password", "")
    return pw == ADMIN_PASSWORD

def admin_generate_key():
    import random, string
    def seg(): return ''.join(random.choices(string.ascii_uppercase + string.digits, k=4))
    return f"LegendLua-{seg()}-{seg()}-{seg()}"

@app.route("/admin")
def admin_page():
    return render_template_string(ADMIN_HTML)

@app.route("/admin/login", methods=["POST"])
def admin_login():
    data = request.get_json()
    if (data.get("password") or "") == ADMIN_PASSWORD:
        return jsonify({"success": True})
    return jsonify({"success": False})

@app.route("/admin/generate", methods=["POST"])
def admin_generate():
    if not check_admin(request):
        return jsonify({"success": False, "message": "Unauthorized."}), 401

    data  = request.get_json()
    tier  = data.get("tier", "1month")
    count = min(int(data.get("count", 1)), 100)

    if tier not in TIERS:
        return jsonify({"success": False, "message": "Invalid tier."})

    tier_label = TIERS[tier]["label"]
    days       = TIERS[tier]["days"]
    new_keys   = []

    for _ in range(count):
        key = admin_generate_key()
        # Make sure it doesn't already exist
        attempts = 0
        while key_exists(key) and attempts < 20:
            key = admin_generate_key()
            attempts += 1

        key_data = {
            "tier": tier, "tier_label": tier_label, "days": days,
            "activated": False, "activated_at": None,
            "expires_at": None, "locked_user": None, "locked_user_at": None,
            "created_at": datetime.now(timezone.utc).isoformat()
        }
        save_key(key, key_data)
        new_keys.append(key)

    return jsonify({"success": True, "keys": new_keys, "tier": tier_label})

@app.route("/admin/keys", methods=["GET"])
def admin_list_keys():
    if not check_admin(request):
        return jsonify({"success": False, "message": "Unauthorized."}), 401

    rows = []
    if use_db():
        try:
            import psycopg2.extras
            conn = get_db()
            cur  = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
            cur.execute("SELECT * FROM keys ORDER BY created_at DESC")
            raw = cur.fetchall()
            cur.close(); conn.close()
            for r in raw:
                r = dict(r)
                for f in ("activated_at","expires_at","locked_user_at","created_at"):
                    if r.get(f) and hasattr(r[f], "isoformat"):
                        r[f] = r[f].isoformat()
                rows.append(r)
        except Exception as e:
            return jsonify({"success": False, "message": str(e)})
    else:
        keys = _load_json()
        for k, v in keys.items():
            v["key"] = k
            rows.append(v)

    # Build response list with status
    result = []
    now = datetime.now(timezone.utc)
    for r in rows:
        if r.get("tier") == "lifetime":
            status  = "Lifetime"
            expires = "Never"
        elif not r.get("activated"):
            status  = "Unused"
            expires = None
        else:
            exp = r.get("expires_at")
            if exp:
                if isinstance(exp, str):
                    exp = datetime.fromisoformat(exp)
                if exp.tzinfo is None:
                    exp = exp.replace(tzinfo=timezone.utc)
                status  = "Expired" if now > exp else "Active"
                expires = exp.strftime("%Y-%m-%d")
            else:
                status  = "Active"
                expires = None

        result.append({
            "key":         r.get("key",""),
            "tier_label":  r.get("tier_label",""),
            "status":      status,
            "expires":     expires,
            "locked_user": r.get("locked_user"),
        })

    return jsonify({"success": True, "keys": result})

@app.route("/admin/stats", methods=["GET"])
def admin_stats():
    if not check_admin(request):
        return jsonify({"success": False, "message": "Unauthorized."}), 401

    now = datetime.now(timezone.utc)
    total = active = unused = expired = 0

    if use_db():
        try:
            conn = get_db()
            cur  = conn.cursor()
            cur.execute("SELECT COUNT(*) FROM keys"); total = cur.fetchone()[0]
            cur.execute("SELECT COUNT(*) FROM keys WHERE activated = FALSE"); unused = cur.fetchone()[0]
            cur.execute("SELECT COUNT(*) FROM keys WHERE tier = 'lifetime'"); lifetime = cur.fetchone()[0]
            cur.execute("SELECT COUNT(*) FROM keys WHERE activated = TRUE AND tier != 'lifetime' AND expires_at > NOW()"); active = cur.fetchone()[0]
            active += lifetime
            expired = total - unused - active
            cur.close(); conn.close()
        except Exception as e:
            return jsonify({"success": False, "message": str(e)})
    else:
        keys = _load_json()
        total = len(keys)
        for v in keys.values():
            if not v.get("activated"):
                unused += 1
            elif v.get("tier") == "lifetime":
                active += 1
            else:
                exp = v.get("expires_at")
                if exp:
                    exp_dt = datetime.fromisoformat(exp)
                    if exp_dt.tzinfo is None: exp_dt = exp_dt.replace(tzinfo=timezone.utc)
                    if now > exp_dt: expired += 1
                    else: active += 1

    return jsonify({"success": True, "stats": {
        "total": total, "active": active, "unused": unused, "expired": max(0,expired)
    }})

@app.route("/admin/delete", methods=["POST"])
def admin_delete():
    if not check_admin(request):
        return jsonify({"success": False, "message": "Unauthorized."}), 401

    key = (request.get_json().get("key") or "").strip()
    if not key:
        return jsonify({"success": False, "message": "No key provided."})

    if use_db():
        try:
            conn = get_db()
            cur  = conn.cursor()
            cur.execute("DELETE FROM keys WHERE key = %s", (key,))
            conn.commit(); cur.close(); conn.close()
        except Exception as e:
            return jsonify({"success": False, "message": str(e)})
    else:
        keys = _load_json()
        if key in keys:
            del keys[key]
            _save_json(keys)

    return jsonify({"success": True})


# ── Startup ───────────────────────────────────────────────────────────────────
with app.app_context():
    init_db()

if __name__ == "__main__":
    print("=== LegendLua Key Portal ===")
    mode = "PostgreSQL" if DATABASE_URL else "local keys.json"
    print(f"Storage mode: {mode}")
    print("Running at http://localhost:5000")
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
