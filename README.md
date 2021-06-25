# Simple ECS Service

Terraform module for managing ECS services in a simple way

## How to use

In your terraform manifest you can import this module this way:

```tf
module "service_name" {
  source = "github.com/ChispaHub/simple-ecs-service"

  # Variables
}
```

### Required Variables

* vpc_id: The id of the VPC on which to run this service
* vpc_subnets: The list of subnets that can host instances of this service
* ecs_cluster_id: The id of the ECS cluster on which to run this service
* name: The name to give to this service. This will be used to name all related resources
* desired_count: The number of containers of this service to run
* memory: The amount of memory to allocate for each container of this service
* cpu: The amount of 1000ths of CPUs to allocate for each container. E.g.: 500 is 1/2 CPU
* container_name: The name of the Docker container
* container_port: The exposed port of the Docker container
* volumes: A list of objects containing the names of the storage volumes to allocate
* container_image_repository: The Docker repository where the container image is located
* container_image_tag: The tag of the container image to use
* log_configuration: The ECS log forwarding configuration

### Optional Variables

* exposed_port: Create a load balancer for this service and expose the container port at this port. Example: Expose port 80 for HTTP
* assign_public_ip: Assign a public IP to each container running this service. Only works when vpc_subnets are public subnets.
* environment: A list of environment variables to set in each container
