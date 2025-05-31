provider "aws" {
  region = "us-east-1"
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = ["subnet-087628dfdc5753507", "subnet-0abdd86fd6d393ce9"] # Replace with your subnet IDs

  tags = {
    Name = "RDS subnet group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-public-sg"
  description = "Allow MySQL inbound traffic"
  vpc_id      = "vpc-0349b32f0c9ad99aa" # Replace with your VPC ID

  ingress {
    description = "MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open to all (use carefully!)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "mydatabase"
  username             = "admin"
  password             = "hepin9714" # Replace securely (not hardcoded in production)
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "Public MySQL RDS"
  }
}

resource "aws_iam_instance_profile" "ec2_admin_profile" {
  name = "ec2-admin-profile"
  role = "ec2-admin" 
}
resource "aws_instance" "myec2" {
  ami                  = "ami-0953476d60561c955"
  instance_type        = "t2.micro"
  key_name = "demokey"
  iam_instance_profile = aws_iam_instance_profile.ec2_admin_profile.name
  provisioner "remote-exec" {
    inline = [
      "sudo yum install python3-pip -y",
      "sudo pip3 install flask mysql-connector-python",
      "sudo yum install git -y"
    ]
  }
   connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("C:/Users/AMIPARA HEPIN/Downloads/demokey.pem")  # Replace with your actual .pem file path
      host        = self.public_ip
    }
  
  tags = {
    Name = "pythonec2"
  }
}
