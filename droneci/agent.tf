data "template_file" "droneci_agent_task_definition" {
  template         = "${file("task-definitions/droneci-agent.json")}"
  vars {
    drone_version              = "${var.drone_version}"
    environment                = "${terraform.workspace}"
    container_cpu              = "${var.container_cpu}"
    container_memory           = "${var.container_memory}"
    DRONE_SERVER               = "${data.aws_ssm_parameter.DRONE_SERVER.value}"
    DRONE_SECRET               = "${data.aws_ssm_parameter.DRONE_SECRET.value}"
  }
}

resource "aws_ecs_task_definition" "droneci_agent" {
  family                = "droneci-agent-${terraform.workspace}"
  container_definitions = "${data.template_file.droneci_agent_task_definition.rendered}"
  task_role_arn         = "${aws_iam_role.droneci_role.arn}"

  volume {
    name      = "dockersock"
    host_path = "/var/run/docker.sock"
  }
}

resource "aws_ecs_service" "droneci_agent" {
  name                = "droneci-agent-${terraform.workspace}"
  cluster             = "${var.cluster}"
  desired_count       = "${var.desired_count_agent}"
  task_definition     = "${aws_ecs_task_definition.droneci_agent.arn}"
}
