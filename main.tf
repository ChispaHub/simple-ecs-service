resource "aws_ecs_task_definition" "this" {
  family                   = var.name
  requires_compatibilities = ["FARGATE"]
  container_definitions = templatefile("${path.module}/task_definition.tpl", {
    container_name    = var.container_name
    image_repository  = aws_ecr_repository.this.repository_url
    image_tag         = var.container_image_tag
    container_memory  = var.memory
    container_port    = var.container_port
    environment       = jsonencode(var.environment)
    log_configuration = jsonencode(var.log_configuration)
  })
  network_mode       = "awsvpc"
  memory             = var.memory
  cpu                = var.cpu
  execution_role_arn = "arn:aws:iam::015452888753:role/ecsTaskExecutionRole"
  task_role_arn      = "arn:aws:iam::015452888753:role/ecsTaskExecutionRole"

  dynamic "volume" {
    for_each = var.volumes
    content {
      name = volume.value["name"]
    }
  }
}

resource "aws_security_group" "this" {
  name        = var.name
  description = "${var.name} SG"
  vpc_id      = var.vpc_id

  ingress {
    description      = "TCP ${var.container_port} from LB"
    from_port        = var.container_port
    to_port          = var.container_port
    protocol         = "tcp"
    security_groups  = [aws_security_group.this-lb[0].id]
    ipv6_cidr_blocks = []
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.name
  }
}

resource "aws_ecs_service" "this" {
  name            = var.name
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    assign_public_ip = var.assign_public_ip
    security_groups  = [aws_security_group.this.id]
    subnets          = var.vpc_subnets
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this[0].arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

}

resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"
}
