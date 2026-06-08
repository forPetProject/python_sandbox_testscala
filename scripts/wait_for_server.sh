#!/usr/bin/env bash
set -euo pipefail

HOST="${1:?host required}"
PORT="${2:?port required}"
MAX_ATTEMPTS="${3:-60}"

echo "Waiting for gRPC server at ${HOST}:${PORT}..."

for attempt in $(seq 1 "$MAX_ATTEMPTS"); do
  if python3 - <<EOF
import socket
socket.create_connection(("${HOST}", int("${PORT}")), timeout=2).close()
EOF
  then
    echo "Server is ready."
    exit 0
  fi
  echo "Attempt ${attempt}/${MAX_ATTEMPTS}: server not ready, retrying..."
  sleep 2
done

echo "Timed out waiting for ${HOST}:${PORT}" >&2
exit 1
