<?php
    header("Access-Control-Allow-Origin: *");
    session_start();
    $_SESSION = array();
    include("src/php/idmenus.php");
    echo "<html class=\"html-custom\" >";
    echo "<head>\n";
    echo " <meta name='viewport' content='width=device-width, initial-scale=1'>\n";
    echo " <link rel='icon' type='image/png' href='favicon.png'>\n";
    echo "<title>FORAPI</title>";
    echo "</head>\n";
    echo "<body name=principal class=\"body-custom\" '>\n";
    echo "  <script src='dist/bundle.js' type='text/javascript' language='javascript'></script> ";
    echo "<div  id='div_titulos'  >\n";
    include('src/php/titulos.php');
    echo "</div>\n";

    echo "<div class='pleca'>\n";
    echo "<div id=menus class=\"navbar navbar-expand-lg navbar-light bg-light\" >\n";
    echo "<div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">\n";
    echo "     <ul class=\"navbar-nav mr-auto\" id=\"navbarSupportedContentul\">\n";
    echo "     </ul>";
    echo "</div>\n";
    echo "</div>\n";
    echo "</div>\n";

    echo "<section class='container'>\n";
    echo "<div >\n";
    echo "<div id=entrada class='div_menus' >\n";
    echo "</div>";
    echo "</div>\n";
    echo "</section>\n";
    echo "  <script>muestra_vista(".MENUS_BIENVENIDO.",'abre');</script> ";
    echo "<footer class='footer' >\n";
    echo "</footre>";
    echo "</body>\n";
    echo "</html>\n";
?>
