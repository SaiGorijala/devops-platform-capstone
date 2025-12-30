resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = "t3.large"
  subnet_id     = var.subnet_id

  associate_public_ip_address = true

  vpc_security_group_ids = [var.security_group_id]

  key_name = null

  tags = {
    Name = "phase1-${terraform.workspace}"
  }
}