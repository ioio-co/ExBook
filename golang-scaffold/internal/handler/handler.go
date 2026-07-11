// Package handler contains the HTTP handlers of the application.
package handler

import (
	"encoding/json"
	"log/slog"
	"net/http"

	"github.com/ioio-co/golang-scaffold/pkg/version"
)

// Health reports service liveness. Wire it to load balancer or
// Kubernetes probes.
func Health(w http.ResponseWriter, r *http.Request) {
	writeJSON(w, http.StatusOK, map[string]string{"status": "ok"})
}

// Version returns build information injected at compile time.
func Version(w http.ResponseWriter, r *http.Request) {
	writeJSON(w, http.StatusOK, map[string]string{
		"version": version.Version,
		"commit":  version.Commit,
		"date":    version.Date,
	})
}

// Hello is an example business handler demonstrating path parameters.
func Hello(w http.ResponseWriter, r *http.Request) {
	name := r.PathValue("name")
	if name == "" {
		name = "world"
	}
	writeJSON(w, http.StatusOK, map[string]string{"message": "hello, " + name})
}

func writeJSON(w http.ResponseWriter, status int, v any) {
	w.Header().Set("Content-Type", "application/json; charset=utf-8")
	w.WriteHeader(status)
	if err := json.NewEncoder(w).Encode(v); err != nil {
		slog.Error("write json response", "error", err)
	}
}
