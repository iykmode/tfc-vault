resource "aws_db_instance" "example" {
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "example"
  # Set the secrets from AWS Secrets Manager
  username = local.db_creds.username
  password = local.db_creds.password
}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}

data "aws_secretsmanager_secret_version" "creds" {
  # Fill in the name you gave to your secret
  secret_id = "db-creds"
}