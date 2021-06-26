# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter
# https://github.com/terraform-aws-modules/terraform-aws-rds/blob/master/examples/complete-postgres/main.tf
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4"

  name        = "rds_allow_all_access"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = var.tags
}

module "rds_infinite_lambda" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "rdsinfinitelambda"

  create_db_option_group    = false
  create_db_parameter_group = false
  publicly_accessible       = true

  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
  engine               = "postgres"
  engine_version       = "11.10"
  family               = "postgres11" # DB parameter group
  major_engine_version = "11"         # DB option group
  instance_class       = "db.t3.large"

  allocated_storage = 20

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  name                   = "rdsinfinitelambda"
  username               = var.database_user
  password               = var.database_password
  port                   = 5432

  subnet_ids             = data.terraform_remote_state.vpc.outputs.database_subnets
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  backup_retention_period = 0

  tags                     = var.tags
}



module "store_write_infinite_lambda" {
  source          = "git::https://github.com/cloudposse/terraform-aws-ssm-parameter-store?ref=master"

  parameter_write = [
    {
      name        = "/cp/prod/app/database/master_user"
      value       = var.database_user
      type        = "String"
      overwrite   = "true"
      description = "Production database master user"
    },
    {
      name        = "/cp/prod/app/database/master_password"
      value       = var.database_password
      type        = "String"
      overwrite   = "true"
      description = "Production database master password"
    }
  ]

  tags = var.tags
}
