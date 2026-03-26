FROM node:20-bookworm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    make \
    git \
    curl \
    python3 \
    python3-pip \
    docker.io \
    docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the entire project
COPY . .

# Make scripts executable
RUN chmod +x scripts/* 2>/dev/null || true

# Install dependencies (this may take time on first build)
RUN make install || echo "Make install completed with warnings"

EXPOSE 2026

# Use the official development start command
CMD ["make", "docker-start"]
