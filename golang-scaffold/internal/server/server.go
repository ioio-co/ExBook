// Package server wires the HTTP server together: routing, middleware
// and lifecycle management (start + graceful shutdown).
package server

import (
	"context"
	"errors"
	"fmt"
	"log/slog"
	"net/http"

	"github.com/ioio-co/golang-scaffold/internal/config"
	"github.com/ioio-co/golang-scaffold/internal/handler"
	"github.com/ioio-co/golang-scaffold/internal/middleware"
)

// Server is the application HTTP server.
type Server struct {
	cfg    *config.Config
	logger *slog.Logger
	http   *http.Server
}

// New builds a Server with all routes and middleware registered.
func New(cfg *config.Config, logger *slog.Logger) *Server {
	mux := http.NewServeMux()
	registerRoutes(mux)

	var h http.Handler = mux
	h = middleware.Logging(logger)(h)
	h = middleware.Recovery(logger)(h)

	return &Server{
		cfg:    cfg,
		logger: logger,
		http: &http.Server{
			Addr:         cfg.Addr(),
			Handler:      h,
			ReadTimeout:  cfg.ReadTimeout,
			WriteTimeout: cfg.WriteTimeout,
			IdleTimeout:  cfg.IdleTimeout,
		},
	}
}

func registerRoutes(mux *http.ServeMux) {
	mux.HandleFunc("GET /healthz", handler.Health)
	mux.HandleFunc("GET /version", handler.Version)
	mux.HandleFunc("GET /api/v1/hello", handler.Hello)
	mux.HandleFunc("GET /api/v1/hello/{name}", handler.Hello)
}

// Run starts the server and blocks until ctx is cancelled, then shuts
// down gracefully within the configured shutdown timeout.
func (s *Server) Run(ctx context.Context) error {
	errCh := make(chan error, 1)
	go func() {
		if err := s.http.ListenAndServe(); err != nil && !errors.Is(err, http.ErrServerClosed) {
			errCh <- err
		}
	}()

	select {
	case err := <-errCh:
		return fmt.Errorf("listen and serve: %w", err)
	case <-ctx.Done():
	}

	s.logger.Info("shutting down server", "timeout", s.cfg.ShutdownTimeout)
	shutdownCtx, cancel := context.WithTimeout(context.Background(), s.cfg.ShutdownTimeout)
	defer cancel()

	if err := s.http.Shutdown(shutdownCtx); err != nil {
		return fmt.Errorf("shutdown: %w", err)
	}
	s.logger.Info("server stopped")
	return nil
}
