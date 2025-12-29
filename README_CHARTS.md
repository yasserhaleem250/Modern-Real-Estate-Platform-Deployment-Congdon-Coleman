# Helm charts / Values

This folder contains example `values.yaml` files you can pass to Helm when installing monitoring components.

Install Prometheus (kube-prometheus-stack):

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack -f deploy/charts/prometheus-values.yaml --namespace monitoring --create-namespace
```

Install Grafana (if not installed as part of kube-prometheus-stack):

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana grafana/grafana -f deploy/charts/grafana-values.yaml --namespace monitoring
```

Adjust values files for persistence, ingress, and credentials before production use.
