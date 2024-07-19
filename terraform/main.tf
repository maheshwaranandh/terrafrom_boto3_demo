provider "aws" {
  region=var.aws_region
}

#iam role for ec2 instance with SES and S3 access
resource "aws_iam_role" "ec2_role" {
  name="ec2_with_ses_s3_access"

  assume_role_policy=jsonencode({
    Version="2012-10-17",
    Statement=[
      {
        Effect="Allow",
        Principal={
          Service="ec2.amazonaws.com"
        },
        Action="sts:AssumeRole"
      }
    ]
  })
}

#attach policies to the iam role
resource "aws_iam_role_policy_attachment" "ses_access" {
  role=aws_iam_role.ec2_role.name
  policy_arn="arn:aws:iam::aws:policy/AmazonSESFullAccess"
}

resource "aws_iam_role_policy_attachment" "s3_access" {
  role=aws_iam_role.ec2_role.name
  policy_arn="arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

#create a security group
resource "aws_security_group" "web_sg" {
  name="web_sg"
  description="allows http,shh access"
  ingress {
    from_port=80
    to_port=80
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }
  ingress {
    from_port=22
    to_port=22
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }

  egress {
    from_port=0
    to_port=0
    protocol="-1"
    cidr_blocks=["0.0.0.0/0"]
  }
}

#create ec2 instance
resource "aws_instance" "web_server" {
  ami=var.ami_id
  instance_type=var.instance_type
  key_name=var.key_pair_name

  iam_instance_profile=aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids=[aws_security_group.web_sg.id]

  #add volume
  root_block_device {
    volume_size=var.volume_size
  }
  #name the ec2
  tags={
    Name="Web-server-101"
  }
}

#create instance profile (to attach the iam role to ec2 instance)
resource "aws_iam_instance_profile" "ec2_profile" {
  name="ec2_profile"
  role=aws_iam_role.ec2_role.name
}
