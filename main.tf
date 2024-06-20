terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
### Variables ###
variable "ami_id" {
  description = "ID de la AMI para la instancia EC2"
  default     = "ami-0440d3b780d96b29d"
}
variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t2.micro"
}
variable "server_name" {
  description = "Nombre del servidor web"
  default     = "nginx-server"
}
variable "environment" {
  description = "Ambiente de la aplicación"
  default     = "test"

}

## provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "nginx-server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  ## creamos un script de bash, donde instalamos nginx
  user_data = <<-EOF
              #!/bin/bash
              sudo yum install -y nginx
              sudo systemctl enable nginx
              sudo systemctl start nginx
              EOF
  # creamos una varible para hacer referencia a la llave aws_keys_pair de nginx
  key_name               = aws_key_pair.nginx-server-ssh.key_name
  vpc_security_group_ids = [aws_security_group.nginx-server-sg.id]

  # Tags
  tags = {
    Name        = var.server_name
    Environment = var.environment
    Owner       = "carol123dbt@gmail.com"
    Team        = "DevOps"
    Project     = "terraform-nginx"
  }
}

## keys de nginx
resource "aws_key_pair" "nginx-server-ssh" {
  key_name = "${var.server_name}-ssh"
  #subimos nuestra llave en aws 
  public_key = file("${var.server_name}.key.pub")
  # Tags
  tags = {
    Name        = "${var.server_name}-ssh"
    Environment = "${var.environment}"
    Owner       = "carol123dbt@gmail.com"
    Team        = "DevOps"
    Project     = "terraform-nginx"
  }
}


### SG ###
resource "aws_security_group" "nginx-server-sg" {
  name        = "nginx-server-sg"
  description = "Security group allowing SSH and HTTP access"

  ## Reglas de entrada
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ## Reglas de salida: aceptando todos los puertos
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Tags
  tags = {
    Name        = "${var.server_name}-sg"
    Environment = "${var.environment}"
    Owner       = "carol123dbt@gmail.com"
    Team        = "DevOps"
    Project     = "terraform-nginx"
  }
}

# Mostrar información resultante de la infraestructura
output "public_ip" {
  description = "Dirección IP publica de la instancia EC2"
  value       = aws_instance.nginx-server.public_ip
}

# Mostrar información resultante de la infraestructura
output "public_dns" {
  description = "DNS publico de la instancia EC2"
  value       = aws_instance.nginx-server.public_dns
}
