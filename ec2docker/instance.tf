resource "aws_instance" "test-instances" {
  ami  = "ami-08d4ac5b634553e16"
  count = "1"
  instance_type = "t2.medium"
  key_name = "devops"
  security_groups = [ "launch-wizard-5" ]
  user_data = <<-EOF
                #! /bin/bash
                sudo apt-get update
                sudo git clone http://github.com/lerndevops/labs
                sudo chmod -R 775 labs
                sudo labs/cloud/setup-user.sh
                sudo su -
                sudo apt-get remove docker docker-engine docker.io containerd runc
                sudo apt-get update
                sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
                sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
                sudo apt-get update
                sudo apt-get install -y docker-ce docker-ce-cli containerd.io
               
        EOF

  tags = {
    Name = "kube${count.index + 1}"
    training = "devops"
  }
}