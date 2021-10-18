  engine                              = "aurora-postgresql"
  engine_version                      = "10.14"
  engine_mode                         = "serverless"
  envtype                             = "test"
  subnets                             = ["XXXXXX","XXXXXX"]
  azs                                 = ["us-east-1c"]
  security_groups                     = "var.security_groups"
  backup_retention_period             = "5"
  final_snapshot_identifier           = "final-db-snapshot-"
  storage_encrypted                   = "true"
  apply_immediately                   = "true"
  monitoring_interval                 = "10"
  cw_alarms                           = false
  db_parameter_group_name             = "default.aurora5.6"
  db_cluster_parameter_group_name     = "default.aurora5.6"
  iam_database_authentication_enabled = "false"

