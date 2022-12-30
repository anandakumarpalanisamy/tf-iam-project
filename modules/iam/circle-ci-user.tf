resource "aws_iam_user" "circleci" {
  name = "circleci"
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_access_key" "circleci" {
  user = aws_iam_user.circleci.name
}

resource "aws_iam_user_policy" "circleci-policy" {
  name = "circleci-policy"
  user = aws_iam_user.circleci.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
          "ecr:*",
          "cloudtrail:LookupEvents"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
          "autoscaling:Describe*",
          "autoscaling:UpdateAutoScalingGroup",
          "cloudformation:CreateStack",
          "cloudformation:DeleteStack",
          "cloudformation:DescribeStack*",
          "cloudformation:UpdateStack",
          "cloudwatch:GetMetricStatistics",
          "ec2:Describe*",
          "elasticloadbalancing:*",
          "ecs:*",
          "events:DescribeRule",
          "events:DeleteRule",
          "events:ListRuleNamesByTarget",
          "events:ListTargetsByRule",
          "events:PutRule",
          "events:PutTargets",
          "events:RemoveTargets",
          "iam:ListInstanceProfiles",
          "iam:ListRoles",
          "iam:PassRole"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "lambda:UpdateFunctionCode",
        "lambda:UpdateFunctionConfiguration",
        "lambda:GetFunctionConfiguration"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}