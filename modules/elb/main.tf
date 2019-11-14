resource "aws_security_group" "elb" {
  name        = "security_group_for_elb"
  description = "Used in the aws assignment"
  vpc_id      = "${var.vpc_id}"

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

resource "aws_elb" "web" {
  name = "aws-assignment-elb"

  #subnets         = ["${aws_subnet.default.id}"]
  #subnets = "${var.subnet_id}"
  subnets = ["${var.subnet_ids}"]

  security_groups = ["${aws_security_group.elb.id}"]

  #instances       = ["${aws_instance.web.*.id}"]
  instances = ["${var.instaces_web_ids}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
}
