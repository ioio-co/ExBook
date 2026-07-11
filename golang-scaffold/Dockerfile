# --- Build stage ---
FROM golang:1.24-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .
ARG VERSION=dev
ARG COMMIT=none
ARG DATE=unknown
RUN CGO_ENABLED=0 go build -trimpath \
    -ldflags "-s -w \
      -X github.com/ioio-co/golang-scaffold/pkg/version.Version=${VERSION} \
      -X github.com/ioio-co/golang-scaffold/pkg/version.Commit=${COMMIT} \
      -X github.com/ioio-co/golang-scaffold/pkg/version.Date=${DATE}" \
    -o /server ./cmd/server

# --- Runtime stage ---
FROM gcr.io/distroless/static-debian12:nonroot

COPY --from=builder /server /server

EXPOSE 8080
USER nonroot:nonroot

ENTRYPOINT ["/server"]
