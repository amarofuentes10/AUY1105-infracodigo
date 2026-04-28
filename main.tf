terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# 1. VPC: Bloque CIDR 10.1.0.0/16
resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"
  
  tags = {
    # Nomenclatura: <sigla-curso>-<nombre-aplicación>-<tipo-recurso>
    Name = "AUY1105-duocapp-vpc"
  }
}

# 2. Subred: Máscara de red /24
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.1.0/24"
  
  tags = {
    Name = "AUY1105-duocapp-subnet"
  }
}

# 3. Security Group: Permitir solo SSH
resource "aws_security_group" "ssh_sg" {
  name        = "AUY1105-duocapp-sg"
  description = "Permitir trafico SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH restringido"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # OJO: Usamos una IP falsa (192.168.1.0/24) en lugar de 0.0.0.0/0 
    # Esto es a propósito para cumplir con la política OPA del requerimiento 4
    cidr_blocks = ["192.168.1.0/24"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AUY1105-duocapp-sg"
  }
}

# Buscar la imagen (AMI) de Ubuntu 24.04 LTS automáticamente
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

# 4. Cómputo EC2: Ubuntu 24.04 LTS, tipo t2.micro
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ssh_sg.id]

  tags = {
    Name = "AUY1105-duocapp-ec2"
  }
}