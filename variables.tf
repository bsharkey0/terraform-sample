variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-1"
}
variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = "2"
}

variable vpc_id {
    description = "AWS VPC ID to use."
}

variable "key_name" {
    description = "AWS key pair name to use."
}

variable "instance_type" {
    default = "t2.micro"
    description = "AWS instance type"
}

variable "bucket_name" {
    description = "S3 bucket name, must be unique"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "1"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "2"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "1"
}

variable "admin_cidr_ingress" {
  description = "CIDR to allow tcp/22 ingress to EC2 instance"
}

variable "ecs_cluster_name" {
    description = "ECS Cluster name"
    default = "webapp-cluster"
}

variable "image_url" {
    description = "Docker image url"
}

variable "container_name" {
    description = "Docker container name"
}
