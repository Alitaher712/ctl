#!/bin/bash
set -e

echo "Building C to Rust migration environment..."

# Build original C project
cd /workdir/original-repo
if [ -f "Makefile" ]; then
    echo "Building original C project..."
    make clean
    make
    echo "Running original tests..."
    make test || echo "Original tests completed with status: $?"
fi

# Build migrated Rust project
cd /workdir/migrated-repo
echo "Building migrated Rust project..."
cargo build --verbose
echo "Running migrated tests..."
cargo test --verbose

echo "Migration environment setup complete!"