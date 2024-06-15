resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0"  # Example AMI, update as needed
  instance_type = "t2.micro"
  subnet_id     = element(aws_subnet.public.*.id, 0)
  key_name      = var.key_name

  security_groups = [aws_security_group.app_server_sg.name]

  tags = {
    Name = "${var.environment}-app-server"
  }
}

resource "aws_security_group" "app_server_sg" {
  vpc_id = aws_vpc.main.id

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

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
