# 🐳 Images & Containers

## Key Concepts

| Term | Meaning |
|------|---------|
| Image | Read-only template (like a class) |
| Container | Running instance of an image (like an object) |
| Registry | Storage for images (Docker Hub, ECR, GCR) |
| Layer | Each instruction in a Dockerfile adds a layer |
| Tag | Version label for an image (e.g., `nginx:1.25`) |

---

## Working with Images

```bash
docker pull nginx:1.25                 # Pull from Docker Hub
docker images                          # List local images
docker image ls --filter dangling=true # Show unused images
docker rmi nginx:1.25                  # Remove image
docker image prune                     # Remove all dangling images
docker inspect nginx:1.25             # Full image metadata
docker history nginx:1.25             # Layer history
```

---

## Running Containers

```bash
docker run nginx                                # Run in foreground
docker run -d nginx                             # Run detached
docker run -d -p 8080:80 nginx                 # Port mapping
docker run -d --name webserver nginx           # Named container
docker run -it ubuntu:22.04 bash               # Interactive shell
docker run --rm alpine echo "hello"            # Auto-remove on exit
docker run -e ENV=prod -e DB_HOST=db app:v1    # Environment variables
docker run -v /host/path:/container/path nginx # Volume mount
docker run --cpus="1.5" --memory="512m" app    # Resource limits
```

---

## Managing Containers

```bash
docker ps                              # Running containers
docker ps -a                           # All containers (incl stopped)
docker stop webserver                  # Graceful stop (SIGTERM)
docker kill webserver                  # Force stop (SIGKILL)
docker rm webserver                    # Remove stopped container
docker rm -f webserver                 # Force remove running
docker restart webserver               # Restart container

docker logs webserver                  # Container logs
docker logs -f webserver               # Follow logs
docker logs --tail 50 webserver        # Last 50 lines
docker exec -it webserver bash         # Shell into running container
docker exec webserver cat /etc/nginx/nginx.conf  # Run command
docker cp file.txt webserver:/tmp/     # Copy file to container
docker stats                           # Live resource usage
docker top webserver                   # Processes inside container
```

---

## Building Images

```bash
docker build -t myapp:v1 .             # Build from current dir
docker build -t myapp:v1 -f Dockerfile.prod .  # Custom Dockerfile
docker build --no-cache -t myapp:v1 .  # Force fresh build
docker tag myapp:v1 myapp:latest       # Tag existing image
docker push myrepo/myapp:v1            # Push to registry
```

---

## Registry Operations

```bash
docker login                           # Login to Docker Hub
docker login ghcr.io                   # GitHub Container Registry
docker login 123456.dkr.ecr.ap-south-1.amazonaws.com  # AWS ECR

# ECR login (AWS)
aws ecr get-login-password --region ap-south-1 \
  | docker login --username AWS --password-stdin \
  123456.dkr.ecr.ap-south-1.amazonaws.com
```

---

*Next: [Dockerfile Best Practices →](./02-dockerfile-best-practices.md)*
