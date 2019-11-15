resource "aws_security_group" "default" {
  name        = "security_group_for_ec2"
  description = "Used in the aws assignment"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.172.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  associate_public_ip_address =true
  count = "${var.ec2_count}"

  connection {
    user = "ubuntu"

    type = "ssh"

    private_key = "${file(var.private_key_path)}"

  }

  instance_type = "t2.micro"
  ami = "${lookup(var.amis, "ap-southeast-2")}"

  key_name = "${var.key_name}"

  vpc_security_group_ids = ["${aws_security_group.default.id}"]


  subnet_id = "${var.subnet_ids[0]}"


  provisioner "remote-exec" {
    scripts = [
      "nginx_resume.sh",
    ]
  }

  tags = {
    Name = "mina-interview"
  }
}
