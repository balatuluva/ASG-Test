resource "aws_launch_template" "ASG-LT" {
  name_prefix   = "ASG-LT"
  image_id      = "ami-0f2395d904f76221d" # Bala own ami image
  instance_type = "t2.micro"
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.ASG_VPC_SG.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ASG-LT"
    }
  }
}