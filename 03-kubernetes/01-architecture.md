# ☸️ Kubernetes Architecture

## Control Plane Components

| Component | Role |
|-----------|------|
| **kube-apiserver** | Front door — all kubectl commands hit this |
| **etcd** | Distributed key-value store — cluster state lives here |
| **kube-scheduler** | Decides which node to place a Pod on |
| **kube-controller-manager** | Runs controllers (ReplicaSet, Node, Job, etc.) |
| **cloud-controller-manager** | Cloud-specific logic (LB provisioning, PV binding) |

## Worker Node Components

| Component | Role |
|-----------|------|
| **kubelet** | Agent on each node — ensures containers run in Pods |
| **kube-proxy** | Maintains network rules for Services |
| **Container runtime** | Runs containers (containerd, CRI-O) |

---

## What Happens When You Run `kubectl apply`?

```
kubectl apply -f deployment.yaml
       │
       ▼
  kube-apiserver  ──── authenticates & validates ──► etcd (stores desired state)
       │
       ▼
  kube-controller-manager
  (ReplicaSet controller sees Pods needed)
       │
       ▼
  kube-scheduler
  (picks the best node)
       │
       ▼
  kubelet on the node
  (tells container runtime to start the container)
       │
       ▼
  Pod running ✓
```

---

## etcd — The Source of Truth

```bash
# etcd is queried via kube-apiserver — never directly in production
# Backup etcd
ETCDCTL_API=3 etcdctl snapshot save /backup/etcd.db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key

# Verify backup
etcdctl snapshot status /backup/etcd.db
```

---

## Key Design Principles

- **Declarative** — you describe desired state; Kubernetes reconciles
- **Self-healing** — controllers constantly compare actual vs desired
- **Extensible** — CRDs, admission webhooks, operators
- **API-first** — everything is a resource, all actions go through the API

---

*Next: [Pods & Deployments →](./02-pods-and-deployments.md)*
