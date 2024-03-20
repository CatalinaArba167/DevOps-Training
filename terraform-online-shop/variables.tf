variable "ssh_key_name" {
  description = "The name of the SSH key pair"
  default     = "terraform-ssh-key"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "rds_instance_type" {
  description = "RDS instance type"
  default     = "db.t3.micro"
}

variable "elasticache_instance_type" {
  description = "ElastiCache instance type"
  default     = "cache.t3.micro"
}

variable "application_version" {
  description = "Version of the application to deploy"
  type        = string
  default     = "v0.0.1"
}

variable "my_ip" {
  description = "The IP of my computer"
  default     = "147.161.131.86/32"
}

variable "docker_image_tag" {
  description = "Docker image tag to pull from ECR and run on EC2 instances"
  default     = "74f2062a6d507654e6466217bb5437675ed4240f"
  type        = string
}


locals {
  rds_endpoint  = "jdbc:postgresql://${aws_db_instance.OnlineShopDatabase.endpoint}/postgres"
  radis_endpoint = aws_elasticache_cluster.terraform_online_shop_cache_cluster.cache_nodes[0].address
  jar_url = "https://github.com/msg-CareerPaths/aws-devops-demo-app/releases/download/${var.application_version}/online-shop-${var.application_version}.jar"
}