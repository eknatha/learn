# 💾 Docker Volumes

## Volume Types

| Type | Syntax | Use Case |
|------|--------|----------|
| Named volume | `-v pgdata:/var/lib/postgresql/data` | Persistent DB data |
| Bind mount | `-v /host/path:/container/path` | Dev hot-reload |
| tmpfs | `--tmpfs /tmp` | Sensitive data (in-memory only) |

---

## Commands

```bash
docker volume create pgdata           # Create named volume
docker volume ls                      # List volumes
docker volume inspect pgdata          # Volume details
docker volume rm pgdata               # Remove volume
docker volume prune                   # Remove all unused volumes
```

---

## When to Use What

```bash
# Named volume — DB persistence (Docker manages location)
docker run -v pgdata:/var/lib/postgresql/data postgres

# Bind mount — local dev (see code changes immediately)
docker run -v $(pwd):/app -w /app node:20 npm run dev

# tmpfs — secrets/tokens that should never hit disk
docker run --tmpfs /run/secrets:rw,noexec,nosuid app
```

---

## Backup a Volume

```bash
docker run --rm \
  -v pgdata:/data \
  -v $(pwd):/backup \
  alpine tar czf /backup/pgdata-backup.tar.gz /data
```
