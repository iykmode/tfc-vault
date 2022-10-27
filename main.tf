resource "aws_db_instance" "my_db" {
  engine         = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"
  name           = "db_name"
  # Set the secrets from AWS Secrets Manager
  username = local.db_creds.value["username"]
  password = local.db_creds.password["password"]
}

locals {
  db_creds = jsondecode(
    data.vault_generic_secret.creds.value
  )
}

data "vault_generic_secret" "creds" {
  # Fill in the name you gave to your secret
  path = "kv/db_creds"
}