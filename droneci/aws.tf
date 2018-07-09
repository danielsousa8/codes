provider "aws" {
  assume_role {
    role_arn = "${var.role_arn}"
    session_name = "admin"
  }
}
