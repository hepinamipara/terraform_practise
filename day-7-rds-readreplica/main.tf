resource "aws_db_instance" "default" {
  allocated_storage    = 10
  identifier           = "book-rds"
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "Cloud123"
  db_subnet_group_name = aws_db_subnet_group.sub-grp.id
  parameter_group_name = "default.mysql8.0"
  provider             = aws.primary

  # Enable backups and retention
  backup_retention_period = 7             # Retain backups for 7 days
  backup_window           = "02:00-03:00" # Daily backup window (UTC)

  # Enable monitoring (CloudWatch Enhanced Monitoring)
  monitoring_interval = 60 # Collect metrics every 60 seconds
  monitoring_role_arn = aws_iam_role.rds_monitoring-role.arn

  # Enable performance insights
  #   performance_insights_enabled          = true
  #   performance_insights_retention_period = 7  # Retain insights for 7 days

  # Maintenance window
  maintenance_window = "sun:04:00-sun:05:00" # Maintenance every Sunday (UTC)

  # Enable deletion protection (to prevent accidental deletion)
  deletion_protection = true

  # Skip final snapshot
  skip_final_snapshot = true
}

# IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "rds_monitoring-role" {
  name     = "rds-monitoring-role"
  provider = aws.primary
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      }
    }]
  })
}

# IAM Policy Attachment for RDS Monitoring
resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
  provider   = aws.primary
  role       = aws_iam_role.rds_monitoring-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

// subnet group of main or default database
resource "aws_db_subnet_group" "sub-grp" {
  name       = "mycutsubnet"
  subnet_ids = ["subnet-087628dfdc5753507", "subnet-0abdd86fd6d393ce9"]
  provider   = aws.primary

  tags = {
    Name = "My DB subnet group"
  }
}

// subnet group of main or read replica database
resource "aws_db_subnet_group" "secondary_region_group" {
  name       = "secondary-subnet-group"
  provider   = aws.secondary
  subnet_ids = [aws_subnet.public1.id, aws_subnet.public2.id]
  tags = {
    Name = "Secondary Region Subnet Group"
  }

}


resource "aws_db_instance" "read_replica" {
  identifier          = "book-rds-replica"
  replicate_source_db = aws_db_instance.default.arn
  instance_class      = "db.t3.micro"
  provider            = aws.secondary
  # Network configuration in secondary region
  db_subnet_group_name = aws_db_subnet_group.secondary_region_group.name
  publicly_accessible  = true

  depends_on = [aws_db_instance.default, aws_db_subnet_group.secondary_region_group]
}

