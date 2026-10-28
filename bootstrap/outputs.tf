output "state_bucket_name" {
  description = "S3 bucket used to store Terraform states."
  value       = aws_s3_bucket.state.id
}
output "github_dev_role_arn" {
  description = "IAM role ARN assumed by the GitHub Actions DEV pipeline."
  value       = aws_iam_role.github_dev.arn
}