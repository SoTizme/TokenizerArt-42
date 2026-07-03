#!/bin/bash

set -e

if ! command -v python3 >/dev/null 2>&1; then
    echo "Error: python3 is not installed."
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$SCRIPT_DIR/website"

echo "========================================="
echo " ShilalNFT42 Mint Website"
echo "========================================="
echo
echo "Server: http://localhost:8080/mint.html"
echo "Press Ctrl+C to stop."
echo

python3 -m http.server 8080