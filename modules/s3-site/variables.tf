variable "bucket_name" {
  description = "Name of the S3 bucket hosting the website assets."
  type        = string
}

variable "tags" {
  description = "Tags applied to the module resources."
  type        = map(string)
}