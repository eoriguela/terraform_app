resource "aws_instance" "ac1_instance" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.ac1_public_subnet.id
  vpc_security_group_ids = [aws_security_group.ac1_sg.id]
  key_name               = "vockey"

  tags = {
    Name      = "ac1-instance"
    terraform = "True"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/root/.ssh/vockey.pem")
    host        = self.public_ip
    timeout     = "5m"
  }

# Provisioner para instalar Apache, Git y clonar repositorio
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd git",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",
      "sudo rm -rf /var/www/html/*",
      "sudo git clone https://github.com/mauricioamendola/chaos-monkey-app.git /var/www/html/",
      "sudo cp -r /tmp/chaos/* /var/www/html/",
      "sudo chown -R apache:apache /var/www/html",
      #"sudo chown -R ec2-user:ec2-user /var/www/html"
      "sudo sudo cp -rf /var/www/html/website/* /var/www/html/",
      "sudo systemctl restart httpd"
    ]
  }
}