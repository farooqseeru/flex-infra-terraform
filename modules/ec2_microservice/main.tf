resource "aws_iam_role" "service_role" {
  name = "${var.service_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "secrets_access" {
  name = "${var.service_name}-secrets-policy"
  role = aws_iam_role.service_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["secretsmanager:GetSecretValue"],
      Resource = "*"
    }]
  })
}

resource "aws_iam_instance_profile" "service_profile" {
  name = "${var.service_name}-profile"
  role = aws_iam_role.service_role.name
}

resource "aws_security_group" "service_sg" {
  name        = "${var.service_name}-sg"
  description = "Allow HTTP, HTTPS, SSH"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "service_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.service_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.service_profile.name
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/user_data.sh.tpl", {
    service_name = var.service_name,
    docker_port  = var.docker_port,
    secret_name  = var.secret_name,
    enable_https = var.enable_https,
    domain_name  = var.domain_name
  })

  tags = {
    Name = var.service_name
  }
}
