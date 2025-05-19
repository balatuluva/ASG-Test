resource "aws_instance" "ASG_EC2" {
  count = length(var.ASG_VPC_Private_Subnet)
  ami = "ami-0f2395d904f76221d"
  availability_zone = element(var.azs, count.index)
  instance_type = "t2.micro"
  key_name = var.key_name
  subnet_id = aws_subnet.ASG_VPC_Private_Subnet[count.index].id
  vpc_security_group_ids = ["${aws_security_group.ASG_VPC_SG.id}"]
  associate_public_ip_address = false
  iam_instance_profile = "Delete-Later"

  tags = {
    Name = element(var.EC2-Name, count.index)
  }
}