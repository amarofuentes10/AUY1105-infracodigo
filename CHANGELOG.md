# Registro de Cambios (Changelog)

## [2024-04-27]
- Creación del repositorio inicial.
- Se agregó el archivo .gitignore.
- Se redactó el README.md con los objetivos.

- Se implementó pipeline CI/CD en GitHub Actions (ci.yml) con etapas de análisis estático (TFLint), seguridad (Checkov) y validación de Terraform.

- Se definieron políticas de seguridad con Open Policy Agent (OPA) en 'policies/reglas.rego' para restringir EC2 a 't2.micro' y bloquear accesos SSH públicos (0.0.0.0/0).