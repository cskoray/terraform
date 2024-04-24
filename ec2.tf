resource "aws_instance" "app-server" {
  ami           = "ami-0d5482f3cb962780f"
  instance_type = "t2.micro"
  key_name      = "devops"
  subnet_id     = aws_subnet.public-eu-west-2a.id

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.app-server.id]

  tags = {
    Name = "app-server"
  }
}
