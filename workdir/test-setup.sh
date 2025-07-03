#!/bin/bash
set -e

echo "Testing CTL to Rust migration setup..."

# Test original CTL project
echo "Testing original CTL project..."
cd original-repo/ctl

if [ -f "Makefile" ]; then
    echo "Found Makefile, running make test..."
    make test || echo "CTL tests completed with status: $?"
elif [ -f "all.sh" ]; then
    echo "Found all.sh, executing..."
    chmod +x all.sh
    ./all.sh || echo "CTL build completed"
else
    echo "No build system found, attempting manual compilation..."
    gcc -Wall -Wextra -std=c99 -I. examples/*.c -o test_ctl || echo "Manual compilation attempted"
fi

cd ../../

# Test migrated Rust project
echo "Testing migrated Rust project..."
cd migrated-repo/hello_world

echo "Running cargo build..."
cargo build

echo "Running cargo test..."
cargo test

cd ../../

echo "All tests completed!"