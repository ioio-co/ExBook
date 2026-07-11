// Package config loads application configuration from environment
// variables and command-line flags. Flags take precedence over
// environment variables, which take precedence over defaults.
package config

import (
	"flag"
	"fmt"
	"net"
	"os"
	"strconv"
	"time"
)

// Config holds all runtime configuration of the application.
type Config struct {
	Env      string // development | production
	Host     string
	Port     int
	LogLevel string // debug | info | warn | error

	ReadTimeout     time.Duration
	WriteTimeout    time.Duration
	IdleTimeout     time.Duration
	ShutdownTimeout time.Duration
}

// Addr returns the listen address in "host:port" form.
func (c *Config) Addr() string {
	return net.JoinHostPort(c.Host, strconv.Itoa(c.Port))
}

// Load builds a Config from defaults, environment variables and flags.
func Load() (*Config, error) {
	return load(os.Args[1:])
}

func load(args []string) (*Config, error) {
	cfg := &Config{
		Env:             envStr("APP_ENV", "development"),
		Host:            envStr("APP_HOST", "0.0.0.0"),
		Port:            envInt("APP_PORT", 8080),
		LogLevel:        envStr("APP_LOG_LEVEL", "info"),
		ReadTimeout:     envDuration("APP_READ_TIMEOUT", 5*time.Second),
		WriteTimeout:    envDuration("APP_WRITE_TIMEOUT", 10*time.Second),
		IdleTimeout:     envDuration("APP_IDLE_TIMEOUT", 60*time.Second),
		ShutdownTimeout: envDuration("APP_SHUTDOWN_TIMEOUT", 10*time.Second),
	}

	fs := flag.NewFlagSet("server", flag.ContinueOnError)
	fs.StringVar(&cfg.Env, "env", cfg.Env, "runtime environment (development|production)")
	fs.StringVar(&cfg.Host, "host", cfg.Host, "listen host")
	fs.IntVar(&cfg.Port, "port", cfg.Port, "listen port")
	fs.StringVar(&cfg.LogLevel, "log-level", cfg.LogLevel, "log level (debug|info|warn|error)")
	if err := fs.Parse(args); err != nil {
		return nil, err
	}

	if err := cfg.validate(); err != nil {
		return nil, err
	}
	return cfg, nil
}

func (c *Config) validate() error {
	if c.Port < 1 || c.Port > 65535 {
		return fmt.Errorf("invalid port %d: must be in range 1-65535", c.Port)
	}
	switch c.Env {
	case "development", "production":
	default:
		return fmt.Errorf("invalid env %q: must be development or production", c.Env)
	}
	switch c.LogLevel {
	case "debug", "info", "warn", "error":
	default:
		return fmt.Errorf("invalid log level %q: must be debug, info, warn or error", c.LogLevel)
	}
	return nil
}

func envStr(key, def string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return def
}

func envInt(key string, def int) int {
	if v := os.Getenv(key); v != "" {
		if n, err := strconv.Atoi(v); err == nil {
			return n
		}
	}
	return def
}

func envDuration(key string, def time.Duration) time.Duration {
	if v := os.Getenv(key); v != "" {
		if d, err := time.ParseDuration(v); err == nil {
			return d
		}
	}
	return def
}
