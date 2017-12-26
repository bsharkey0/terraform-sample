output "instance_security_group" {
  value = "${aws_security_group.sg_webapp.id}"
}

output "launch_configuration" {
  value = "${aws_launch_configuration.webapp.id}"
}

output "asg_name" {
  value = "${aws_autoscaling_group.webapp.id}"
}

output "alb_hostname" {
  value = "${aws_alb.webapp_alb.dns_name}"
}