output "ec2_ssh_command" {
	value = "ssh -i ~/.ssh/terraform-ec2.pem ubuntu@${aws_instance.tf_ec2_instance.public_ip}"
}

output "rds_address" {
	value = aws_db_instance.tf_rds_instance.address
	
}

# output "rds_username" {
# 	value = aws_db_instance.tf_rds_instance.username
	
# }
# it is too sensitive to output.

output "rds_db_name" {
	value = aws_db_instance.tf_rds_instance.db_name
	
}