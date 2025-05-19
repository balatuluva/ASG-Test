resource "aws_lb_target_group" "ASG-TG" {
  name     = "ASG-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ASG_VPC.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-299"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "ASG-TG"
  }
}

resource "aws_lb" "ASG-LB" {
  name               = "ASG-LB"
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.ASG_VPC_Public_Subnet[*].id
  security_groups    = [aws_security_group.ASG_VPC_SG.id]

  tags = {
    Name = "ASG-LB"
  }
}

resource "aws_lb_listener" "ASG-LB-listener" {
  load_balancer_arn = aws_lb.ASG-LB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ASG-TG.arn
  }
}