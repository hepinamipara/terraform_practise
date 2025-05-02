resource "aws_db_instance" "my_rds" {
  identifier              = "database-1"
  db_subnet_group_name    = aws_db_subnet_group.pvt-sub-grp.name
  publicly_accessible     = false
  instance_class          = "db.t3.micro"
  engine                  = "mysql"
  engine_version          = "8.0.32"
  allocated_storage       = 20
  username                = "admin"
  password                = "Hepincloud"
  db_name                 = "mydb"
  skip_final_snapshot     = true
  depends_on              = [aws_db_subnet_group.pvt-sub-grp]
  backup_retention_period = 7
  vpc_security_group_ids = [aws_security_group.mydbsg.id]


  tags = {
    Name = "database-1"
  }
}

resource "aws_db_subnet_group" "pvt-sub-grp" {
  name       = "main"
  subnet_ids = [aws_subnet.pvt7.id, aws_subnet.pvt8.id]
  depends_on = [aws_subnet.pvt7, aws_subnet.pvt8]

  tags = {
    Name = "My DB subnet group"
  }
}
