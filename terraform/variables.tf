variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_path" {
  description = "EC2 public SSH key path"
}

variable "your_ip" {
  description = "The IP address (with /32) of your laptop, for ssh access"
}
