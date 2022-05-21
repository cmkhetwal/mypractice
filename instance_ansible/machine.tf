resource "aws_instance" "ansible_master" {
  # Use an Ubuntu image
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  key_name      = "devops"
  user_data     = <<-EOF
                #! /bin/bash
                sudo apt-get update
                sudo git clone http://github.com/lerndevops/labs
                sudo chmod -R 775 labs
                sudo labs/cloud/setup-user.sh
               
        EOF
  tags = {
    Name = "ansible_master"
  }

  # This is where we configure the instance with ansible-playbook
  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ./devops.pem -i '${aws_instance.ansible_master.public_ip},' ansible.yml"
  }
}
