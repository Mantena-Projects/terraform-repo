# Create a launch configuration for the Autoscalling-EC2 instances
resource "aws_launch_configuration" "public_web_launch_config" {
  image_id                    = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  user_data                   = file("userdata.sh")

  lifecycle {
    create_before_destroy = true
  }
}

# Create an Auto Scaling group for the EC2 instances
resource "aws_autoscaling_group" "public_web_autoscaling_group" {
  name                      = "public-web-asg"
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  launch_configuration      = aws_launch_configuration.public_web_launch_config.name
  target_group_arns         = [aws_lb_target_group.web.arn]
  vpc_zone_identifier       = [aws_subnet.public_subnet-1.id, aws_subnet.public_subnet-2.id]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "asg-instance"
    propagate_at_launch = true
  }
}

# Define a scaling policy to increase the number of instances when CPU utilization is above 80%
resource "aws_autoscaling_policy" "scale_up_policy" {
  name                   = "public-web-scale-up-policy"
  autoscaling_group_name = aws_autoscaling_group.public_web_autoscaling_group.name
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  policy_type            = "SimpleScaling"
  scaling_adjustment     = 1

  metric_aggregation_type = "Average"
}

# Define a scaling policy to decrease the number of instances when CPU utilization is below 20%
resource "aws_autoscaling_policy" "scale_down_policy" {
  name                   = "public-web-scale-down-policy"
  autoscaling_group_name = aws_autoscaling_group.public_web_autoscaling_group.name
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  policy_type            = "SimpleScaling"
  scaling_adjustment     = -1

  metric_aggregation_type = "Average"

}


# Trigger the scale-up policy when CPU utilization is above 80% 
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_scale_up" {
  alarm_name          = "public-web-cpu-utilization-scale-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Scale up the number of instances when CPU utilization is above 80%"
  alarm_actions       = [aws_autoscaling_policy.scale_up_policy.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.public_web_autoscaling_group.name
  }
}


# Trigger the scale-down policy when CPU utilization is below 20
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_scale_down" {
  alarm_name          = "public-web-cpu-utilization-scale-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 20
  alarm_description   = "Scale down the number of instances when CPU utilization is below 20%"
  alarm_actions       = [aws_autoscaling_policy.scale_down_policy.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.public_web_autoscaling_group.name
  }

}





