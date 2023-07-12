provider "aws" {}

# ---------------------------- #
# Restrict AWS REGIONS 
# ---------------------------- #

data "aws_iam_policy_document" "restrict_regions" {
  statement {
    sid    = "RestrictAWSRegions"
    effect = "Deny"
    not_actions = [
      "a4b:*",
      "budgets:*",
      "ce:*",
      "chime:*",
      "cloudfront:*",
      "cur:*",
      "globalaccelerator:*",
      "health:*",
      "iam:*",
      "importexport:*",
      "mobileanalytics:*",
      "organizations:*",
      "route53:*",
      "route53domains:*",
      "shield:*",
      "support:*",
      "trustedadvisor:*",
      "waf:*",
      "wellarchitected:*"
    ]
    resources = ["*"]

    condition {
      test     = "StringNotEquals"
      variable = "aws:RequestedRegion"

      values = [
        "us-east-1",
        "us-east-2"
      ]
    }
  }
}

resource "aws_organizations_policy" "restrict_regions" {
  name        = "restrict_regions"
  description = "Deny all regions except US East 1."
  content     = data.aws_iam_policy_document.restrict_regions.json
}

resource "aws_organizations_policy_attachment" "restrict_regions" {
  policy_id = aws_organizations_policy.restrict_regions.id
  target_id = "541383790912"
}

# ---------------------------- #
# Restrict EC2 Instances 
# ---------------------------- #

data "aws_iam_policy_document" "restrict_ec2_instances" {
  statement {
    sid       = "RestrictEc2Instances"
    effect    = "Deny"
    actions   = ["ec2:RunInstances"]
    resources = ["arn:aws:ec2:*:*:instance/*"]

    condition {
      test     = "StringNotEquals"
      variable = "ec2:InstanceType"

      values = [
        "t3*"
      ]
    }
  }
}

resource "aws_organizations_policy" "restrict_ec2_instances" {
  name        = "restrict_ec2_instances"
  description = "Allow certain EC2 instance types only."
  content     = data.aws_iam_policy_document.restrict_ec2_instances.json
}

resource "aws_organizations_policy_attachment" "restrict_ec2_instances_on_root" {
  policy_id = aws_organizations_policy.restrict_ec2_instances.id
  target_id = "541383790912"
}
