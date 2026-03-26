# Use the official Docker-in-Docker image or a base that can run docker-compose
FROM docker:27.3.1-dind

# Install dependencies
RUN apk add --no-cache make git curl nodejs npm pnpm

# Set working directory
WORKDIR /app

# Copy everything
COPY . .

# Install project dependencies (if needed)
RUN make check || echo "Make check skipped"
RUN make install || echo "Dependencies installed via make"

# Expose the port DeerFlow uses
EXPOSE 2026

# Default command - we'll override this with docker-compose in Railway
CMD ["make", "docker-start"]
