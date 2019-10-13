<?php
    header("Access-Control-Allow-Origin: *");
    session_start();
    $_SESSION = array();
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
    echo "<div id=menus class='div_menus' >\n";
    echo "</div>\n";
    echo "<div id=entrada class='div_menus' >\n";
    include('src/php/entrada.php');
    echo "</div>\n";
    echo "</body>\n";
    echo "</html>\n";
?>
