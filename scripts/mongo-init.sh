#!/usr/bin/env bash
set -euo pipefail

HOST="mongo:27017"

# Wait for mongod to answer pings
until mongosh --host "$HOST" --quiet --eval 'db.runCommand({ ping: 1 })' >/dev/null 2>&1; do
  sleep 2
done

mongosh --host "$HOST" --quiet <<'EOF'
const cfg = { _id: "rs0", members: [ { _id: 0, host: "mongo:27017" } ] };

function isInitiated() {
  try { rs.status(); return true; } catch (e) { return false; }
}

if (!isInitiated()) {
  rs.initiate(cfg);
}

// Wait until PRIMARY (state 1)
while (true) {
  try {
    if (rs.status().myState === 1) break;
  } catch (e) { /* ignore until ready */ }
  sleep(1000);
}
print("Replica set PRIMARY");
EOF

echo "Replica set initialized and PRIMARY"
exit 0
