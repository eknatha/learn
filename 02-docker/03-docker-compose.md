# 🐙 Docker Compose

## What is Compose?

Docker Compose defines and runs multi-container applications using a single `docker-compose.yml` file.

---

## Basic Example — App + DB

```yaml
version: "3.9"

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DB_HOST=db
      - DB_PORT=5432
    depends_on:
      db:
        condition: service_healthy
    networks:
      - backend

  db:
    image: postgres:16-alpine
    volumes:
      - pgdata:/var/lib/postgresql/data
    environment:
      - POSTGRES_USER=app
      - POSTGRES_PASSWORD_FILE=/run/secrets/db_password
      - POSTGRES_DB=appdb
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "app"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - backend

volumes:
  pgdata:

networks:
  backend:
    driver: bridge
```

---

## Common Commands

```bash
docker compose up -d              # Start all services detached
docker compose down               # Stop and remove containers
docker compose down -v            # Also remove volumes
docker compose ps                 # Status of services
docker compose logs -f app        # Follow app logs
docker compose exec app bash      # Shell into app container
docker compose build              # Build images
docker compose pull               # Pull latest images
docker compose restart app        # Restart one service
docker compose scale app=3        # Run 3 replicas of app
```

---

## Environment Variables

```bash
# .env file (auto-loaded by Compose)
DB_PASSWORD=secret
IMAGE_TAG=v1.2.3

# docker-compose.yml
services:
  app:
    image: myapp:${IMAGE_TAG}
```

---

*Next: [Networking →](./04-networking.md)*
