# Creating Aurora RDS Cluster, username and password used only for practice, otherwise follow DevOps best practices to keep it secret
resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = var.aurora-cluster-identifier
  engine                  = "aurora-mysql"
  engine_version = "8.0.mysql_aurora.3.05.2"
  engine_mode             = "provisioned"
  enable_local_write_forwarding = true
  master_username         = var.rds-username
  master_password         = var.rds-pwd
  database_name           = var.db-name
  backup_retention_period = 7
  preferred_backup_window = "19:00-21:00"
  skip_final_snapshot     = true
  port                    = 3306

  db_subnet_group_name   = data.aws_db_subnet_group.db-subnet-group.name
  vpc_security_group_ids = [data.aws_security_group.db-sg.id]
  availability_zones = ["us-east-2a","us-east-2b"]

  tags = {
    Name       = var.rds-name
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }
}

resource "aws_rds_cluster_instance" "aurura_instance" {
  count=1
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = var.rds-instance-class
  engine             = aws_rds_cluster.aurora_cluster.engine
  availability_zone = element(var.azs, count.index)

  depends_on = [ aws_rds_cluster.aurora_cluster ]

  tags = {
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }
}

resource "aws_appautoscaling_target" "aurora_replica_scaling_target" {
  max_capacity       = "15"
  min_capacity       = "1"
  resource_id        = "cluster:${aws_rds_cluster.aurora_cluster.id}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"

  depends_on = [ aws_rds_cluster_instance.aurura_instance ]

  tags = {
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }
}

resource "aws_appautoscaling_policy" "aurora_replica_scaling_policy" {
  name               = "aurora-replica-scaling-policy"
  resource_id        = aws_appautoscaling_target.aurora_replica_scaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.aurora_replica_scaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.aurora_replica_scaling_target.service_namespace
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value       = 75
    predefined_metric_specification {
      predefined_metric_type = "RDSReaderAverageCPUUtilization"
    }
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }

  depends_on = [ aws_appautoscaling_target.aurora_replica_scaling_target ]
}
