# forapi
formas rapidas

Es una herramiente que permite generar formulario en donde se pueden realizar los clasicos movimiento de altas, baja, cambios y consultas.

Utiliza base de datos postgres 9.2 , php 7.3 y apache 2.0, entonces para poder utillizar esta herramienta hay que
tener instalados estos paquetes.

Instalación.

Posteriormente de haber hecho un clone al repositorio.

se debera de ir al directorio del proyecto donde se hizo el clone y ejecutar el siguiente script.

src/sh/crea_forapi.sh   $1 $2 $3 

se debera de proporciona los parametros

$1=Nombre de la base de datos
$2=usuario administrador
$3=password del administrador


Una vez ejecutado este shell, se debera de utilizar un browser y darle la url donde se instalo la herramienta, 
si todo esa bien la url solicitara el usuario y password. el cual  sera el mismo que se tecleo en el shell 
src/sh/crea_forapi.sh

.


