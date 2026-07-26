############################################################
# IAM ROLE
############################################################

resource "aws_iam_role" "jenkins_role" {

  name = "jenkins-ec2-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ec2.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

}

# -------------------
# Iam POLicies
# ---------
resource "aws_iam_role_policy_attachment" "ssm" {

  role = aws_iam_role.jenkins_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

resource "aws_iam_role_policy_attachment" "ecr" {

  role = aws_iam_role.jenkins_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"

}

resource "aws_iam_role_policy_attachment" "eks" {

  role = aws_iam_role.jenkins_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

}

resource "aws_iam_role_policy_attachment" "readonly" {

  role = aws_iam_role.jenkins_role.name

  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"

}

# -----------------
# Instance Profile
# -----------------
resource "aws_iam_instance_profile" "this" {

  name = "jenkins-instance-profile"

  role = aws_iam_role.jenkins_role.name

}

# ---------------------
# EC2 Instance
# ---------------------

resource "aws_instance" "jenkins" {

  ami = var.ami_id

  instance_type = var.instance_type

  subnet_id = var.public_subnet_id

  key_name = var.key_name

  vpc_security_group_ids = [

    var.security_group_id

  ]

  iam_instance_profile = aws_iam_instance_profile.this.name

  associate_public_ip_address = true

  user_data = file("${path.module}/userdata.sh")

  root_block_device {

    volume_size = 40

    volume_type = "gp3"

    encrypted = true

  }

  metadata_options {

    http_tokens = "required"

    http_endpoint = "enabled"

  }

  tags = merge(

    var.common_tags,

    {

      Name = "jenkins-server"

    }

  )

}