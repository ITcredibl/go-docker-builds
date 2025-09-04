# Example for building multi-architecture images (amd64 + arm64)
# Note: This requires Docker Buildx
FROM --platform=$BUILDPLATFORM golang:1.22 AS builder

ARG TARGETARCH
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=$TARGETARCH go build -ldflags='-s -w' -o /usr/bin/app ./cmd/server/

FROM alpine:latest
COPY --from=builder /usr/bin/app /app
CMD ["/app"]
