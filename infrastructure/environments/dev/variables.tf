variable "aws_region" {
  type = string
}

variable "instance_ami" {
  type    = string
  default = "ami-01419b804382064e4"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_pair_name" {
  type    = string
  default = ""
}