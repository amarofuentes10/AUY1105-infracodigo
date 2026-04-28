package terraform.policies

# Por defecto, denegamos si se rompe alguna regla
default allow = false

# Regla 1: Política que solo permita la creación de ec2 de tipo "t2.micro"
deny[msg] {
    resource := input.resource_changes[_]
    resource.type == "aws_instance"
    resource.change.after.instance_type != "t2.micro"
    
    msg := sprintf("Infracción: La instancia EC2 debe ser 't2.micro', pero se detectó '%v'", [resource.change.after.instance_type])
}

# Regla 2: Política para no permitir el acceso SSH público (0.0.0.0/0)
deny[msg] {
    resource := input.resource_changes[_]
    resource.type == "aws_security_group"
    
    ingress := resource.change.after.ingress[_]
    ingress.from_port == 22
    ingress.to_port == 22
    ingress.cidr_blocks[_] == "0.0.0.0/0"
    
    msg := "Infracción: El Security Group permite acceso SSH público (0.0.0.0/0). Esto no está permitido por políticas de seguridad."
}