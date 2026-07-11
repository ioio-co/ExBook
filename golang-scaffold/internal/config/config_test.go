package config

import (
	"testing"
	"time"
)

func TestLoadDefaults(t *testing.T) {
	cfg, err := load(nil)
	if err != nil {
		t.Fatalf("load: %v", err)
	}
	if cfg.Env != "development" {
		t.Errorf("Env = %q, want %q", cfg.Env, "development")
	}
	if cfg.Port != 8080 {
		t.Errorf("Port = %d, want 8080", cfg.Port)
	}
	if cfg.Addr() != "0.0.0.0:8080" {
		t.Errorf("Addr() = %q, want %q", cfg.Addr(), "0.0.0.0:8080")
	}
	if cfg.ShutdownTimeout != 10*time.Second {
		t.Errorf("ShutdownTimeout = %v, want 10s", cfg.ShutdownTimeout)
	}
}

func TestLoadFlagsOverrideEnv(t *testing.T) {
	t.Setenv("APP_PORT", "9000")
	t.Setenv("APP_ENV", "production")

	cfg, err := load([]string{"-port", "9001"})
	if err != nil {
		t.Fatalf("load: %v", err)
	}
	if cfg.Port != 9001 {
		t.Errorf("Port = %d, want 9001 (flag should override env)", cfg.Port)
	}
	if cfg.Env != "production" {
		t.Errorf("Env = %q, want %q", cfg.Env, "production")
	}
}

func TestLoadInvalid(t *testing.T) {
	tests := []struct {
		name string
		args []string
	}{
		{name: "bad port", args: []string{"-port", "70000"}},
		{name: "bad env", args: []string{"-env", "staging"}},
		{name: "bad log level", args: []string{"-log-level", "verbose"}},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if _, err := load(tt.args); err == nil {
				t.Errorf("load(%v) succeeded, want error", tt.args)
			}
		})
	}
}
