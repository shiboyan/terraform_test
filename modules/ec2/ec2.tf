# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "default" {
  name        = "security_group_for_ec2"
  description = "Used in the aws assignment"
  vpc_id      = "${var.vpc_id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "web" {
   #count = "${var.ec2_size}"
 count         = "${var.ec2_count}"
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "ubuntu"

    type        = "ssh"
    private_key = "${file("./minaterraform.pem")}"

    # The connection will use the local SSH agent for authentication.
  }
  instance_type = "t2.micro"
  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.amis, "ap-southeast-2")}"

  # Use az from variables we specified
  availability_zone = "${var.availability_zone}"

  # The name of our SSH keypair we created above.
  key_name = "${var.key_name}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = "${var.subnet_id}"

  # We run a remote provisioner on the instance after creating it.
  # In this case, we just install nginx and start it. By default,
  # this should be on port 80
  provisioner "remote-exec" {
    scripts = [
      "nginx_resume.sh",
      ]
  }
  tags = {
    Name = "mina_interview"
  }
}

