variable "instance_name" {
  description = "Name of the EC2 instance"
  type = string
  default = "GroceryStoreApplication_TF"
}
variable "instance_type" {
  description = "EC instance type"
  type = string
  default = "t2.micro"
}
variable "key_pair_name" {
  description = "Name of the existing AWS key pair"
  type        = string
  default     = "suma_key"
}
variable "aws_region" {
  description = "AWS region to deploy resources"
  type = string
  default = "eu-central-1"
}
variable "profile" {
  description = "AWS Profile"
  type = string
  default = "default"
}

variable "ami" {
  description = "AWS AMI"
  type = string
  default = "ami-08aa372c213609089"
}

