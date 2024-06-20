# Configuración y Despliegue de AWS Instance con Terraform
Este repositorio contiene la configuración de Terraform para desplegar una instancia de AWS con un grupo de seguridad que permite acceso SSH y HTTP.
## Generación de Claves SSH
Antes de comenzar con Terraform, necesitas generar un par de claves SSH si aún no las tienes. Sigue estos pasos para crearlas:

### Genera las Claves SSH

Ejecuta el siguiente comando en tu terminal para generar un par de claves RSA:

```bash
ssh-keygen -t rsa -b 2048 -f nginx-server.key
```
Esto generará dos archivos:

* nginx-server.key: Clave privada.
* nginx-server.key.pub: Clave pública.
* Guarda de manera segura la clave privada (nginx-server.key). La clave pública (nginx-server.key.pub) será utilizada en Terraform para configurar el acceso a la instancia en AWS.
* Realice cambios en la linea 33,48,86 de main.tf el apartado de Tags -> Owner: "Por el nombre del propietario"
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
Una vez realizado el apply, accedemos a nuestra consola de aws, y buscamos la instancia creada, copiamos la ip, la pegamos en el navegador, finalmente comprobamos que funciona correctamente nuestra instancia. 
