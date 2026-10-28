variable "bucket_name" {
  description = "Name of the S3 bucket hosting the website assets."
  type        = string
}

variable "tags" {
  description = "Tags applied to the module resources."
  type        = map(string)
}
variable "noncurrent_version_retention_days" {
  description = "Days to retain noncurrent S3 object versions."
  type        = number

  validation {
    condition = (
      var.noncurrent_version_retention_days >= 1 &&
      floor(var.noncurrent_version_retention_days) == var.noncurrent_version_retention_days
    )
    error_message = "Retention must be a positive whole number of days."
  }
}
variable "cloudfront_distribution_arn" {
  description = "CloudFront distribution ARN authorized to read S3 objects."
  type        = string
  default     = null
}