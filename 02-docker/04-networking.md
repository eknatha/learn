# 🌐 Docker Networking

## Network Types

| Driver | Use Case |
|--------|----------|
| bridge | Default. Container-to-container on same host |
| host | Container shares host network stack |
| none | No networking |
| overlay | Multi-host (Docker Swarm / advanced) |
| macvlan | Container gets its own MAC address |

---

## Commands

```bash
docker network ls                          # List networks
docker network create mynet                # Create bridge network
docker network create --driver host hnet  # Host network
docker network inspect mynet              # Inspect network
docker network connect mynet container1   # Connect running container
docker network disconnect mynet container1

# Run container on specific network
docker run -d --network mynet --name app myimage
```

---

## DNS Between Containers

Containers on the same user-defined network can reach each other by **service name**:

```bash
# Container "app" can reach "db" by name
curl http://db:5432
ping db
```

Default bridge network does NOT support DNS — always use user-defined networks.

---

## Port Mapping

```bash
docker run -p 8080:80 nginx          # host:container
docker run -p 127.0.0.1:8080:80 nginx  # Bind to localhost only
docker run -P nginx                  # Auto-map all exposed ports
docker port container1               # Show port mappings
```
