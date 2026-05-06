# 👤 User Management

## Users and Groups

```bash
# View users
cat /etc/passwd                       # All users
id eknatha                            # UID, GID, groups for a user
whoami                                # Current user
who                                   # Who is logged in
w                                     # Who + what they're doing
last                                  # Login history
```

---

## Managing Users

```bash
useradd -m -s /bin/bash eknatha       # Create user with home + bash shell
useradd -m -G sudo,docker eknatha     # Add to groups at creation
passwd eknatha                        # Set password
usermod -aG docker eknatha            # Add to group (append)
usermod -s /bin/zsh eknatha           # Change shell
userdel eknatha                       # Delete user (keep home)
userdel -r eknatha                    # Delete user + home directory
```

---

## Managing Groups

```bash
groupadd devops                       # Create group
groupdel devops                       # Delete group
gpasswd -a eknatha devops             # Add user to group
gpasswd -d eknatha devops             # Remove user from group
groups eknatha                        # List groups for user
cat /etc/group | grep docker          # Who is in docker group
```

---

## sudo

```bash
visudo                                # Edit sudoers safely
sudo -l                               # List sudo privileges
sudo -i                               # Switch to root shell
sudo -u postgres psql                 # Run as another user
```

**sudoers examples:**
```
# Full sudo access
eknatha ALL=(ALL:ALL) ALL

# No password for specific commands
eknatha ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart nginx

# Group sudo
%devops ALL=(ALL:ALL) ALL
```

---

## SSH Key Management

```bash
ssh-keygen -t ed25519 -C "eknatha@eknathalabs.com"   # Generate keypair
ssh-copy-id user@host                                  # Copy public key to server
cat ~/.ssh/authorized_keys                             # View authorized keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys                       # Correct permissions
```

---

## Account Security

```bash
passwd -l eknatha                     # Lock account
passwd -u eknatha                     # Unlock account
chage -l eknatha                      # Password expiry info
chage -M 90 eknatha                   # Expire password every 90 days
chage -E 2025-12-31 eknatha           # Account expiry date
faillock --user eknatha               # Check failed login attempts
faillock --reset --user eknatha       # Reset lockout
```

---

## Real-World Scenarios

### Scenario 1: Create a service account (no login)
```bash
useradd -r -s /sbin/nologin -M prometheus
# -r = system account, -M = no home dir
```

### Scenario 2: Audit who has sudo access
```bash
grep -E '^[^#].*ALL' /etc/sudoers
grep -r '' /etc/sudoers.d/
getent group sudo
```

### Scenario 3: Force all users to reset password at next login
```bash
chage -d 0 eknatha                    # Expire immediately
```

---

*Next: [System Monitoring →](./07-system-monitoring.md)*
