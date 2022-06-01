<?php
session_start();
header("Access-Control-Allow-Origin: *");
$t=getdate();
$today=date('Y-m-d h:i:s',$t[0]);
error_log($today." Entro imprime_credencial.php opcion=".print_r($_POST,true)."\n",3,"/var/tmp/errores.log");
include("conneccion.php");
require_once("xmlhttp_class.php");
require_once("../plantillas/credencial.php");
require '../../vendor/autoload.php';
		use Dompdf\Dompdf;
class gen_pdf_class extends xmlhttp_class {
      function gen_pdf() {

		// instantiate and use the dompdf class
		$dompdf = new Dompdf();
		$dompdf->loadHtml(credencial($this->argumentos));

		// (Optional) Setup the paper size and orientation
		$dompdf->setPaper('A4', 'landscape');
                error_log($today." Entro imprime_credencial.php basepath=".print_r($dompdf->getBasePath(),true)."\n",3,"/var/tmp/errores.log");

		// Render the HTML as PDF
		$dompdf->render();
                $output = $dompdf->output();
                $fileName = 'document.pdf';
                //file_put_contents('../../upload_ficheros/'.$fileName, $output);

		// Output the generated PDF to Browser
	//	$dompdf->stream();
            echo "<abrepdf_modal>".base64_encode($output)."</abrepdf_modal>";
      }
}
$va = new gen_pdf_class();
$va->connection = $connection;
if ($_POST["opcion"]=="")
{ 
	$va->inicio();
	echo "<error>No esta definida la opcion a ejecutar</error>";
	$va->termina();	
}
else
{
	## 20071105  Se cambio el get por el post
	## 20071105 $va->argumentos = $_GET;
	$va->argumentos = $_POST;
	$va->funcion = $_POST["opcion"];
	$va->procesa();
}
error_log($today." paso if imprime_credencial.php  post ".print_r($_POST,true)."\n"." get".print_r($_GET,true),3,"/var/tmp/errores.log");
?>
