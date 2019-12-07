<?php
	include "conneccion.php";		
	require "soldatos.php";
	$soldatos = new soldatos();
        echo "CORREO_HOST=".CORREO_HOST;
        $soldatos->Enviaemail('prueba envio email1');
?>
