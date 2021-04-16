variable "region" {
  description = "aws region to use"
  default     = "us-east-2"
}

variable "cidr_blocks" {
  description = "IPs that should be whitelisted in security group"
  default = ["0.0.0.0/0"]
}
