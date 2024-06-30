data "aws_lb" "app-elb" {
  name = var.APP_ALB_NAME
}

data "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier = var.AURORA_CLUSTER_IDENTIFIER
}