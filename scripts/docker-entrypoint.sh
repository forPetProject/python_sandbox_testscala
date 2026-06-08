#!/usr/bin/env bash
set -euo pipefail

if [[ "${GRPC_HOST:-localhost}" != "localhost" ]]; then
  bash scripts/wait_for_server.sh "${GRPC_HOST}" "${GRPC_PORT:-9091}"
fi

exec "$@"
