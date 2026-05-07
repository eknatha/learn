# 🔐 ConfigMaps & Secrets

## ConfigMap

Store non-sensitive config data.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  ENV: production
  LOG_LEVEL: info
  config.yaml: |
    server:
      port: 8080
      timeout: 30s
```

```bash
kubectl create configmap app-config --from-literal=ENV=prod
kubectl create configmap app-config --from-file=config.yaml
kubectl get configmap app-config -o yaml
```

## Secret

Store sensitive data (base64-encoded, not encrypted by default — use SOPS or Sealed Secrets for GitOps).

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
type: Opaque
stringData:
  DB_PASSWORD: mysecretpassword
  API_KEY: abc123
```

```bash
kubectl create secret generic app-secret --from-literal=DB_PASSWORD=mysecret
kubectl get secret app-secret -o jsonpath='{.data.DB_PASSWORD}' | base64 -d
```

## Using in a Pod

```yaml
spec:
  containers:
  - name: app
    image: myapp:v1
    envFrom:
    - configMapRef:
        name: app-config
    - secretRef:
        name: app-secret
    volumeMounts:
    - name: config-vol
      mountPath: /etc/config
  volumes:
  - name: config-vol
    configMap:
      name: app-config
```

*Next: [RBAC →](./05-rbac.md)*
