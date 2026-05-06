# 📋 Log Analysis

## Where Logs Live

```
/var/log/
├── syslog          → General system messages (Debian/Ubuntu)
├── messages        → General system messages (RHEL/CentOS)
├── auth.log        → Authentication events
├── kern.log        → Kernel messages
├── dmesg           → Boot + hardware messages
├── nginx/          → Nginx access and error logs
├── apt/            → Package manager logs
└── journal/        → systemd journal (binary)
```

---

## Reading Logs

```bash
tail -f /var/log/syslog               # Live follow
tail -n 100 /var/log/auth.log         # Last 100 lines
less /var/log/syslog                  # Paginated (/ to search)
cat /var/log/syslog | grep -i error   # Filter errors
zcat /var/log/syslog.2.gz             # Read compressed log
zgrep "OOM" /var/log/syslog*.gz       # Search across compressed logs
```

---

## journalctl (systemd)

```bash
journalctl                            # All logs
journalctl -f                         # Live follow
journalctl -u nginx                   # Logs for a unit
journalctl -u kubelet -f              # Live kubelet logs
journalctl --since "2024-01-10 10:00:00"
journalctl --since "1 hour ago"
journalctl -p err                     # Error priority and above
journalctl -p err..crit               # Range of priorities
journalctl -k                         # Kernel messages only
journalctl --disk-usage               # Journal size
journalctl --vacuum-time=7d           # Keep last 7 days
```

**Priority levels:** emerg(0) alert(1) crit(2) err(3) warning(4) notice(5) info(6) debug(7)

---

## grep, awk, sed for Log Analysis

```bash
# grep
grep -i "error" /var/log/syslog
grep -v "INFO" app.log                # Exclude INFO lines
grep -A 5 -B 2 "OOMKill" syslog      # 5 lines after, 2 before
grep -c "Failed" auth.log             # Count matches
grep -E "error|warn|crit" app.log     # Multiple patterns

# awk
awk '{print $1, $2, $NF}' access.log  # Print columns 1, 2, last
awk '$9 == 500' access.log            # HTTP 500 errors (nginx)
awk '{sum += $NF} END {print sum}' access.log  # Sum last column

# sed
sed -n '100,200p' bigfile.log         # Print lines 100–200
sed 's/ERROR/[ERROR]/g' app.log       # Replace text
```

---

## Log Rotation

```bash
cat /etc/logrotate.conf               # Global config
ls /etc/logrotate.d/                  # Per-app configs
logrotate -d /etc/logrotate.conf      # Dry run
logrotate -f /etc/logrotate.d/nginx   # Force rotate now
```

Example config:
```
/var/log/app/*.log {
    daily
    rotate 14
    compress
    delaycompress
    missingok
    notifempty
    postrotate
        systemctl reload app
    endscript
}
```

---

## Real-World Scenarios

### Scenario 1: Find OOM kills
```bash
grep -i "out of memory" /var/log/syslog
journalctl -k | grep -i "oom"
dmesg | grep -i "killed process"
```

### Scenario 2: Count failed SSH logins by IP
```bash
grep "Failed password" /var/log/auth.log \
  | awk '{print $(NF-3)}' \
  | sort | uniq -c | sort -rn | head -10
```

### Scenario 3: Find slowest API calls in nginx log
```bash
awk '{print $NF, $7}' /var/log/nginx/access.log \
  | sort -rn | head -20
```

---

*Next: [User Management →](./06-user-management.md)*
