# Golang Scaffold

一个开箱即用的 Go 项目脚手架，遵循 [Standard Go Project Layout](https://github.com/golang-standards/project-layout)，仅依赖标准库，无第三方依赖。

## 特性

- **标准项目布局**：`cmd/` 入口、`internal/` 私有代码、`pkg/` 可复用包
- **HTTP 服务**：基于 `net/http`（Go 1.22+ 路由，支持方法匹配和路径参数）
- **配置管理**：环境变量 + 命令行 flag，带默认值和校验
- **结构化日志**：`log/slog`，开发环境文本格式、生产环境 JSON 格式
- **中间件**：请求日志、panic 恢复
- **优雅关闭**：监听 SIGINT/SIGTERM，超时可配置
- **版本注入**：通过 `-ldflags` 在编译期注入版本号、commit、构建时间
- **工程化**：Makefile、单元测试、golangci-lint 配置、多阶段 Dockerfile、GitHub Actions CI

## 目录结构

```
golang-scaffold/
├── cmd/
│   └── server/            # 程序入口 (main)
│       └── main.go
├── internal/              # 私有应用代码，外部无法 import
│   ├── config/            # 配置加载与校验
│   ├── handler/           # HTTP 处理器（含测试）
│   ├── middleware/        # HTTP 中间件
│   └── server/            # 服务器组装与生命周期
├── pkg/                   # 可被外部复用的包
│   └── version/           # 构建版本信息
├── .github/workflows/     # CI
├── .golangci.yml          # lint 配置
├── Dockerfile             # 多阶段构建，distroless 运行时
├── Makefile
└── go.mod
```

## 快速开始

```bash
# 运行
make run

# 测试（含 race 检测）
make test

# 构建（自动注入版本信息）
make build
./bin/server

# 查看全部命令
make help
```

## API

| 方法 | 路径                  | 说明               |
| ---- | --------------------- | ------------------ |
| GET  | `/healthz`            | 健康检查           |
| GET  | `/version`            | 构建版本信息       |
| GET  | `/api/v1/hello`       | 示例接口           |
| GET  | `/api/v1/hello/{name}`| 示例接口（路径参数）|

```bash
curl localhost:8080/healthz
# {"status":"ok"}

curl localhost:8080/api/v1/hello/gopher
# {"message":"hello, gopher"}
```

## 配置

所有配置支持环境变量，部分支持命令行 flag（flag 优先级更高）：

| 环境变量               | flag          | 默认值        | 说明                          |
| ---------------------- | ------------- | ------------- | ----------------------------- |
| `APP_ENV`              | `-env`        | `development` | `development` / `production`  |
| `APP_HOST`             | `-host`       | `0.0.0.0`     | 监听地址                      |
| `APP_PORT`             | `-port`       | `8080`        | 监听端口                      |
| `APP_LOG_LEVEL`        | `-log-level`  | `info`        | `debug`/`info`/`warn`/`error` |
| `APP_READ_TIMEOUT`     | —             | `5s`          | 读超时                        |
| `APP_WRITE_TIMEOUT`    | —             | `10s`         | 写超时                        |
| `APP_IDLE_TIMEOUT`     | —             | `60s`         | 空闲连接超时                  |
| `APP_SHUTDOWN_TIMEOUT` | —             | `10s`         | 优雅关闭超时                  |

```bash
APP_PORT=9000 APP_ENV=production go run ./cmd/server
# 或
go run ./cmd/server -port 9000 -env production
```

## Docker

```bash
make docker
docker run -p 8080:8080 server:dev
```

## 如何扩展

1. **新增接口**：在 `internal/handler/` 添加处理函数，在 `internal/server/server.go` 的 `registerRoutes` 中注册路由。
2. **新增中间件**：在 `internal/middleware/` 实现 `Middleware` 类型，在 `server.New` 中挂载。
3. **新增配置**：在 `internal/config/config.go` 的 `Config` 结构体中添加字段并在 `load` 中读取。
4. **接入数据库/缓存**：建议新增 `internal/store/` 或 `internal/repository/` 包，在 `main.go` 中初始化并注入 handler。
5. **改模块名**：全局替换 `github.com/ioio-co/golang-scaffold` 为你的模块路径。
