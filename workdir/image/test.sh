#!/bin/bash
set -e

echo "Running comprehensive tests..."

# Test original C project
cd /workdir/original-repo
if [ -f "Makefile" ]; then
    echo "Testing original C project..."
    make test || echo "Original tests status: $?"
fi

# Test migrated Rust project
cd /workdir/migrated-repo
echo "Testing migrated Rust project..."
cargo test -- --nocapture

echo "All tests completed!"