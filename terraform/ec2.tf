data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "tf-ec2-instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
	associate_public_ip_address = true
	vpc_security_group_ids = [ aws_security_group.tf_ec2_sg.id ]
	key_name = "terraform-ec2"
	depends_on = [ aws_s3_object.tf_s3_object ]
	user_data = file("userdata.sh")

	user_data_replace_on_change = true 
  tags = {
    Name = "nodejs-server"
  }
}

resource "aws_security_group" "tf_ec2_sg" {
	name = "nodejs-server-sg"
	description = "Allow SSH and HTTP Traffic"
	vpc_id = "vpc-06851edae54341762"
	ingress {
		from_port = 443
		to_port = 443
		protocol = "tcp"
		cidr_blocks = [ "0.0.0.0/0" ]
	}

	ingress {
		description = "SSH"
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = [ "0.0.0.0/0" ]
	}

	ingress {
		description = "TCP"
		from_port = 3000
		to_port = 3000
		protocol = "tcp"
		cidr_blocks = [ "0.0.0.0/0" ]
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = [ "0.0.0.0/0" ]
	}
}