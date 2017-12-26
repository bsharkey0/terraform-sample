# Create our app server security group
resource "aws_security_group" "sg_webapp" {
  name        = "allow_webapp"
  description = "Allow all inbound traffic on port 5000 and ssh and all egress traffic."
  vpc_id      = "${var.vpc_id}"

  # Web App port
  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = ["${aws_security_group.sg_webapp_alb.id}"]
  }

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.admin_cidr_ingress}"] # set to cidr needed
  }

  # This is for outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name      = "allow_webapp"
    Terraform = "true"
  }
}

resource "aws_security_group" "sg_webapp_alb" {
  name        = "allow_alb_webapp"
  description = "Allow all inbound traffic on port 80 mapped to 5000 and all egress traffic."
  vpc_id      = "${var.vpc_id}"

  # Web App port forwarded
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # This is for outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name      = "allow_alb_webapp"
    Terraform = "true"
  }
}
