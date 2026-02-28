"""
LegendLua Key Generator
Generates keys and saves them to PostgreSQL (if DATABASE_URL is set)
or keys.json (local use).

Usage:
  - Locally:   python generate_keys.py
  - On server: set DATABASE_URL env var, then python generate_keys.py
"""

import json, random, string, os
from datetime import datetime, timezone

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
KEYS_FILE  = os.path.join(SCRIPT_DIR, "keys.json")
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

def use_db():
    return bool(DATABASE_URL)

def get_db():
    import psycopg2
    url = DATABASE_URL.replace("postgres://", "postgresql://", 1)
    return psycopg2.connect(url)

def generate_segment():
    return ''.join(random.choices(string.ascii_uppercase + string.digits, k=4))

def generate_key():
    return f"LegendLua-{generate_segment()}-{generate_segment()}-{generate_segment()}"

def key_exists_db(key):
    try:
        conn = get_db()
        cur  = conn.cursor()
        cur.execute("SELECT 1 FROM keys WHERE key = %s", (key,))
        exists = cur.fetchone() is not None
        cur.close(); conn.close()
        return exists
    except:
        return False

def save_key_db(key, tier, tier_label, days):
    conn = get_db()
    cur  = conn.cursor()
    cur.execute("""
        INSERT INTO keys (key, tier, tier_label, days, activated, created_at)
        VALUES (%s, %s, %s, %s, FALSE, %s)
        ON CONFLICT (key) DO NOTHING
    """, (key, tier, tier_label, days, datetime.now(timezone.utc)))
    conn.commit()
    cur.close(); conn.close()

def load_json():
    if os.path.exists(KEYS_FILE):
        with open(KEYS_FILE, "r") as f:
            return json.load(f)
    return {}

def save_json(keys):
    with open(KEYS_FILE, "w") as f:
        json.dump(keys, f, indent=2)

def generate_keys(count, tier):
    if tier not in TIERS:
        print(f"[ERROR] Invalid tier. Choose from: {', '.join(TIERS.keys())}")
        return

    tier_label = TIERS[tier]["label"]
    days       = TIERS[tier]["days"]
    new_keys   = []

    if use_db():
        print(f"  Saving to PostgreSQL database...")
        # Make sure table exists
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
            cur.close(); conn.close()
        except Exception as e:
            print(f"[ERROR] Could not connect to database: {e}")
            return

        for _ in range(count):
            key = generate_key()
            while key_exists_db(key):
                key = generate_key()
            save_key_db(key, tier, tier_label, days)
            new_keys.append(key)
    else:
        print(f"  Saving to keys.json (no DATABASE_URL set)...")
        keys = load_json()
        for _ in range(count):
            key = generate_key()
            while key in keys:
                key = generate_key()
            keys[key] = {
                "tier": tier, "tier_label": tier_label, "days": days,
                "activated": False, "activated_at": None,
                "expires_at": None, "locked_user": None, "locked_user_at": None,
                "created_at": datetime.now(timezone.utc).isoformat()
            }
            new_keys.append(key)
        save_json(keys)

    print(f"\n  Generated {count} {tier_label} key(s):\n")
    for k in new_keys:
        print(f"    {k}")
    dest = "PostgreSQL" if use_db() else KEYS_FILE
    print(f"\n  Saved to: {dest}")

if __name__ == "__main__":
    try:
        print("=== LegendLua Key Generator ===\n")
        mode = "PostgreSQL" if use_db() else "keys.json (local)"
        print(f"  Storage: {mode}\n")
        print("  Available tiers:")
        for tid, t in TIERS.items():
            print(f"    {tid:10} -> {t['label']}")
        print()
        tier = input("  Enter tier: ").strip().lower()
        if tier not in TIERS:
            print(f"\n  [ERROR] Invalid tier.")
        else:
            count_str = input("  How many keys? ").strip()
            if not count_str.isdigit() or int(count_str) < 1:
                print("\n  [ERROR] Enter a valid number.")
            else:
                generate_keys(int(count_str), tier)
    except Exception as e:
        print(f"\n  [ERROR] {e}")

    input("\n  Press Enter to exit...")
