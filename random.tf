resource "random_id" "random_id" {
  byte_length = 8
}

resource "random_password" "postgresql_password" {
  length  = 16
  special = true
}
