resource "aws_iam_role" "droneci_role" {
  name = "droneci-role-${terraform.workspace}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "droneci-policy" {
  role       = "${aws_iam_role.droneci_role.name}"
  policy_arn = "${aws_iam_policy.droneci_policy.arn}"
}
