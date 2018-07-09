resource "aws_lb_target_group" "droneci_web" {
  name     = "droneci-${terraform.workspace}"
  port     = "${var.alb_port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc}"
  target_type = "ip"

  health_check {
    path                = "/"
    matcher             = "200"
    timeout             = "5"
    healthy_threshold   = "3"
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener_rule" "droneci_web" {
  listener_arn = "${data.aws_ssm_parameter.ALB_LISTENER_PUBLIC.value}"
  priority     = "13"

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.droneci_web.arn}"
  }

  condition {
    field  = "host-header"
    values = ["droneci.${var.env_domain}"]
  }
}
