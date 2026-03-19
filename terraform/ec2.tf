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

resource "aws_instance" "tf_ec2_instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
	associate_public_ip_address = true
	vpc_security_group_ids = [ aws_security_group.tf_ec2_sg.id ]
	key_name = "terraform-ec2"

	depends_on = [ aws_s3_object.tf_s3_object, aws_db_instance.tf_rds_instance ]
	
	user_data = templatefile("${path.module}/userdata.sh", {
  #db_host = aws_db_instance.tf_rds_instance.endpoint, it has :3306
	db_host = aws_db_instance.tf_rds_instance.address
  db_user = aws_db_instance.tf_rds_instance.username
  db_pass = aws_db_instance.tf_rds_instance.password
  db_name = aws_db_instance.tf_rds_instance.db_name
})

	user_data_replace_on_change = true 
	#after success of deployment, you might want to commont out above so that you can use the same EC2 instance
  
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

# module "tf_module.ec2_sg" {
# 	source  = "terraform-aws-modules/security-group/aws"
# 	version = "5.3.1"
# }

