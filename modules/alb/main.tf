resource "aws_alb" "web" {
  name               = "minaalb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets = var.subnet_ids

}

resource "aws_alb_target_group" "default" {
  name     = "mina-interview"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = 2
    interval            = 15
    path                = "/"
    timeout             = 10
    unhealthy_threshold = 2
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.default.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = aws_alb_target_group.default.arn
//  target_id        =  var.instaces_web_ids[0]
  count = length(var.instaces_web_ids)
  target_id = element(var.instaces_web_ids, count.index)
  port             = 80
}


resource "aws_security_group" "alb" {
  name        = "alb_sg"
  description = "managed by terraform - ALB SG"
  vpc_id      = var.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
