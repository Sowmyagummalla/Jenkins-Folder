# Resource-8: Create jenkins EC2 Instance
resource "aws_instance" "jenkins-vm" {
    ami = var.ec2_ami_id
    instance_type = var.ec2_instance_type
    key_name = "Docker"
    count = 1
    subnet_id = aws_subnet.jenk-vpc-public-subnet.id
    vpc_security_group_ids = [aws_security_group.jenk-vpc-sg.id]
    user_data = file("install_jenkins.sh")
     
    tags = {
      "Name" = "jenkins-vm"
    }

    root_block_device {
      volume_size = var.volume
    }
}