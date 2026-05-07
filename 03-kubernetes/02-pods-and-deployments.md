# 📦 Pods & Deployments

## Pod

The smallest deployable unit in Kubernetes. A Pod wraps one or more containers that share network and storage.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    ports:
    - containerPort: 80
    resources:
      requests:
        cpu: "100m"
        memory: "128Mi"
      limits:
        cpu: "250m"
        memory: "256Mi"
```

```bash
kubectl apply -f pod.yaml
kubectl get pods
kubectl describe pod nginx-pod
kubectl logs nginx-pod
kubectl exec -it nginx-pod -- bash
kubectl delete pod nginx-pod
```

---

## Deployment

Manages a ReplicaSet, which manages Pods. Enables rolling updates and rollbacks.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deploy
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 80
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 10
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 15
          periodSeconds: 20
```

---

## Deployment Commands

```bash
kubectl apply -f deployment.yaml
kubectl get deployments
kubectl rollout status deployment/nginx-deploy
kubectl rollout history deployment/nginx-deploy
kubectl rollout undo deployment/nginx-deploy          # Rollback
kubectl rollout undo deployment/nginx-deploy --to-revision=2
kubectl scale deployment nginx-deploy --replicas=5
kubectl set image deployment/nginx-deploy nginx=nginx:1.26
```

---

## Other Workload Types

| Kind | Use Case |
|------|----------|
| DaemonSet | Run one Pod per node (log agents, node exporters) |
| StatefulSet | Ordered, stable identity pods (databases) |
| Job | Run to completion (batch tasks) |
| CronJob | Scheduled jobs |

---

*Next: [Services & Ingress →](./03-services-and-ingress.md)*
