<?php
	$_SESSION['challenge']=md5(rand(1,100000));
	include "conneccion.php";		
	require "soldatos.php";
	session_unset();	
	$soldatos = new soldatos();
	$soldatos->destino = 'ccajas';
	$soldatos->connection = $connection;
	$soldatos->datos = array('MTA');
	$soldatos->opcionesbin = array('','');
	$soldatos->descripcion='Bienvenido';
	$soldatos->idmenu='';
	if(isset($_POST['filtro']))
	{
		$soldatos->filtro=$_POST['filtro'];##20071105
	}
	$soldatos->despledatos();
	$arraydes = array( 0 => "IE", 1 => "AC", 2=> "ZIP",3=> "CONECT");
        echo "	<script language=\"JavaScript\">";
	echo "	</script>	";
?>
