variable "ami" {
  description = "description"
  type=string
  default = "ami-052c08d70def0ac62"
}

variable "instance_type" {
  description = "select instance type"
  type=string
}


variable "environment" {
  description = "enter the environment in which you want to work"
  type=string
}

variable "key_name" {
  description = "enter the key name"
  type=string
  default="test"
}
