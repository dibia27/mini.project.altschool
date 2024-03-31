locals {
  instance_name = ["webServer1-AMZL2", "webServer2-UBUNT", "webServer3-DEBI12"]
  ami           = ["ami-062a49a8152e4c031", "ami-06c4d7ac549ae02a0", "ami-0eb11ab33f229b26c"]
  ansible_user  = ["ec2-user", "ubuntu", "admin"]
}

resource "aws_instance" "webServer" {
  count         = 3
  ami           = local.ami[count.index]
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = [aws_subnet.webPubSunet1.id, aws_subnet.webPubSunet2.id, aws_subnet.webPubSunet3.id][count.index]
  vpc_security_group_ids = [
    aws_security_group.webServerPubSG.id
  ]
  associate_public_ip_address = true
  tags = {
    Name = local.instance_name[count.index]
  }
  provisioner "local-exec" {
    command = "echo ${self.tags.Name} ansible_host=${self.public_ip} ansible_user=${local.ansible_user[count.index]} >> ../host-inventory"
  }

   # provisioner "local-exec" {
  #   command = "ansible-playbook -i ../host-inventory ../main.yml"
 #  }
}

output "webServerIPs" {
  value = [aws_instance.webServer.*.public_ip, aws_instance.webServer.*.tags.Name]
}

# resource "local_file" "webServerIPs" {
#   content  = jsonencode(output.webServerIPs.value)
#   filename = "${path.module}/host-inventory"
# }
