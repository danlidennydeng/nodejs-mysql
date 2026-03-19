resource "aws_db_instance" "tf_rds_instance" {
  allocated_storage    = 20
  db_name              = "kunal_demo"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t4g.micro"
  username             = "admin"
  password             = "kunal123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
	identifier           = "nodejs-rds-mysql"
	publicly_accessible  = true
	vpc_security_group_ids = [aws_security_group.tf_rds_sg.id]
}

resource "aws_security_group" "tf_rds_sg" {
	name = "all_mysql"
	description = "Allow MySQL Traffic"
	vpc_id = "vpc-06851edae54341762"

	ingress {
		from_port 				= 3306
		to_port   				= 3306
		protocol  				= "tcp"
		cidr_blocks 			= [ "0.0.0.0/0" ]
		security_groups = [aws_security_group.tf_ec2_sg.id]
	}

	

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = [ "0.0.0.0/0" ]
	}
}

# locals {
# 	rds_endpoint = element(split(":", aws_db_instance.tf_rds_instance.endpoint), 0)
# }

