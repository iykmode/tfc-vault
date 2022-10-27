resource "aws_db_instance" "example" {
  engine         = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"
  name           = "example"
  # Set the secrets from AWS Secrets Manager
  username = local.db_creds.username
  password = local.db_creds.password
}

locals {
  db_creds = jsondecode(
    data.vault_generic_secret.creds.data
  )
}

data "vault_generic_secret" "creds" {
  # Fill in the name you gave to your secret
  path = "kv/db_creds"
}