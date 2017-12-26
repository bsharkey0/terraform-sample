resource "aws_ecs_cluster" "webapp-ecs" {
  name = "${var.ecs_cluster_name}"
}

data "template_file" "task_definition" {
  template = "${file("${path.module}/data/webapp-task.json")}"

  vars {
    image_url        = "${var.image_url}"
    container_name   = "${var.container_name}"
    log_group_region = "${var.aws_region}"
    log_group_name   = "${aws_cloudwatch_log_group.app.name}"
  }
}

resource "aws_ecs_task_definition" "webapp" {
  family                = "service"
  container_definitions = "${data.template_file.task_definition.rendered}"
}

resource "aws_ecs_service" "webapp-demo" {
  name            = "ecs-webapp-demo"
  cluster         = "${aws_ecs_cluster.webapp-ecs.id}"
  task_definition = "${aws_ecs_task_definition.webapp.arn}"
  desired_count   = 1
  iam_role        = "${aws_iam_role.ecs_service.name}"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.webapp_group.arn}"
    container_name   = "${var.container_name}"
    container_port   = 5000
  }

  depends_on = [
    "aws_iam_role_policy.ecs_service",
    "aws_alb_listener.webapp_front_end",
  ]
}

## CloudWatch Logs

resource "aws_cloudwatch_log_group" "ecs" {
  name = "tf-ecs-group/ecs-agent"
}

resource "aws_cloudwatch_log_group" "app" {
  name = "tf-ecs-group/app-webapp-demo"
}