provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

provider "vault" {
    address = var.VAULT_ADDR
    token = var.VAULT_TOKEN
}
