resource "aws_db_instance" "my_db" {
  engine         = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"
  db_name        = "my_db"
  # Set the secrets from AWS Secrets Manager
  username = local.db_user.username
  password = local.db_password.password
}

locals {
  db_user = jsondecode(
    data.vault_generic_secret.creds.data["username"]
  )
}

locals {
  db_password = jsondecode(
    data.vault_generic_secret.creds.data["password"]
  )
}

data "vault_generic_secret" "creds" {
  # Fill in the name you gave to your secret
  path = "kv/db_creds"
}