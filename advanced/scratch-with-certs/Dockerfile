# Enhanced scratch example for apps needing HTTPS/SSL
FROM golang:1.22 AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags='-s -w' -o /usr/bin/app ./cmd/server/

# Ultimate minimalism, but with CA certificates for HTTPS
FROM scratch

# Copy CA certificates from the builder stage
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Copy compiled binary
COPY --from=builder /usr/bin/app /app

CMD ["/app"]