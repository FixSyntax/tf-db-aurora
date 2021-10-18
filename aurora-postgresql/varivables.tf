variable "region" {
  type        = string
  description = "Regiao onde vai ser criado"
}

variable "subnets" {
  type        = list(string)
}

variable "envname" {
  type        = string
  description = "Environment"
}

variable "envtype" {
  type        = string
  description = "Environment(eg,prod)"
}

variable "identifier_prefix" {
  type        = string
  default     = ""
  description = "prefixo do cluster"
}

variable "azs" {
  type        = list
  description = "lista das az"
}

variable "security_groups" {
  description = "receba"
}

variable "database_name" {
  type        = string
  default     = ""
  description = "nome da base master"
}

variable "username" {
  default     = "root"
  description = "username"
}

variable "password" {
  type        = string
  description = "password"
}

variable "final_snapshot_identifier" {
  type        = string
  default     = "final"
  description = "fria um snapshot final com timesmap no nome"
}

variable "skip_final_snapshot" {
  type        = string
  default     = "false"
  description = "Deve um snapshot final ser criado na destruição do cluster"
}

variable "backup_retention_period" {
  type        = string
  default     = "7"
  description = "Por quanto tempo manter os backups (em dias)"
}

variable "preferred_backup_window" {
  type        = string
  default     = "02:00-03:00"
  description = "janela de backup"
}

variable "preferred_maintenance_window" {
  type        = string
  default     = "sun:05:00-sun:06:00"
  description = "janela de manutencao"
}

variable "auto_pause" {
  type        = string
  default     = "true"
  description = "Quando realizar a pausa automatica do banco de dados"
}

variable "max_capacity" {
  type        = string
  default     = "8"
  description = "capacidade maxima"
}

variable "min_capacity" {
  type        = string
  default     = "2"
  description = "capacidade minima"
}

# variable "port" {
#   type        = string
#   default     = "3306"
#   description = "porta da instancia de banco de dados"
# }

variable "apply_immediately" {
  type        = string
  default     = "false"
  description = "Determina se quaisquer modificações do banco de dados são aplicadas imediatamente ou durante a janela de manutenção"
}

variable "monitoring_interval" {
  type        = string
  default     = 0
  description = "O intervalo (segundos) entre os pontos quando as métricas de monitoramento avançado são coletadas"
}

variable "auto_minor_version_upgrade" {
  type        = string
  default     = "true"
  description = "Determina se pequenas atualizações do motor serão realizadas automaticamente na janela de manutenção"
}

variable "db_parameter_group_name" {
  type        = string
  default     = ""
  description = "parameter group"
}

variable "db_cluster_parameter_group_name" {
  type        = string
  description = "parameter group de DB de cluster de banco de dados a ser usado"
}
variable "snapshot_identifier" {
  type        = string
  default     = ""
  description = "DB snapshot para criar a partir de"
}

variable "storage_encrypted" {
  type        = string
  default     = "true"
  description = "armazenamento subjacente deve ser criptografada"
}

variable "cw_alarms" {
  type        = string
  default     = false
  description = "habilitar alarmes CloudWatch - requer que `cw_sns_topic`"
}

variable "cw_sns_topic" {
  type        = string
  default     = "false"
  description = "Um tópico SNS para publicar alarmes CloudWatch para"
}

variable "cw_max_conns" {
  type        = string
  default     = "500"
  description = "Contagem de conexão além da qual acionar um alarme CloudWatch"
}

variable "cw_max_cpu" {
  type        = string
  default     = "85"
  description = "Limite de CPU acima do qual alarmar"
}

variable "cw_max_replica_lag" {
  type        = string
  default     = "2000"
  description = "Atraso máximo da réplica Aurora em milissegundos acima do qual alarmar"
}

variable "cw_eval_period_connections" {
  type        = string
  default     = "1"
  description = "Período de avaliação dos alarmes de conexões DB"
}

variable "cw_eval_period_cpu" {
  type        = string
  default     = "2"
  description = "Período de avaliação dos alarmes da CPU DB"
}

variable "cw_eval_period_replica_lag" {
  type        = string
  default     = "5"
  description = "Período de avaliação para o alarme de atraso de réplica DB"
}

variable "engine" {
  type        = string
  default     = ""
  description = "engine"
}

variable "engine_mode" {
  type        = string
  default     = ""
  description = "engine"
}

variable "engine_version" {
  type        = string
  default     = "5.6.10a"
  description = "engine"
}

variable "performance_insights_enabled" {
  type        = string
  default     = false
  description = "Whether to enable Performance Insights"
}

variable "iam_database_authentication_enabled" {
  type        = string
  default     = false
  description = "Se deve habilitar a autenticação do banco de dados IAM para o RDS Cluster"
}

variable "enabled" {
  type        = string
  default     = true
  description = "Se os recursos do banco de dados devem ser criados"
}

variable "aws_db_subnet_group" {
  description = "grupo de subnets"
}

variable "tags" {
  type        = map
  default     = {}
  description = "Um conjunto de tags para anexar aos recursos criados"
}

locals {
  default_tags = {
    "envname" = var.envname
    "envtype" = var.envtype
  }

  tags = merge(var.tags, local.default_tags)
}