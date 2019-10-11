<?php
include("menudata.php");
include "conneccion.php";
$v = new menudata();
$v->idmenu=1349;
$v->filtro="nombre='NOMBRE'";
$v->connection=$connection;
$v->damemetadata();
echo "<pre>";
##echo "<fuente>".$v->camposm["fuente"];
print_r($v->camposm);
echo "menus_movtos";
print_r($v->camposmm);
echo "menus_campos";
print_r($v->camposmc);
echo "menus_campos_eventos";
print_r($v->camposmce);
echo "menus_eventos";
print_r($v->camposme);
echo "menus_subvistas";
print_r($v->camposmsv);
echo "menus_htmltable";
print_r($v->camposmht);
echo "</pre>";
?>
