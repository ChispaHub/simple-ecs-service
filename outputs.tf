output "container_image_repository" {
  description = "The Docker repository where the container image is located"
  value       = aws_ecr_repository.this.repository_url
}

output "lb_id" {
  description = "Load balancer id"
  value = aws_lb.this.id
}

output "lb_arn" {
  description = "Load balancer arn"
  value = aws_lb.this.arn
}

output "lb_dns_name" {
  description = "Load balancer dns_name"
  value = aws_lb.this.dns_name
}

output "lb_zone_id" {
  description = "Load balancer zone_id"
  value = aws_lb.this.zone_id
}