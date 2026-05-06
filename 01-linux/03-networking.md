# 🌐 Linux Networking for DevOps

## Core Concepts

| Concept | Description |
|---------|-------------|
| IP Address | Unique identifier for a network interface |
| Subnet Mask | Defines the network boundary |
| Gateway | Router that forwards packets outside the subnet |
| DNS | Resolves hostnames to IP addresses |
| Port | Logical endpoint for a process (0–65535) |

---

## Interface & Address Commands

```bash
ip addr show                  # All interfaces and IPs (modern)
ip addr show eth0             # Specific interface
ip link show                  # Link layer info
ifconfig                      # Legacy (still common on older systems)

ip route show                 # Routing table
ip route add 10.0.0.0/8 via 192.168.1.1   # Add static route
ip route del 10.0.0.0/8
```

---

## Connectivity Testing

```bash
ping -c 4 8.8.8.8             # Test reachability
traceroute google.com         # Trace packet path
mtr google.com                # Combined ping + traceroute (live)
curl -I https://eknathalabs.com   # Check HTTP response headers
wget -q --spider https://site.com # Check URL without downloading
```

---

## DNS

```bash
nslookup eknathalabs.com       # Basic DNS lookup
dig eknathalabs.com            # Detailed DNS info
dig eknathalabs.com MX         # Mail records
dig +short eknathalabs.com     # Just the IP
host eknathalabs.com           # Simple lookup
cat /etc/resolv.conf           # DNS server config
cat /etc/hosts                 # Local hostname overrides
```

---

## Ports & Sockets

```bash
ss -tlnp                       # TCP listening ports with process
ss -ulnp                       # UDP listening ports
ss -anp | grep :443            # All connections on port 443
netstat -tlnp                  # Legacy (same as ss)
lsof -i :80                    # What's using port 80
```

**Port ranges:**
- 0–1023: Well-known (root required)
- 1024–49151: Registered (app ports)
- 49152–65535: Ephemeral (client connections)

---

## Firewall (iptables / ufw)

```bash
# ufw (Ubuntu/Debian)
ufw status verbose
ufw allow 22/tcp
ufw allow 80/tcp
ufw deny 3306
ufw enable

# iptables
iptables -L -n -v              # List all rules
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -j DROP      # Drop everything else
iptables-save > /etc/iptables.rules   # Persist rules
```

---

## SSH

```bash
ssh user@host                  # Basic SSH
ssh -i ~/.ssh/id_rsa user@host # With key
ssh -L 8080:localhost:80 user@host    # Local port forward
ssh -R 9090:localhost:9090 user@host  # Remote port forward
scp file.txt user@host:/tmp/   # Copy file to remote
rsync -avz ./dir/ user@host:/opt/app/ # Sync directory
```

---

## Real-World Scenarios

### Scenario 1: Service not reachable — debug step by step
```bash
ping <host>             # Is host alive?
telnet <host> <port>    # Is port open?
curl -v http://<host>   # Is HTTP responding?
ss -tlnp | grep <port>  # Is service actually listening?
```

### Scenario 2: Check bandwidth usage
```bash
iftop -i eth0           # Live bandwidth per connection
nethogs                 # Bandwidth per process
```

### Scenario 3: Test DNS resolution inside a pod/container
```bash
kubectl exec -it <pod> -- nslookup kubernetes.default
kubectl exec -it <pod> -- cat /etc/resolv.conf
```

---

*Next: [Disk Management →](./04-disk-management.md)*
