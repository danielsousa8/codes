data "aws_ssm_parameter" "DRONE_OPEN" {
  name  = "/${terraform.workspace}/droneci/DRONE_OPEN"
}
data "aws_ssm_parameter" "DRONE_HOST" {
  name  = "/${terraform.workspace}/droneci/DRONE_HOST"
}
data "aws_ssm_parameter" "DRONE_GITHUB" {
  name  = "/${terraform.workspace}/droneci/DRONE_GITHUB"
}
data "aws_ssm_parameter" "DRONE_GITHUB_CLIENT" {
  name  = "/${terraform.workspace}/droneci/DRONE_GITHUB_CLIENT"
}
data "aws_ssm_parameter" "DRONE_GITHUB_SECRET" {
  name  = "/${terraform.workspace}/droneci/DRONE_GITHUB_SECRET"
}
data "aws_ssm_parameter" "DRONE_SECRET" {
  name  = "/${terraform.workspace}/droneci/DRONE_SECRET"
}
data "aws_ssm_parameter" "DRONE_SERVER" {
  name  = "/${terraform.workspace}/droneci/DRONE_SERVER"
}
data "aws_ssm_parameter" "DRONE_SERVER_ADDR" {
  name  = "/${terraform.workspace}/droneci/DRONE_SERVER_ADDR"
}
data "aws_ssm_parameter" "DRONE_GITHUB_SKIP_VERIFY" {
  name  = "/${terraform.workspace}/droneci/DRONE_GITHUB_SKIP_VERIFY"
}
data "aws_ssm_parameter" "DRONE_ADMIN" {
  name  = "/${terraform.workspace}/droneci/DRONE_ADMIN"
}
data "aws_ssm_parameter" "DRONE_DATABASE_DRIVER" {
  name  = "/${terraform.workspace}/droneci/DRONE_DATABASE_DRIVER"
}
data "aws_ssm_parameter" "DRONE_DATABASE_DATASOURCE" {
  name  = "/${terraform.workspace}/droneci/DRONE_DATABASE_DATASOURCE"
}
data "aws_ssm_parameter" "ALB_LISTENER_PUBLIC" {
  name  = "/${terraform.workspace}/ALB_LISTENER_PUBLIC"
}
data "aws_ssm_parameter" "alb_dns_name_public" {
  name  = "/${terraform.workspace}/ALB_DNS_NAME_PUBLIC"
}
data "aws_ssm_parameter" "alb_dns_name_internal" {
  name  = "/${terraform.workspace}/ALB_DNS_NAME_INTERNAL"
}

data "aws_ssm_parameter" "service_discovery" {
  name  = "/${terraform.workspace}/servicediscovery/NAMESPACE-ID"
}
