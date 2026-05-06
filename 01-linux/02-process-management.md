# ⚙️ Process Management

## What is a Process?

A process is a running instance of a program. Every command you run, every service, every container runtime — all are processes managed by the Linux kernel.

---

## Viewing Processes

```bash
ps aux                        # All processes (BSD style)
ps -ef                        # All processes (UNIX style)
ps aux | grep nginx           # Find specific process
pgrep kubelet                 # Get PID by name
pidof sshd                    # Get PID of sshd
```

### top / htop
```bash
top                           # Real-time process viewer
htop                          # Enhanced top (if installed)
# Inside top:
# k → kill process
# r → renice (change priority)
# 1 → show individual CPU cores
```

### Process Tree
```bash
pstree -p                     # Show parent-child tree with PIDs
ps -ejH                       # Hierarchical process list
```

---

## Process States

| State | Meaning |
|-------|---------|
| R | Running or runnable |
| S | Sleeping (waiting for event) |
| D | Uninterruptible sleep (usually I/O) |
| Z | Zombie (finished but not reaped) |
| T | Stopped (SIGSTOP or traced) |

---

## Signals

```bash
kill -l                       # List all signals
kill -9 1234                  # SIGKILL — force kill PID 1234
kill -15 1234                 # SIGTERM — graceful shutdown
kill -HUP 1234                # SIGHUP — reload config
killall nginx                 # Kill all nginx processes
pkill -f "python app.py"      # Kill by full command match
```

**Common signals:**

| Signal | Number | Use |
|--------|--------|-----|
| SIGTERM | 15 | Graceful shutdown (default) |
| SIGKILL | 9 | Force kill — cannot be caught |
| SIGHUP | 1 | Reload config without restart |
| SIGINT | 2 | Keyboard interrupt (Ctrl+C) |

---

## Background & Job Control

```bash
./long-script.sh &            # Run in background
jobs                          # List background jobs
fg %1                         # Bring job 1 to foreground
bg %1                         # Resume job 1 in background
nohup ./script.sh &           # Keep running after logout
disown %1                     # Detach job from shell
```

---

## Process Priority (nice / renice)

```bash
nice -n 10 ./cpu-heavy.sh     # Start with lower priority
renice -n 5 -p 1234           # Change priority of running process
# Range: -20 (highest) to 19 (lowest)
# Only root can set negative values
```

---

## systemd — Managing Services

```bash
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
systemctl reload nginx         # Reload config without restart
systemctl status nginx
systemctl enable nginx         # Start on boot
systemctl disable nginx
systemctl list-units --type=service --state=running
journalctl -u nginx -f         # Live logs for nginx service
journalctl -u kubelet --since "1 hour ago"
```

---

## Real-World Scenarios

### Scenario 1: Find what's using port 8080
```bash
ss -tlnp | grep 8080
lsof -i :8080
fuser 8080/tcp
```

### Scenario 2: Process won't die
```bash
kill -15 <pid>    # try graceful first
sleep 2
kill -9 <pid>     # force if needed
```

### Scenario 3: Find zombie processes
```bash
ps aux | awk '$8=="Z" {print $2, $11}'
```

---

*Next: [Networking →](./03-networking.md)*
