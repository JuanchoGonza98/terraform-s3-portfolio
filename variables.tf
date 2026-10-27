variable "aws_region" {
  description = "Región AWS donde desplegaremos los recursos."
  type        = string
  default     = "us-east-1"
}
variable "project_name" {
  description = "Nombre del proyecto."
  type        = string
  default     = "terraform-s3-lab"
}

variable "environment" {
  description = "Ambiente de despliegue."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "hml"], var.environment)
    error_message = "El ambiente debe ser dev o hml."
  }
}