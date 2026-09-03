#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

make build
exec ./bin/holyc-8bit-vm
