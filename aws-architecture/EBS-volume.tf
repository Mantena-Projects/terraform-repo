resource "aws_instance" "ebs-instance" {

  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"

  tags = {
    Name = "EBS-attached-ec2"
  }

}

#EBS resource creation
resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "extra-volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name  = "/dev/xvdh"
  volume_id    = aws_ebs_volume.ebs-volume-1.id
  instance_id  = aws_instance.ebs-instance.id
  skip_destroy = "true"
}