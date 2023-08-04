#Create subnets and Subnet group -subnet already created
### Create Subnet group
resource "aws_db_subnet_group" "devVPC_db_subnet_group" {
  name       = "dev_terraform_db_subnet_group"
  subnet_ids = [aws_subnet.devVPC_private_subnet1.id, aws_subnet.devVPC_private_subnet2.id]

  tags = {
    Name = "dev_terraform_db_subnet_group"
  }
}

/*
data "aws_rds_engine_version" "mysql" {
  engine             = "mysql"
  preferred_versions = ["5.7"] # Beispiel für bevorzugte Versionen
} */

###Create RDS DB Instance
resource "aws_db_instance" "mysql_db" {
  allocated_storage        = 20 
#  storage_type             = "gp2"
  engine                   = "mysql"
  engine_version           = "5.7" #data.aws_rds_engine_version.mysql.version 
  instance_class           = "db.t2.micro"
  db_name                  = local.DB
  username                 = local.User
  password                 = local.PW 
  #parameter_group_name     = "default.mysql5.6" 
  skip_final_snapshot      = true
  vpc_security_group_ids   = [aws_security_group.allow_mysql.id]
  db_subnet_group_name     = aws_db_subnet_group.devVPC_db_subnet_group.name
  
  # optional
  multi_az                 = false
  auto_minor_version_upgrade = true
  backup_retention_period  = 0 
  apply_immediately        = true
  publicly_accessible      = false 

  tags = {
    Name = "my-database"
  }
}