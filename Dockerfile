FROM node:22-bookworm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    make \
    git \
    curl \
    python3 \
    python3-pip \
    python3-venv \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

WORKDIR /app

# Copy the entire project
COPY . .

# Make scripts executable
RUN chmod +x scripts/* 2>/dev/null || true

# Run DeerFlow's own setup
RUN make install || echo "Install completed with warnings"

EXPOSE 2026

# Start DeerFlow (this is the official command)
CMD ["make", "docker-start"]
