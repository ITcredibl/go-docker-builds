# Example for applications requiring CGO (like go-sqlite3)
# Uses a slim Debian base to include necessary C libraries
FROM golang:1.22 AS builder

WORKDIR /app
COPY . .
# Note: CGO_ENABLED=1 is required for C-linked libraries
RUN CGO_ENABLED=1 GOOS=linux go build -o /usr/bin/app ./cmd/server/

# Use a slim Debian image that includes glibc and other dependencies
FROM debian:bookworm-slim

# Install runtime dependencies & CA certificates, then clean up apt cache
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN groupadd -r app && useradd -r -g app app
USER app

COPY --from=builder --chown=app:app /usr/bin/app /app

CMD ["/app"]
