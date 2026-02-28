=== LegendLua Key Portal ===

SETUP:
  1. pip install -r requirements.txt
  2. python generate_keys.py   (generate your keys)
  3. python app.py             (start the web portal at http://localhost:5000)

FILES:
  generate_keys.py  - Generate and save license keys to keys.json
  app.py            - Flask web portal for key activation + script delivery
  keys.json         - Auto-created when you generate keys (do not share publicly)

TIERS:
  1day / 3day / 7day / 1month / 3month / 6month / 1year / lifetime

KEY FORMAT:
  LegendLua-XXXX-XXXX-XXXX

NOTE:
  Keys do NOT start expiring until a user activates them via the portal.
