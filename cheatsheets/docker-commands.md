# Docker Cheatsheet

## Images
```bash
docker pull nginx:1.25
docker images
docker build -t myapp:v1 .
docker push myrepo/myapp:v1
docker rmi myapp:v1
docker image prune
```

## Containers
```bash
docker run -d -p 8080:80 --name web nginx
docker ps -a
docker logs web -f
docker exec -it web bash
docker stop web
docker rm web
docker stats
```

## Cleanup
```bash
docker container prune    # Remove stopped containers
docker image prune        # Remove dangling images
docker system prune -a    # Remove everything unused
docker volume prune
```

## Compose
```bash
docker compose up -d
docker compose down
docker compose logs -f app
docker compose exec app bash
docker compose ps
```
