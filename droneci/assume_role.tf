data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = [ "sts:AssumeRole" ]

    principals {
      type        = "Service"
      identifiers = [
        "sns.amazonaws.com",
        "lambda.amazonaws.com",
        "cloudformation.amazonaws.com",
        "ecs.amazonaws.com",
        "ec2.amazonaws.com",
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}

