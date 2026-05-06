# 📁 File Management in Linux

## Why It Matters

Every DevOps task — deploying configs, rotating logs, managing secrets — involves files.
Understanding the Linux filesystem hierarchy and file operations is non-negotiable.

---

## Filesystem Hierarchy Standard (FHS)

```
/
├── bin/     → Essential user binaries (ls, cp, mv)
├── sbin/    → System binaries (iptables, fdisk)
├── etc/     → Configuration files
├── var/     → Variable data (logs, caches, spools)
├── tmp/     → Temporary files (cleared on reboot)
├── home/    → User home directories
├── opt/     → Optional/third-party software
├── proc/    → Virtual FS — kernel & process info
├── sys/     → Virtual FS — device and kernel info
└── usr/     → User programs and libraries
```

---

## Essential Commands

### Navigation
```bash
pwd                   # Print working directory
ls -lah               # List with human-readable sizes + hidden files
cd -                  # Switch to previous directory
tree -L 2             # Directory tree, 2 levels deep
```

### File Operations
```bash
cp -r src/ dest/           # Copy directory recursively
mv oldname newname         # Move or rename
rm -rf dir/                # Remove directory (caution!)
mkdir -p a/b/c             # Create nested dirs in one shot
touch file.txt             # Create empty file / update timestamp
ln -s /target /link        # Create symbolic link
```

### Finding Files
```bash
find /etc -name "*.conf"              # Find by name
find /var/log -mtime -1               # Modified in last 24h
find / -size +100M -type f            # Files larger than 100MB
find . -perm /u+x                     # Executable files
locate nginx.conf                     # Fast search (uses index)
which kubectl                         # Find binary location
```

### Viewing Files
```bash
cat file.txt                  # Print entire file
less file.txt                 # Paginated view (q to quit)
head -n 20 file.txt           # First 20 lines
tail -n 50 file.txt           # Last 50 lines
tail -f /var/log/syslog       # Live follow (great for logs)
grep -n "error" file.txt      # Search with line numbers
```

### File Permissions
```bash
chmod 755 script.sh           # rwxr-xr-x
chmod u+x script.sh           # Add execute for owner
chown eknatha:devops file     # Change owner and group
chown -R eknatha /opt/app     # Recursive ownership change
umask 022                     # Default permission mask
```

**Permission breakdown:**
```
-rwxr-xr-x
 │││└──── others: r-x (5)
 ││└───── group:  r-x (5)
 │└────── owner:  rwx (7)
 └─────── type: - file, d dir, l symlink
```

### Archiving & Compression
```bash
tar -czf archive.tar.gz dir/        # Create gzip archive
tar -xzf archive.tar.gz             # Extract gzip archive
tar -czf - dir/ | ssh host "cat > archive.tar.gz"  # Stream over SSH
zip -r app.zip ./app
unzip app.zip -d /opt/
```

---

## Real-World Scenarios

### Scenario 1: Find large files eating disk space
```bash
du -sh /var/log/*  | sort -rh | head -10
find /var/log -name "*.log" -size +50M -exec ls -lh {} \;
```

### Scenario 2: Backup config before editing
```bash
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak.$(date +%Y%m%d)
```

### Scenario 3: Safely delete old logs
```bash
find /var/log/app -name "*.log" -mtime +30 -delete
```

---

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| `rm -rf /` without thinking | Always double-check path before `rm -rf` |
| Forgetting `-p` in mkdir | Use `mkdir -p` for nested directories |
| Wrong permissions on scripts | Scripts need `chmod +x` to execute |
| Editing files without backup | Always `cp file file.bak` before editing |

---

*Next: [Process Management →](./02-process-management.md)*
