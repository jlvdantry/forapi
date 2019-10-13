<?php
	include "conneccion.php";		
	require "soldatos.php";
	$soldatos = new soldatos();
	$soldatos->destino = 'ccajas';
	$soldatos->connection = $connection;
	$soldatos->datos = array('MTA');
	$soldatos->opcionesbin = array('','');
	$soldatos->idmenu=$idmenu;
	if(isset($_POST['_idmenu_'])) 
	{
		$soldatos->idmenu=$_POST['_idmenu_'];
	}	
	if(isset($_POST['_filtro_'])) 
	{
		$soldatos->filtro=$_POST['_filtro_'];
	}
	
	if(isset($_GET['filtro']))	
	{
		$soldatos->filtro=$_GET['filtro'];
	}
	if(isset($_GET['idmenu']))	
	{
		$soldatos->idmenu=$_GET['idmenu'];
	}	
	$soldatos->despledatos();
?>
