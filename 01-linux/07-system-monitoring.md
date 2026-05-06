# 📊 System Monitoring

## CPU

```bash
top                           # Real-time CPU + memory
htop                          # Enhanced top
mpstat -P ALL 1               # Per-CPU stats every second
sar -u 5 10                   # CPU every 5s, 10 times
vmstat 1                      # VM stats including CPU
lscpu                         # CPU architecture info
nproc                         # Number of logical CPUs
```

**Key metrics in top:**
- `us` — user space CPU
- `sy` — kernel/system CPU
- `wa` — I/O wait (high = disk bottleneck)
- `id` — idle

---

## Memory

```bash
free -h                       # RAM and swap
cat /proc/meminfo             # Detailed memory stats
vmstat -s                     # Summary memory stats
```

**Interpreting free -h:**
```
              total    used    free   shared  buff/cache  available
Mem:           15Gi    4.2Gi   8.1Gi   512Mi    2.9Gi      10.5Gi
```
→ `available` is what matters — memory that can be given to new processes.

---

## Disk I/O

```bash
iostat -xz 1                  # Extended disk I/O stats
iotop                         # Per-process I/O (like top for disk)
dstat                         # Combined CPU, disk, net stats
```

**Watch for:**
- `%util` > 80% → disk is saturated
- `await` > 20ms → high disk latency

---

## Network

```bash
iftop -i eth0                 # Bandwidth per connection
nethogs                       # Bandwidth per process
sar -n DEV 1                  # Network interface stats
ip -s link                    # TX/RX bytes per interface
ss -s                         # Socket summary
```

---

## System Load

```bash
uptime                        # Load averages (1, 5, 15 min)
cat /proc/loadavg             # Same in file form
w                             # Uptime + logged-in users
```

**Load average interpretation:**
- On a 4-core system: load of 4.0 = 100% utilization
- Load > number of CPUs = overloaded

---

## Process-Level Monitoring

```bash
ps aux --sort=-%cpu | head -10   # Top CPU consumers
ps aux --sort=-%mem | head -10   # Top memory consumers
pidstat 1                         # Per-process CPU/memory
strace -p <pid>                   # Trace system calls of a process
lsof -p <pid>                     # Open files for a process
```

---

## Health Check Scripts

```bash
# Quick system health snapshot
echo "=== CPU ===" && uptime
echo "=== Memory ===" && free -h
echo "=== Disk ===" && df -h
echo "=== Top Processes ===" && ps aux --sort=-%cpu | head -5
echo "=== Failed Services ===" && systemctl list-units --state=failed
```

---

## Alerting Basics

```bash
# Alert if disk > 80%
USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
[ "$USAGE" -gt 80 ] && echo "ALERT: Disk at ${USAGE}%"

# Alert if load > 4
LOAD=$(uptime | awk '{print $(NF-2)}' | tr -d ',')
echo "Load: $LOAD"
```

---

## Real-World Scenarios

### Scenario 1: Server is slow — triage
```bash
uptime               # Check load
free -h              # Check memory
iostat -xz 1 3       # Check disk I/O
ss -s                # Check connections
top                  # What's consuming CPU
```

### Scenario 2: OOM — find what was killed
```bash
dmesg | grep -i "oom killer"
journalctl -k | grep -i "killed process"
```

---

*Module 01 complete. Next: [Docker & Containers →](../02-docker/README.md)*
