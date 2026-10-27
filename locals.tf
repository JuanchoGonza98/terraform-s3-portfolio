locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Service     = "portfolio-web"
  }

  website_files = {
    "index.html"   = "text/html; charset=utf-8"
    "project.json" = "application/json"
  }
}