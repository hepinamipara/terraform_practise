resource "aws_autoscaling_group" "myasgfrontend" {
  name_prefix         = "myasgfrontend"
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.pvt3.id, aws_subnet.pvt4.id]
  target_group_arns   = [aws_lb_target_group.myfronttg.arn]

  health_check_type = "EC2"
  #health_check_grace_period = 300 # default is 300 seconds  
  # Launch Template
  launch_template {
    id      = aws_launch_template.frontend.id
    version = aws_launch_template.frontend.latest_version
  }
  # Instance Refresh
  instance_refresh {
    strategy = "Rolling"
    preferences {
      #instance_warmup = 300 # Default behavior is to use the Auto Scaling Group's health check grace period.
      min_healthy_percentage = 50
    }
    triggers = [/*"launch_template",*/ "desired_capacity"] # You can add any argument from ASG here, if those has changes, ASG Instance Refresh will trigger
  }
  tag {
    key                 = "Name"
    value               = "myasgfrontend"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "myasgbackend" {
  name_prefix         = "myasgbackend"
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.pvt5.id, aws_subnet.pvt6.id]
  target_group_arns   = [aws_lb_target_group.mybackendtg.arn]

  health_check_type = "EC2"
  #health_check_grace_period = 300 # default is 300 seconds  
  # Launch Template
  launch_template {
    id      = aws_launch_template.backend.id
    version = aws_launch_template.backend.latest_version
  }
  # Instance Refresh
  instance_refresh {
    strategy = "Rolling"
    preferences {
      #instance_warmup = 300 # Default behavior is to use the Auto Scaling Group's health check grace period.
      min_healthy_percentage = 50
    }
    triggers = [/*"launch_template",*/ "desired_capacity"] # You can add any argument from ASG here, if those has changes, ASG Instance Refresh will trigger
  }
  tag {
    key                 = "Name"
    value               = "myasgbackend"
    propagate_at_launch = true
  }
}

