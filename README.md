# Configuración y Despliegue de AWS Instance con Terraform
Este repositorio contiene la configuración de Terraform para desplegar una instancia de AWS con un grupo de seguridad que permite acceso SSH y HTTP.
## Pasos para Configurar y Desplegar
### Paso 1: Inicializar Terraform
Antes de comenzar, inicializa Terraform en el directorio del proyecto para preparar el entorno de trabajo:
```bash
terraform init
```
### Paso 2: Planificación del Despliegue
Genera un plan de ejecución para revisar los cambios que se aplicarán a tu infraestructura:
```bash
terraform plan
```
Revisa cuidadosamente el plan generado para asegurarte de que se alinea con tus expectativas antes de proceder.

### Paso 3: Aplicar la Configuración
Una vez revisado el plan y estés listo para aplicar los cambios, ejecuta el comando apply para implementar la configuración en AWS:
```bash
terraform apply
```
Confirma la acción escribiendo "yes" cuando se solicite.
