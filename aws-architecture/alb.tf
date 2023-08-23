# Create Apllication Load Balancer
resource "aws_lb" "public_web_loadbalancer" {
  name               = "public-web-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_subnet-1.id, aws_subnet.public_subnet-2.id]
  security_groups    = [aws_security_group.lb_sg.id]
  tags = {
    Name = "public_web_loadbalancer"
  }
}

#listner
resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.public_web_loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.web.arn
    type             = "forward"
  }
}


# Create a target group for the load balancer
resource "aws_lb_target_group" "web" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terraform_vpc.id

  health_check {
    path = "/"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# Associate the target group with the EC2 instances created by autoscaling
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.public_web_autoscaling_group.name
  alb_target_group_arn   = aws_lb_target_group.web.arn
}
