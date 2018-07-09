resource "aws_service_discovery_service" "drone-server" {
  name = "drone-server"
  dns_config {
    namespace_id = "${data.aws_ssm_parameter.service_discovery.value}"
    dns_records {
      ttl = 10
      type = "A"
    }
    routing_policy = "MULTIVALUE"
  }
  
  health_check_custom_config {
    failure_threshold = 10
  }
}
