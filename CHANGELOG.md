# Registro de Cambios (Changelog)

## [2024-04-27]
- Creación del repositorio inicial.
- Se agregó el archivo .gitignore.
- Se redactó el README.md con los objetivos.

## [2026-04-28]
- Se agregó el archivo `main.tf` con la definición de infraestructura usando Terraform.
- Se configuró el proveedor de AWS (versión ~> 5.0).
- Se definió la creación de una VPC (10.1.0.0/16) y una Subred pública (/24) aplicando la nomenclatura requerida.
- Se implementó un Security Group con restricción de acceso SSH.
- Se configuró el despliegue de una instancia EC2 tipo t2.micro con sistema operativo Ubuntu 24.04 LTS.