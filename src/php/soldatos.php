<?php
/* February 15, 2006 07:06:20 PM se incluyo MTA Mantenimiento a tabla  
		se quita MRP mantenimiento a rangos y se entra por mta, la tabla indica que accesar */
/*  20080208  tener esto bien presente los eventos estan delimitado por comilla simple
              esto quiere decir que internamente se van a manejar doble comilla si es que es necesario
              manejar este dato
              */		
/*  20080208  Tomar en cuenta que cuando se pone que convierta a mayusculas o minusculas
				no funciona el onchange
				**/     
/*  20080208  checar porque no hace los cambios de uppercase y dowcase en menus_campos  */		
/*  20080210  hay que limpira los campos hijos cuando el campo padre cambie  */		         
/*  20080215  corregir para que en menus_pg_tables el select,update,insert,delete debe alguno tener un valor */
include("mensajes.php");
require_once("class.phpmailer.php");
require_once("menudata.php");
require_once("class_logmenus.php");   
require_once("config.php");   
/**
*   clase que genera la pantalla que genera la solicitud de datos 
*   <pre>
*   La pantalla que genera esta dividida en tres partes que son:
*   parte 1.  El objetivo de esta parte es mostrar todo el registro que se va a cambiar, dar de baja, consultar
*             o sirve tambien para dar de alta, id=tablacaptura
*   parte 2.  el objetivo de esta tabla muestra las botoneras id=tabbotones
*   parte 3.  El objetivo de esta parte es mostrar un renglon por cada registro que forma parte de la consulta
*             id=tabdinamica
*   </pre>
*   @package   forapi
*   @author Jose Luis Vasquez Barbosa
*   @version    1.0
*   @link http://jlvazque16:8082/doc/report.htm
*   
**/
class soldatos
{
  /**
    *  contiene la conexion a la base de datos
    *  @var string
    **/
  var $connection="";
  /**
     *    variable donde se solicita la fecha de inicio, tiende a desaparecer
     *    @var datetime
     */
  var $xlfechaini="";
  /**
     *    variable donde se solicita la fecha final, tiende a desaparecer
     */  
  var $xlfechafin="";
  /**
     *    titulos que aparece en la tabla de captura, tiende a desaparecer
     */  
  var $titulos="";
  /**
     *    Datos que presenta en la tabla 
     *     si el dato contien 'FE' muestra fecha, 'RF' muestra rango de fecha,'PI' muestra punto de recaudacion inicial
     *               'PF' muestra punto de recaudacion final, 'ES' muestra el estado
     *               'MTA'  Mantenimiento de tabla  'AA' Alta automatica a un catalogo   //20070215
     *     @var arreglo
     */    
  var $datos=array();
  /**
    *   movimientos que se pueden realizar a la tabla
    *          i=insert,d=delete,u=update,s=select e=checar cc=copia un registro 
    *   @var string
    */
  var $movto_mantto="";
  /**
    *   nombre de la tabla a la que se le va a dar mantenimiento
    */  
  var $tabla=""; 
  /**
    *   variable que indica si se muestra un boton,  tiende a desaparecer
    */    
  var $boton="";
  /**
    *   que accion debe de ejecutar despues que se ejecuto el submit
    */
  var $accion="";
  /**
    *   Cual va a ser el target de la accion
    */  
  var $destino="";
  /**
    *   Numero de menu el cual se le va a dar mantenimiento
    */    
  var $idmenu="";  /* numero de vista a la que va a dar mantenimiento  */
  /**
    *   Descripcion de la vista a la cual se le va a dar manteniento
    */      
  var $descripcion="";
  /**
    *  Arreglo que contiene los campos de la vista que se le va a dar mantenimiento
    */  
  var $menu = array();
  /**
    *  Arreglo que contiene los campos de la tabla menus campos
    */
  var $menuc = array();
  /**   20070804
    *  Arreglo que contiene los eventos de la tabla menus campos
    */
  var $menumce = array();  
  /**
    *  Arreglo que contiene los campos de la tabla menus eventos
    */
  var $menue = array();
  /**
    *  Arreglo que contiene los campos de la tabla menus movtos, indica que movimientos se van a reliazar i,d,u,s etcc
    */
  var $menum = array();
  /**  20070627
    *  Arreglo que contiene los campos de la tabla menus htmltables, indica si los campos van hacer agrupados
    */
  var $menumht = array();  
  
  /**
    *  filtro que se va a aplicar en la vista
    */  							
  var $filtro="";
  /**
    *   todo el metada del menu
    */
  var $metada="";
  
  /**
    *   funcion que arma el html el cual solicita los datos
    */
  function despledatos()
  {

	  if (in_array("MTA",$this->datos)) // 20070818
	  { // 20070818
		  $this->lee_menu();	  // 20070818
	  } // 20070818
      $this->inicio_html();
      $this->arma_js();
      $this->inicio_form();
      $this->quedatos();
      $this->botones();
      $this->fin_form();
      $this->fin_html();
  }

  /**
    *  Metodo que arma el javascript, de acuerdo a lo definido en la variable datos
    */
  function arma_js()
  {
    echo "<script>\n";

//20070524    include("sortable.js");
    echo "function inicioforma() {\n";  // funcion para obtener el valor del dato de la cookiee
##    echo "   alert('inicio'); ";
    echo "   window.defaultStatus='nada';\n";
    echo "   if(document.URL.indexOf('filtro=')!=-1)\n";
    echo "   { fijos(document.URL); window.name='dialog'; }\n";

    echo "   try { hayunregistro(); } catch(err) { } \n";  // 20070215
    echo "   var a='';\n";
    reset($this->datos);
    $z=0;
    while (current($this->datos) !== false)
    {
          switch (current($this->datos))
          {
             case 'FE':
                $this->obtendato('xlfechaini',$z);
                break;
             case 'RF':
                $this->obtendato('xlfechaini',$z);
                $this->obtendato('xlfechafin',$z+1);
                break;
             case 'PI':
                $this->obtendato('xlprini',$z);
                break;
             case 'PF':
                $this->obtendato('xlprfin',$z);
                break;
             case 'ES':
                $this->obtendato('xlestado',$z);
                break;
//             case 'AA':   //20070215
//                $this->obtendato('xlestado',$z);   //20070215
//                break;                //20070215
          }
          next($this->datos);
          $z=$z+1;
    }
    echo "}\n";
    echo "</script>";
    echo "<script>";
    echo "  ContextMenu.intializeContextMenu(".$this->idmenu.");";
    echo "function valdatos() {\n";  // funcion para validar los datos en el cliente 
    echo "    var vd = new valcomunes();\n";
    reset($this->datos);
    while (current($this->datos) !== false)
    {
          switch (current($this->datos))
          {
             case 'FE':
                echo "    vd.ponfecha(document.forms[0].xlfechaini);\n";
                break;
             case 'RF':
                echo "    vd.ponfecha(document.forms[0].xlfechaini);\n";
                echo "    vd.ponfechaf(document.forms[0].xlfechafin);\n";
                break;
             case 'PI':
                echo "    vd.ponpi(document.forms[0].xlprini);\n";
                break;
             case 'PF':
                echo "    vd.ponpf(document.forms[0].xlprfin);\n";
                break;
             case 'ES':
                echo "    vd.pones(document.forms[0].xlestado);\n";
                break;
          }
          next($this->datos);
    }
    echo "    vd.valida();\n";
    echo "}\n";
    echo "</script>";


    reset($this->datos);
    while (current($this->datos) !== false)
    {
          switch (current($this->datos))
          {
             case 'BI':
				//echo "<script src='broseaing.js'></script>\n";                    
                break;
             case 'MTA':
				//echo "<script src='broseaing.js'></script>\n";                                 
                break;
             case 'AA':
				//echo "<script src='broseaing.js'></script>\n";                                 
                break;                

          }
          next($this->datos);
    }



  }

  /**
    * funcion que investiga que datos se deben de solicitar
    * FE=fecha  RF=fecha final; PI=Punto de recaudacion inicial PF=Punto de recaudacion fina ES=estatus del dia de cobro
    *   OCC=opciones del control de caja
    */
  function quedatos()
  {
	if (in_array("MTA",$this->datos)) 
	{
		$this->mantotab();
	}
	else
	{
		echo $this->inicio_tab($this->menu["table_width"],$this->menu["table_height"],$this->menu["table_align"]);
		$this->quedatos_t();
    	reset($this->datos);
    	while (current($this->datos) !== false)
    	{
        	  switch (current($this->datos))
          		{
	
             		case 'FE':
                		$this->pidefechaini();
                		break;
             		case 'RF':
                		$this->pidefechaini();
                		$this->pidefechafin();
                		break;
             		case 'PI':
                		$this->pideprini();
                		break;
             		case 'PF':
                		$this->pideprfin();
                		break;
             		case 'ES':
                		$this->pideestado();
                		break;
             		case 'BI':
                		$this->broseaing();
                		break;
             		case 'MTA':  // mantenimiento a rangos de puntos de recaudacion
                		break;
            		case 'OCC':
                		$this->pideocc();
                		break;
            		case 'AA':    //20070215  alta automatico
                		$this->pidedes();   //20070215
                		break;              //20070215
          			}
          		next($this->datos);
    	}
	}
  }
  /**
    *   funcion que arma los titulos de los datos
    */
  function quedatos_t()
  {
    reset($this->datos);
    while (current($this->datos) !== false)
    {
          switch (current($this->datos))
          {
	
             case 'FE':
                $this->pidefechaini_t();
                break;
             case 'RF':
                $this->pidefechaini_t();
                $this->pidefechafin_t();
                break;
             case 'PI':
                $this->pideprini_t();
                break;
             case 'PF':
                $this->pideprfin_t();
                break;
             case 'ES':
                $this->pideestado_t();		
                break;
             case 'AA':    //20070215  alta automatico
             	$this->pidedes_t();   //20070215
             	break;              //20070215                
          }
          next($this->datos);
    }
	echo "</tr>	";
  }
  function inicio_card($ini)
  { 
        echo    "<table data-tr-$ini>";
  }
  /**
     *  funcion que arma el inicio de la tabla de captura
     */
  function inicio_tabcaptura($table_width,$table_height,$table_align)
  { 
        echo    "<div class='btn-02 d-flex justify-content-between '".
				"	\" oncontextmenu='contextForTABLE(this,$this->idmenu);return false;' >".
			"		<label align='center' class=titulo >".$this->titulos."</label>".
                ($_SESSION["parametro1"]!="" ?	"<button class='btn-mostrar' type=button  tabindex='-1' id='imostrar' onclick=\"return toggleDiv('"
                                        .$this->titulos."',this);\" /></button>"
                                     :	"" ).
		"</div>".
        	"<quepasa id='".$this->titulos."'>".
        	"	<div class='container'".
				"\" id='tabcaptura' oncontextmenu='contextForTABLE(this,$this->idmenu);return false;'>\n";
  }

  function inicio_tabcaptura_t($table_width,$table_height,$table_align,$id)
  {
        echo    "       <div id='".$id."' class='container grupo ' oncontextmenu='contextForTABLE(this,$this->idmenu);return false;'".
        ">\n";
  }
  
  
  /**
    *   funcion que arma el inicio de la tabla de los botonoes
    */
  function inicio_tab_botones($table_width,$table_height,$table_align)
  {
        echo "<div class='container'><div class='row d-flex justify-content-around align-items-center' id='tabbotones_$this->idmenu' name=tabbotones >\n";
  }
  function fin_tab_botones() {
        echo "</div></div>";
  }

  //grecar 20070831
  /**
     *  funcion que arma ligas para descargar
     */
  function descargas ($datos,$table_width,$table_height,$table_align)
  {
          $num=count($datos);
          echo "<table valign=middle align=\"".$table_align."\" style=\"        width:".(($table_width>0) ? $table_width : "100" )."%; height:".(($table_height!="") ? $table_height : "100" )."%\">";
          for ($i=0; $i<$num; $i++)
          {
                  if ($datos[$i]=="IE")
                  {      echo "<tr align=center><td><a href=\"http://windows.microsoft.com/es-MX/windows/downloads\" target=otra>Descargar Internet Explorer</a></td></tr>      ";  }
                  if ($datos[$i]=="AC")
                  {     echo "<tr align=center><td><a href=\"http://get.adobe.com/es/reader\" target=otra>Descargar Adobe Reader</a></td></tr>  "; }
                  if ($datos[$i]=="CONECT")
                  {     echo "<tr align=center><td><a href=\"revisaConexion.js\">Revisa conexion</a></td></tr>  "; }
          }
          echo "</table>";
  }
  /**
    *  Funcion que arma el inicio de la tabla dinamica
    *  @param int $s_table  indica si pone scrroll en la tabla 0=si 1=no
    *  @param int $s_table_height  Altura del scroll
    */
  function inicio_tab($table_width,$table_height,$table_align)
  {
    		return "<div class='table-responsive'> <table id='tabdinamica_".$this->idmenu."' class='tabla table-striped'"
                         .(strlen($table_align)>0 ? " align=".$table_align : "" )
                         ."       style=\" ".   "  width:100" ."%;"
                         .((strlen($table_height)>0 && $table_height>0) ? " height:".$table_height : " heigth:100" )."%;\""
                         ."  >\n";			
  }
  
  /**
    *   arma el  inicio de la forma
    */
  function inicio_form()
  {
     if ($this->accion!="")
     { echo "  <form method=POST data-movtos='".$this->movto_mantto."' name='formpr' id='formpr_".$this->idmenu."' action=".$this->accion." target='".$this->destino."' >\n"; }
     else
     { echo "  <form method=POST data-movtos='".$this->movto_mantto."' name='formpr' id='formpr_".$this->idmenu."'  action='' >\n"; }     //20070306     
  }

  /**
    *   arma el fin de la forma
    */   
  function fin_form()
  {
     echo "</form>";
  }
  
  /**
    *   arma el inicio de la forma
    */   
  function inicio_html()
  {
    echo "<div id='soldatos_".$this->idmenu."' class='container mt-lg-5' onunload='this.Cierraforma()' onresize=\"this.Cambiasize('".$this->idmenu."');\" onClick='sumaclicks()' onLoad=\"try { inicia();inicioforma();\n pone_focus_forma('',this);\n pone_sort_scroll(); \n sumatotales();\n } catch (e) { };ContextMenu.intializeContextMenu();\"  >\n";      
    echo "<div class='row d-flex justify-content-around align-items-center' >";
    echo "<div class='".($this->menu["table_align"]!="" ? $this->menu["table_align"] : "col-lg-6")."' >";
  }
  /**
    *  Arma el boton
    */
  function botones()
  {
    if ($this->boton!="")
    {
       echo "<table>\n";
       echo "<tr><th><input type=submit value=\"".$this->boton."\" name=Cajas onclick='valdatos();return false;'></input></th><tr>\n";
       echo "<table>\n";
    }
  }

  /**
    *  Arma las opciones que se piden en la hoja del control de cajas tiende a desaparecer
    */
  function pideocc()
  {
    echo "<table align=center style=\"width:50%\">";
    echo "<th><input checked name=xltiporep type=radio style=\"background-color:#EEEEEE;\"value=estado> Trae Estados</input></th>";
    echo "<th><input name=xltiporep type=radio style=\"background-color:#EEEEEE;\" value=total> Trae Importes</input></th>";
    echo "<th><input checked name=xldetalle style=\"background-color:#EEEEEE;\" type=checkbox value=si> Incluye Detalle</input></th>";
    echo "<table>";
  }
  /**
    *  arma fin de la tabla
    */
  function fin_tabcaptura()
  {
    echo "</div>";
  }

  /**
    * Arma fin del  html
    */
  function fin_html()
  {
    echo "</div>";
    echo "</div>";
    echo "</div>";
    echo "      <script language=\"JavaScript\">";
    echo "  </script>       ";
  } 

  function __construct()
  {
  }


  /**
    *   obtiene el dato de una cookie
    *   @param string $xldato Nombre de la variable a obtener el dato
    *   @param int    $z      
    */  
  function obtendato($xldato,$z)
  {
         echo "obtenCookie('".$xldato."');\n";
         if ($z==0) { echo "document.forms[0].".$xldato.".focus();"; };
  }


   /**
     *   arma el option select del html de acuerdo al sql que se pasa
     *   @param string $sql sql sobre el cual se arma el option select
     */
   function arma_select($sql)
   {
    $sql_result = pg_exec($this->connection,$sql)
                   or die("Problemas al hacer sql. arma_select" );
     $num = pg_numrows($sql_result);
     for ($i=0; $i < $num ;$i++)
     {
         $Row = pg_fetch_array($sql_result, $i);
         $a = trim($Row[1]);
         $b = trim($Row[0]);
         if ($a==$xlestado)
         {
            echo "<option selected value=$a>$b</option>";
         }
         else
         {
             echo "<option value=$a>$b</option>";
         }
     }
     echo "  </select></th>  ";
   }
/**
  * Arma el select a  ejecutar para llenar el option select 
  *	@param string $wlcampos recibe los campos del select
  * @param int $ordenado Indica com va ordenado por el primer campo 0=no 1=si 
  *	esto lo hice asi porque este select en otros lados le incluye un filtro sobretodo el los select
  *	que depende de otro valor capturado en la pantalla
   */   
   function dame_sql_sel($wlcampos,$ordenado)
   {
	   $wlcampo=explode(",",$wlcampos);   // hay caso donde hay mas de un campo que se llena con el valor de un campo padre
	   								// por lo que tomas el primer valor , como ejemplo esta la vista de menu campos donde
	   								// el campo descripcion y el campo dependiente depende de lo telcleado en la fuente o tabla
	   return "select  ".$this->menuc[$wlcampo[0]]["fuente_campodes"].
	            ",".$this->menuc[$wlcampo[0]]["fuente_campodep"]. 
	            " from ".($this->menuc[$wlcampo[0]]["fuente_nspname"]!='' ? $this->menuc[$wlcampo[0]]["fuente_nspname"]."." : '' ).$this->menuc[$wlcampo[0]]["fuente"].	            
                    ($this->menuc[$wlcampo[0]]["fuente_evento"]==0 && $this->menuc[$wlcampo[0]]["fuente_where"]!="" ? " where ". $this->menuc[$wlcampo[0]]["fuente_where"] : "").
	            ($ordenado==0 ? "" : " order by 1 ");
   }
   
/**
  *  funcion que arma un option select del html
  *  @param string $sql sql a ejecutar el sql a ejecutar
  *  @param string $wlnombre El nombre del campo select
  *  @param string $fuente_campofil Campo o campos que primero se debio de haber selecciona a capturado para poder teclear este campo
  *  @param string $esfiltrode el campo del filtro hijo o campo donde se va a llenar el select de acuero al valor del filtro padre
  *  @param bool $obligatorio Indica si el campo es obligatorio
  *  @param string $tip Campo que va en el title tip de ayuda
  *  @param bool  $tipodedato para ver si es numerico
  *  @param bool  $busqueda indica si el campos se puede buscar la informacion
  *  @param int  $j recibe el numero de la columna del campo de la captura esto para relacionarlo con los cambios
  *  @param string  $filtroshijo campos con los que va a filtrar el select del campo hijo
  *  @param int $size la longitud de los renglones
  *  @param string $fuentewhere where del select principalmente para mostrar las opciones que aun no has sido seleccionadas
  *  @param bool  $readonly si readonly es true se desabilita las lista
  *  @param string $valorDefault  valor por default de la opcion
  *  @param int $fuente_evento en que evento se va a cargar el campo select
  *     			si fuente_evento=0   cuando la forma se carga
  *     			si fuente_evento=1   cuando el campo padre se cambia
  *     			si fuente_evento=2   cuando el campo recibe el focus
  *  @param string movtos   Movimiento a efectuar en la tabla
  *  @param string descripcion  Descripcion del campo que va el el td
  *  @param bool   altaautomatico  Indica si en el catalogo se puede dar de alta un miembro del catalogo que se esta referenciando
  *  @param int    idmenu   numero de menu se utiliza para la alta en automatico
  *  @param int    attnum   numero de banco se utiliza para la alta en automatico
  *  @param arrelgo menuc   arreglo que contiene todos los atributos del campo
  *  @param bool $fuente_busqueda   arreglo que contiene todos los atributos del campo  
    *				20070725  se incluyo la logica para validar campos particulares
    *  @param string val_particulares  que validacion se va hacer en forma particular en este campo
    *									esto se programa en el archivo val_particulares.js y se debe de desarrollar
    *									la funcion caso contrario envia mensaje de error  
    *  @param arreglo menumce      eventos del campos
  *  @return string select armado
		*/
   function arma_selectn($sql,$wlnombre,$fuente_campofil,$esfiltrode,$obligatorio,$tip,
##              $tipodedato,$busqueda,$j,$filtroshijo,$size,$fuentewhere,$readonly,$valorDefault,$fuente_evento) 
              $tipodedato,$busqueda,$j,$filtroshijo,$size,$fuentewhere,$readonly
              ,$valorDefault,$fuente_evento,$movtos,$descripcion,$altaautomatico,$idmenu,$attnum,$menuc
              ,$fuente_busqueda   //20070618   se agrego que en los campos select se tuviese la opcion de busqueda de opciones
              ,$val_particulares  //20070725
              ,$menumce
              ,$mecq
              )   //20070214
   {
		if (strpos($movtos,"i")!==false
		 || (strpos($movtos,"s")!==false )		 
		 || strpos($movtos,"u")!==false
		 || strpos($movtos,"e")!==false		 
		 || strpos($movtos,"I")!==false		 		 // 20080115  altas automaticas de catalogo
     	         || (strpos($movtos,"S")!==true )	//20080119	 // 20070214     	 
     	         || (strpos($movtos,"B")!==true )
		 ) 
		{
			$wlonchange=""; // 20071109 maneje variables ya que un evento puede ejecutar varias funciones
			$wlonfocus="";	                    
			$vas="";
			$wltdf=$menuc["formato_td"];
			$wltdd="Seleccionar opcion";
                        $wleshiden=($menuc["eshidden"]!='t' ? "" : " class='hidden' ");
                        $wlbusqueda=   (($busqueda=='t')    ? "<font color='black'>*</font>" : "");
                        $wlbusqueda_=   (($busqueda=='t')    ? "data-busqueda=1" : "");
                        $wlobligatorio=(($obligatorio=='t') ? "<font ".$wleshiden." color='red'  >*</font>" : "");
                        $wlobligatorio_=(($obligatorio=='t') ? "data-obligatorio=1" : "");
                        $cambiarencambios_ = (($menuc["cambiarencambios"]=='f') ? "data-cambiarencambios=0" : "" );
                        $tipodato_=((substr($tipodedato,0,3)==='int' || $tipodedato=='numeric') ? "data-numerico=1" : "" );
                        $wlidcampo=$mecq["idcampo"];
   		        $vas="<div class='".$menuc["clase"]."' ><div class='d-flex'><label class='form-label-custom ".$menuc["clase_label"]." ' "
                                .$wleshiden."id='wlt_".$wlnombre."__".$this->idmenu."' name='wlt_".$wlnombre."__".$this->idmenu
                                ."' abbr=\"".$descripcion."\" value=\"".$descripcion."\" "
   		 		.">".$descripcion.(($busqueda=='t') ? "* " : " ")
   		                ."</label>".$wlobligatorio."</div>"; 
   			$vas=$vas."<div class='d-flex'><select $wlobligatorio_ $wlbusqueda_ $tipodato_ $cambiarencambios_ class="
                                    ."'form-control form-control-custom".$menuc["clase_dato"]."' "
                                    .$wleshiden."placeholder=\"prueba\" "
	 		            .($menuc["autocomplete"]=='1' ? " ;restaura_autocomplete(this)" : "" )
   			            .(($menumce[1]["idevento"]=='1' && $menumce[1]["donde"]=='0' && $menumce[1]["descripcion"]!='') 
                                       ? "return eventosparticulares(this,\"".$menumce[1]["descripcion"]."\");" : "")."' ";   			            
   			$vas=$vas.($menuc["autocomplete"]=='1' ? " onkeyup='autollenado(this,event,\"".$this->dame_sql_sel($wlnombre,0)
                                    ."\",\"".$menuc["fuente_campodes"]."\");'" : "" );
			$wlonfocus=$this->foco($readonly);   			          
			$wlonblur=$this->blur($readonly);   			          
   			($tip!="") ?  $vas=$vas." title='".$tip."' " : $vas=$vas;   			   			 
   			($readonly=='t') ?  $vas.="  disabled=true readonly " :  $vas=$vas;
   			($fuente_campofil!="") ?  $vas=$vas." onClick=\"si_Select('".$sql."','".$fuente_campofil."',".$this->idmenu.");\" " : $vas=$vas;
   			($esfiltrode!="" ) ?  $wlonchange=$wlonchange." pon_Select(\"".   //20071109   			
  	        		  $this->dame_sql_sel($esfiltrode,0)."\",\"".$filtroshijo."\",\"".$esfiltrode."\",\"".$fuentewhere
                                  ."\",".$fuente_evento.",0".",".$this->idmenu.") " : $vas=$vas;
   			($fuente_evento==2 || $fuente_evento==3 ) ?  $wlonfocus=$wlonfocus."; pon_Select(\"".
   	        		  $this->dame_sql_sel($wlnombre,0)."\",\"".$fuente_campofil."\",\"".$wlnombre."\",\"".$fuentewhere
                                  ."\",".$fuente_evento.",0".",".$this->idmenu.") " : $vas=$vas;
			$wlonchange=$this->agregaevento('2',$wlonchange,$menumce); 		//20071109
			$wlonfocus=$this->agregaevento('3',$wlonfocus,$menumce); 		//20071109
			$wlonblur=$this->agregaevento('1',$wlonblur,$menumce); 		//20071109
                        $wlondck=($this->menu["esadmon"]!="0" && $this->menu["esadmon"]!="") ? 'abre_subvista("src/php/man_menus.php","idmenu='.MENUS_CAMPOS.'&filtro=idmenu='.$this->idmenu.' and idcampo='.$wlidcampo.'","","",'.MENUS_CAMPOS.',800,600,"Idmenu")' : "";

			$vas=$vas.($wlonchange!="" ? " onChange='".$wlonchange.";'" : "".$esfiltrode );  //20071109
			$vas=$vas.($wlonfocus!="" ? " onFocus='".$wlonfocus.";'" : "");  //20071109
                        $vas=$vas.($wlondck !="" ? " ondblclick='".$wlondck.";'" : "" );
                        $vas=$vas.($wlonblur!="" ? " onblur='".$wlonblur.";'" : "");
   	        		     			$vas=$vas." ".$this->armaid_cc($j)."name=wl_".$wlnombre."__".$this->idmenu." >\n";	   
			if ($fuente_evento==0)  // si tiene el campo padre este se debe de llenar cuando se seleeciona el campo padre
			{   	       
                            $sql= $this->dame_sql_sel($wlnombre,1);
    			    $sql_result = pg_exec($this->connection,$sql)
        	    		       or die("Problemas al hacer sql. arma_selectn ".$sql );
     			    $num = pg_numrows($sql_result);
				if ($num!=1 || ($obligatorio!=='t'))
	   			 $DefaultSelect="<option selected value >".(($wltdf==3) ? $wltdd : utf8_encode("Selecciona una Opción") )."</option>\n"; 
     			for ($i=0; $i < $num ;$i++)
     			{
         			$Row = pg_fetch_array($sql_result, $i);
         			$a = trim($Row[1]);
         			$b = trim($Row[0]);
         			if (($a==$valorDefault & $valorDefault!="") )// 20070622
         			{ $DefaultSelect="<option selected value=".$valorDefault." >".$b."</option>\n";        			}// 20070622
         			if ($num==1 & $obligatorio=='t' & $DefaultSelect=="")// 20070622         			
         			{ $DefaultSelect="<option selected value=".$a." >".$b."</option>\n";        			}// 20070622 
           			$opciones=$opciones."<option value=$a>$b</option>\n";
     			}
 			}
 			
			$vas=$vas.$DefaultSelect.$opciones."  </select>";
	 		$vas = ($altaautomatico=='t' ? $vas.
             	               " <input tabindex='-1' type=image class='img'  src='dist/img/agregar.svg' title='Alta de un nuevo registro de: "
                               .$descripcion."' value='Alta' id='aa_".$wlnombre."' name=matriz ". 
            	  "onclick='altaautomatico(\"".$idmenu."\",\"".$attnum."\",".   //20070214
            	  trim(substr($this->armaid_cc($j),4))."".
            	  ",\"".$menuc["fuente"]."\"".
            	  ",\"".$menuc["fuente_campodes"]."\"".            	  
            	  ",\"".$menuc["fuente_nspname"]."\"".       
            	  ",\"".$menuc["altaautomatico_idmenu"]."\"".      
            	  ",\"".$menuc["fuente_campodep"]."\"".   
            	  ",\"".$menuc["fuente_campofil"]."\"".   
            	  ",this);return false' />\n" : $vas ); 
	 		$vas = ($fuente_busqueda=='t' ? $vas. //20070618
             	  "<input class=img type=image src='img/action_search_20.gif' title='Buscar opciones' value='Buscar' name=matriz value='Buscar' ". //20070618
   			          " onClick=\"pidebusqueda('". //20070618
   	        		  $this->dame_sql_sel($wlnombre,0)."','".$fuente_campofil."','".$wlnombre."','".$fuentewhere."','".$fuente_evento."',0".   //20080117
            	  	  ",'".$menuc["fuente_busqueda_idmenu"]."'"."); ". //20080117
                 	  "return false;\"></input>\n" : $vas ); 
	 	$vas = ((substr($tipodedato,0,3)==='int' || $tipodedato=='numeric') ? $vas." <input type=hidden name=nu_".$wlnombre." value=1></input>\n" : $vas ); 
	 	$vas = (($tipodedato=='date' || $tipodedato=='timestampz') ? $vas." <input type=hidden name=_da_".$wlnombre." value=1></input>\n" : $vas ); 	 
	        ($val_particulares!='') ? $vas=$vas." <input type=hidden name=_vp_".$wlnombre." value='".$val_particulares."'></input>\n" : $wli=$wli ; 
	 	$vas = ($busqueda=='t' ? $vas." <input type=hidden name=bu_".$wlnombre." value=1></input>\n" : $vas ); 	 
     		  $vas=$vas."</div></div>";  //20070214   		     		
 		}
	 	return $vas;
   }   
   
  /**
    * Funcion que arma los titulos de la tabla dinamica
    * @param recordset $sql_result recibe el result del sql
    * @param metada    $md  Metadata del menu
    */   
  function titulos_tab($sql_result,$md)  
  {
	 $tt = "<script type=\"text/javascript\">\n";
	 $tt .= "function pone_sort_scroll() {\n";
	 $tt .= " initable( 'tabdinamica_".$this->idmenu."', [ ";
     $i = pg_numfields($sql_result);
        for ($j = 0; $j < $i; $j++) {
	        $tt .= (($j==0) ? "null" : ",null");
        }
	 $tt .= " ], 0, null, 28 );";
	 $tt .= "}";
	 $tt .= "</script>\n";
	 
	 $tt .= "<thead class='scrolling_table_body'>\n";
     $tt .= "<tr>";
     if (strpos($md->camposm["movtos"],"d")!==false) 
     {
             $tt .= "<th id='baja_$this->idmenu' name=noimprime >Baja</th>\n";             
     }
     if (strpos($md->camposm["movtos"],"cc")!==false) 
     {
             $tt .= "<th id='copia_$this->idmenu' name=noimprime >Copia</th>\n";             
     }

//20070611   lo modifique para que cuando sea solo select "s" se pudiese tambien seleccionar el registro
//20070611   ya que habia ocaciones que no se podiar dar update al registro y no se podia seleccionar
//20070611     if (strpos($md->camposm["movtos"],"u")!==false) 
     if (strpos($md->camposm["movtos"],"u")!==false || strpos($md->camposm["movtos"],"s")!==false || strpos($md->camposm["movtos"],"B")!==false)      
     {
             $tt .= "<th id='cambiotxt_$this->idmenu' name=noimprime >Sel</th>\n";                          
     }     

	$tt .= $this->titulos_subvistas($md->camposmsv,0);
 
     // campos      	     
     $i = pg_numfields($sql_result);
        for ($j = 0; $j < $i; $j++)
        {
##  20070503        Restaure la correccion del 20070118, ya que cuando hay una consulta y existe un campos de trabajo
##  20070503        este lo borra, el 20070213 se comentarizo no se porque no me acuerdo hay que dar seguimiento a este cambio	        
##  20070118        lo modifique para que los campos de trabajo osea los campos que no forman parte de la tabla
##					no los muestre en el renglon
			if	($md->camposmc[pg_fieldname($sql_result, $j)]["attnum"]!="0") ## 20070213	
			{ ## 20070213	
//20070515          		echo "<td>".$this->menuc[pg_fieldname($sql_result, $j)]["descripcion"]."</td>\n";## 20070213	
          		$tt .= "<th".($md->camposmc[pg_fieldname($sql_result, $j)]["totales"]=='t' ? " id=totales " : "").
          		">".$md->camposmc[pg_fieldname($sql_result, $j)]["descripcion"]."</th>";## 20070213	          		
      		} ## 20070213	
        };
     $tt .= "</tr>";
	$tt .= "</thead>\n";
	return $tt;
  }

  /**
    * arma los titulos de la subvista
    * @param metada $md Arreglo de la subvistas
    * @param integer $cs Indica si hay colspan en los botones de acciones  0=no 1=si  (sirve para que las acciones esten centradas baja,cambio,xxxx,
    *       este dato hay que ponerlo en las tablas las tablas 
    * @return string  string armado con los titulos de las subvistas
    */
  function titulos_subvistas($md,$cs)
  {  
	 $regresa="";
	 $wlcs=0;
     $i=0;
     while ($i < count($md))    // checa que subvistas hay o botones
	 {
		 if($md[$i]["esboton"]==0 || $md[$i]["esboton"]==1)
		 {		 
		 	if($md[$i]["posicion"]=="0")   // pone los titulos de vistas o botones que que van a nivel renglon
		 	{
				if ($cs ==0)
				{
//20070524		 		$regresa.="<td>".$md[$i]["texto"]."</td>";
		 			$regresa.="<th name=noimprime >".$md[$i]["texto"]."</th>";		 		
	 			}
	 			else
	 			{   $wlcs+=1; }
	 	 	}
	 	}
	 	$i=$i+1;
     }     
     
     //  20070629   se incluyo menus como opciones     
     $i=0;
     while ($i < count($md))    // checa que subvistas hay o botones
	 {
		 if($md[$i]["esboton"]==2 )
		 {
			 if($md[$i]["posicion"]=="0")   // pone los titulos de vistas o botones que que van a nivel renglon
			 {
				if ($cs ==0)
				{
		 			$regresasel="<th>Opciones</th>";
	 			}
	 			else
	 			{   $wlcs+=1; }
	 	 	}
 	 	 }
		 $i=$i+1;
     }     
          
     if ($cs==1)
     {
//20070524	     $regresa="<td colspan=".$wlcs." >Acciones</td>";
	     $regresa="<th colspan=".$wlcs." >Acciones</th>";	     
     }
     return $regresa.$regresasel; //  20070629
  }     
  
  
  /**
    *  funcion que arma los campos input a capturar
    *  @param string $nombre nombre del campo
    *  @param int $size tamañ desplegar en pantalla
    *  @param int $male maxima longitud recibida en la pantalla
    *  @param bool $obligatorio indica si es obligatorio el dato o no, este lo pone com hidden
    *  @param string $tip ayuda del campo
    *  @param string $tipodedato tipo de dato para ver si es numerico
    *  @param bool $busqueda   campos que indica si por este campo se puede hacer una busqueda
    *  @param int $tcase      indica si el dato que se capturar lleva case o no 1=upper 2=lower
    *  @param int $j numero de la columna
    *  @param bool $readonly  indica si el campo es de readonly
    *  @param string $valordefault  valor del campo a mostrar por default
    *  @param int $espassword  diferente de cero indica que el campo es un password
    *  @param string $movtos  Que movimiento se debe hacer a la tabla o vista
    *  @param string descripcion Descripcion del td
    *				20070622  se incluyo la logica para validar campos particulares
    *  @param string val_particulares  que validacion se va hacer en forma particular en este campo
    *									esto se programa en el archivo val_particulares.js y se debe de desarrollar
    *									la funcion caso contrario envia mensaje de error
    *  @param arreglo menumce      eventos del campos    
    *  @parma arreglo menuc todos los datos el campo        
    *  @return string Input armado
    */
##  function arma_input ($nombre,$size,$male,$obligatorio,$descripcion,$tipodedato,$busqueda,$tcase,$j,$readonly,$valordefault,$espassword)  //20070214
  function arma_input ($nombre,$size,$male,$obligatorio,$tip,$tipodedato,$busqueda,$tcase,$j,$readonly
  						,$valordefault,$espassword,$movtos,$descripcion,$val_particulares
              ,$menumce  // 20071009  
              ,$mecq  // 20080123
  )   // 20070214
  { 
	  $wltdf=$mecq["formato_td"];
	  $wltdd="".$mecq["descripcion"];
     if (strpos($movtos,"i")!==false 
     || ((strpos($movtos,"s")!==false ))      // 20060117
     || strpos($movtos,"u")!==false
     || strpos($movtos,"e")!==false     
     || strpos($movtos,"I")!==false          // 20080115  altas automaticas de catalogo
     || (strpos($movtos,"S")!==false )  //20080119   // 20070214     
     || (strpos($movtos,"B")!==false )  //20080119   // 20070214          
     ) 
     {
	    $wlonchange=""; // 20071009 maneje variables ya que un evento puede ejecutar varias funciones
	                    // ejemplo el touupercase combinarse con una funcion particular
	    $wlfocus="";
	    $wlonblur="";
	    $wlonkp="";	    
	    $wlonck="";	    	    
    $descripcion=($espassword=="3" ? $tip : $descripcion);
    $wlvalordefault=" value=\"$valordefault\" ";
    $wlvalordefault=($valordefault=='hoy' ? " value=\"".date("Y")."-".date('m')."-".date("d")."\" " : ($valordefault=='hora' ? " value=\"".date("H").":".date('i').":".date('s')."\" " : ($valordefault=='hoyyhora' ? " value=\"".date("Y")."-".date('m')."-".date("d")." ".date("H").":".date('i').":".date('s')."\" " :$wlvalordefault)));
    $wleshiden=($mecq["eshidden"]!='t' ? "" : " d-none ");
    $wlbusqueda=   (($busqueda=='t')    ? "<font color='black'>*</font>" : "");
    $wlobligatorio=(($obligatorio=='t') ? "<font ".$wleshiden." color='red'>*</font>" : "");
    $wlobligatorio_=(($obligatorio=='t') ? "data-obligatorio=1" : "");
    $cambiarencambios_ = (($mecq["cambiarencambios"]=='f') ? "data-cambiarencambios=0" : "" );
    $tipodato_=((substr($tipodedato,0,3)==='int' || $tipodedato=='numeric') ? "data-numerico=1" : "" );
    $wlbusqueda_=   (($busqueda=='t')    ? "data-busqueda=1" : "");
    $wlidcampo=$mecq["idcampo"];
    $wltipodedato=((substr($tipodedato,0,3)=='int' || $tipodedato=='numeric') ? " type='tel' " : "");
            $wli="<div class='".$mecq["clase"]."'><div class='d-flex'><label class='form-label-custom $wleshiden ".$mecq["clase_label"]."'  id='wlt_".$nombre."__".$this->idmenu."' name=wlt_".$nombre."__".$this->idmenu." title=\"".$descripcion."\" abbr=\"".$descripcion."\""
			.">".$descripcion
			."</label>".$wlobligatorio.$wlbusqueda."</div>"; 
	    $wli=$wli.
	    	(($tipodedato != "text") 
	    	? "<div class='d-flex'><input $wlobligatorio_ $cambiarencambios_ $tipodato_ $wlbusqueda_ autocapitalize='none' class=".
                            "'form-control form-control-custom $wleshiden".$mecq["clase_dato"]."'  onKeydown='return quitaenter(this,event)' " 
	    	: "<div class='d-flex'><textarea $wlobligatorio_ $cambiarencambios_ $tipodato_ $wlbusqueda_ class=".
                            "'form-control form-control-custom $wleshiden".$mecq["clase_dato"]."' ".((preg_match("/1|2|3/",$wltdf) && strlen($mecq["colspantxt"])>0) 
	    						? "cols=".$mecq["colspantxt"] : "" )
	    				).
	    				(($tipodedato == "text") 
	    					? ($mecq["rowspantxt"]=="" 
	    						? "" 
	    						: " rows=".$mecq["rowspantxt"]." " ) 
	    						: " ").
	                    (($male!="" && $male!="0") ? " maxlength=".$male : ($espassword=="3" ? " maxlength=14 " : "") ).
                                (($readonly=='t') ? (($tipodedato == 'bool') ? " disabled=true " : " readonly=true ")." readonly " : " ").
                            $wlvalordefault.
	    	            ($tip!="" ? " title='".$tip."'" : " ").
	    	            ($tipodedato == "bool" ? " type=checkbox onclick='ponvalor_cb(this)' value=f " 
	    	            : ( $espassword=="1" ? " type=password onChange='seguridad(this)'"   //20070305
	    	            : "")).	//20070305 //20080123
	    	            ##(($tipodedato == "timestamptz" || $tipodedato=='date') ? " type=date format='aaaaa-mm-dd' onChange='validafecha(this)' " : " " ).
	    	            (($tipodedato == "timestamptz" || $tipodedato=='date') ? " onChange='validafecha(this)' " : " " ).
	    	            $this->armaid_cc($j)." name=wl_".$nombre."__".$this->idmenu.
						( $size!="" ? " size=".$size : ($espassword=="3" ? " size=14 " : ""));
						($tcase==1) ? $wli=$wli." onkeyup='mayusculas(this,event);'" : "";  ##20071029
						($tcase==2) ? $wli=$wli." onkeyup='minusculas(this,event);'" : "";  ##20071029
                                                ($tcase==3) ? $wli=$wli." onkeyup='mayusletras(this,event);'" : "";  ##20071029
						(substr($tipodedato,0,3)=='int') ? $wli=$wli." onKeyPress='return(SoloNumerico(event))'" : ($tipodedato=='numeric') ? $wli=$wli." onKeyPress='return(SoloMoneda(event,this))'" : $wli=$wli;
                                                ($espassword=="4") ? $wli=$wli." type='email' " : " ";
						$wlfocus=$this->foco($readonly);
                                                $wlfocus.=($espassword=="3" ?  ";DrawCaptcha(this)" : "");
						$wlonblur=$this->blur($readonly);
                                                $wlonChange.=($espassword=="3" ?  ";ValidCaptcha(this)" : "");
                                                $wlonChange.=($espassword=="4" ?  ";validaEmail(this)" : "");
						$wlonChange=$this->agregaevento('2',$wlonChange,$menumce);
						$wlfocus=$this->agregaevento('3',$wlfocus,$menumce);
						$wlonblur=$this->agregaevento('1',$wlonblur,$menumce);						
						$wlonkp=$this->agregaevento('5',$wlonkp,$menumce);
						$wlonck=$this->agregaevento('4',$wlonck,$menumce);
                                                $wlondck=($this->menu["esadmon"]!="0" && $this->menu["esadmon"]!="") ? 'abre_subvista("src/php/man_menus.php","idmenu='.MENUS_CAMPOS.'&filtro=idmenu='.$this->idmenu.' and idcampo='.$wlidcampo.'","","",'.MENUS_CAMPOS.',800,600,"Idmenu")' : "";
						$wli=$wli.($wlfocus!="" ? " onFocus='".$wlfocus.";'" : "" );
						$wli=$wli.($wlonChange!="" ? " onChange='".$wlonChange.";'" : "" );
						$wli=$wli.($wlonblur!="" ? " onBlur='".$wlonblur.";'" : "" );						
						$wli=$wli.($wlonkp !="" ? " onKeyPress='".$wlonkp.";'" : "" );
						$wli=$wli.($wlonck !="" ? " onClick='".$wlonck.";'" : "" );	
                                                $wli=$wli.($wlondck !="" ? " ondblclick='".$wlondck.";'" : "" );

	    	            $wli=$wli.(($wltdf==3) ? " placeholder=\"".$wltdd."\"" : "").
	    	            (($tipodedato != "text") ? " ></input>" : " >".$valordefault."</textarea>").
	    	            (($tipodedato == "timestamptz" || $tipodedato == "date") & $readonly!='t' ? " <input $wlobligatorio_ $cambiarencambios_ $tipodato_ $wlbusqueda_ tabindex='-1' class='img' type=image id='fe_".$nombre."' name=fe_".$nombre." src='img/icon_datepicker_pink.gif' onclick='muestrafecha(this);return false' title='Selecciona la fecha del calendario'></input>" : " " ). 
                            (($espassword=="3") ? " <input $wlobligatorio_ $cambiarencambios_ $tipodato_ $wlbusqueda_ tabindex='-1' size=20 class='captcha' readonly='on' type=text id='wl_".$nombre."_img"."__".$this->idmenu."' name=wl_".$nombre."_img__".$this->idmenu." title='Imagen de la captcha' ></input>&nbsp<input tabindex='-1' class='img' type=image id='wl_".$nombre."_bot__".$this->idmenu."' name=wl_".$nombre."_bot__".$this->idmenu." src='img/refresh.png' onclick='ReDrawCaptcha(this);return false' title='Refresca la imagen del captcha'></input>" : " " );
			if ($mecq["upload_file"]=='t')
			{ 
                            $wli.=" <input class='img' type=image abbr='' id='upl_".$nombre."__".$this->idmenu."' name=upl_".
                                  $nombre."__".$this->idmenu.
                                  " src='/dist/img/carpeta.svg' onclick='subearchivo(this,".$this->idmenu.");return false' title='Adjunta archivo de explorador' />"; 
                            $wli.=" <input class='img' type=hidden abbr='' id='uplh_".$nombre."__".$this->idmenu."' name=uplh_".$nombre."__".$this->idmenu."  />"; 
			}
			(substr($tipodedato,0,3)=='int' || $tipodedato=='numeric') ? $wli=$wli." <input type=hidden id='nu_"
                                         .$nombre."' name=nu_".$nombre." value=1></input>\n" : $wli=$wli ; 
	 		($tipodedato=='date' || $tipodedato=='timestampz') ? $wli=$wli." <input type=hidden id='_da_".$nombre."' name=_da_".$nombre
                                    ." value=1></input>\n" : $wli=$wli ; 	      	
			($busqueda=='t') ? $wli=$wli." <input type=hidden id='bu_".$nombre."' name=bu_".$nombre." value=1></input>\n" : $wli=$wli ; 
			($mecq["imprime"]!='t') ? $wli=$wli." <input type=hidden id='_np_".$nombre."' name=_np_".$nombre." ></input>\n" : $wli=$wli ;
			($val_particulares!='') ? $wli=$wli." <input type=hidden id='_vp_".$nombre."' name=_vp_".$nombre." value='"
                                    .$val_particulares."'></input>\n" : $wli=$wli ; 			
	    	        $wli.="</div></div>\n";
	}
    return $wli;
  }
  /**
   ** 20071009   funcion que agrega codigo a un evento
    *  @param string $queevento Numero de evento a agregar 1=blur  2=onchange
    *  @param string $codigo    codigo al que hay que agregar codigo
    *  @param arreglo que contiene el campo del evento
    *  @return string  codigo ya agregado
   */

  function agregaevento($queevento,$codigo,$menumce)
  {
		if ($menumce[$queevento]["idevento"]==$queevento && $menumce[$queevento]["donde"]=='0' && $menumce[$queevento]["descripcion"]!='')
		{
		    if ($codigo!="") 
		    { return $codigo=$codigo.";eventosparticulares(this,\"".$menumce[$queevento]["descripcion"]."\")"; ##20080209
		    }
		    else
		    { return $codigo=$codigo."return eventosparticulares(this,\"".$menumce[$queevento]["descripcion"]."\")"; ##20080209
		    }		    
	    }
	    else
	    { return $codigo; }
 }

  /** 
    * arma el id de la columna de captura para relacionarla con los cambios
    * @param int $j recibe el numero de la columna
    * @return string id armado
    */
  function armaid_cc($j)
  { return " id=\"cc".$j."_".$this->idmenu."\" "; }

  /**
    * Arma el focus, para cambiara el color cuando tenga el focus y lo reestablesca cuando pierda el foco
    * @param bool $readonly indica si el campo es de readyonly
    * @return string regresa el foco armado
    */
  function foco($readonly)
  { return " \"\""; }
  function blur($readonly)  
  { return $readonly=='t' ? " class='form-control form-control-custom' " : " \"\"" ; }
    	  
  /**
    * desplega los campos para capturar en una tabla
    * @param recordset $sql_result recordset de la tabla donde va a capturar o cambiar algun dato
    * @param metadata $meda metadata de el menu o vista
    */
  function campo_cap($sql_result,$meda)
  {

     $md = new menudata();	  
	$this->inicio_tabcaptura($this->menu["table_width"],$this->menu["table_height"],$this->menu["table_align"]);	  	     
     	$i = pg_numfields($sql_result);
	$wllinea="";
        for ($j = 0; $j < $i; $j++)
        {
	        $z=0;
	        $wltdf=$this->menuc[pg_fieldname($sql_result, $j)]["formato_td"];
	        $wltdd=$this->menuc[pg_fieldname($sql_result, $j)]["descripcion"];
        	  $nomcampo=pg_fieldname($sql_result, $j);		
        	  if ($j==0) {
                      $htmltableanterior=$this->menuc[$nomcampo]["htmltable"];
                      $filaanterior=$this->menuc[$nomcampo]["fila"];
	              $this->inicio_tabcaptura_t($this->menu["table_width"],$this->menu["table_height"],$this->menu["table_align"],$this->menumht[$this->menuc[$nomcampo]["htmltable"]]["descripcion"]);	  	     
                  }
				if ($this->menuc[$nomcampo]["htmltable"]!==$htmltableanterior)
				{
                                        error_log($this->dame_tiempo()." src/php/soldatos.php detecto cambio htmltable=".$htmltableanterior
                                          ." de campos=".$this->menuc[$nomcampo]["htmltable"]." j=".$j."\n",3,"/var/tmp/errores.log");
                                        $wllinea="<div id=".$filaanterior." class='d-flex justify-content-between flex-wrap'>".$wllinea."</div>";
                                        echo $wllinea;
                                        $filaanterior=$this->menuc[$nomcampo]["fila"];
                                        $wllinea="";
	    			        $this->fin_tabcaptura();	  	    				
                                        echo "<div class='btn-01 d-flex justify-content-between flex-row-reverse' ><tr><td><button class='btn-mostrar'  tabindex='-1' align='left' type=button id='imostrar' ".
                                        "onclick=\"return toggleDiv('".$this->menumht[$this->menuc[$nomcampo]["htmltable"]]["descripcion"]."',this);\"></button></td>";
                                        echo "<td><label>".$this->menumht[$this->menuc[$nomcampo]["htmltable"]]["descripcion"]."</label></td></tr></div>";
	    		                $this->inicio_tabcaptura_t($this->menu["table_width"],$this->menu["table_height"],$this->menu["table_align"],
                                          $this->menumht[$this->menuc[$nomcampo]["htmltable"]]["descripcion"]);	
	    			        $htmltableanterior=$this->menuc[$nomcampo]["htmltable"];
				} else {
                                        error_log($this->dame_tiempo()." src/php/soldatos.php no detecto cambio j=".$j."\n",3,"/var/tmp/errores.log");
                                }
                  if ($this->menuc[$nomcampo]["fila"]!=$filaanterior) {
                      $wllinea="<div id=".$filaanterior." class='d-flex justify-content-between flex-wrap mb-2'>".$wllinea."</div>";
                      echo $wllinea;
                      $filaanterior=$this->menuc[$nomcampo]["fila"];
                      $wllinea="";
                  }

	      	  $esFiltroDe=$md->dame_ultimo($this->menuc[$nomcampo]["esFiltroDe"]);
	          if (strpos($this->movto_mantto,"i")!==false 
	             || strpos($this->movto_mantto,"s")!==false
		     || strpos($this->movto_mantto,"u")!==false
		   || strpos($this->movto_mantto,"e")!==false
		   || strpos($this->movto_mantto,"I")!==false   // 20080115 altas automaticas de catalogo
     		   || (strpos($this->movto_mantto,"S")!==false)  // 20070214			       
     		   || (strpos($this->movto_mantto,"B")!==false)  
			     )  
    		  {	  	
	          		if ($this->menuc[$nomcampo]["fuente"]!="") // si no es espacio es un campos select
	          		{   
			         	$wllinea=$wllinea.     // 20070214
		          		           $this->arma_selectn(
		          		           						$this->dame_sql_sel($nomcampo,1)
		          		                               ,$nomcampo
		          		                               ,$this->menuc[$nomcampo]["fuente_campofil"]
		          		                               ,$this->menuc[$nomcampo]["esFiltroDe"]
		          		                               ,$this->menuc[$nomcampo]["obligatorio"]
		          		                               ,$this->menuc[$nomcampo]["tipayuda"]
		          		                               ,$this->menuc[$nomcampo]["typname"]
		          		                               ,$this->menuc[$nomcampo]["busqueda"]
		          		                               ,$j
		          		                               ,
		          		                               (strpos($this->menuc[$nomcampo]["esFiltroDe"],",")!==false ? $nomcampo :
		          		                               		$this->menuc[$this->menuc[$nomcampo]["esFiltroDe"]]["fuente_campofil"])
		          		                               ,$this->menuc[$nomcampo]["size"]
	                                       			   ,$this->menuc[$nomcampo]["fuente_where"]	                                       			   
	                								   ,$this->menuc[$nomcampo]["readonly"]	                					
	                								   ,$this->menuc[$nomcampo]["valordefault"]
													   ,$this->menuc[$nomcampo]["fuente_evento"]	                					
													   ,$this->movto_mantto   //  20070214					
													   ,$this->menuc[$nomcampo]["descripcion"]  // 20070214
											           ,$this->menuc[$nomcampo]["altaautomatico"]  // 20070214																									   
											           ,$this->menuc[$nomcampo]["idmenu"]  // 20070214												
											           ,$this->menuc[$nomcampo]["attnum"]  // 20070214											    											    											           
											           ,$this->menuc[$nomcampo]  // 20070214
											    	   ,$this->menuc[$nomcampo]["fuente_busqueda"]  // 20070618											           
											    	   ,$this->menuc[$nomcampo]["val_particulares"]  // 20070725	
											    	   ,$this->menumce[$nomcampo]  // 20070804
											    	   ,$this->menuc[$nomcampo]  // 20070804
		          		                               ); 
		          	}
	          		else
	          		{
		                   if ($this->menu["tiene_pk_serial"]==$nomcampo)  // si se cumple el campo es un serial
		          	   {
                                       $nombre=pg_fieldname($sql_result, $j);
                                       $busqueda=$this->menuc[$nomcampo]["busqueda"];
                                       $wlbusqueda=($busqueda=='t' ? " <input type=hidden id='bu_".$nombre."' name=bu_".$nombre." value=1></input>\n" : "") ;
                                       $wleshiden=($this->menuc[$nomcampo]["eshidden"]!='t' ? "" : " d-none ");
			               $wllinea=$wllinea."<div class='$wleshiden' ><label class='form-label-custom ' >".$wltdd."</label>".
			          			 " <br><input  ".$wleshiden.
            		  	                (($this->menuc[$nomcampo]["size"]!="" && $this->menuc[$nomcampo]["size"]!="0") ? " size="
                                                             .$this->menuc[$nomcampo]["size"] : "" ).
            		  	       $this->armaid_cc($j)." type=text class='form-control form-control-custom' readonly=true name=wl_"
                                                  .pg_fieldname($sql_result, $j)."__".$this->idmenu." ".
            		  	                   "\"></input>".$wlbusqueda."</div>\n";
            		  	    }
		          	    else
		          	    {
	            				$wllinea=$wllinea.$this->arma_input(
	            				pg_fieldname($sql_result, $j)
	            				,$this->menuc[pg_fieldname($sql_result, $j)]["size"]
	            				,$this->menuc[pg_fieldname($sql_result, $j)]["male"]
	                 			,$this->menuc[pg_fieldname($sql_result, $j)]["obligatorio"]
	                 			,$this->menuc[pg_fieldname($sql_result, $j)]["tipayuda"]
	                 			,$this->menuc[pg_fieldname($sql_result, $j)]["typname"]	                 			
	                 			,$this->menuc[pg_fieldname($sql_result, $j)]["busqueda"]
	                 			,$this->menuc[pg_fieldname($sql_result, $j)]["tcase"]
	                 			,$j
	                			,$this->menuc[pg_fieldname($sql_result, $j)]["readonly"]
	                			,$this->menuc[pg_fieldname($sql_result, $j)]["valordefault"]	                				                 			
	                			,$this->menuc[pg_fieldname($sql_result, $j)]["espassword"]
							    ,$this->movto_mantto   //  20070214
							    ,$this->menuc[pg_fieldname($sql_result, $j)]["descripcion"]  // 20070214
								,$this->menuc[pg_fieldname($sql_result, $j)]["val_particulares"] // 20070622							    
								,$this->menumce[$nomcampo]  // 20071009					
								,$this->menuc[$nomcampo]  // 20080123
	             			);
						}	             			
        			}	          		
			  }

			

        };
            if ($wllinea!="") {
                                   $wllinea="<div id=".$filaanterior." class='d-flex justify-content-between flex-wrap'>".$wllinea."</div>";
                                   echo $wllinea;
            }
	    $this->fin_tabcaptura();	  	    
	    $this->fin_tabcaptura();	  	    
	    echo "</quepasa>";      	
	    $this->inicio_tab_botones($this->menu["table_width"],$this->menu["table_height"],$this->menu["table_align"]);
     	echo "<tr class='d-flex justify-content-between flex-wrap' >";	    
        if ( strpos($this->movto_mantto,"i")!==false ||  strpos($this->movto_mantto,"I")!==false  
        ) 
        {
     		echo "<td  class='botones' > ".  //20070920
            ($this->menum['i']['idmovto']=='i' && $this->menum['i']["descripcion"]!="" ? "<input type=button class='btn-02' id='iAlta' value='".$this->menum['i']["descripcion"]."' title='Alta'  " : "<input type=button class='btn-02' id='iAlta' src='img/add.gif' title='Alta' value='Alta' name=matriz ").  //20070920
        	"onclick='mantto_tabla(\"".$this->idmenu.
        	                          "\",\"".
        	                          (strpos($this->movto_mantto,"i")!==false ? "i" : "")
        	                          .(strpos($this->movto_mantto,"I")!==false ? "I" : "")
        	                          ."\",\"\",\"\",\"".
        	                          // evento antes de dar de alta
        	                          (($this->menue[3][2]['donde']==1) ? $this->menue[3][2]['descripcion'] : "").
        	                          "\",\"".
        	                          // evento despues de dar de alta
        	                          (($this->menue[4][2]['donde']==1) ? $this->menue[4][2]['descripcion'] : "").        	                          
        	                          "\",\"".
//20071112     se incluyo los evento que se efectuar en el cliente        	                          
        	                          // evento antes de dar de alta en el cliente    //20071112
        	                          (($this->menue[3][1]['donde']==0) ? $this->menue[3][1]['descripcion'] : "").  //20071112
        	                          "\",\"". //20071112
        	                          // evento despues de dar de alta en el cliente   //20071112
        	                          (($this->menue[4][1]['donde']==0) ? $this->menue[4][1]['descripcion'] : "").   //20071112
                                          // confirma el movimiento a efectuar
                                          "\",\"".$this->menu["noconfirmamovtos"]."\"".
                                          ",this);return false'></input></td>\n";
    	  }
        if (
        		strpos($this->movto_mantto,"s")!==false
        		|| strpos($this->movto_mantto,"S")!==false        		
        		|| strpos($this->movto_mantto,"B")!==false        		        		
           )     	  
        {
     	echo "<td class='botones'> <input type=button class='btn-02' id='iBusca_$this->idmenu' src='img/action_search_20.gif' title='Buscat'  name=busca value=Buscar ".
        	"onclick='mantto_tabla(\"".$this->idmenu.
        	                          "\",\"".
        	                          (strpos($this->movto_mantto,"s")!==false ? "s" : "")
        	                          .(strpos($this->movto_mantto,"S")!==false ? "S" : "")        	                          
        	                          .(strpos($this->movto_mantto,"B")!==false ? "B" : "")        	                                  	                          
        	                          ."\",\"\",\"\",\"".
        	                          // evento antes 
        	                          (($this->menue[9][2]['donde']==1) ? $this->menue[9][2]['descripcion'] : "").
        	                          "\",\"".
        	                          // evento despues 
        	                          (($this->menue[10][2]['donde']==1) ? $this->menue[10][2]['descripcion'] : "").
        	                          "\",\"".
        	                          // evento despues    //20071113
        	                          (($this->menue[9][1]['donde']==0) ? $this->menue[9][1]['descripcion'] : ""). //20071113
        	                          "\",\"". //20071113
        	                          // evento despues  //20071113
        	                          (($this->menue[10][1]['donde']==0) ? $this->menue[10][1]['descripcion'] : ""). //20071113
                                          // confirma el movimiento a efectuar
                                          "\",\"".$this->menu["noconfirmamovtos"]."\"".
                                          ");return false'></input></td>\n";
    	  }
    	  
/**********************************************   20061101     **/    	  

    	if (strpos($this->movto_mantto,"u")!==false)     	  
        {
	     	echo "<td id='cambio' class='botones' > ".
	     	($this->menum['u']['idmovto']=='u' && $this->menum['u']["descripcion"]!="" ? "<input type='button' class='d-none btn-02' id='iCambio_".
                     $this->idmenu."' value='".$this->menum['u']["descripcion"].
                      "' title='Cambio'  " : "<input type=button class='d-none btn-02' id='iCambio_".$this->idmenu."'  title='Cambio' value='Cambio' ").
        	      "></input></td>\n";	        
        }    	
		echo $this->arma_subvistas($sql_result,$Row,$z,$meda,1);        	      	    
		
        if (strpos($this->movto_mantto,"p")!==false)     	  
        {
			echo "<TD id='imprime' class=botones > <input onclick='imprime(\"\");return false' id='iimprime_$this->idmenu'  value=Imprime type=button class='btn-02' ></input> </TD>";
        }
        		
        if (strpos($this->movto_mantto,"l")!==false)     	  
        {
     	    echo "<td id='Limpiar' class='botones' > <input type=button class='btn-02' id='iLimpiar_$this->idmenu' title='Limpia datos de la pantalla'  ".
        	 "  onclick='pone_focus_formaID(\"".$this->idmenu."\");formResetID(\"".$this->idmenu."\",\"t\")' value='Limpiar' ></input></td>\n";	        
        }

        if (strpos($this->movto_mantto,"f")!==false)     	  
        {
     	    echo "<td id='Archvio' class='botones' > <input type=button class='btn-02' id='iArchvio_$this->idmenu' title='Genera archvio en txt'  ".
        	"onclick='mantto_tabla(\"".$this->idmenu.
        	                          "\",\"f\",\"\",\"\",\"".
        	                          // evento antes 
        	                          (($this->menue[9][2]['donde']==1) ? $this->menue[9][2]['descripcion'] : "").
        	                          "\",\"".
        	                          // evento despues 
        	                          (($this->menue[10][2]['donde']==1) ? $this->menue[10][2]['descripcion'] : "").
        	                          "\",\"".
        	                          // evento despues    //20071113
        	                          (($this->menue[9][1]['donde']==0) ? $this->menue[9][1]['descripcion'] : ""). //20071113
        	                          "\",\"". //20071113
        	                          // evento despues  //20071113
        	                          (($this->menue[10][1]['donde']==0) ? $this->menue[10][1]['descripcion'] : ""). //20071113
                                          // confirma el movimiento a efectuar
                                          "\",\"".$this->menu["noconfirmamovtos"]."\"".
                                          ");return false' value='Archivo txt'></input></td>\n";
        }

        if (strpos($this->movto_mantto,"ex")!==false)
        {
            echo "<td id=Excel class='botones' > <input type=button class='btn-02' id='iExcel_$this->idmenu' title='Genera archvio en Excel'  ".
                "onclick='mantto_tabla(\"".$this->idmenu.
                                          "\",\"ex\",\"\",\"\",\"".
                                          // evento antes
                                          (($this->menue[9][2]['donde']==1) ? $this->menue[9][2]['descripcion'] : "").
                                          "\",\"".
                                          // evento despues
                                          (($this->menue[10][2]['donde']==1) ? $this->menue[10][2]['descripcion'] : "").
                                          "\",\"".
                                          // evento despues    //20071113
                                          (($this->menue[9][1]['donde']==0) ? $this->menue[9][1]['descripcion'] : ""). //20071113
                                          "\",\"". //20071113
                                          // evento despues  //20071113
                                          (($this->menue[10][1]['donde']==0) ? $this->menue[10][1]['descripcion'] : ""). //20071113
                                          // confirma el movimiento a efectuar
                                          "\",\"".$this->menu["noconfirmamovtos"]."\"".
                                          ");return false' value='Archivo Excel'></input></td>\n";
        }

        if (strpos($this->movto_mantto,"ea")!==false)
        {
            echo "<td id=ExcelA class='botones' > <input type=button class='btn-02' id='iExcelA_$this->idmenu' title='Genera archivo en Excel con documentos escaneados'  ".
                "onclick='mantto_tabla(\"".$this->idmenu.
                                          "\",\"ea\",\"\",\"\",\"".
                                          // evento antes
                                          (($this->menue[9][2]['donde']==1) ? $this->menue[9][2]['descripcion'] : "").
                                          "\",\"".
                                          // evento despues
                                          (($this->menue[10][2]['donde']==1) ? $this->menue[10][2]['descripcion'] : "").
                                          "\",\"".
                                          // evento despues    //20071113
                                          (($this->menue[9][1]['donde']==0) ? $this->menue[9][1]['descripcion'] : ""). //20071113
                                          "\",\"". //20071113
                                          // evento despues  //20071113
                                          (($this->menue[10][1]['donde']==0) ? $this->menue[10][1]['descripcion'] : ""). //20071113
                                          // confirma el movimiento a efectuar
                                          "\",\"".$this->menu["noconfirmamovtos"]."\"".
                                          ");return false' value='Archivo Excel con Documentos'></input></td>\n";
        }



        if ($meda->camposm["esadmon"]!="0" && $meda->camposm["esadmon"]!="")
        	{
				echo "<td id='Autodiseno' class=botones ><input type=button class='btn-02' id='iAutoDiseno_$this->idmenu' title='Entra al diseno de la forma' ".
									  " onclick='abre_subvista(\"src/php/man_menus.php\",\"idmenu=".$this->menu["idmenu"].
						              " &filtro=idmenu=".$this->menu["idmenu"].
						              "\",\"\",\"\",".MENU.",800,600,\"Diseno de form\"".	//20070526
						              ");return false;' value=AutoDiseno >".
									  "</input>".
						              "</td>\n"; 										

        	}        	            	
        if (strpos($meda->camposm['movtos'],"n")!==false) 
        	{
	     	echo "<td id='navegacionar' class='botones' > ".
	     	($this->menum['n']['idmovto']=='n' && $this->menum['n']["descripcion"]!="" ? "<input type=button id='iinicio' value='".$this->menum['n']["descripcion"]."' title='Registro Inicial'  " : "<button type=image id='iInicio_$this->idmenu' src='img/quitato2s.gif' title='RegistroInicial' value='RegistroInicial' ").
        	  "onclick='registroinicial();return false'></button>  </td>\n";
	     	echo "<td id='navegacionar' class='botones' > ".
	     	($this->menum['n']['idmovto']=='n' && $this->menum['n']["descripcion"]!="" ? "<input type=button id='iAnterior' value='".$this->menum['n']["descripcion"]."' title='Siguiente Registro'  " : "<input type=image id='AnteriorRegistro' src='img/quita1.gif' title='AnteriorRegistro' value='AnteriorRegistro' ").
        	  "onclick='anteriorregistro();return false'></input>  </td>\n";	                	  	        	
	     	echo "<td id='navegacionsr' class='botones' > ".
	     	($this->menum['n']['idmovto']=='n' && $this->menum['n']["descripcion"]!="" ? "<input type=button id='iSiguiente' value='".$this->menum['n']["descripcion"]."' title='Siguiente Registro'  " : "<input type=image id='SiguienteRegistro' src='img/asigna1.gif' title='SiguienteRegistro' value='SiguienteRegistro' ").
        	  "onclick='siguienteregistro();return false'></input></td>\n";	        
	     	echo "<td id=navegacionar class='botones' > ".
	     	($this->menum['n']['idmovto']=='n' && $this->menum['n']["descripcion"]!="" ? "<input type=button id='ifinal' value='".$this->menum['n']["descripcion"]."' title='Registro Final'  " : "<input type=image id='iFinal' src='img/asignato2s.gif' title='RegistroInicial' value='RegistroFinal' ").
        	  "onclick='registrofinal();return false'></input>  </td>\n";	                	  	        		        	        	  
        	}        	            	    	  
     	echo "</tr>";
	    $this->fin_tab_botones();     	
	    $this->fin_tabcaptura();     	
  }

  /**
    *   Arma los renglones de la tabla 
    *   @param recordset $sql_result recordset de la tabla donde se van armar todos los renglones
    *   @param int $num numero de renglones a armar
    */
  function filas_ing($sql_result,$num,$md) 
  {
	if ($md=="")	//20070623
	{//20070623
     $md = new menudata();
     $md->connection=$this->connection;
     $md->tabla=$this->tabla;
     $md->idmenu=$this->idmenu;
     $md->damemetadata();
	}     //20070623
     $tt = $this->titulos_tab($sql_result,$md);     
     $wlllave="";
     if ($num!=0)
     {
	     $Row1 = pg_fetch_array($sql_result, 0);
		 $tt = $tt."<tbody class='scrolling_table_body'>\n";
    	 for ($z=0; $z < $num ;$z++)
     	{
	    	$wlllave="";
        	$Row = pg_fetch_array($sql_result, $z);
        	$wl=$this->armarenglon($sql_result,$Row,$z,$md);
 			$tt = $tt.$wl;       
          	//next($Row1);
        }
		$tt = $tt."</tbody>\n";        
      }
	return $tt;		
  } 

/**
  * Arma un reglon 
  *  @param recordset $sql_result recordset de la tabla
  *  @param arreglo   $row row del cual va a generar la fila de la tabla
  *  @param int       $z   numero de row
  *  @param metada    $meda metadata de la tabla
  *  $md el objeto del metada    
  *  @return string renglon armado
	*/
  function armarenglon($sql_result,$Row,$z,$meda)
  {
	  		$wl="";
	  		$wlini="";
	  		$wlcol=0;
	        $i = pg_numfields($sql_result);
	        for ($j = 0; $j < $i; $j++)
    	    {
        	  	switch (pg_fieldname($sql_result, $j))
          		{
            		case "ximportex":
               			if (trim($Row[pg_fieldname($sql_result, $j)])!="Correcto Usuario")
               			{ $wl=$wl."<td><input onBlur='caping(".($j+1).",".$wlcol.",this,this.value,".$Row["atl"].",\"".$this->xlfechaini."\");' name=celda".($j+1)."_".$wlcol.
                    		  " value=".$Row[pg_fieldname($sql_result, $j)]."></input></td>"; }
               			else
               			{ $wl=$wl."<td>".$Row[pg_fieldname($sql_result, $j)]."</td>"; }
               			break;
            		default:
			if ($meda->camposmc[pg_fieldname($sql_result, $j)]['attnum']!='0') ##  20070213
			{##  20070213
							if ($meda->camposmc[pg_fieldname($sql_result, $j)]['idsubvista']==''
						    	|| $meda->camposmc[pg_fieldname($sql_result, $j)]['idsubvista']=='0'
						   		)
							{
								if ($meda->camposmc[pg_fieldname($sql_result, $j)]["upload_file"]!='t' && $meda->camposmc[pg_fieldname($sql_result, $j)]["link_file"]!='t')
								{ 
									$wl=$wl.$this->arma_td($z,$j,$Row[pg_fieldname($sql_result, $j)],$meda->camposmc[pg_fieldname($sql_result, $j)]['fuente']);
								}
								else
								{
                                                                        $wlid=$this->armaid_td($z,$j);
                                                                        $wl=$wl."<td ".$wlid."><a onclick='event.preventDefault(); showModalDialog(\"upload_ficheros/".$Row[pg_fieldname($sql_result, $j)]."\",600,700,\"".$wlid."\",2);' >".$Row[pg_fieldname($sql_result, $j)]."</a></td>";

								}
								
							}
							else
							{
								$wl=$wl."<td  ".$this->armaid_td($z,$j)."><a href=## onclick='muestra_cambio(\"formpr\","
						        	      .$z.",".$i.",\"wlllave\",".$meda->camposm['idmenu'].
        	                        	  // evento antes de dar cambio
        	                          	",\"".(($meda->camposme[7][2]['donde']==1) ? $meda->camposme[7][2]['descripcion'] : "").
        	                          	"\",\"".
        	                          	// evento despues de dar cambio
        	                          	(($meda->camposme[8][2]['donde']==1) ? $meda->camposme[8][2]['descripcion'] : "").
        	                          	"\",\"".  //20071113
        	                          	// evento despues de dar cambio  //20071113
        	                          	(($meda->camposme[7][1]['donde']==0) ? $meda->camposme[7][1]['descripcion'] : "").//20071113
        	                          	"\",\"".//20071113
        	                          	// evento despues de dar cambio//20071113
        	                          	(($meda->camposme[8][1]['donde']==0) ? $meda->camposme[8][1]['descripcion'] : "").//20071113
						              	"\",\"u1\");abre_subvista(\"src/php/man_menus.php\",\"idmenu=".
						              	$meda->camposmc[pg_fieldname($sql_result, $j)]['idsubvista'].
						              	"&filtro=".pg_fieldname($sql_result, $j)."=".
						              	$Row[pg_fieldname($sql_result, $j)]."\",\"".
##						              "&filtro=\"wlllave\",\"".
							              //  evento antes de abrir subvista
							              (($meda->camposme[1][2]['donde']==1) ? $meda->camposme[1][2]['descripcion'] : "").
							              "\",\"".
							              //  despues de abrir subvista
							              (($meda->camposme[10][2]['donde']=1)  ? $meda->camposme[10][2]['descripcion'] : "").
							              "\",".
                                                                      $meda->camposmc[pg_fieldname($sql_result, $j)]['idsubvista'].   /// con este dato se identifica el id de la ventana
                                                                  ",".$meda->camposmc[pg_fieldname($sql_result, $j)]['dialogwidth'].
                                                                      ",".$meda->camposmc[pg_fieldname($sql_result, $j)]['dialogheight'].
                                                                      ",\"".$meda->camposmc[pg_fieldname($sql_result, $j)]['descripcion']."\"".
						            	  ");return false;'>".
						              	$Row[pg_fieldname($sql_result, $j)]."</a></td>\n"; 					
							}
						}##  20070213
						break;
				}
	          	if ($meda->camposmc[pg_fieldname($sql_result, $j)]['indice']=='t' || $meda->camposmc[pg_fieldname($sql_result, $j)]['esindex']=='t')  /*   checa si es un index para armar llave */
    	      	{  ($wlllave!='') ? $wlllave=$wlllave.' and '.
        	    	           pg_fieldname($sql_result, $j)."=".$this->guionbajo($Row[pg_fieldname($sql_result, $j)],$meda->camposmc[pg_fieldname($sql_result, $j)]['typname']) 
            	    	       :  $wlllave=pg_fieldname($sql_result, $j)."=".$this->guionbajo($Row[pg_fieldname($sql_result, $j)],$meda->camposmc[pg_fieldname($sql_result, $j)]['typname']); 
            	}
            	$wl=str_replace("wlllave",$wlllave,$wl);  // reemplaza la palabra llave por la variable wlllave
       			$wlcol=$wlcol+1;               	
          	}
          
        	$wlini="<tr id=tr".($z)."_".$this->idmenu."  oncontextmenu='contextForTR(this,".$this->idmenu.");return false;' >"; //20070703      
                error_log($this->dame_tiempo()." src/php/soldatos.php valor de z en tr=".$wlini."\n",3,"/var/tmp/errores.log");
        	if (strpos($meda->camposm['movtos'],"d")!==false) 
        	{
            	 $wlini=$wlini."<td name=noimprime ><button class='btn-eliminar'  title='Eliminar registro'  ".
                   "onclick='daunClick(\"cam".$z."\",".$this->idmenu.");mantto_tabla(\"".$meda->camposm['idmenu']."\",\"d\",\"".$wlllave."\",".($z).",\"".                   
        	                          // evento antes de dar de baja
        	                          (($meda->camposme[5][2]['donde']==1) ? $meda->camposme[5][2]['descripcion'] : "").
        	                          "\",\"".
        	                          // evento despues de dar de baja
        	                          (($meda->camposme[6][2]['donde']==1) ? $meda->camposme[6][2]['descripcion'] : "").
        	                          "\",\"". //20071113
        	                          // evento antes de dar de baja  //20071113
        	                          (($meda->camposme[5][1]['donde']==0) ? $meda->camposme[5][1]['descripcion'] : "").//20071113
        	                          "\",\"". //20071113
        	                          // evento despues de dar de baja  //20071113
        	                          (($meda->camposme[6][1]['donde']==0) ? $meda->camposme[6][1]['descripcion'] : "").//20071113
                                         // confirma el movimiento a efectuar
                                          "\",\"".$this->menu["noconfirmamovtos"]."\"".
                                                           ");return false'></input></td>\n";
        	}

        	if (strpos($meda->camposm['movtos'],"cc")!==false) 
        	{
            	 $wlini=$wlini."<td name=noimprime ><i class='fas fa-copy' type=image title='Copia registro' src='img/copy.gif' ".
                   "onclick='mantto_tabla(\"".$meda->camposm['idmenu']."\",\"cc\",\"".$wlllave."\",".($z).",\"".
        	                          // evento antes de dar de baja
        	                          (($meda->camposme[5][2]['donde']==1) ? $meda->camposme[5][2]['descripcion'] : "").
        	                          "\",\"".
        	                          // evento despues de dar de baja
        	                          (($meda->camposme[6][2]['donde']==1) ? $meda->camposme[6][2]['descripcion'] : "").
        	                          "\",\"".
        	                          // evento despues de dar de baja
        	                          (($meda->camposme[5][1]['donde']==0) ? $meda->camposme[5][1]['descripcion'] : "").
        	                          "\",\"".
        	                          // evento despues de dar de baja
        	                          (($meda->camposme[6][1]['donde']==0) ? $meda->camposme[6][1]['descripcion'] : "").
                                          // confirma el movimiento a efectuar
                                          "\",\"".$this->menu["noconfirmamovtos"]."\"".
                                                           ");return false'></i></td>\n";
        	}

            if (strpos($meda->camposm['movtos'],"u")!==false || strpos($meda->camposm['movtos'],"s")!==false)      
        	{
            	 $wlini=$wlini."<td name=noimprime ><button class='btn-editar' name='botcam' id=cam".$z."_".$this->idmenu." title='Seleccionar renglon'  ".
                	  "onclick='muestra_cambio(\"formpr\",".$z.",".$i.",\"".$wlllave."\",".$meda->camposm['idmenu'].",\"".
        	                          // evento antes de dar cambio
        	                          (($meda->camposme[7][2]['donde']==1) ? $meda->camposme[7][2]['descripcion'] : "").
        	                          "\",\"".
        	                          // evento despues de dar cambio
        	                          (($meda->camposme[8][2]['donde']==1) ? $meda->camposme[8][2]['descripcion'] : "").
        	                          "\",\"".//20071113
        	                          // evento despues de dar cambio  //20071113
        	                          (($meda->camposme[7][1]['donde']==0) ? $meda->camposme[7][1]['descripcion'] : ""). //20071113
        	                          "\",\"".//20071113
        	                          // evento despues de dar cambio//20071113
        	                          (($meda->camposme[8][1]['donde']==0) ? $meda->camposme[8][1]['descripcion'] : ""). //20071113
                                                          "\",\"u\"".
                                          ",\"".$this->menu["noconfirmamovtos"]."\"".
                                          "); return false;' ></input></td>\n";
                 //error_log($this->dame_tiempo()." src/php/soldatos.php valor de wlini en td=".$wlini."\n",3,"/var/tmp/errores.log");
        	}
        	
            if (strpos($meda->camposm['movtos'],"B")!==false)      
        	{
            	 $wlini=$wlini."<td name=noimprime ><input  type=Image name='botcam' id=cam".$z." title='Seleccionar renglon' src='img/icon_enabled_checkbox_unchecked.gif' ".	        	
                	  "onclick='muestra_cambio(\"formpr\",".$z.",".$i.",\"".$wlllave."\",".$meda->camposm['idmenu'].",\"".
        	                          // evento antes de dar cambio
        	                          (($meda->camposme[7][2]['donde']==1) ? $meda->camposme[7][2]['descripcion'] : "").
        	                          "\",\"".
        	                          // evento despues de dar cambio
        	                          (($meda->camposme[8][2]['donde']==1) ? $meda->camposme[8][2]['descripcion'] : "").
        	                          "\",\"".//20071113
        	                          // evento despues de dar cambio  //20071113
        	                          (($meda->camposme[7][1]['donde']==0) ? $meda->camposme[7][1]['descripcion'] : ""). //20071113
        	                          "\",\"".//20071113
        	                          // evento despues de dar cambio//20071113
        	                          (($meda->camposme[8][1]['donde']==0) ? $meda->camposme[8][1]['descripcion'] : ""). //20071113
                  					  "\",\"B\"); return false;' ></input></td>\n";	        
        	}
        	
			$wlini.=$this->arma_subvistas($sql_result,$Row,$z,$meda,0);

        	return $wlini.$wl."</tr>\n";
  }

  
  /**
    * arma los botones de accion que pueden abrir una subvista
    * @param recordset $sql_result recordset del metadata
    * @param arreglo   $row el row del cual va a generar los botones
    * @param int       $z  el numero de row
    * @param metadata  $md el objeto del metada    
    * @param int       $posicion en que parte muestra los botones a nivel renglon o cabecera
    * @return string    botones armados
    */
  function arma_subvistasbotonligasel($sql_result,$Row,$z,$meda,$posicion,$mm,$i)
  {
			return "<option ".
                   			"value='daunClick(\"cam".$z."\",".$this->idmenu.");".
						              "abre_subvista(\"src/php/man_menus.php\",\"idmenu=".
						              $meda->camposmsv[$mm]['idsubvista'].
						              "&filtro=".$this->pon_filtro($meda->camposmsv[$mm],$Row,$meda->camposmc)."\",\"".
						              //  evento antes de abrir subvista
						              $meda->camposmsv[$mm]['eventos_antes'].
						              "\",\"".
						              //  despues de abrir subvista
						              $meda->camposmsv[$mm]['eventos_despues'].
						              "\",".
						              $meda->camposmsv[$mm]['idsubvista'].
						              ",".$meda->camposmsv[$mm]['dialogwidth'].
						              ",".$meda->camposmsv[$mm]['dialogheight'].
                                                              ",\"".$meda->camposmsv[$mm]['texto']."\"".
						              ");return false;'".
						          "> ".$meda->camposmsv[$mm]['texto'].						              
							  "</option>"; 											  
  }  

  /**
    * arma los botones de accion que pueden abrir una subvista
    * @param recordset $sql_result recordset del metadata
    * @param arreglo   $row el row del cual va a generar los botones
    * @param int       $z  el numero de row
    * @param metadata  $md el objeto del metada    
    * @param int       $posicion en que parte muestra los botones a nivel renglon o cabecera
    * @return string    botones armados
    */
  function arma_subvistasbotonligacomandosel($sql_result,$Row,$z,$meda,$posicion,$mm,$i)
  {
			return "<option ".
               			"value='daunClick(\"cam".$z."\",".$this->idmenu.");".
                                "comandos_servidor(\"".$meda->camposmsv[$mm]['clase']."\",\"".$meda->camposmsv[$mm]['funcion']."\",".$meda->camposm['idmenu'].
                                    ");return false;'".
			          "> ".$meda->camposmsv[$mm]['texto'].						              
				  "</option>"; 											  
  }  
  
  
  /**
    * arma los botones de accion que pueden abrir una subvista
    * @param recordset $sql_result recordset del metadata
    * @param arreglo   $row el row del cual va a generar los botones
    * @param int       $z  el numero de row
    * @param metadata  $md el objeto del metada    
    * @param int       $posicion en que parte muestra los botones a nivel renglon o cabecera
    * @return string    botones armados
    */
  function arma_subvistasbotonliga($sql_result,$Row,$z,$meda,$posicion,$mm,$i)
  {
			return "<td name=noimprime class=botones >".
				  (	$meda->camposmsv[$mm]['esboton']==1 ? "<input class='btn-02' type=button id='".$meda->camposmsv[$mm]['texto']."'" : "<a id='".$meda->camposmsv[$mm]['texto']."' href=## ").
                   			"onclick='daunClick(\"cam".$z."\",".$this->idmenu.");".
						              "abre_subvista(\"src/php/man_menus.php\",\"idmenu=".
						              $meda->camposmsv[$mm]['idsubvista'].
						              "&filtro=".$this->pon_filtro($meda->camposmsv[$mm],$Row,$meda->camposmc)."\",\"".
						              //  evento antes de abrir subvista
						              $meda->camposmsv[$mm]['eventos_antes'].
						              "\",\"".
						              //  despues de abrir subvista
						              $meda->camposmsv[$mm]['eventos_despues'].
						              "\",".
						              $meda->camposmsv[$mm]['idsubvista'].
						              ",".$meda->camposmsv[$mm]['dialogwidth'].
						              ",".$meda->camposmsv[$mm]['dialogheight'].
                                                              ",\"".$meda->camposmsv[$mm]['texto']."\"".
						              ");return false;'".
									  (	$meda->camposmsv[$mm]['esboton']==1 ? " value='".$meda->camposmsv[$mm]['texto']."'> " : " >".$meda->camposmsv[$mm]['texto']).						              
									  (	$meda->camposmsv[$mm]['esboton']==1 ? "</input> " : "</a> ").
						              "</td>\n"; 											  
  }  
  /**
    * arma los botones de accion que ejecutan un comando en el servidor
    * @param recordset $sql_result recordset del metadata
    * @param arreglo   $row el row del cual va a generar los botones
    * @param int       $z  el numero de row
    * @param metadata  $md el objeto del metada    
    * @param int       $posicion en que parte muestra los botones a nivel renglon o cabecera
    * @return string    botones armados
    */
  function arma_subvistasbotonligacomando($sql_result,$Row,$z,$meda,$posicion,$mm,$i)
  {
	 return "<td class='botones' name=noimprime >".
	  (	$meda->camposmsv[$mm]['esboton']==1 ? "<input type=button id='".$meda->camposmsv[$mm]['texto']."' class='btn-02' " : "<a href=## ").
        		"onclick='daunClick(\"cam".$z."\",".$this->idmenu.");".
	              "comandos_servidor(\"".$meda->camposmsv[$mm]['clase']."\",\"".$meda->camposmsv[$mm]['funcion']."\",".$meda->camposm['idmenu'].
	              ");return false;'".
	  (	$meda->camposmsv[$mm]['esboton']==1 ? " value='".$meda->camposmsv[$mm]['texto']."'> " : " >".$meda->camposmsv[$mm]['texto']).
				  (	$meda->camposmsv[$mm]['esboton']==1 ? "</input> " : "</a> ").
              "</td>\n"; 																		  
  }  
  
  /**
    * arma los botones de accion que pueden abrir una subvista o ejecutar un xml
    * @param recordset $sql_result recordset del metadata
    * @param arreglo   $row el row del cual va a generar los botones
    * @param int       $z  el numero de row
    * @param metadata  $md el objeto del metada    
    * @param int       $posicion en que parte muestra los botones a nivel renglon o cabecera
    * @return string    botones armados
    */
  function arma_subvistas($sql_result,$Row,$z,$meda,$posicion)
  {
	  		$wlini="";
	  		$wlinis="";
        	$mm=0;
	        $i = pg_numfields($sql_result);        	
			while ($mm < count($meda->camposmsv))    // checa que subvistas hay o botones
			{
				if ($meda->camposmsv[$mm]['esboton']==1 or $meda->camposmsv[$mm]['esboton']==0)
				{
					if ($meda->camposmsv[$mm]['posicion']==$posicion )
					{
						if ($meda->camposmsv[$mm]['idsubvista']!='0')
						{$wlini=$wlini.($this->arma_subvistasbotonliga($sql_result,$Row,$z,$meda,$posicion,$mm,$i));}
					
						if ($meda->camposmsv[$mm]['funcion']!='')
						{$wlini=$wlini.($this->arma_subvistasbotonligacomando($sql_result,$Row,$z,$meda,$posicion,$mm,$i));}
					}
				}
				$mm=$mm+1;
			}
			
        	$mm=0;			
			while ($mm < count($meda->camposmsv))    // checa que subvistas hay o botones
			{
				if ($meda->camposmsv[$mm]['esboton']==2)
				{
					if ($meda->camposmsv[$mm]['posicion']==$posicion )
					{
						if ($meda->camposmsv[$mm]['idsubvista']!='0')
						{$wlinis=$wlinis.($this->arma_subvistasbotonligasel($sql_result,$Row,$z,$meda,$posicion,$mm,$i));}
					
						if ($meda->camposmsv[$mm]['funcion']!='')
						{$wlinis=$wlinis.($this->arma_subvistasbotonligacomandosel($sql_result,$Row,$z,$meda,$posicion,$mm,$i));}
					}
				}
				$mm=$mm+1;
			}			
//			($wlinis!="") ? $wlinis="<td><select onfocus='desplega(this);return false;' onchange='submenus(this);return false' >".$wlinis."</select></td>" : $wlinis="" ;			
			($wlinis!="") ? $wlinis="<td><select class='form-control form-control-custom' onchange='submenus(this);return false' >".$wlinis."</select></td>" : $wlinis="" ;			
			return $wlini.$wlinis;
  }
////////////////   20070629  se modifico para tener un menu de acuerdo a un campo select    
  
  /**
    * arma el filtro de la subvista que vaya a abrir
    *  @param string  $msv campos de la subvista separados por punto y coma
    *  @param arreglo $row datos del renglon o fila
    *  @param camposmc $camposmc arreglo que contiene los campos de la menus campos
    *  @return string filtro armado
    */
  function pon_filtro($msv,$row,$camposmc)
  {
	   		$va="";
	   		$campo_filtro=explode(";",$msv['campo_filtro']);
	   		$valor_padre=explode(";",$msv['valor_padre']);	   		
			$i=0;
			while ($i < count($campo_filtro))    // filtro que vienen desde el php
			{
				if (trim($campo_filtro[$i])!="")
				{
					//20070223  cuando el filtro es mas de un campo no anteponia el and en el 2do. campos
//20070223					$va.=trim($campo_filtro[$i])."=".(strpos($camposmc[$valor_padre[$i]]["typname"],"int")===false ? "\\\"".trim($row[$valor_padre[$i]])."\\\"" : $row[$valor_padre[$i]]) ;
//20070223					$va.=($i==0 ? '' : ' and ').trim($campo_filtro[$i])."=".(strpos($camposmc[$valor_padre[$i]]["typname"],"int")===false ? "\\\"".trim($row[$valor_padre[$i]])."\\\"" : $row[$valor_padre[$i]]) ; //20070223
//20070223          el 20070223 me di cuenta que hacia falta incorporar una modificacion para que en  vez de manejar
//20070223          el & manejase el =
					$va.=($i==0 ? '' : ' and ').trim($campo_filtro[$i])."=".$this->guionbajo(trim($row[$valor_padre[$i]]),$camposmc[$valor_padre[$i]]["typname"]);  //20070219					
				}
				$i=$i+1;
			}
##	  		echo "entro en pon_filtro va".$va;			
			return $va;	  
  }
  
  /**
    *   Si valor contiene un ampersand regresa el valor que tiene del lador derecho
    *   @param string $valor valor del campo
    *   @param typname $typname tipo de campo (caracter,name etc.. para saber si lo regresa con comillas
    *   @return string conteniendo el valor del lado derecho
    */
  function guionbajo($valor,$typname)
	{ 
//		echo "valor-typname".$valor."-".$typname." posicion".strpos($typname,"char");
		$comilla="";
		strpos($typname,"char")===false && strpos($typname,"name")===false && strpos($typname,"date")===false ? $comilla="" : $comilla="\\\""  ;
//		return (strpos($valor,"_"))===false ? $comilla.$valor.$comilla : $comilla.substr($valor,strpos($valor,"_")+1).$comilla ; 
//		return (strpos($valor,"_"))===false ? $comilla.$valor.$comilla : $comilla.substr($valor,strpos($valor,"_")+1).$comilla ; 
//20070219		return (strpos($valor,"&"))===false ? $comilla.$valor.$comilla : $comilla.substr($valor,strpos($valor,"&")+1).$comilla ; 
//20070219      el ampersand lo cambie por el igual, ya que cuando el filtro era un select tronada 
		return (strpos($valor,"="))===false ? $comilla.$valor.$comilla : $comilla.substr($valor,strpos($valor,"=")+1).$comilla ; 		
	}

/**
  * arma el td de un renglon de una tabla
  * @param int $z renglon
  * @param int $j columna
  * @param string $wltexto texto que aparece en el td, si el texto tiene un = quiere decir que la descripcion viene   // 20070219
  *                         del lador derecho y del valor izquierdo el valor                                          // 20070219
  *                         cambi en caracter de separacion de & por = ya que al hacer el filtro tronaba              // 20070219
  *                         cuando se hacia la subvista ya que el & es un caracter de control                         // 20070219
  * @return string td armado
  **/
##20070226  function arma_td($z,$j,$wltexto)
  function arma_td($z,$j,$wltexto,$wlfuente)  // 20070226
  {
//	  if (strpos($wltexto,"&")===false)  // 20070219
//20070226	  if (strpos($wltexto,"=")===false)	 // 20070219 
	  if ($wlfuente=='' || ($wlfuente!='' && $wlfuente=='menus_tiempos'))	 // 20070226
	  {
	  	return "<td onclick='contextForTR(this.parentNode,$this->idmenu);return false;' ".$this->armaid_td($z,$j).">".trim($wltexto)."</td>\n";
  	}
  	else
  	{
	  		  	return "<td onclick='contextForTR(this.parentNode,$this->idmenu);return false;' ".$this->armaid_td($z,$j)." abbr='".trim(substr($wltexto,strpos($wltexto,"=")+1))."'>".substr($wltexto,0,strpos($wltexto,"="))."</td>\n";  // 20070219
  	}
  }
  	  
  /**
   *  Arma el id del td en base al numero de renglon y columna
   *  @param int $z renglon
   *  @param int $j columna
   **/
  function armaid_td($z,$j)
	{ return " id=r".$z."c".$j."_".$this->idmenu." ";	}

  /**	
    *  20070818 lee los datos del menu este estaba en mantotab pero lo cambie 
    *			para leer estos datos y tener esta informacion desque el inicio de la forma para el css
    **/		
  function lee_menu()
  {
	  if ($this->idmenu=="" && $this->descripcion=="")
	  {
	  	menerror("no esta definida la definicion del menu");
	  	die();
  	  }	
	  $menu = new menudata();
  	  $menu->connection=$this->connection;
	  $menu->idmenu = $this->idmenu;
	  $menu->descripcion = $this->descripcion;
	  $menu->filtro = $this->filtro;
	  $menu->damemetadata();

	  $sql=$menu->camposm["fuente"];
	  $this->movto_mantto=$menu->camposm["movtos"];
	  $this->tabla=$menu->camposm["tabla"];
	  $this->titulos=$menu->camposm["descripcion"];
	  $this->menu=$menu->camposm;
	  $this->menuc=$menu->camposmc;
	  $this->menumce=$menu->camposmce;	  // 20070904
	  $this->menue=$menu->camposme;
	  $this->menum=$menu->camposmm;	     /*   20061101   */	  
	  $this->menumht=$menu->camposmht;	     /*   20070627   */	  	  	  
	  $this->metada=$menu;    // 20070818
	  $this->idmenu=$menu->idmenu;
  }
  
  /**	
    *  Da mantenimiento a una tabla de acuerdo al idmenu
    **/
  function mantotab()
  {
     $sql=$this->menu["fuente"];   // 20070818
     $sql_result = @pg_exec($this->connection,$sql);
     if (pg_last_error($this->connection)!="")
     {
          error_log($this->dame_tiempo()." src/php/soldatos.php error al leer la fuente\r".pg_last_error($this->connection),3,"/var/tmp/errores.log");
          $this->Enviaemail("Opcion: ".$this->titulos."<br>Error: ".pg_last_error($this->connection)."<br>Query: ".$sql."<br>"."Usuario=".$_SESSION["parametro1"]);
                   echo "Error al leer la base de datos reportar a sistemas";
                   die("Error al leer la base de datos reportar a sistemas");
     }
     $num = pg_numrows($sql_result);
     if ( $num == 0 && 
     		 (   
         		 strpos($this->movto_mantto,"s")!==false 
         		|| strpos($this->movto_mantto,"u")!==false
         		|| strpos($this->movto_mantto,"d")!==false              
         		|| strpos($this->movto_mantto,"cc")!==false              
         	 )
     	) 
     	{
	     	};
     if ( $num >= $this->menu["limite"] )
        {menerror("El limite de registros para mostrar fue rebasado, limite:".$this->menu["limite"]); };
        
	if ($num != 0 )
	{
      $reg= new logmenus($this->connection); //20070623
      $reg->registra($this->idmenu ,trim($this->camposm["tabla"]." ".$this->filtro." regs=".$num));//20070623
      $reg=null;        //20070623
  }
     if (   strpos($this->movto_mantto,"i")!==false 
         || strpos($this->movto_mantto,"s")!==false 
         || strpos($this->movto_mantto,"S")!==false          
         || strpos($this->movto_mantto,"B")!==false                   
         || strpos($this->movto_mantto,"u")!==false
         || strpos($this->movto_mantto,"e")!==false         
         || strpos($this->movto_mantto,"I")!==false    // 20070115 solo altas en automatico
         ) 
         { $this->campo_cap($sql_result,$this->metada); }         
         
     if (   strpos($this->movto_mantto,"i")!==false 
         || strpos($this->movto_mantto,"s")!==false 
         || strpos($this->movto_mantto,"u")!==false
         || strpos($this->movto_mantto,"U")!==false         
         || strpos($this->movto_mantto,"d")!==false         
         || strpos($this->movto_mantto,"cc")!==false         
         || strpos($this->movto_mantto,"S")!==false       
         || strpos($this->movto_mantto,"B")!==false                      
         )          
         {
     		echo $this->inicio_tab($this->menu["table_width"],$this->menu["table_height"],$this->menu["table_align"]);	  	  
     		echo $this->filas_ing($sql_result, $num, $this->metada);     		//20070623   
     		echo "</table>";  		
     		echo "</div>";  		
 	 }
  } 

  /**
    *    Brosea los ingresos recibidos, esto tiende a desaparecer
    **/
  function broseaing()
  {
     $sql ="SELECT atl,nombre_atl as Nombre  ".
           " ,(select total from cobros_enca_cap as cec where   cec.atl=atls.atl and cec.fcobro='".$this->xlfechaini."') as importe".
           " ,(select (select descripcion from estados es where es.estado=ce.estado) from cobros_enca as ce ".
           "  where   ce.atl=atls.atl and ce.fcobro='".$this->xlfechaini."') as estado".
           " ,(select fecha_modifico from cobros_enca_cap as cec where   cec.atl=atls.atl and cec.fcobro='".$this->xlfechaini."') as fecha".
           " ,(select usuario_modifico from cobros_enca_cap as cec where   cec.atl=atls.atl and cec.fcobro='".$this->xlfechaini."') as usuario".
           " FROM atls order by atl";
     $sql_result = pg_exec($this->connection,$sql)
                   or die("Problemas al hacer sql broseaing. ".$sql );
     $num = pg_numrows($sql_result);
     if ( $num == 0 ) {menerror("No hay opciones ");die(); };
##     $this->titulos_tab($sql_result);
//20070623     $this->filas_ing($sql_result, $num);
     echo $this->filas_ing($sql_result, $num, "");//20070623     
    }
  /**
    *   funcion que desplega el mensaje de mantenimiento
    */
  function desplemanto()
  {
	  $this->inicio_html();
	  echo "	<table>	";
	  echo "	<tr><td align=center><b><font color=red><big>Temporalmemte fuere de servicio por mantenimiento	";
	  echo "	de los dias Viernes 7 de octubre a partir de las 20:00 hrs ";
	  echo "	al domingo 9 de octubre a las 24 hrs de 2008</td></tr>	";
	  echo "	</table>	";
	  die;
  } 

    function Enviaemail($error)
    {
   $mail = new PHPMailer();
   $wlemail='jlvdantry@hotmail.com';
   $mail->Host = CORREO_HOST;  // Specify main and backup server
   $mail->SMTPAuth = true;                               // Enable SMTP authentication
   $mail->Username = MANDRILL_USUARIO;                            // SMTP username
   $mail->Password = MANDRILL_APIKEY;                           // SMTP password
   $mail->Port = CORREO_PUERTO;                           // SMTP password
   $mail->SMTPSecure = 'tls';                            // Enable encryption, 'ssl' also accepted
   $mail->From = $wlemail;
   $mail->FromName = 'Jose Luis Vasquez Barbosa';
   $mail->AddAddress($wlemail);               // Name is optional
   $mail->AddReplyTo($wlemail, 'Information');
   $mail->WordWrap = 50;                                 // Set word wrap to 50 characters
   $mail->IsHTML(true);                                  // Set email format to HTML
   $mail->Subject = 'envio de email';
   $mail->Body    = $error."<br>IP: ".(is_null($_SERVER['REMOTE_ADDR'])?'Localhost':$_SERVER['REMOTE_ADDR']);
   if(!$mail->Send()) {
      exit;
                      }
    }
   function dame_tiempo()
   {
                            $t=getdate();
                            return date('Y-m-d h:i:s',$t[0]);
   }


}

