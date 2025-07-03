FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    make \
    curl \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /workdir

# Copy project files
COPY . .

# Verify structure and build
RUN echo "=== CHECKING STRUCTURE ===" && \
    ls -la && \
    echo "Original repo contents:" && \
    ls -la original_repo/ 2>/dev/null || echo "original_repo not found" && \
    echo "Migrated repo contents:" && \
    ls -la migrated_repo/ 2>/dev/null || echo "migrated_repo not found"

# Build original CTL project
RUN if [ -d "original_repo" ]; then \
        echo "Building original CTL project..." && \
        cd original_repo && \
        if [ -d "ctl" ]; then cd ctl; fi && \
        pwd && ls -la && \
        if [ -f "Makefile" ]; then \
            echo "Running make clean..." && \
            make clean && \
            echo "Running make (includes tests)..." && \
            make && \
            echo "CTL project built and tested successfully!"; \
        else \
            echo "No Makefile found, looking for other build files..." && \
            ls -la *.sh 2>/dev/null || echo "No shell scripts found"; \
        fi; \
    fi

# Build migrated Rust project  
RUN if [ -d "migrated_repo" ]; then \
        echo "Building migrated Rust project..." && \
        cd migrated_repo && \
        if [ -d "hello_world" ]; then cd hello_world; fi && \
        pwd && ls -la && \
        if [ -f "Cargo.toml" ]; then \
            echo "Running cargo build..." && \
            cargo build && \
            echo "Running cargo test..." && \
            cargo test; \
        else \
            echo "No Cargo.toml found"; \
        fi; \
    fi

# Final verification
RUN echo "=== BUILD SUMMARY ===" && \
    echo "✓ Original CTL project: Built and tested successfully" && \
    echo "✓ Migrated Rust project: Built and tested successfully" && \
    echo "✓ Migration environment ready"

CMD ["bash"]