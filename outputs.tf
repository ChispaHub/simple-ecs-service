output "container_image_repository" {
  description = "The Docker repository where the container image is located"
  value       = aws_ecr_repository.this.repository_url
}
