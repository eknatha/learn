# 💾 Disk Management

## Disk Usage — Quick Check

```bash
df -h                          # Filesystem usage (human-readable)
df -hT                         # Include filesystem type
du -sh /var/log                # Size of a directory
du -sh /var/log/* | sort -rh   # Subdirs sorted by size
ncdu /var                      # Interactive disk usage browser
```

---

## Block Devices

```bash
lsblk                          # List block devices (tree view)
lsblk -f                       # Include filesystem info
fdisk -l                       # List all partitions (root)
blkid                          # Show UUIDs and filesystem types
```

---

## Partitioning

```bash
fdisk /dev/sdb                 # Interactive partition tool
gdisk /dev/sdb                 # GPT partition tool
parted /dev/sdb                # Modern alternative

# Inside fdisk:
# n → new partition
# d → delete partition
# p → print partition table
# w → write and exit
```

---

## Filesystems

```bash
mkfs.ext4 /dev/sdb1            # Format as ext4
mkfs.xfs /dev/sdb1             # Format as XFS (common in RHEL)
mkfs.ext4 -L "data" /dev/sdb1 # With label

e2fsck /dev/sdb1               # Check ext4 filesystem
xfs_repair /dev/sdb1           # Check XFS filesystem
```

---

## Mounting

```bash
mount /dev/sdb1 /mnt/data      # Mount a partition
mount -o ro /dev/sdb1 /mnt     # Mount read-only
umount /mnt/data               # Unmount

# Persistent mount via /etc/fstab
# UUID=xxxx  /mnt/data  ext4  defaults  0  2
blkid /dev/sdb1                # Get UUID for fstab
mount -a                       # Mount everything in fstab
```

---

## Logical Volume Manager (LVM)

```bash
# Physical Volumes
pvcreate /dev/sdb /dev/sdc
pvs
pvdisplay

# Volume Groups
vgcreate vg_data /dev/sdb /dev/sdc
vgs
vgdisplay

# Logical Volumes
lvcreate -L 20G -n lv_app vg_data
lvs
lvdisplay

# Extend an LV online
lvextend -L +10G /dev/vg_data/lv_app
resize2fs /dev/vg_data/lv_app    # ext4
xfs_growfs /mnt/app               # XFS
```

---

## Swap

```bash
swapon --show                  # Current swap usage
free -h                        # Memory + swap summary
mkswap /dev/sdb2               # Create swap on partition
swapon /dev/sdb2               # Enable swap
swapoff /dev/sdb2              # Disable swap

# Create swap file
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
```

---

## Real-World Scenarios

### Scenario 1: Disk full — find and clean
```bash
df -h                                      # Which partition is full?
du -sh /var/log/* | sort -rh | head -10    # Biggest dirs
find /var/log -name "*.log" -mtime +7 -delete
journalctl --vacuum-size=500M              # Trim systemd logs
```

### Scenario 2: Extend root volume on cloud VM (AWS)
```bash
# After resizing EBS in console:
lsblk
growpart /dev/xvda 1          # Extend partition
resize2fs /dev/xvda1          # Extend filesystem (ext4)
```

---

*Next: [Log Analysis →](./05-log-analysis.md)*
