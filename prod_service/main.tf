module "ecs" {
  source = "./modules/aws-ecs"

  app-cluster-name   = var.APP_CLUSTER_NAME
  app-container-name = var.APP_CONTAINER_NAME
  app-port           = var.APP_PORT
  db-cluster-endpoint    = data.aws_rds_cluster.aurora_cluster.endpoint
  app-task-name      = var.APP_TASK_NAME
  app-service-name   = var.APP_SERVICE_NAME

  app-sg-name         = var.APP_SG_NAME
  app-tg-name         = var.APP_TG_NAME
  app-subnets         = var.APP_SUBNETS
  private-subnet-name = var.PRIVATE_SUBNET_NAME
  task-execution-role-name = var.TASK_EXECUTION_ROLE_NAME
}