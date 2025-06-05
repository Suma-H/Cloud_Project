provider "aws" {
  region = var.aws_region
  profile = var.profile
}

/*
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
}

resource "aws_instance" "web_server_suma" {
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

 */

resource "aws_s3_bucket" "avatars-suma" {
  bucket = "grocerymate-avatars-suma"

  tags = {
    Name = "grocerymate-avatars-suma"
    Environment = "Dev"
  }
}