# kubectl Cheatsheet

## Pods
```bash
kubectl get pods -A                     # All namespaces
kubectl get pods -o wide               # With node info
kubectl describe pod <name>            # Full details
kubectl logs <pod> -f                  # Live logs
kubectl logs <pod> -c <container>      # Multi-container pod
kubectl exec -it <pod> -- bash         # Shell into pod
kubectl delete pod <name> --force      # Force delete
```

## Deployments
```bash
kubectl get deployments
kubectl rollout status deployment/<name>
kubectl rollout undo deployment/<name>
kubectl scale deployment <name> --replicas=3
kubectl set image deployment/<name> app=image:v2
```

## Debugging
```bash
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl top pods
kubectl top nodes
kubectl get pods --field-selector=status.phase=Failed
```

## Config
```bash
kubectl config get-contexts
kubectl config use-context <name>
kubectl config set-context --current --namespace=mynamespace
```
