resource "aws_lb" "this" {
  count              = var.exposed_port != "" ? 1 : 0
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.this-lb[0].id]
  subnets            = var.vpc_subnets
}

resource "aws_lb_listener" "this" {
  count             = var.exposed_port != "" ? 1 : 0
  load_balancer_arn = aws_lb.this[0].arn
  port              = var.exposed_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[0].arn
  }
}

resource "aws_security_group" "this-lb" {
  count       = var.exposed_port != "" ? 1 : 0
  name        = "${var.name}-lb"
  description = "port ${var.exposed_port} public access"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Port ${var.exposed_port} public access"
    from_port        = var.exposed_port
    to_port          = var.exposed_port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "this-lb"
  }
}

resource "aws_lb_target_group" "this" {
  count       = var.exposed_port != "" ? 1 : 0
  name        = var.name
  port        = var.exposed_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}
