data "aws_ami" "latest_amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Amazon
}
/*
data "aws_ami" "amzLinux" {
        most_recent = true
        owners = ["amazon"]
    }
#in ressource aws_instance: ami                         = data.aws_ami.amzLinux.id
*/


##new:
###Create EC2
resource "aws_instance" "deham6demo"{
    ami                    = data.aws_ami.latest_amazon_linux.id
    instance_type          = "t2.micro"
    key_name               = "vockey"
    vpc_security_group_ids = [aws_security_group.devVPC_sg_allow_ssh_http.id]
    subnet_id              = aws_subnet.devVPC_public_subnet1.id   
    tags = {
        Name = "terraform15_ec2_for_public_subnet1_az1"
    }
/*    provisioner "remote-exec"{
        inline = [
            "sudo yum update -y",
            "sudo yum install -y nginx",
            "sudo service nginx start"
        ]
        on_failure = continue
    }*/
#

/*
  user_data = <<-EOF
! /bin/bash
sudo yum update -y
sudo yum install -y httpd php mysql
sudo service httpd start
sudo chkconfig httpd on
sudo chmod 777 /var/www
sudo service mysqld start
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz -d /var/www/html/
  EOF
  */

  user_data = <<-EOF
#!/bin/bash

# System-Update
sudo yum update -y

# Installation von Apache, MariaDB, PHP und zusätzlichen Paketen
sudo yum install -y httpd mariadb-server php php-mysqlnd unzip

# EPEL und Remi Repository für PHP 7.4 hinzufügen
sudo amazon-linux-extras install epel
sudo yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm

# PHP 7.4 aktivieren und benötigte PHP-Pakete installieren
sudo amazon-linux-extras enable php7.4
sudo yum clean metadata
sudo yum install php-cli php-pdo php-fpm php-json php-mysqlnd php php-{mbstring,json,xml,mysqlnd}

# Starten und Aktivieren von Apache und MariaDB
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl start mariadb
sudo systemctl enable mariadb

# WordPress herunterladen und konfigurieren
cd /var/www/html
sudo curl -LO https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo mv -f wordpress/* ./
sudo rm -rf wordpress latest.zip
sudo chown -R apache:apache /var/www/html

# Konfiguration von MariaDB für WordPress
sudo mysql -e "CREATE DATABASE wordpress;"
sudo mysql -e "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'wppassword';"
sudo mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

sudo yum update -y

# Neustart von Apache um alle Änderungen zu übernehmen
sudo systemctl restart httpd

# Überprüfung der PHP-Version
php -v
sudo yum update -y

  EOF


/*    provisioner "local-exec"{
        command = "echo Instance Type=${self.instance_type},Instance ID=${self.id},Public DNS=${self.public_dns},AMI ID=${self.ami} >> allinstancedetails"
    }
connection {
    type = "ssh"
    host = self.public_ip
    user = "ec2-user"
    private_key = file("${path.module}/terraform.pem")
}*/


/*
    provisioner "remote-exec"{
        inline = [
            "sudo yum update -y",
            "sudo yum install -y nginx",
            "sudo service nginx start"
        ]
        on_failure = continue
    }
    provisioner "local-exec"{
        command = "echo Instance Type=${self.instance_type},Instance ID=${self.id},Public DNS=${self.public_dns},AMI ID=${self.ami} >> allinstancedetails"
    }
    connection {
        type = "ssh"
        host = aws_instance.provisioner-remoteVM.public_ip
        user = "ec2-user"
        private_key=file("${path.module}/terraform.pem")
    }*/
}

#provisioner "local-exec"{
#    command = "echo Instance Type=${self.instance_type},Instance ID=${self.id},Public DNS=${self.public_dns},AMI ID=${self.ami} >> allinstancedetails"
#  }