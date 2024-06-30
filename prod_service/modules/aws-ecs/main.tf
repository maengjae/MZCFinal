resource "aws_ecs_cluster" "app_cluster" {
  name = var.app-cluster-name
  
  setting {
    name = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name       = var.app-cluster-name
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }
}

# Create ECS task definition for app service
resource "aws_ecs_task_definition" "app_task_definition" {
  family = "app-task-family"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 1024
  memory = 2048

  container_definitions = jsonencode([
    {
      "name" : "${var.app-container-name}",
      "image" : "lygerin14/test:app-deploy",
      "cpu" : 256,
      "memory" : 512,
      "portMappings" : [
        {
          "containerPort" : "${var.app-port}",
          "protocol" : "tcp"
        }
      ],
      "environment" : [
        {
          "name" : "db_endpoint",
          "value" : "${var.db-cluster-endpoint}"
        }
      ]
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }

  execution_role_arn = data.aws_iam_role.task-execution.arn

  tags = {
    Name       = var.app-task-name
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }

  depends_on = [ aws_ecs_cluster.app_cluster ]
}

resource "aws_ecs_service" "app-service" {
  name            = var.app-service-name
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.app-subnets.ids
    security_groups  = [data.aws_security_group.app-sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = data.aws_lb_target_group.app-tg.arn
    container_name   = var.app-container-name
    container_port   = var.app-port
  }

  tags = {
    Name       = var.app-service-name
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }

  depends_on = [aws_ecs_task_definition.app_task_definition]
}

resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 10
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.app_cluster.name}/${aws_ecs_service.app-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "scale_up" {
  name               = "scale-up"
  policy_type        = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 75.0
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}

resource "aws_appautoscaling_policy" "scale_down" {
  name               = "scale-down"
  policy_type        = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 25.0
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}