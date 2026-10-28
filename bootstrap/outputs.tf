output "state_bucket_name" {
  description = "S3 bucket used to store Terraform states."
  value       = aws_s3_bucket.state.id
}