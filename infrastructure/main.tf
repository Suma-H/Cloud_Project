provider "aws" {
  region = var.aws_region
  profile = var.profile
}

resource "aws_security_group" "EC2_SG" {

  name  = "EC2_SecGrp"
  description =  "Allow HTTP and SSH traffic"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "grocerystore_application" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.EC2_SG.id]
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }

  user_data = <<-EOF
            #!/bin/bash
            yum update -y
            yum install -y httpd
            systemctl start httpd
            systemctl enable httpd
            echo "Hello World! > /var/www/html/index.html
            EOF
}

resource "aws_s3_bucket" "avatars-users" {
  bucket = "grocerymate-avatars-users"

  tags = {
    Name = "grocerymate-avatars-user"
    Environment = "Dev"
  }
}
resource "aws_sns_topic" "topic" {
  name = "WebServer-CPU_Utilization_alert"
}

####################################################
# Create a cloudwatch alarm for EC2 instances and alarm_actions to SNS topic
####################################################
resource "aws_cloudwatch_metric_alarm" "CPU_Utilisation" {
  alarm_name                = "terraform-test-CPUUtilisation"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "10"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  dimensions                = {       InstanceId = aws_instance.grocerystore_application.id    }
  insufficient_data_actions = []
}