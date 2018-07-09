data "aws_route53_zone" "domain_internal" {
  name         = "${var.env_domain}."
  private_zone = true
}

data "aws_route53_zone" "domain_external" {
  name         = "${var.env_domain}."
}

resource "aws_route53_record" "droneci_external" {
  zone_id = "${data.aws_route53_zone.domain_external.zone_id}"
  name    = "droneci.${var.env_domain}"
  type    = "A"

  alias {
    name                   = "${data.aws_ssm_parameter.alb_dns_name_public.value}"
    zone_id                = "${var.aws_alb_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "droneci_internal" {
  zone_id = "${data.aws_route53_zone.domain_internal.zone_id}"
  name    = "droneci.${var.env_domain}"
  type    = "A"

  alias {
    name                   = "${data.aws_ssm_parameter.alb_dns_name_internal.value}"
    zone_id                = "${var.aws_alb_zone_id}"
    evaluate_target_health = true
  }
}
