variable "region" {
  default = "ap-southeast-1"
}

variable "database_user" {
  default = "pgsql_user"
}

variable "database_password" {
  default = "Nduen1ke$nfg"
}

variable "tags" {
  default = {
    Terraform   = "true"
    Environment = "dev"
  } 
}
