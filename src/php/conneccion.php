<?php
session_cache_expire(60);  ## se establece el limite de la sesion de php en 60 min
session_start(); 
require_once("idmenus.php");
##  hay que checar porque hay veces que entra la clave temporal, como que hay un limite y se pierde la session
$wlhost='localhost';
$wldbname=BD;
$wlport='5432';
if(isset($_SESSION['parametro1']) || isset($_SESSION['parametro2']) || isset($_SESSION['bada']) || isset($_SESSION['servidor']))
{	$connection = pg_connect("host=".$_SESSION['servidor']." dbname=".$_SESSION['bada']." user=".$_SESSION['parametro1']." password=".$_SESSION['parametro2']." port=$wlport") or die("Finalizo la session tienes que volver a ingresar");	
        pg_exec($connection,"set client_encoding to 'latin1'");
}
else
{
    if(isset($escron))
    {	$connection = pg_connect("host=$wlhost dbname=BD user='jlv' password='888aDantryR' port=$wlport") or die("Error en el cron");	}
    else
    {	
        $connection = pg_connect("host=$wlhost	dbname=".BD." user=tmp_".BD." password=".PWD_USER_TMP." port=$wlport") or die("Error con clave temporal1");
    }
}
?>
