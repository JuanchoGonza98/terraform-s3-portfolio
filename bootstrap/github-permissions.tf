resource "aws_iam_role_policy" "github_dev" {
  name = "portfolio-dev-deployment"
  role = aws_iam_role.github_dev.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "ListDevState"
        Effect = "Allow"
        Action = ["s3:ListBucket"]

        Resource = aws_s3_bucket.state.arn

        Condition = {
          StringLike = {
            "s3:prefix" = ["portfolio/dev/*"]
          }
        }
      },
      {
        Sid    = "ReadWriteDevState"
        Effect = "Allow"
        Action = ["s3:GetObject", "s3:PutObject"]

        Resource = [
          "${aws_s3_bucket.state.arn}/portfolio/dev/terraform.tfstate",
          "${aws_s3_bucket.state.arn}/portfolio/dev/terraform.tfstate.tflock"
        ]
      },
      {
        Sid      = "ReleaseDevStateLock"
        Effect   = "Allow"
        Action   = ["s3:DeleteObject"]
        Resource = "${aws_s3_bucket.state.arn}/portfolio/dev/terraform.tfstate.tflock"
      },
      {
        Sid    = "ManageExistingDevBucketConfiguration"
        Effect = "Allow"

        Action = [
          "s3:Get*",
          "s3:ListBucket",
          "s3:ListBucketVersions",
          "s3:PutBucketPolicy",
          "s3:PutBucketPublicAccessBlock",
          "s3:PutBucketVersioning",
          "s3:PutBucketTagging",
          "s3:PutEncryptionConfiguration",
          "s3:PutLifecycleConfiguration"
        ]

        Resource = "arn:aws:s3:::terraform-s3-lab-dev-${data.aws_caller_identity.current.account_id}"
      },
      {
        Sid    = "ManageDevWebsiteObjects"
        Effect = "Allow"

        Action = [
          "s3:GetObject*",
          "s3:PutObject",
          "s3:PutObjectTagging",
          "s3:PutObjectVersionTagging",
          "s3:DeleteObject",
          "s3:DeleteObjectTagging",
          "s3:DeleteObjectVersionTagging"
        ]

        Resource = "arn:aws:s3:::terraform-s3-lab-dev-${data.aws_caller_identity.current.account_id}/*"
      },
      {
        Sid    = "ManageExistingDevDistribution"
        Effect = "Allow"

        Action = [
          "cloudfront:GetDistribution",
          "cloudfront:GetDistributionConfig",
          "cloudfront:UpdateDistribution",
          "cloudfront:ListTagsForResource",
          "cloudfront:TagResource",
          "cloudfront:UntagResource",
          "cloudfront:CreateInvalidation",
          "cloudfront:GetInvalidation"
        ]

        Resource = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/E272ROGO886AWD"
      },
      {
        Sid    = "ReadExistingDevOriginAccessControl"
        Effect = "Allow"

        Action = [
          "cloudfront:GetOriginAccessControl",
          "cloudfront:GetOriginAccessControlConfig"
        ]

        Resource = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:origin-access-control/E3QGUPVOQIVIJ9"
      },
      {
        Sid    = "ReadCachePolicies"
        Effect = "Allow"

        Action = [
          "cloudfront:ListCachePolicies",
          "cloudfront:GetCachePolicy",
          "cloudfront:GetCachePolicyConfig"
        ]

        Resource = "*"
      }
    ]
  })
}