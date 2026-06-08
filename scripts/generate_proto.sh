#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROTO_ROOT="$ROOT/proto/scala-grpc-sandbox/src/main/protobuf"
OUT="$ROOT/generated"

mkdir -p "$OUT"

python3 -m grpc_tools.protoc \
  -I "$PROTO_ROOT" \
  --python_out="$OUT" \
  --grpc_python_out="$OUT" \
  hello/v1/service.proto

echo "Generated Python gRPC stubs in $OUT"
