# Linux Commands Cheatsheet

## File Operations
| Command | Description |
|---------|-------------|
| `ls -lah` | List with sizes + hidden |
| `find / -name "*.conf"` | Find files by name |
| `chmod 755 file` | Set permissions |
| `chown user:group file` | Change ownership |
| `tar -czf a.tar.gz dir/` | Create archive |
| `tail -f /var/log/syslog` | Follow log live |

## Process
| Command | Description |
|---------|-------------|
| `ps aux --sort=-%cpu` | Top CPU processes |
| `kill -9 <pid>` | Force kill |
| `systemctl status nginx` | Service status |
| `journalctl -u nginx -f` | Service logs |

## Disk
| Command | Description |
|---------|-------------|
| `df -h` | Disk usage |
| `du -sh /var/log/*` | Dir sizes |
| `lsblk` | Block devices |

## Network
| Command | Description |
|---------|-------------|
| `ss -tlnp` | Listening ports |
| `ip addr show` | IP addresses |
| `dig eknathalabs.com` | DNS lookup |
| `curl -I https://site` | HTTP headers |
