output "vpc_id" {
  description = "List of private subnets for database"
  value       = module.vpc_infinite_lambda_test.vpc_id
}

output "database_subnets" {
  description = "List of private subnets for database"
  value       = module.vpc_infinite_lambda_test.database_subnets
}
