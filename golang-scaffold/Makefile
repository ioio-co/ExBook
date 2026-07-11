MODULE      := github.com/ioio-co/golang-scaffold
BINARY      := server
BUILD_DIR   := bin

VERSION     ?= $(shell git describe --tags --always --dirty 2>/dev/null || echo dev)
COMMIT      ?= $(shell git rev-parse --short HEAD 2>/dev/null || echo none)
DATE        ?= $(shell date -u +%Y-%m-%dT%H:%M:%SZ)

LDFLAGS     := -s -w \
	-X $(MODULE)/pkg/version.Version=$(VERSION) \
	-X $(MODULE)/pkg/version.Commit=$(COMMIT) \
	-X $(MODULE)/pkg/version.Date=$(DATE)

.PHONY: all build run test cover lint fmt vet tidy clean docker help

all: fmt vet test build ## Format, vet, test and build

build: ## Build the server binary into ./bin
	go build -trimpath -ldflags "$(LDFLAGS)" -o $(BUILD_DIR)/$(BINARY) ./cmd/server

run: ## Run the server locally
	go run ./cmd/server

test: ## Run tests with race detector
	go test -race -count=1 ./...

cover: ## Run tests and open the coverage report
	go test -race -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out

lint: ## Run golangci-lint (must be installed)
	golangci-lint run ./...

fmt: ## Format code
	gofmt -s -w .

vet: ## Run go vet
	go vet ./...

tidy: ## Tidy go.mod / go.sum
	go mod tidy

clean: ## Remove build artifacts
	rm -rf $(BUILD_DIR) coverage.out

docker: ## Build the docker image
	docker build -t $(BINARY):$(VERSION) .

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'
