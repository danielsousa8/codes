resource "aws_iam_policy" "droneci_policy" {
  name = "droneci-policy-${terraform.workspace}"
  policy = "${data.aws_iam_policy_document.droneci.json}"
}

data "aws_iam_policy_document" "droneci" {

  statement {
    effect = "Allow"
    actions = [ "ecr:*" ]
    resources = [ "*" ]
  }

  statement {
    effect = "Allow"
    actions = [ "ecs:*" ]
    resources = ["*"]
  }
  
  statement {
    effect = "Allow"
    actions = [ "s3:*" ]
    resources = ["*"]
  }
  
  statement {
    effect = "Allow"
    actions = [ "logs:CreateLogStream", "logs:PutLogEvents" ]
    resources = [ "*" ]
  }
  
  statement {
    effect = "Deny"
    actions =  [
      "ecr:Delete*",
      "ecs:Delete*",
      "s3:Delete*"
    ]
    resources = [
      "*"
    ]
  }
  
 statement {
    effect = "Allow"
    actions = [ "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
                "elasticloadbalancing:DeregisterTargets",
                "elasticloadbalancing:Describe*",
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                "elasticloadbalancing:RegisterTargets" ]
    resources = ["*"]
  }

}
