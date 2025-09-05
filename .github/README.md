# Optimized Go Docker Builds 🏗️

A production-ready template for building minimal, secure, and fast Docker images for Go applications. This repository demonstrates industry best practices for containerizing Go services.

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/your-username/optimized-go-docker-builds.git
cd optimized-go-docker-builds

# Build all image variants to see the difference
make build-all

# View image sizes
make sizes

# Run the optimized production image
make run

# Test the application
curl http://localhost:8080

📊 Image Comparison

Dockerfile	            Size	Security	    Use Case
dockerfile.naive	    ~950MB	❌ Poor	       Anti-pattern example
dockerfile.minimal	    ~17MB	⚠️ Basic	    Intermediate learning
dockerfile.optimized	~15MB	✅ Production   Production deployment
dockerfile.scratch	    ~10MB	✅ Minimal	   Fully static binaries
dockerfile.distroless	~25MB	✅ Secure	   Google's distroless base

🛠️ Features

Multi-stage builds for minimal final images
Non-root user execution for security
Profile-Guided Optimization (PGO) ready
SBOM generation for supply chain security
Trivy security scanning integration
Multi-architecture support (amd64/arm64)
Health checks and production best practices
CI/CD workflows with GitHub Actions
Makefile for developer convenience

📖 Usage

Local Development

bash
# Build and run with Docker Compose
docker compose up --build

# Or use the Makefile
make build-optimized
make run

Production Deployment

bash
# Build multi-architecture image
make build-multi-arch

# Or use the release workflow
make release

🔧 Advanced Features

Profile-Guided Optimization (PGO)
Enable PGO for performance improvements:

Generate a CPU profile:

bash
curl -o default.pgo "http://localhost:8080/debug/pprof/profile?seconds=30"
Rebuild with PGO:

bash
docker build -t my-app:pgo -f dockerfile.optimized .
Supply Chain Security
Generate a Software Bill of Materials (SBOM):

bash
make sbom
Security scan your images:

bash
make scan

🤝 Contributing
This repository is maintained as a reference implementation. Feel free to open issues or pull requests for improvements.

📄 License
MIT License - see LICENSE file for details.

🏆 Credits
Created as a companion to the article "From main.go to Production: Building Modern, Secure, & Lean Go Docker Images".

text

---

This repository is now a complete, professional-grade resource that:
1.  **Educates** through clear examples and comparisons
2.  **Provides production-ready code** that teams can adapt
3.  **Automates best practices** through CI/CD and Makefiles
4.  **Documents thoroughly** for easy adoption
5.  **Follows security best practices** throughout

It stands as both a learning resource and a practical template for real-world Go development.

