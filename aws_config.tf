provider "aws" {
  region = "${var.aws_region}"
  version = "~> 1.6" # Lockdown the version
}


# Get subnets in existing vpc
data "aws_subnet_ids" "main" {
  vpc_id = "${var.vpc_id}"
}