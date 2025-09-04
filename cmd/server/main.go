package main

import (
	"log"
	"net/http"
	"net/http/pprof"
	"os"
	"time"
)

func main() {
	mux := http.NewServeMux()

	// Application endpoint
	mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/plain")
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("✅ Hello from a production-optimized Go container!\n"))
		w.Write([]byte("📦 This image is minimal, secure, and fast.\n"))
		if hostname, err := os.Hostname(); err == nil {
			w.Write([]byte("🌐 Served by: " + hostname + "\n"))
		}
	})

	// Health check endpoint
	mux.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("OK"))
	})

	// Performance profiling endpoints (for PGO)
	mux.HandleFunc("/debug/pprof/", pprof.Index)
	mux.HandleFunc("/debug/pprof/profile", pprof.Profile)
	mux.HandleFunc("/debug/pprof/symbol", pprof.Symbol)
	mux.HandleFunc("/debug/pprof/trace", pprof.Trace)

	server := &http.Server{
		Addr:         ":8080",
		Handler:      mux,
		ReadTimeout:  10 * time.Second,
		WriteTimeout: 10 * time.Second,
		IdleTimeout:  120 * time.Second,
	}

	log.Printf("Server starting on %s", server.Addr)
	log.Fatal(server.ListenAndServe())
}
