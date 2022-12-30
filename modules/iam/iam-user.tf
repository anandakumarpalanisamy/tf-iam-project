resource "aws_iam_user" "user" {
  name = "github-actions-tf-user"
}

resource "aws_iam_policy" "policy" {
  name        = "deploy-dev-policy"
  description = "A policy created for developers to perform deployments"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [ "ec2:Describe*" ],
        Effect = "Allow",
        Resource = "*"
      },
      {
        Action = [ "lambda:UpdateFunctionCode", "lambda:UpdateFunctionConfiguration", "lambda:GetFunctionConfiguration" ],
        Effect = "Allow",
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_user_policy_attachment" "dev-user-attach" {
  user        = aws_iam_user.user.name
  policy_arn  = aws_iam_policy.policy.arn
}