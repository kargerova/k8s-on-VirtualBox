variable "worker_nodes_count" {
    description = "Count of k8s worker nodes"
    default     = 2
    type        = number
}

variable "cp_nodes_count" {
    description = "Count of k8s control plane nodes"
    default     = 3
    type        = number
}