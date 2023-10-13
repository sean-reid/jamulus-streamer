provider "aws" {
  region = var.region
}

resource "aws_key_pair" "jamulus_instance_ssh_key" {
  key_name   = "jamulus-instance-ssh-key"
  public_key = file(var.key_path) # Specify the path to your public key file
}

data "aws_ami" "latest_ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "jamulus_instance" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.jamulus_instance_ssh_key.key_name
}

resource "aws_security_group" "jamulus_sg" {
  name_prefix = "jamulus-"

  # Inbound rules (ingress)
  # Allow SSH from your IP address (replace 'your-ip' with your actual IP)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.your_ip]
  }

  # Allow Jamulus client connections (adjust the port as needed)
  ingress {
    from_port   = 22124
    to_port     = 22124
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rules (egress)
  # Allow all outbound traffic (for the EC2 instance to reach external resources)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
