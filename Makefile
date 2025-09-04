# Build configuration
APP_NAME ?= optimized-go-app
GO_VERSION = 1.22
REGISTRY ?= ghcr.io
REGISTRY_NS ?= your-username

.PHONY: help build build-all run test scan sbom clean release login

.DEFAULT_GOAL := help

help: ## Show this help message
	@echo "🏗️ Optimized Go Docker Builds"
	@echo "================================"
	@echo ""
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Build targets
build: build-optimized ## Build the optimized production image

build-all: build-naive build-minimal build-optimized build-scratch build-distroless ## Build all image variants

build-naive: ## Build naive anti-pattern image
	@echo "🚫 Building naive image (anti-pattern)..."
	docker build -t $(APP_NAME):naive -f dockerfile.naive .

build-minimal: ## Build minimal multi-stage image (intermediate step)
	@echo "📦 Building minimal multi-stage image..."
	docker build -t $(APP_NAME):minimal -f dockerfile.minimal .

build-optimized: ## Build production-optimized image
	@echo "✅ Building production-optimized image..."
	docker build -t $(APP_NAME):optimized -f dockerfile.optimized .

build-scratch: ## Build scratch-based minimal image
	@echo "⚙️ Building scratch-based image..."
	docker build -t $(APP_NAME):scratch -f dockerfile.scratch .

build-distroless: ## Build distroless-based image
	@echo "🔒 Building distroless-based image..."
	docker build -t $(APP_NAME):distroless -f dockerfile.distroless .

build-multi-arch: ## Build multi-architecture image
	@echo "🌍 Building multi-arch image..."
	docker buildx build --platform linux/amd64,linux/arm64 -t $(APP_NAME):multi-arch -f dockerfile.optimized .

# Development targets
run: build-optimized ## Run optimized production image
	@echo "🚀 Starting production container..."
	docker run -d -p 8080:8080 --name $(APP_NAME) $(APP_NAME):optimized

test: ## Run tests
	@echo "🧪 Running tests..."
	go test ./... -v

scan: build-optimized ## Security scan optimized image
	@echo "🔍 Scanning for vulnerabilities..."
	trivy image --severity HIGH,CRITICAL $(APP_NAME):optimized

sbom: build-optimized ## Generate Software Bill of Materials
	@echo "📋 Generating SBOM..."
	syft $(APP_NAME):optimized -o table
	syft $(APP_NAME):optimized -o json > sbom.json
	@echo "SBOM saved to sbom.json"

# Utility targets
clean: ## Clean up containers and images
	@echo "🧹 Cleaning up..."
	docker stop $(APP_NAME) 2>/dev/null || true
	docker rm $(APP_NAME) 2>/dev/null || true
	docker rmi $(APP_NAME):naive $(APP_NAME):minimal $(APP_NAME):optimized $(APP_NAME):scratch $(APP_NAME):distroless 2>/dev/null || true

sizes: ## Show image sizes
	@echo "📊 Image sizes:"
	@docker images --filter="reference=$(APP_NAME)*" --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"

# Release targets
login: ## Login to container registry
	@echo "🔐 Logging in to $(REGISTRY)..."
	echo "$$CR_PAT" | docker login $(REGISTRY) -u $(REGISTRY_NS) --password-stdin

release: build-optimized ## Prepare release image
	@echo "🎯 Preparing release image..."
	docker tag $(APP_NAME):optimized $(REGISTRY)/$(REGISTRY_NS)/$(APP_NAME):latest
	docker tag $(APP_NAME):optimized $(REGISTRY)/$(REGISTRY_NS)/$(APP_NAME):$(shell git rev-parse --short HEAD)

release-push: release login ## Push release images to registry
	@echo "📤 Pushing release images..."
	docker push $(REGISTRY)/$(REGISTRY_NS)/$(APP_NAME):latest
	docker push $(REGISTRY)/$(REGISTRY_NS)/$(APP_NAME):$(shell git rev-parse --short HEAD)
