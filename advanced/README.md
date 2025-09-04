# Advanced Go Docker Patterns

This directory contains examples for complex production scenarios.

## CGO with SQLite

`cgo-sqlite/Dockerfile` - For applications requiring C-linked libraries (e.g., go-sqlite3). Uses a debian:slim base to provide necessary C libraries.

## Multi-Platform Builds

`multi-platform/Dockerfile` - Build for both amd64 and arm64 (Apple Silicon, AWS Graviton) using Docker Buildx. Usage:

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t your-app:multi-arch .