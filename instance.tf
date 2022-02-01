resource "aws_instance" "firstec2" {
  ami                    = var.imageid
  instance_type          = var.instancetype
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = ["${aws_security_group.firstsg.id}"]

  tags = {
    Name = "HelloWorld"
  }
  user_data = file("${path.module}/script.sh")

  connection { #we can define connection as global paramater or with each provisioner
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/id_rsa")
    host        = self.public_ip
  }


  provisioner "file" {
    source      = "readme.md"      #terraform machine
    destination = "/tmp/readme.md" #remote machine which will create

  }

  provisioner "file" {
    content     = "my name is jeetu"
    destination = "/tmp/content.md"
  }
}
