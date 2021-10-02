variable "vpc_id" {
  description = "The id of the VPC on which to run this service"
  type        = string
}

variable "vpc_subnets" {
  description = "The list of subnets that can host containers of this service"
  type        = list(string)
}

variable "ecs_cluster_id" {
  description = "The id of the ECS cluster on which to run this service"
  type        = string
}

variable "name" {
  description = "The name to give to this service. This will be used to name all related resources"
  type        = string
}

variable "desired_count" {
  description = "The number of containers of this service to run"
  type        = string
}

variable "memory" {
  description = "The amount of memory to allocate for each container of this service"
  type        = string
}

variable "cpu" {
  description = "The amount of 1000ths of CPUs to allocate for each container. E.g.: 500 is 1/2 CPU"
  type        = string
}

variable "container_name" {
  description = "The name of the Docker container"
  type        = string
}

variable "container_port" {
  description = "The exposed port of the Docker container"
  type        = string
}

variable "volumes" {
  description = "A list of objects containing the names of the storage volumes to allocate"
  type = set(object({
    name = string
  }))
}

variable "assign_public_ip" {
  description = "Assign a public IP to each container running this service. Only works when vpc_subnets are public subnets."
  type        = bool
  default     = false
}

variable "container_image_tag" {
  description = "The tag of the container image to use"
  type        = string
}

variable "certificate_arn" {
  description = "The ARN of the TLS certificate to use in the HTTPS listener"
  type        = string
}

variable "environment" {
  description = "A list of environment variables to set in each container"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "log_configuration" {
  description = "The ECS log forwarding configuration"
  type        = any
}
