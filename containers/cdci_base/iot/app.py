#!/usr/bin/env python3
# (c) Mihai Chiroiu - CDCI
# Simple IoT Sensors Dashboard — runs on cdci_base (no MySQL needed)

import os
import sqlite3
import random
from flask import Flask

app = Flask(__name__)
DB_PATH = "/opt/iot/sensors.db"


def init_db():
    """Create the sensors table and seed it with sample data."""
    con = sqlite3.connect(DB_PATH)
    cur = con.cursor()
    cur.execute("""CREATE TABLE IF NOT EXISTS sensors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sensor TEXT NOT NULL,
        value REAL NOT NULL,
        ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )""")
    # Seed some realistic IoT sensor data
    for sensor, lo, hi in [("temperature", 18.0, 32.0),
                            ("humidity", 30.0, 80.0),
                            ("pressure", 990.0, 1030.0)]:
        for _ in range(5):
            cur.execute(
                "INSERT INTO sensors (sensor, value) VALUES (?, ?)",
                (sensor, round(random.uniform(lo, hi), 1)),
            )
    con.commit()
    con.close()


@app.route("/")
def default():
    con = sqlite3.connect(DB_PATH)
    rows = con.execute(
        "SELECT sensor, value, ts FROM sensors ORDER BY ts DESC LIMIT 20"
    ).fetchall()
    con.close()
    table_rows = "".join(
        f"<tr><td>{r[0]}</td><td>{r[1]}</td><td>{r[2]}</td></tr>" for r in rows
    )
    return f"""<!DOCTYPE html>
<html><head><title>IoT Sensors Dashboard</title></head>
<body>
<h1>IoT Sensors Dashboard</h1>
<p>CDCI Lab — Smart Home IoT device</p>
<table border="1" cellpadding="4">
<tr><th>Sensor</th><th>Value</th><th>Timestamp</th></tr>
{table_rows}
</table>
</body></html>"""


if __name__ == "__main__":
    if not os.path.exists(DB_PATH):
        init_db()
    app.run(host="0.0.0.0", port=8080, debug=False)
