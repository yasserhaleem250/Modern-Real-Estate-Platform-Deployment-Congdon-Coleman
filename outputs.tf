output "cluster_name" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "kubeconfig" {
  description = "Kubeconfig content (sensitive). Use with caution."
  value       = module.eks.kubeconfig
  sensitive   = true
}
