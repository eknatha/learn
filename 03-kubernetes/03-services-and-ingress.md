# 🔌 Services & Ingress

## Service Types

| Type | Accessible From | Use Case |
|------|----------------|----------|
| ClusterIP | Inside cluster only | Default — internal communication |
| NodePort | Outside via node IP + port | Dev/testing |
| LoadBalancer | External via cloud LB | Production external access |
| ExternalName | DNS alias | Point to external service |

## ClusterIP Example
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-svc
spec:
  selector:
    app: nginx
  ports:
  - port: 80
    targetPort: 80
```

## Ingress Example (nginx ingress controller)
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: learn.eknathalabs.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: nginx-svc
            port:
              number: 80
```

```bash
kubectl get svc
kubectl get ingress
kubectl describe ingress app-ingress
kubectl port-forward svc/nginx-svc 8080:80   # Local testing
```

*Next: [ConfigMaps & Secrets →](./04-configmaps-and-secrets.md)*
