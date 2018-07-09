data "template_file" "droneci_server_task_definition" {
  template         = "${file("task-definitions/droneci-server.json")}"
  vars {
    drone_version              = "${var.drone_version}"
    environment                = "${terraform.workspace}"
    log_group                  = "${var.log_group}"
    alb_port                   = "${var.alb_port}"
    agent_port                 = "${var.agent_port}"
    container_cpu              = "${var.container_cpu}"
    container_memory           = "${var.container_memory}"
    DRONE_OPEN                 = "${data.aws_ssm_parameter.DRONE_OPEN.value}"
    DRONE_HOST                 = "${data.aws_ssm_parameter.DRONE_HOST.value}"
    DRONE_SERVER_ADDR          = "${data.aws_ssm_parameter.DRONE_SERVER_ADDR.value}"
    DRONE_GITHUB               = "${data.aws_ssm_parameter.DRONE_GITHUB.value}"
    DRONE_GITHUB_CLIENT        = "${data.aws_ssm_parameter.DRONE_GITHUB_CLIENT.value}"
    DRONE_GITHUB_SECRET        = "${data.aws_ssm_parameter.DRONE_GITHUB_SECRET.value}"
    DRONE_SECRET               = "${data.aws_ssm_parameter.DRONE_SECRET.value}"
    DRONE_GITHUB_SKIP_VERIFY   = "${data.aws_ssm_parameter.DRONE_GITHUB_SKIP_VERIFY.value}"
    DRONE_SERVER               = "${data.aws_ssm_parameter.DRONE_SERVER.value}"
    DRONE_SECRET               = "${data.aws_ssm_parameter.DRONE_SECRET.value}"
    DRONE_ADMIN                = "${data.aws_ssm_parameter.DRONE_ADMIN.value}"
    DRONE_DATABASE_DRIVER      = "${data.aws_ssm_parameter.DRONE_DATABASE_DRIVER.value}"
    DRONE_DATABASE_DATASOURCE  = "${data.aws_ssm_parameter.DRONE_DATABASE_DATASOURCE.value}"
  }
}

resource "aws_ecs_task_definition" "droneci_server" {
  cpu                      = "${var.task_cpu}"
  memory                   = "${var.task_memory}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = "${aws_iam_role.droneci_role.arn}"
  execution_role_arn       = "${aws_iam_role.droneci_role.arn}"
  family                   = "droneci-server-${terraform.workspace}"
  container_definitions    = "${data.template_file.droneci_server_task_definition.rendered}"
}

data "aws_ecs_task_definition" "droneci_server" {
  task_definition = "${aws_ecs_task_definition.droneci_server.family}"
}

resource "aws_ecs_service" "droneci_server" {
  name                = "droneci-server-${terraform.workspace}"
  cluster             = "${var.cluster}"
  desired_count       = 1
  task_definition     = "${aws_ecs_task_definition.droneci_server.family}:${max("${aws_ecs_task_definition.droneci_server.revision}", "${data.aws_ecs_task_definition.droneci_server.revision}")}"
  launch_type         = "FARGATE"

  network_configuration {
    security_groups   = ["${aws_security_group.default.id}"]
    subnets           = ["${var.subnets_priv}"]
  assign_public_ip    = "true"
  }
  
  service_registries {
    registry_arn   =  "${aws_service_discovery_service.drone-server.arn}" 
  }
  
  load_balancer {
    target_group_arn  = "${aws_lb_target_group.droneci_web.arn}"
    container_name    = "droneci-server-${terraform.workspace}"
    container_port    = "${var.alb_port}"
  }
}
