# terraform-sample

I used [terraform](https://www.terraform.io/docs/providers/aws/) with the AWS provider to provision an ECS cluster to run the required container.
###### Terraform Resources used

##### aws_ami
By using the data resource I was able to find the most up to date release of Container Linux from CoreOS to use as my ami for each instance.

##### aws_security_group
I setup two security groups, one for the webapp server and one for the ALB.  I setup restrictions on ingress to an admin cidr on webapp security group. The ALB allows all inbond traffic on port 80 forwarded to port 5000. The webapp server allows inbound traffic on port 3000 from the ALB.  Both security groups were granted egress access by default terraform removes this option.

##### aws_instance
Using the AMI info found earlier I provisioned an autoscaling group to be part of the ecs cluster.  This ASG used the [Cloud-Config](data/cloud-config.yml) to setup the AWS ECS Agent and log drivers before joining the ecs cluster.

##### aws_iam
Created an IAM role for the ECS cluster to be able to register nodes with the ALB.  The [Instance-profile](data/instance-profile-policy.json) allows the nodes to talk to the cloudwatch groups for logging and to talk to the ECS cluster.

##### aws_alb
Povisioned an ALB to be attached to the ECS cluster and forward traffic to demo app target group.

##### aws_ecs_cluster
Created a cluster with task definition listed under [Webapp Task](data/webapp-task.json) and an ECS service that maps that task to the alb.

##### aws_cloudwatch_log_group
Create two log groups for the ECS cluster to use, one for the application and one for the host.

### How to Run
1. [Install Terraform](https://www.terraform.io/downloads.html)
2. Configure your AWS credentials with the aws cli
3. Clone this repo
4. Create `terraform.tfvars` file with the variables required, read `variables.tf` for more info
5. Run `terraform init` to install terraform dependencies
6. Run `terraform plan` to see what aws resources it will provision, 2 security groups and 2 instances
7. Run `terraform apply` to create the resources in aws
8. Terraform will output the ALB Hostname, ASG Name, Instance Security Group IDs and the Launch Configuration Name

### Reasoning, Options and Issues
My reasoning behind using Terraform and AWS is that I have a lot of experience using it to provision systems and environments. Also I feel it is a lot easier to use and work with than cloudformation templates.  I have never used ECS before but it fit the requirements listed pretty well and was very easy to get setup and working. I have also never directly integrated systems to cloudwatch but found that to be equally as easy. 

##### Options
* Use a kubernetes environment if I had one available and provisioning a cluster was outside the scope of this task.
* Use AWS Fargate instead of managing my own EC2 instances
* Use Azure over AWS, I already have an AWS account so I chose to use that.