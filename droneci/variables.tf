variable "role_arn" {}
variable "log_group" {}
variable "env_domain" {}
variable "alb_port" { default = "80" }
variable "task_cpu" { default = "256" }
variable "task_memory" { default = "512" }
variable "container_cpu" { default = "128" }
variable "container_memory" { default = "512" }
variable "agent_port" { default = "9000" }
variable "cluster" { default = "xxxxx" }
variable "subnets_priv" { type = "list" }
variable "vpc" { default = "xxxxxx" }
variable "drone_version" { default = "0.8" }
variable "desired_count_agent" { default = "2" }
variable "aws_alb_zone_id" { default = "xxxxxxx" }
variable "ecr" { default = "xxxxxxxx.dkr.ecr.us-east-1.amazonaws.com" }
