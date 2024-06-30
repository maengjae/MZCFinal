# DATA
MAIN_REGION = "us-east-2"
APP_ALB_NAME      = "mjy-prod-app-alb"
AURORA_CLUSTER_IDENTIFIER = "mjy-aurora-cluster"

# ECS
APP_CLUSTER_NAME   = "mjy-app-cluster"
APP_CONTAINER_NAME = "mjy-app"
APP_PORT           = 8080
APP_TASK_NAME      = "mjy-app-task"
APP_SERVICE_NAME   = "mjy-app-service"

APP_SG_NAME     = "mjy-prod-app-sg"
APP_TG_NAME       = "mjy-prod-app-tg-blue"
APP_SUBNETS        = ["3", "4"]
PRIVATE_SUBNET_NAME    = "PrivateSubnet"
TASK_EXECUTION_ROLE_NAME = "mjy-task-execution-policy"

# CI/CD
PIPELINE_NAME = "mjy-pipeline"
ROLE_NAME = "AWSCodePipelineServiceRole-us-east-2-mjy-pipeline"
BUCKET_NAME = "mjy-bucket"
GIT_REPO = "maengjae/MZCFinal"
GIT_CONNECTION_NAME = "mjy-pipeline-connection"
BRANCH_NAME = "Prod_app"
CODEBUILD_PROJECT_NAME = "mjy-build-app"
