<?php
    function credencial() {
       $html='<html>
    <head>
        <meta charset="utf-8">
        <style>
            /** Define the margins of your page **/
            @page {
                margin: 0;
            }

            body {
                font-size: 7pt;
                //background-image: url("../../dist/img/enca_imss.png");
                background-image: url("enca_imss.png");
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
                background-color: #008000;
            }
            .atras {
                height: 359px;
                width: 242px;
                background-color: #FFFF00 ;
            }
		.center {
		  margin-left: auto;
		  margin-right: auto;
		}
             .enca {
                  position: absolute;
                  top: 0px;
                  margin-left: 20px;
                  background-image: url("../../dist/img/enca_imss.png");
             }
             .text-center-row {
                  text-align: center;
                  width : 100%;
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
               </td>
               <td class="atras">atras</td>
            </tr>
         <tbody>
        </table
        <main>

    </body>
</html>';
       return $html;
    }
?>
