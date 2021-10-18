provider "aws" {
  region  = "us-east-1"
}


module "aurora_db_postgres1014" {
  source                              = "./aurora-postgresql/"
  region                              = var.region
  engine                              = var.engine
  engine_version                      = var.engine_version
  engine_mode                         = var.engine_mode
  envname                             = var.envname
  envtype                             = var.envtype
  subnets                             = var.subnets
  azs                                 = var.azs
  security_groups                     = var.security_groups
  username                            = var.password
  password                            = var.password
  backup_retention_period             = var.backup_retention_period
  final_snapshot_identifier           = var.final_snapshot_identifier
  storage_encrypted                   = var.storage_encrypted
  apply_immediately                   = var.apply_immediately
  monitoring_interval                 = var.monitoring_interval
  cw_alarms                           = false
#   cw_sns_topic                        = aws_sns_topic.db_alarms_postgres96.id
  db_parameter_group_name             = var.db_parameter_group_name
  db_cluster_parameter_group_name     = var.db_cluster_parameter_group_name
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  aws_db_subnet_group = var.aws_db_subnet_group
}
# aqui vou criar um alerta do banco com sns
# resource "aws_sns_topic" "db_alarms_postgres96" {
#   name = "aurora-db-alarms-postgres1014"
# }