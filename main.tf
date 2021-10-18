terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}

//criando o cluster
resource "aws_rds_cluster" "default" {
  count              = var.enabled ? 1 : 0
  cluster_identifier = var.identifier_prefix != "" ? format("%s-cluster", var.identifier_prefix) : format("%s-aurora", var.envname)
  availability_zones = var.azs
  engine                              = var.engine
  engine_version                      = var.engine_version
  engine_mode                         = var.engine_mode
  database_name                       = var.database_name
  master_username                     = var.username
  preferred_maintenance_window        = var.preferred_maintenance_window
  db_subnet_group_name                = var.aws_db_subnet_group
  vpc_security_group_ids              = [var.security_groups]
  snapshot_identifier                 = var.snapshot_identifier
  storage_encrypted                   = var.storage_encrypted
  apply_immediately                   = var.apply_immediately
  db_cluster_parameter_group_name     = var.db_cluster_parameter_group_name
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  master_password                     = var.password
  final_snapshot_identifier           = "${var.final_snapshot_identifier}-${local.timestamp_sanitized}"
  skip_final_snapshot                 = var.skip_final_snapshot
  backup_retention_period             = var.backup_retention_period
  preferred_backup_window             = var.preferred_backup_window

  scaling_configuration {
    auto_pause   = var.auto_pause
    max_capacity = var.max_capacity
    min_capacity = var.min_capacity
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = local.tags
}


locals {
  timestamp = timestamp()
  timestamp_sanitized = replace(local.timestamp, "/[-| |T|Z|:]/", "")

}

# output "timestamp" {
#   value = "${local.timestamp_sanitized}"
# }


# aqui vou criar a role e police para monitoramento
# data "aws_iam_policy_document" "monitoring-rds-assume-role-policy" {
#   count = var.enabled ? 1 : 0

#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["monitoring.rds.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "rds-enhanced-monitoring" {
#   count              = var.enabled && var.monitoring_interval > 0 ? 1 : 0
#   name_prefix        = "rds-enhanced-mon-${var.envname}-"
#   assume_role_policy = data.aws_iam_policy_document.monitoring-rds-assume-role-policy.json
# }

# resource "aws_iam_role_policy_attachment" "rds-enhanced-monitoring-policy-attach" {
#   count      = var.enabled && var.monitoring_interval > 0 ? 1 : 0
#   role       = aws_iam_role.rds-enhanced-monitoring.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
# }
