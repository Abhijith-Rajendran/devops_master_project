# 1. Tell Terraform we are using the Stockholm region
provider "aws" {
  region = "eu-north-1"
}

# Create an SSH Key Pair in AWS
resource "aws_key_pair" "devops_key" {
  key_name   = "devops-master-key"
  public_key = file("~/.ssh/devops_key.pub") # Reads the key you just generated
}

# 2. Dynamically fetch the latest Ubuntu 22.04 AMI for Stockholm
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's official AWS Account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 3. Create a Security Group (A Virtual Firewall)
resource "aws_security_group" "web_sg" {
  name        = "devops-api-security-group"
  description = "Allow SSH and API traffic"

  # Allow inbound SSH (Port 22) so Ansible can connect later
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound web traffic (Port 8000) for our Python API
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow the server to access the internet to download Docker
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 4. Create the actual Linux Server (EC2 Instance)
resource "aws_instance" "devops_server" {
  ami           = data.aws_ami.ubuntu.id 
  instance_type = "t3.micro"             

  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.devops_key.key_name # <--- ADD THIS LINE

  tags = {
    Name = "DevOps-Master-Project-Server"
  }
}

# 5. Output the public IP address so we know how to connect to it
output "server_public_ip" {
  value = aws_instance.devops_server.public_ip
}