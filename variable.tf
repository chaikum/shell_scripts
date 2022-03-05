
variable "subnet_names" {
  description = "Create subnets with these names"
  type        = list
  default     = ["aws_subnet.Green_subnet-1", "aws_subnet.Green_subnet-2", "aws_subnet.Green_subnet-3"]
}
