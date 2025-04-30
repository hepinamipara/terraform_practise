resource "aws_security_group" "dev_same_cidr_diff_port_sg" {
  name        = "dev_multi_inbound_same_cidr_sg"
  description = "dev_multi_inbound_same_cidr_sg"
  
  #use for loop for multiple port but same cidr
  ingress = [
    for port in [22, 80, 443, 8080, 9000, 3000, 8082, 8081] : {
      from_port        = port
      to_port          = port
      protocol         = "TCP"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "port "
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false

    }

  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev_multi_inbound_same_cidr_sg"
  }
}
