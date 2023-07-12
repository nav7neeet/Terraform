provider "aws" {}

# data "aws_iam_policy_document" "vpc_flow_logs" {
#   statement {
#     sid    = "vpcFlowLogs"
#     effect = "Deny"
#     actions = [
#       "ec2:DeleteFlowLogs",
#       "logs:DeleteLogGroup",
#       "logs:DeleteLogStream"
#     ]
#     resources = ["*"]
#   }
# }

resource "aws_organizations_policy" "vpc_flow_logs" {
  name        = "vpc_flow_logs"
  description = "protect vpc flow logs"
  content     = data.aws_iam_policy_document.vpc_flow_logs.json
  # content = file("${path.module}/vpc-flow-logs.json")
}

resource "aws_organizations_policy_attachment" "vpc_flow_logs" {
  policy_id = aws_organizations_policy.vpc_flow_logs.id
  target_id = "541383790912"
}
