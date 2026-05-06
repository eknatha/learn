# 📄 Dockerfile Best Practices

## Basic Dockerfile

```dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
CMD ["node", "server.js"]
```

---

## Multi-Stage Build (Production Pattern)

```dockerfile
# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Runtime (lean image)
FROM node:20-alpine AS runtime
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
USER appuser
EXPOSE 3000
CMD ["node", "dist/server.js"]
```

**Why multi-stage?** Build tools (compilers, test frameworks) don't belong in production images. Final image is much smaller and has a smaller attack surface.

---

## Best Practices

### 1. Use specific base image tags
```dockerfile
# BAD
FROM node:latest

# GOOD
FROM node:20.11-alpine3.19
```

### 2. Order layers by change frequency (cache optimization)
```dockerfile
# Dependencies change less often than source code
COPY package*.json ./      # Cache this layer
RUN npm ci
COPY . .                   # This changes most often — put last
```

### 3. Minimize layers
```dockerfile
# BAD — 3 layers
RUN apt-get update
RUN apt-get install -y curl
RUN rm -rf /var/lib/apt/lists/*

# GOOD — 1 layer
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*
```

### 4. Never run as root
```dockerfile
RUN addgroup -S app && adduser -S app -G app
USER app
```

### 5. Use .dockerignore
```
node_modules
.git
.env
*.log
dist
coverage
.DS_Store
```

### 6. Don't store secrets in images
```dockerfile
# BAD
ENV DB_PASSWORD=supersecret

# GOOD — pass at runtime
docker run -e DB_PASSWORD=$DB_PASSWORD myapp
# Or use Docker secrets / K8s secrets
```

---

## Image Size Comparison

| Base Image | Size |
|------------|------|
| ubuntu:22.04 | ~77MB |
| debian:slim | ~75MB |
| alpine:3.19 | ~7MB |
| distroless/static | ~2MB |
| scratch | 0 (empty) |

---

*Next: [Docker Compose →](./03-docker-compose.md)*
