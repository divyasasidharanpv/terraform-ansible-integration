  provider "aws" {
   region     = "us-east-2"
   
}
resource "aws_instance" "web-server-instance" {
  ami           = "ami-002068ed284fb165b"
  instance_type = "t2.micro"
  availability_zone = "us-east-2a"
  key_name = "ohio"
  security_groups = [ "launch-wizard-3" ]
  tags = {
      Name = "web-server"
  }
  
  provisioner "local-exec" {
        command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key ./ohio.pem -i '${aws_instance.web-server-instance.public_ip},' instance4.yml"
  }
}
output "op1" {
value = aws_instance.web-server-instance.public_ip
}


