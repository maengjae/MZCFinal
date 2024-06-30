# DATA
variable "MAIN_REGION" {}
variable "APP_ALB_NAME" {}
variable "AURORA_CLUSTER_IDENTIFIER" {}

# ECS
variable "APP_CLUSTER_NAME" {}
variable "APP_CONTAINER_NAME" {}
variable "APP_PORT" {}
variable "APP_TASK_NAME" {}
variable "APP_SERVICE_NAME" {}

variable "APP_SG_NAME" {}
variable "APP_TG_NAME" {}
variable "APP_SUBNETS" {}
variable "PRIVATE_SUBNET_NAME" {}
variable "TASK_EXECUTION_ROLE_NAME" {}

# PIPELINE
variable "PIPELINE_NAME" {}
variable "ROLE_NAME" {}
variable "BUCKET_NAME" {}
variable "GIT_REPO" {}
variable "GIT_CONNECTION_NAME" {}
variable "BRANCH_NAME" {}
variable "CODEBUILD_PROJECT_NAME" {}
