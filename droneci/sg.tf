resource "aws_security_group" "default" {
  name        = "drone-server-${terraform.workspace}"
  vpc_id      = "${var.vpc}"

  ingress {
    from_port = "${var.alb_port}"
    to_port   = "${var.alb_port}"
    protocol  = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port = "${var.agent_port}"
    to_port   = "${var.agent_port}"
    protocol  = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
