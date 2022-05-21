resource "aws_instance" "jenkins_master" {
    # Use an Ubuntu image
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    key_name = "devops"
    tags = {
        Name = "jenkins-master"
    }

    # This is where we configure the instance with ansible-playbook
    provisioner "local-exec" {
        command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ./devops.pem -i '${aws_instance.jenkins_master.public_ip},' jenkins.yml"
    }
}
