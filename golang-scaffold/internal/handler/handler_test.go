package handler

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestHealth(t *testing.T) {
	rec := httptest.NewRecorder()
	req := httptest.NewRequest(http.MethodGet, "/healthz", nil)

	Health(rec, req)

	if rec.Code != http.StatusOK {
		t.Fatalf("status = %d, want %d", rec.Code, http.StatusOK)
	}
	var body map[string]string
	if err := json.Unmarshal(rec.Body.Bytes(), &body); err != nil {
		t.Fatalf("decode body: %v", err)
	}
	if body["status"] != "ok" {
		t.Errorf(`status = %q, want "ok"`, body["status"])
	}
}

func TestHello(t *testing.T) {
	tests := []struct {
		name     string
		path     string
		pathName string
		want     string
	}{
		{name: "default", path: "/api/v1/hello", want: "hello, world"},
		{name: "with name", path: "/api/v1/hello/gopher", pathName: "gopher", want: "hello, gopher"},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			rec := httptest.NewRecorder()
			req := httptest.NewRequest(http.MethodGet, tt.path, nil)
			if tt.pathName != "" {
				req.SetPathValue("name", tt.pathName)
			}

			Hello(rec, req)

			if rec.Code != http.StatusOK {
				t.Fatalf("status = %d, want %d", rec.Code, http.StatusOK)
			}
			var body map[string]string
			if err := json.Unmarshal(rec.Body.Bytes(), &body); err != nil {
				t.Fatalf("decode body: %v", err)
			}
			if body["message"] != tt.want {
				t.Errorf("message = %q, want %q", body["message"], tt.want)
			}
		})
	}
}
