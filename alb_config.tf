# Provision an ALB to handle the web traffic
resource "aws_alb" "webapp_alb" {
  name            = "webapp-alb"
  internal        = false
  security_groups = ["${aws_security_group.sg_webapp_alb.id}"]
  subnets         = ["${data.aws_subnet_ids.main.ids}"]

  tags {
    Environment = "production"
    Terraform   = "true"
    Owner       = "bsharkey"
  }
}

resource "aws_alb_target_group" "webapp_group" {
  name     = "webapp-lb-tg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_alb_listener" "webapp_front_end" {
  load_balancer_arn = "${aws_alb.webapp_alb.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.webapp_group.id}"
    type             = "forward"
  }
}
