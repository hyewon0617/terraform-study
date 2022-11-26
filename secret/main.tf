provider "aws" {
  region = "ap-northeast-2"
}

data "aws_kms_secrets" "hyewon-creds" {
  secret {
    name    = "db"
    payload = file("\${path.module}/db-creds.yml.encrypted2")
  }
}

locals {
  db_creds = yamldecode(data.aws_kms_secrets.hyewon-creds.plaintext["db"])
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-hyewon"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true
  db_name             = var.db_name

  # Pass the secrets to the resource
  username = local.db_creds.username
  password = local.db_creds.password
}
