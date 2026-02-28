"""
LegendLua Key Dashboard
Run: pip install flask && python app.py
"""

from flask import Flask, request, jsonify, render_template_string, Response
import json
import os
from datetime import datetime, timedelta, timezone

app = Flask(__name__)
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
KEYS_FILE   = os.path.join(SCRIPT_DIR, "keys.json")
LUA_FILE    = os.path.join(SCRIPT_DIR, "LegendLuaHub.lua")

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

# ── Helpers ───────────────────────────────────────────────────────────────────
def load_keys():
    if os.path.exists(KEYS_FILE):
        with open(KEYS_FILE, "r") as f:
            return json.load(f)
    return {}

def save_keys(keys):
    with open(KEYS_FILE, "w") as f:
        json.dump(keys, f, indent=2)

def check_expiry(key_data):
    if key_data["tier"] == "lifetime":
        return True, "Lifetime"
    if not key_data["activated"]:
        return True, "Not yet activated"
    expires_at = datetime.fromisoformat(key_data["expires_at"])
    now = datetime.now(timezone.utc)
    if expires_at.tzinfo is None:
        expires_at = expires_at.replace(tzinfo=timezone.utc)
    if now > expires_at:
        return False, "Expired"
    remaining = expires_at - now
    days  = remaining.days
    hours = remaining.seconds // 3600
    if days > 0:
        return True, f"{days}d {hours}h remaining"
    return True, f"{hours}h remaining"

def get_base_url():
    if request.headers.get("X-Forwarded-Proto"):
        scheme = request.headers["X-Forwarded-Proto"]
    else:
        scheme = "http"
    return f"{scheme}://{request.host}"


HTML = r"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1"/>
<title>LegendLua — Key Portal</title>
<link href="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&family=Orbitron:wght@600;900&display=swap" rel="stylesheet"/>
<style>
  :root{
    --bg:#05070d;--surface:#0c1220;--border:#1a2a4a;
    --accent:#00d4ff;--accent2:#7b2fff;--text:#c8e0ff;
    --dim:#3a5070;--success:#00ff9d;--danger:#ff4466;
  }
  *{margin:0;padding:0;box-sizing:border-box}
  body{
    background:var(--bg);color:var(--text);
    font-family:'Share Tech Mono',monospace;
    min-height:100vh;display:flex;flex-direction:column;
    align-items:center;padding:40px 20px;
    background-image:
      radial-gradient(ellipse 80% 50% at 50% -20%,rgba(0,212,255,.08),transparent),
      radial-gradient(ellipse 60% 40% at 80% 80%,rgba(123,47,255,.06),transparent);
  }
  body::before{
    content:'';position:fixed;inset:0;
    background:repeating-linear-gradient(0deg,transparent,transparent 2px,rgba(0,0,0,.08) 2px,rgba(0,0,0,.08) 4px);
    pointer-events:none;z-index:999;
  }
  .logo{
    font-family:'Orbitron',sans-serif;
    font-size:clamp(1.6rem,5vw,3rem);font-weight:900;
    letter-spacing:.12em;text-transform:uppercase;
    background:linear-gradient(135deg,var(--accent),var(--accent2));
    -webkit-background-clip:text;-webkit-text-fill-color:transparent;
    margin-bottom:6px;
  }
  .tagline{color:var(--dim);font-size:.8rem;letter-spacing:.25em;margin-bottom:48px}
  .card{
    background:var(--surface);border:1px solid var(--border);
    border-radius:12px;padding:36px;width:100%;max-width:680px;
    box-shadow:0 0 40px rgba(0,212,255,.04),0 0 80px rgba(0,0,0,.4);
    position:relative;overflow:hidden;margin-bottom:24px;
  }
  .card::before{
    content:'';position:absolute;top:0;left:0;right:0;height:1px;
    background:linear-gradient(90deg,transparent,var(--accent),var(--accent2),transparent);
  }
  label{display:block;font-size:.7rem;letter-spacing:.2em;color:var(--dim);margin-bottom:8px;text-transform:uppercase}
  .input-row{display:flex;gap:12px;margin-bottom:20px}
  input[type=text]{
    flex:1;background:#080e1a;border:1px solid var(--border);
    color:var(--text);font-family:'Share Tech Mono',monospace;font-size:.95rem;
    padding:12px 16px;border-radius:8px;outline:none;
    transition:border-color .2s,box-shadow .2s;
  }
  input[type=text]:focus{border-color:var(--accent);box-shadow:0 0 0 2px rgba(0,212,255,.15)}
  input[type=text]::placeholder{color:var(--dim)}
  .btn{
    padding:12px 22px;border:none;border-radius:8px;cursor:pointer;
    font-family:'Orbitron',sans-serif;font-size:.75rem;font-weight:600;
    letter-spacing:.1em;text-transform:uppercase;transition:all .2s;white-space:nowrap;
  }
  .btn-primary{background:linear-gradient(135deg,var(--accent),var(--accent2));color:#fff}
  .btn-primary:hover{opacity:.85;transform:translateY(-1px);box-shadow:0 4px 20px rgba(0,212,255,.3)}
  #status{
    padding:14px 18px;border-radius:8px;font-size:.85rem;
    margin-bottom:20px;display:none;border-left:3px solid;
  }
  #status.success{background:rgba(0,255,157,.06);border-color:var(--success);color:var(--success)}
  #status.error{background:rgba(255,68,102,.06);border-color:var(--danger);color:var(--danger)}
  .key-info{
    background:#080e1a;border:1px solid var(--border);border-radius:8px;
    padding:16px 20px;margin-bottom:20px;display:none;
  }
  .key-info .row{display:flex;justify-content:space-between;font-size:.8rem;margin-bottom:6px}
  .key-info .row:last-child{margin-bottom:0}
  .key-info .label-k{color:var(--dim)}
  .key-info .value-k{color:var(--accent)}
  .key-info .value-k.ok{color:var(--success)}
  .key-info .value-k.ex{color:var(--danger)}
  .divider{border:none;border-top:1px solid var(--border);margin:24px 0}
  .loadstring-section{display:none}
  .ls-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:10px}
  .ls-label{font-size:.7rem;letter-spacing:.2em;color:var(--dim);text-transform:uppercase}
  .ls-desc{font-size:.78rem;color:var(--dim);margin-bottom:12px;line-height:1.6}
  .ls-desc span{color:var(--accent)}
  .loadstring-box{
    background:#030508;border:1px solid var(--border);border-radius:8px;
    padding:16px 20px;font-size:.82rem;line-height:1.6;
    color:#00ff9d;word-break:break-all;cursor:pointer;
    transition:border-color .2s;position:relative;
  }
  .loadstring-box:hover{border-color:var(--accent)}
  .copy-hint{
    display:block;margin-top:8px;
    font-size:.65rem;color:var(--dim);letter-spacing:.1em;text-align:right;
  }
  .how-card{
    background:var(--surface);border:1px solid var(--border);
    border-radius:12px;padding:28px 36px;width:100%;max-width:680px;
    position:relative;overflow:hidden;
  }
  .how-card::before{
    content:'';position:absolute;top:0;left:0;right:0;height:1px;
    background:linear-gradient(90deg,transparent,var(--accent2),var(--accent),transparent);
  }
  .how-title{
    font-family:'Orbitron',sans-serif;font-size:.8rem;
    letter-spacing:.2em;color:var(--accent);margin-bottom:20px;
  }
  .step{display:flex;gap:16px;margin-bottom:16px;align-items:flex-start}
  .step:last-child{margin-bottom:0}
  .step-num{
    min-width:28px;height:28px;border-radius:50%;
    background:linear-gradient(135deg,var(--accent),var(--accent2));
    display:flex;align-items:center;justify-content:center;
    font-family:'Orbitron',sans-serif;font-size:.7rem;font-weight:900;color:#fff;
  }
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
    <div class="ls-header">
      <span class="ls-label">// Your Executor Script</span>
    </div>
    <p class="ls-desc">
      Copy the loadstring below and paste it into your executor.<br/>
      It will <span>automatically use your key</span> — no editing needed.
    </p>
    <div class="loadstring-box" id="loadstringBox" onclick="copyLoadstring()">
      <span id="loadstringText"></span>
      <span class="copy-hint" id="copyHint">click to copy</span>
    </div>
  </div>
</div>

<div class="how-card">
  <div class="how-title">// HOW TO USE</div>
  <div class="step">
    <div class="step-num">1</div>
    <div class="step-text">Enter your <b>LegendLua key</b> above and click <b>Activate</b></div>
  </div>
  <div class="step">
    <div class="step-num">2</div>
    <div class="step-text">Copy the <b>loadstring</b> that appears — your key is already baked in</div>
  </div>
  <div class="step">
    <div class="step-num">3</div>
    <div class="step-text">Open Roblox and your executor, then <b>paste and execute</b> the loadstring</div>
  </div>
  <div class="step">
    <div class="step-num">4</div>
    <div class="step-text">The hub loads automatically. Press <b>RightShift</b> to toggle the UI</div>
  </div>
</div>

<div class="footer">LegendLua &copy; 2025 &mdash; All rights reserved</div>

<script>
async function submitKey() {
  const key = document.getElementById('keyInput').value.trim();
  if (!key) return showStatus('Please enter a key.', 'error');
  showStatus('Verifying key...', 'success');
  const res = await fetch('/submit', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify({key})
  });
  const data = await res.json();
  if (!data.success) {
    showStatus(data.message, 'error');
    document.getElementById('keyInfo').style.display = 'none';
    document.getElementById('loadstringSection').style.display = 'none';
    return;
  }
  showStatus('Key authenticated successfully.', 'success');
  const ki = document.getElementById('keyInfo');
  ki.style.display = 'block';
  document.getElementById('infoKey').textContent = data.key;
  document.getElementById('infoTier').textContent = data.tier_label;
  const st = document.getElementById('infoStatus');
  st.textContent = data.expires_status;
  st.className = 'value-k ' + (data.expires_status === 'Expired' ? 'ex' : 'ok');
  document.getElementById('loadstringSection').style.display = 'block';
  document.getElementById('loadstringText').textContent = data.loadstring;
}
function showStatus(msg, type) {
  const el = document.getElementById('status');
  el.textContent = msg;
  el.className = type;
  el.style.display = 'block';
}
function copyLoadstring() {
  const text = document.getElementById('loadstringText').textContent;
  navigator.clipboard.writeText(text).then(() => {
    const hint = document.getElementById('copyHint');
    const box  = document.getElementById('loadstringBox');
    hint.textContent = 'Copied!';
    box.style.borderColor = 'var(--success)';
    setTimeout(() => {
      hint.textContent = 'click to copy';
      box.style.borderColor = '';
    }, 2000);
  });
}
</script>
</body>
</html>
"""

# Routes

@app.route("/")
def index():
    return render_template_string(HTML)

@app.route("/submit", methods=["POST"])
def submit():
    data = request.get_json()
    key  = data.get("key", "").strip()
    keys = load_keys()
    if key not in keys:
        return jsonify({"success": False, "message": "Key not found. Please check and try again."})
    key_data = keys[key]
    if not key_data["activated"]:
        key_data["activated"] = True
        key_data["activated_at"] = datetime.now(timezone.utc).isoformat()
        if key_data["days"] is not None:
            expires = datetime.now(timezone.utc) + timedelta(days=key_data["days"])
            key_data["expires_at"] = expires.isoformat()
        else:
            key_data["expires_at"] = None
        keys[key] = key_data
        save_keys(keys)
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
    keys = load_keys()
    if key not in keys:
        return Response('error("[LegendLua] Invalid key.")', mimetype="text/plain", status=403)
    key_data = keys[key]
    valid, expires_status = check_expiry(key_data)
    if not valid:
        return Response(f'error("[LegendLua] Key expired ({key_data["tier_label"]} tier).")', mimetype="text/plain", status=403)
    if not os.path.exists(LUA_FILE):
        return Response('error("[LegendLua] Script file missing on server.")', mimetype="text/plain", status=500)
    with open(LUA_FILE, "r", encoding="utf-8") as f:
        lua = f.read()
    if key_data["tier"] == "lifetime":
        expires_str = "Never (Lifetime)"
    elif key_data.get("expires_at"):
        expires_str = key_data["expires_at"][:10]
    else:
        expires_str = "Unknown"
    header = f"-- LegendLua Hub | Key: {key} | Tier: {key_data['tier_label']} | Expires: {expires_str}\n"
    lua = lua.replace('local KEY = "KEY_HERE"', f'local KEY = "{key}"', 1)
    return Response(header + lua, mimetype="text/plain")

@app.route("/verify", methods=["POST"])
def verify():
    data    = request.get_json()
    key     = (data.get("key")    or "").strip()
    user_id = (data.get("userId") or "").strip()
    if not key or not user_id:
        return jsonify({"success": False, "message": "Missing key or userId."})
    keys = load_keys()
    if key not in keys:
        return jsonify({"success": False, "message": "Key not found. Get a valid key at the portal."})
    key_data = keys[key]
    valid, expires_status = check_expiry(key_data)
    if not valid:
        return jsonify({"success": False, "message": f"Your key has expired ({key_data['tier_label']} tier)."})
    if not key_data.get("locked_user"):
        key_data["locked_user"]    = user_id
        key_data["locked_user_at"] = datetime.now(timezone.utc).isoformat()
        keys[key] = key_data
        save_keys(keys)
    elif key_data["locked_user"] != user_id:
        return jsonify({"success": False, "message": "This key is already linked to another Roblox account."})
    return jsonify({"success": True, "tier": key_data["tier_label"], "expires": expires_status})

if __name__ == "__main__":
    print("=== LegendLua Key Portal ===")
    print("Running at http://localhost:5000")
    import os as _os
    app.run(host="0.0.0.0", port=int(_os.environ.get("PORT", 5000)))
