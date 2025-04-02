# variables.tf

variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
  default     = "spark"
}

variable "aws_region" {
  description = "Região AWS onde o cluster será criado"
  type        = string
  default     = "us-east-1"
}

variable "node_instance_type" {
  description = "Tipo de instância para os nós workers"
  type        = string
  default     = "t3.medium"
}

variable "node_desired_capacity" {
  description = "Número desejado de nós workers (0 para desligar quando não estiver em uso)"
  type        = number
  default     = 2 # Reduzido para economizar custos
}

variable "node_max_capacity" {
  description = "Número máximo de nós workers"
  type        = number
  default     = 3 # Reduzido para limitar gastos
}

variable "node_min_capacity" {
  description = "Número mínimo de nós workers (0 permite desligar completamente)"
  type        = number
  default     = 1 # Permite desligar completamente quando não estiver em uso
}