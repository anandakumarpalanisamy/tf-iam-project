resource "aws_api_gateway_rest_api" "rest_api" {
  name = "sample-api"

  endpoint_configuration {
    types = [ "PRIVATE" ]
  }
}

data "aws_api_gateway_rest_api" "rest_api" {
  name = "sample-api"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_api_gateway_rest_api_policy" "rest_api_policy" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  policy = data.aws_iam_policy_document.rest_api_policy.json
}

data "aws_iam_policy_document" "rest_api_policy" {
  version = "2012-10-17"
    statement {
    effect  = "Deny"
    actions = ["execute-api:Invoke"]
    principals {
      type = "AWS"
      identifiers = [
        "*"
      ]
    }
    resources = [
      "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${data.aws_api_gateway_rest_api.rest_api.id}/*"
    ]
    condition {
      test = "StringNotEquals"
      variable = "aws:SourceVpce"
      values = [
        "vpce-1a2b3c4d"
      ]
    }
  }
  statement {
    effect  = "Allow"
    actions = ["execute-api:Invoke"]
    principals {
      type = "AWS"
      identifiers = [
        "*"
      ]
    }
    resources = [
      "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${data.aws_api_gateway_rest_api.rest_api.id}/*"
    ]
  }
}

# resource "aws_api_gateway_rest_api_policy" "rest_api_policy" {
#   rest_api_id = aws_api_gateway_rest_api.rest_api.id

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Deny",
#       "Principal": {
#         "AWS": "*"
#       },
#       "Action": "execute-api:Invoke",
#       "Resource": "execute-api:/*",
#       "Condition": {
#         "StringNotEquals": {
#           "aws:SourceVpce": "vpce-1a2b3c4d"
#         }
#       }
#     },
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "*"
#       },
#       "Action": "execute-api:Invoke",
#       "Resource": "execute-api:/*"
#     }
#   ]
# }
# EOF
# }

# resource "aws_api_gateway_rest_api_policy" "rest_api_policy" {
#   rest_api_id = aws_api_gateway_rest_api.rest_api.id

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::<account_id>:user/Administrator"
#       },
#       "Action": "execute-api:Invoke",
#       "Resource": "execute-api:/*"
#     }
#   ]
# }
# EOF
# }