resource "aws_instance" "dev_db_instance" {
  ami = var.db-instance-ami
  instance_type = var.instance-type
  subnet_id = data.aws_subnet.dev-db-subnet.id
  associate_public_ip_address = false
  security_groups = [data.aws_security_group.db-sg.id]
  iam_instance_profile = var.ec2-profile-name

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt install -y mysql-server

                # Allow remote connections to MySQL
                sudo sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

                sudo systemctl start mysql

                sudo mysql -e "CREATE DATABASE fullstack;"
                sudo mysql -e "CREATE USER 'admin'@'%' IDENTIFIED BY 'adminadmin';"
                sudo mysql -e "GRANT ALL PRIVILEGES ON fullstack.* TO 'admin'@'%';"
                sudo mysql -e "FLUSH PRIVILEGES;"
                sudo systemctl restart mysql
                EOF

  tags = {
    Name = "mjy-dev-db-instance"
  }
}

resource "aws_instance" "dev_app_instance" {
  ami           = var.app-instance-ami
  instance_type = var.instance-type
  key_name      = var.key-pair-name
  subnet_id     = data.aws_subnet.dev-app-subnet.id
  associate_public_ip_address = true
  security_groups = [ data.aws_security_group.app-sg.id ]
  iam_instance_profile = var.ec2-profile-name

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo systemctl start docker
              DB_ENDPOINT=${aws_instance.dev_db_instance.private_ip}
              sudo docker run -d -p 8080:8080 --name mjy-app -e db_endpoint=$DB_ENDPOINT lygerin14/test:app-deploy
              EOF
  

  tags = {
    Name = "mjy-dev-app-instance"
  }

  depends_on = [ aws_instance.dev_db_instance ]
}

# # AWS Route53 record resource for the "www" subdomain. The record uses an "A" type record and an alias to the AWS CloudFront distribution with the specified domain name and hosted zone ID. The target health evaluation is set to false.
# resource "aws_route53_record" "test" {
#   zone_id = data.aws_route53_zone.zone.id
#   name    = "test.${var.domain-name}"
#   type    = "A"

#   alias {
#     name                   = data.aws_s3_bucket.dev_static_bucket.bucket_regional_domain_name
#     zone_id                = aws_cloudfront_distribution.cdn-web-elb-distribution.hosted_zone_id
#     evaluate_target_health = false
#   }
# }