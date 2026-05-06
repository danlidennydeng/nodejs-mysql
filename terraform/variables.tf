variable "instance_type" {
	type = string
	default = "t3.micro"
}

variable "vpc_id" {
	type = string
	default = "vpc-06851edae54341762"
}

variable "subnet_id" {
	type = string
	default = "subnet-02c2269b9643530d0"
}

variable "db_password" {
  type      = string
  sensitive = true
}