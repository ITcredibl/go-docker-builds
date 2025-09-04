# Optimized Go Docker Builds 🏗️

A production-ready template for building minimal, secure, and fast Docker images for Go applications.

## 📊 Results

All images successfully built and run the same Go application:

| Dockerfile                | Size      | Description                       
|------------               |------     |-------------                      
| `dockerfile.naive`         1.4GB      | ❌ Anti-pattern example           
| `dockerfile.minimal`       25.4MB     | ✅ Basic multi-stage build 
| `dockerfile.optimized`     24.4MB     | ✅ Production-ready with security 
| `dockerfile.scratch`       7.91MB     | ✅ Absolute minimal image 
| `dockerfile.distroless`    52MB       | ✅ Google's distroless base 

## 🚀 Quick Start

```bash
# Build all image variants
make build-all

# See the size difference
make sizes

# Run any image
docker run --rm -p 8080:8080 optimized-go-app:optimized

# Test the application
curl http://localhost:8080
📋 Features
Multi-stage builds for minimal images

Security hardening (non-root users, etc.)

Production-ready patterns

CI/CD integration ready

Educational examples from basic to advanced

🛠️ Usage
bash
# Build specific image
make build-optimized

# Run with Docker
make run

# Security scan
make scan

# Generate SBOM
make sbom
📝 License
MIT License

🏆 Credits
Created as a companion to the article "From main.go to Production: Building Modern, Secure, & Lean Go Docker Images": https://medium.com/@oluseyikofo/from-main-go-to-production-building-modern-secure-lean-go-docker-images-3ec036a41894.


## 🎉 Conclusion:

You now have a complete, working repository that demonstrates:

1. **The problem**: A naive Docker build creates a 1.4GB image
2. **The solution**: Multiple optimization techniques reducing size by 98-99%
3. **Production readiness**: Security best practices and modern patterns
4. **Educational value**: Clear progression from basic to advanced techniques

This is exactly what you wanted to create - a comprehensive guide and template for building optimized Go Docker images! The repository can now be used as a reference or starting point for real-world Go projects.