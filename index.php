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
/*
echo '<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">';
echo '<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>';
echo '<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>';
echo '<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>';
*/
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
    echo "  <script src='dist/bundle.js' type='text/javascript' language='javascript'></script> ";

    echo "<section class='container'>\n";
    echo "<div >\n";
    echo "<div id=entrada class='div_menus' >\n";
    echo "</div>";
    echo "</div>\n";
    echo "</section>\n";
    echo '
            <div class="modal fade" id="msgModal" tabindex="-1" role="dialog" aria-hidden="true">
              <div class="modal-dialog modal-lg" role="document" >
                <div class="modal-content" id="modal-content">
                  <div class="modal-header pb-0">
                    <h1 class="modal-title" id="titleMsgModal"></h1>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                    <div class="modal-body" id="modal-body"> </div>
                </div>
              </div>
            </div>
         ';

    echo "<footer class='footer' >\n";
    echo "</footer>";
    echo "</body>\n";
    echo "</html>\n";
    echo "  <script> $(document).ready(function() { muestra_vista(".MENUS_BIENVENIDO."); }) </script> ";
?>
