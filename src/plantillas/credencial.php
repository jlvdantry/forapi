<?php
    function credencial($argumentos) {
       $data = file_get_contents('../../dist/img/enca_imss.png');
       $pie = file_get_contents('../../dist/img/pie_imss.png');
       $base64 = 'data:image/png;base64,' . base64_encode($data);
       $base64_pie = 'data:image/png;base64,' . base64_encode($pie);
       $html='<html>
    <head>
        <meta charset="utf-8">
        <style>
            /** Define the margins of your page **/
            @page {
                margin: 20px;
            }

            body {
                font-size: 7pt;
                //background-image: url("../../dist/img/enca_imss.png");
                //background-image: url('.$base64.');
            }

            header {
                position: fixed;
                top: -60px;
                left: 0px;
                right: 0px;
                height: 50px;

                /** Extra personal styles **/
                background-color: #03a9f4;
                color: white;
                text-align: center;
                line-height: 35px;
            }

            footer {
                position: fixed; 
                bottom: -60px; 
                left: 0px; 
                right: 0px;
                height: 50px; 

                /** Extra personal styles **/
                background-color: #03a9f4;
                color: white;
                text-align: center;
                line-height: 35px;
            }
            .cred {
                background-color: #03a9f4;
                height: 150px; 
                width: 700px;
            }
            .frente {
                height: 359px;
                width: 242px;
                //background-color: #008000;
            }
            .atras {
                height: 359px;
                width: 242px;
                //background-color: #FFFF00 ;
            }
		.center {
		  margin-left: auto;
		  margin-right: auto;
		}
             .enca {
                  position: absolute;
                  top: 0px;
                  //margin-left: 20px;
                  background-image: url('.$base64.');
                  width: 242px;
                  height: 100%;
                  object-fit: contain;
                  background-repeat: no-repeat;
             }
             .centro {
                  position: absolute;
                  top: 66px;
                  height: 260px;
                  border-style:dotted;
                  width: 242px;
             }
             .pie_container {
                  position: absolute;
                  top: 325.75px;
                  width: 242px;
                  height: 33px;
                  //background-color: #03a9f4;
                  border-style:dotted;
             }
             .pie {
                  position: absolute;
                  top: 0px;
                  left: 0px;
                  background-image: url('.$base64_pie.');
                  width: 100%;
                  height: 100%;
                  object-fit: contain;
                  //background-size: cover; /* scales the image */
                  //background-position: center; /* centers the image */
                  background-repeat: no-repeat;
             }
             .text-center-row {
                  text-align: center;
                  width : 100%;
                  color : white;
             }
             .text-left-row {
                  text-align: justify;
                  width : 95%;
                  color : white;
                  font-size : 5.5pt;
                  margin-left: 3px;
                  margin-right: 30px;
             }

        </style>
    </head>
    <body>
        <!-- Define header and footer blocks before your content 
        <header>
            Our Code World
        </header>

        <footer>
            Copyright &copy; <?php echo date("Y");?> 
        </footer>
          -->
        <main>
        <table class="center">
         <tbody>
            <tr>
               <td class="frente">
                     <div class="enca">
                       <div class="text-center-row">
                         INSTITULO MEXICANO DEL SEGURO SOCIAL<br>
                         DELEGACIÓN SUR<br>
                         GUARDERÍA MADRES IMSS No. VII
                       </div>
                     </div>
                     <div class="centro">
                          <div id="foto">
                          </div>
                          <div id="foto">
                                 NOMBRE: '.strtoupper($argumentos['wl_b']).' '.strtoupper($argumentos['wl_c']).' '.strtoupper($argumentos['wl_d']).'
                          </div>
                     <div>
                     <div class="pie_container">
                        <div class="pie">
                        </div>
                     </div>

               </td>
               <td class="atras">
                     <div class="enca">
                       <div class="text-left-row">
ESTE PRESENTE GAFETE ES PERSONAL E INSTRANFERIBLE Y DEBE PORTARSE DURANTE SU JORNADA DE TRABAJO. EL TITULAR QUEDA OBLIGADO A DEVOLVERLO CUANDO EL INSTITUTO LO SOLICITE
                       </div>
                     </div>
                     <div class="pie_container">
                        <div class="pie">
                        </div>
                     </div>

               </td>
            </tr>
         <tbody>
        </table
        <main>

    </body>
</html>';
       return $html;
    }
?>
