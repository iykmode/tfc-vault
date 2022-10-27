resource "aws_db_instance" "my_db" {
  engine         = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"
  db_name        = "my_db"
  allocated_storage    = 10
  # Set the secrets from Vault
  username = local.db_user
  password = local.db_password
}

locals {
  db_user = data.vault_generic_secret.creds.data["username"]
  db_password = data.vault_generic_secret.creds.data["password"]
}

# locals {
#   db_password = jsondecode(
#     data.vault_generic_secret.creds.data["password"]
#   )
# }

data "vault_generic_secret" "creds" {
  # Fill in the name you gave to your secret
  path = "kv/db_creds"
}