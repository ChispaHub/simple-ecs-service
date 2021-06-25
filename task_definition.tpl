[
  {
    "name": "${container_name}",
    "image": "${image_repository}:${image_tag}",
    "memory": ${container_memory},
    "essential": true,
    "portMappings": [
      {
        "containerPort": ${container_port},
        "hostPort": ${container_port},
        "protocol": "tcp"
      }
    ],
    "resourceRequirements": null,
    "environment": ${environment},
    "environmentFiles": [],
    "logConfiguration": ${log_configuration},
    "secrets": null,
    "mountPoints": null,
    "volumesFrom": null,
    "hostname": null,
    "user": null,
    "workingDirectory": null,
    "extraHosts": null,
    "ulimits": null,
    "dockerLabels": null,
    "dependsOn": null
  }
]
