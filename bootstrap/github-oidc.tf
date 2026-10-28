resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = ["sts.amazonaws.com"]

  tags = local.tags
}

resource "aws_iam_role" "github_dev" {
  name        = "terraform-s3-lab-github-dev"
  description = "Temporary AWS access for the portfolio DEV pipeline."

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
            "token.actions.githubusercontent.com:sub" = "repo:JuanchoGonza98@72740630/terraform-s3-portfolio@1436450217:ref:refs/heads/main"
          }
        }
      }
    ]
  })

  tags = local.tags
}