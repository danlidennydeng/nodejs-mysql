resource "aws_db_instance" "tf_rds_instance" {
  allocated_storage    = 20
  db_name              = "kunal_demo"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t4g.micro"
  username             = "admin"
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
	identifier           = "nodejs-rds-mysql"
	
	publicly_accessible  = false

	db_subnet_group_name = aws_db_subnet_group.main.name

	vpc_security_group_ids = [aws_security_group.tf_rds_sg.id]
}

