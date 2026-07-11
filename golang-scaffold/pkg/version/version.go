// Package version exposes build metadata. The variables are meant to
// be overridden at build time via -ldflags, e.g.:
//
//	go build -ldflags "-X github.com/ioio-co/golang-scaffold/pkg/version.Version=v1.0.0"
package version

var (
	// Version is the semantic version of the build.
	Version = "dev"
	// Commit is the git commit hash the binary was built from.
	Commit = "none"
	// Date is the build timestamp.
	Date = "unknown"
)
