<?php
require_once("class_men.php");
//20070623 require_once("class_logmenus.php");
/**
 *	Regresa el metadata del menu que se desea
 *   @package   forapi 
*/
class menudata
{
   /**
    * menu que se quiere el metadata
    */
   var $idmenu="";  /* numero de menu */
   var $descripcion="";  /* descripcion del menu esto cuando se cambia de un ambiente de otro es mejor utilizar la descripcion */
   /**
     * campos de la tabla menus
     */
   var $camposm=array();
   /**
     * campos de la tabla menus campos
     */
   var $camposmc=array();
   /**
     * campos de la tabla menus campos eventos
     */
   var $camposmce=array(array());
   /**
     * campos de la tabla menus eventos
     */
   var $camposme=array(array());
   /**
     * campos de la tabla menus_movtos
     */
   var $camposmm=array();
   /**
     * campos de la tabla menus_subvistas
     */
   var $camposmsv=array();
   
   /**
     * campos de la tabla menus_htmltable  20070627 se incluyo esta tabla
     */
   var $camposmht=array();   
   
   /**
     * Coneccion a la base de datos
     */
   var $connection="";  /* tabla o sql */
   /**
   	* filtro que viene desde la hoja php externo aparte del ques esta definido en las vista 
   	* si algun campos viene con este filtro por default este se vuelve readonly
   	*/
   var $filtro="";
   
   /**			//20070215
     *  regresa la secuencia de una tabla//20070215
     *  @param fuente  nombre de la tabla //20070215
     *  @return string secuencia//20070215
     */ ///20070215
//   20080117   se incluye el esquema     
//   function damesecuencia($fuente)
   function damesecuencia($fuente,$fuente_nspname)   
   {																									//20070215
//   20080117	  $sql="select valor_default  from campos where valor_default like '%nextval%' and relname='".$fuente."'";		//20070215
	  $sql="select valor_default  from campos where valor_default like '%nextval%' and relname='".$fuente."'".	//   20080117
	       " and nspname='".$fuente_nspname."'";
      $sql_result = pg_exec($this->connection,$sql)														//20070215
                    or die("Couldn't make query damesecuencia. ".$sql );												//20070215
      $num = pg_numrows($sql_result);																	//20070215
      if ( $num == 0 ) { return "No Encontro la definicion de un menu "; }								//20070215
//   20080117      else { $Row=pg_fetch_array($sql_result, 0); return str_replace("nextval","currval",$Row["valor_default"]); } 	   								//20070215
      else { $Row=pg_fetch_array($sql_result, 0); return str_replace("nextval('","currval('".($fuente_nspname!="" ? $fuente_nspname."." : ""),$Row["valor_default"]); } 	   								//20070215      
   }																									//20070215
   
   /**
     *  LLena los diferentes arreglos en base a las tablas menus
     *  por ejemplos menus llena el arreglo camposm
     */
   function damemetadata()
   {
	  $wl=str_replace("and ",";",$this->filtro);	   
	  $wl=str_replace("or ",";",$wl);	   	  
	  $filtros_campos=explode(";",$wl);
	  $m = new class_men();   
	  $sqlarma="";     /* sql armado basado en los conceptos */  
      $mensajes = new class_men();
      if ($this->descripcion!="")
      {
          $sql="select * from forapi.menus where descripcion='".$this->descripcion."'";
      }
##      echo "sql".$sql;
      if ($this->idmenu!="")
      {
          $sql="select * ".
               ",(select count(*) from forapi.cat_usuarios_pg_group where groname='admon' and usename=current_user) as esadmon ".
               " from forapi.menus where idmenu=".$this->idmenu;
      }
      $sql_result = pg_exec($this->connection,$sql)
                    or die("Couldn't make query damemetadata2.");
      $num = pg_numrows($sql_result);
      if ( $num == 0 ) {$m->menerror("No Encontro la definicion de un menu "); die();};
      $this->camposm=pg_fetch_array($sql_result, 0);
      $this->idmenu=$this->camposm["idmenu"];
##      print_r ($this->camposm);

  $sql=" select a.*,pga.attname,pga.attrelid,pga.atttypid ".
       "	, a.esindex as indice	".
	   " ,(select pgad.adsrc from pg_attrdef as pgad where a.attnum = pgad.adnum and a.oid = pgad.adrelid) as pdefault           ".           
	   " ,(select pgt.typname from pg_type as pgt where pgt.oid = pga.atttypid ) as typname ".
           " ,(case when mh.orden is null then htmltable else mh.orden end) ordengrupo  ".
	   " from (".
       " select mc.*, pgc.oid, pgc.relname ".
		   " from forapi.menus_campos as mc".
           " , pg_class as pgc".           
	   " , pg_namespace pgn ".
           " where idmenu=".($this->camposm["menus_campos"]!=0 ? $this->camposm["menus_campos"] : $this->camposm["idmenu"]).
           " and pgc.relname  = '".$this->camposm["tabla"]."' ".
	   " and pgc.relnamespace=pgn.oid ".
	   " and pgn.nspname = '".$this->camposm["nspname"]."' ".  //20070818
           " order by htmltable,orden ) as a".           ##20070627
           " left outer join pg_attribute as pga on (a.oid = pga.attrelid and pga.attnum = cast(a.attnum as smallint))".
           " left outer join forapi.menus_htmltable as mh on (a.htmltable = mh.idhtmltable)".
           " order by ordengrupo ,a.orden "; ## 20080210
           
      $sql_result = pg_exec($this->connection,$sql)
                    or die("Couldn't make query damemetadata2. ".$sql );
      $num = pg_numrows($sql_result);
      if ( $num == 0 ) { $m->menerror("No hay campos definidos para la vista"); return; };
      $Row1 = pg_fetch_array($sql_result, 0);
	  for ($z=0; $z < $num ;$z++)
      {
			$row=pg_fetch_array($sql_result, $z);
			if ($row["attnum"]=="0") // si se cumple no es un campo de la tabla, es un campo de trabajo
				{ $row["attname"]=strtolower($row["descripcion"]); }
			$this->camposmc[$row["attname"]]=$row;     
			// checa si la vista tiene una primary key y es una secuencia			
			if ($row["indice"]=='t' && strpos($row["pdefault"],"nextval")!==false) 
			{
//				      $this->camposm["tiene_pk_serial"]==true;  // 	Se utiliza en las altas para checar que numero se
				      											//  asigno en la alta currentval
				      											//  tambien cuando muestra los campos a capturar ya que este dato no se debe de
				      											//  capturar
				      $sale=array("tiene_pk_serial" => $row["attname"]);											
				   	  $this->camposm=array_merge($this->camposm, $sale);
			}
/*		
			if ($sqlarma=="")
			{
				if ($row["fuente"]!="")
				{	
					$sqlarma="select (".$this->dame_sql_sel($row["attname"]).") as ".$row["attname"]; 
					// el campo selecte se llena cuando cambia el campo padre
					($row["fuente_campofil"]!="" && $row["fuente_evento"]==1) ?  
					$this->camposmc[$this->dame_ultimo($row["fuente_campofil"])]["esFiltroDe"]=$row["attname"] :
					$this->camposmc[$row["fuente_campofil"]]["esFiltroDe"]=""; 
				}
				else
				{	$sqlarma="select ".$row["attname"]; }				
			}
			else
			{
				if ($row["fuente"]!="")
				{	
					$sqlarma=$sqlarma.",(".$this->dame_sql_sel($row["attname"]).") as ".$row["attname"]; 
					// el campo selecte se llena cuando cambia el campo padre
					($row["fuente_campofil"]!="" && $row["fuente_evento"]==1) ?
					  $this->camposmc[$this->dame_ultimo($row["fuente_campofil"])]["esFiltroDe"]=$row["attname"] :
					  $this->camposmc[$row["fuente_campofil"]]["esFiltroDe"]=""; }
				else
				{	$sqlarma=$sqlarma.",".$row["attname"]; }				
			}
*/			
//          crea el campos esfiltro , si hay mas de un campo que depende del campo padre, este lo pone juntos separados por un ;
			($row["fuente_campofil"]!="" && $row["fuente_evento"]==1) ?
				  isset($this->camposmc[$this->dame_ultimo($row["fuente_campofil"])]["esFiltroDe"])	?
				  $this->camposmc[$this->dame_ultimo($row["fuente_campofil"])]["esFiltroDe"].=",".$row["attname"] :
				  $this->camposmc[$this->dame_ultimo($row["fuente_campofil"])]["esFiltroDe"]=$row["attname"] :
				  $this->camposmc[$row["fuente_campofil"]]["esFiltroDe"]=""; 
					  
			$wlpaso="";
			($row["fuente"]!="" && $row["fuente"]!="menus_tiempos")? $wlpaso="(".$this->dame_sql_sel($row["attname"]).") as ".$row["attname"]
			: ($row["attnum"]!="0" ? $wlpaso=$row["attname"] : $wlpaso=" '' as ".$row["descripcion"]);
				$sqlarma=="" ? $sqlarma=" select ".$wlpaso : $sqlarma.=",".$wlpaso ;
				$sqlarma.="\n";			
			$i=0;
			
			while ($i < count($filtros_campos))    // filtro que vienen desde el php
			{
	  			$pp=explode("=",$filtros_campos[$i]);
				if (trim($pp[0])==$row["attname"])				
				{
					$this->camposmc[$row["attname"]]["readonly"]="t";
					$this->camposmc[$row["attname"]]["valordefault"]=str_replace("\"","",$pp[1]);
				}

//				$i=$i+2;
				$i=$i+1;

			}
			
	  }
	  
/**   menus campos eventos  **/	  	  
/*
      $sql="select mce.idevento,mce.donde,mce.descripcion,attname ".
		   " from menus_campos_eventos as mce".
           " , pg_class as pgc".
           " , pg_attribute as pga".           
           " where idmenu=".($this->camposm["menus_campos"]!=0 ? $this->camposm["menus_campos"] : $this->camposm["idmenu"]).
           " and pgc.relname = '".$this->camposm["tabla"]."' ".
           " and pgc.oid = pga.attrelid ".
           " and pga.attnum = mce.attnum ";
*/
      $sql="select idevento,donde,descripcion, case when attname is null then ".
           " (select lower(descripcion) from forapi.menus_campos as mc where mc.idmenu =a.idmenu and mc.attnum=a.attnum) else attname end ".
           " from ( ".
           " select mce.idevento,mce.donde,mce.descripcion ".
           " ,(select attname from pg_class as pgc, pg_attribute as pga where pgc.relname = '".$this->camposm["tabla"]."' ".
           "   and pgc.oid = pga.attrelid ".
           "   and pga.attnum = mce.attnum) as attname ".
           " ,idmenu,attnum".
           " from forapi.menus_campos_eventos as mce".
           " where idmenu=".($this->camposm["menus_campos"]!=0 ? $this->camposm["menus_campos"] : $this->camposm["idmenu"]).
           " ) a ";


      $sql_result = pg_exec($this->connection,$sql)
                    or die("Couldn't make query damemetadata3. ".$sql );
      $num = pg_numrows($sql_result);
      if ($num>=1)
      {
      	$Row1 = pg_fetch_array($sql_result, 0);
	  	for ($z=0; $z < $num ;$z++)
      	{
			$row=pg_fetch_array($sql_result, $z);
			$this->camposmce[$row["attname"]][$row["idevento"]]=$row;      
      	}
  	  }

##    menus eventos  	        
      $sql="select me.idevento,me.donde,me.descripcion,me.idmenu ".
		   " from forapi.menus_eventos as me".
##    20070425   esto no funciona para menus eventos si funciona para menus campos eventos		   
##    20070425           " where idmenu=".($this->camposm["menus_campos"]!=0 ? $this->camposm["menus_campos"] : $this->camposm["idmenu"]);
           " where idmenu=".$this->camposm["idmenu"];  ##20070425
      $sql_result = pg_exec($this->connection,$sql)
                    or die("Couldn't make query damemetata4. ".$sql );
      $num = pg_numrows($sql_result);
      if ($num>=1)
      {      
      	$Row1 = pg_fetch_array($sql_result, 0);
	  	for ($z=0; $z < $num ;$z++)
      	{
			$row=pg_fetch_array($sql_result, $z);
//			$this->camposme[$row["idevento"]] [$row["donde"]]=$row;      
			$this->camposme[$row["idevento"]][$row["donde"]+1]=$row;      
      	}	  			      
  	  }
  	  
##    menus movtos
      $sql="select mm.idmovto,mm.imagen,mm.descripcion ".
		   " from forapi.menus_movtos as mm ".
           " where idmenu=".$this->camposm["idmenu"];
      $sql_result = pg_exec($this->connection,$sql)
                    or die("Couldn't make query movtos. ".$sql );
      $num = pg_numrows($sql_result);
      if ($num>=1)
      {      
      	$Row1 = pg_fetch_array($sql_result, 0);
	  	for ($z=0; $z < $num ;$z++)
      	{
			$row=pg_fetch_array($sql_result, $z);
			$this->camposmm[$row["idmovto"]]=$row;      
      	}	  			      
  	  }
  	  
  	    	  
  	  
##    menus subvistas  	  
      $sql="select msv.* ".
		   " from forapi.menus_subvistas as msv".
           " where idmenu=".$this->camposm["idmenu"].
           " order by orden ";
      $sql_result = pg_exec($this->connection,$sql)
                    or die("Couldn't make query. ".$sql );
      $num = pg_numrows($sql_result);
      if ($num>=1)
      {      
      	$Row1 = pg_fetch_array($sql_result, 0);
	  	for ($z=0; $z < $num ;$z++)
      	{
			$row=pg_fetch_array($sql_result, $z);
			$this->camposmsv[$z]=$row;      
      	}	  			      
  	  }  	  
      
##    menus htmltable  20070627
      $sql="select mht.idhtmltable,mht.descripcion ".
		   " from forapi.menus_htmltable as mht".
           " where idhtmltable IN (select htmltable from forapi.menus_campos where idmenu=".$this->camposm["idmenu"]." group by 1)";
##           " order by orden ";
      $sql_result = pg_exec($this->connection,$sql)
                    or die("Couldn't make query. ".$sql );
      $num = pg_numrows($sql_result);
      if ($num>=1)
      {      
      	$Row1 = pg_fetch_array($sql_result, 0);
	  	for ($z=0; $z < $num ;$z++)
      	{
			$row=pg_fetch_array($sql_result, $z);
			$this->camposmht[$row["idhtmltable"]]=$row;      
      	}	  			      
  	  }  	    	  
  	    	  
      /*  filtro definido en la vista */
// 20070517   contempla tablas en otros esquemas pero que estan en la misma base de datos
// 20070517	  $sqlarma=$sqlarma." from ".$this->camposm["tabla"];  
// 20070612   Lo modifique para tener por separado el from y tambien el where
// 20070612	  $sqlarma=$sqlarma." from ".($this->camposm["nspname"]!="" ? $this->camposm["nspname"]."." : "").$this->camposm["tabla"];  
	  $from=" from ".($this->camposm["nspname"]!="" ? $this->camposm["nspname"]."." : "").$this->camposm["tabla"];  
// 20070612	  $sqlarma=$sqlarma.($this->camposm["filtro"]!='' ? ' where '.$this->camposm["filtro"] : '');
	  $where=($this->camposm["filtro"]!='' ? ' where '.$this->camposm["filtro"] : '');	  
##	  echo "sqlarma".$sqlarma;
	  /*  filtro que viene en la hoja php */
	  if ($this->filtro!="")
//	  { $sqlarma=$sqlarma.(strpos($sqlarma," where")===false ? " where ".$this->filtro : " and ".$this->filtro) ; }	  
//    lo cambie porque con el anterior el problema es cuando viene un subselect ya no funcionaba porque
//		encontraba la palabra where
	  { 
##	          echo "es filtro del php".$this->filtro;
		  $wl=str_replace("\"","'",$this->filtro);
		  $where=$where.($this->camposm["filtro"]=='' ? " where ".$this->convierte_tiempo($wl) : " and ".$this->convierte_tiempo($wl)) ; 		  //2007022		  
	  }	  	  

	  $sqlarma=$sqlarma.$from.$where;
	  /*   orden definicio en la vista */
	  $sqlarma=$sqlarma.($this->camposm["orden"]!='' ? ' order by '.$this->camposm["orden"] : '');

	  /*  limite definido en las vista 
	      si la vista indica que no debe mostrar registros al inicio el limite es 0
	      esto no se cuplue si el filtro es diferente de espacio */
##	  if ($this->camposm["inicioregistros"]=='f' & $this->filtro==''  & $this->camposm["filtro"]=='') 
		$this->camposmf["fuente"]=$sqlarma;
	  if ($this->camposm["inicioregistros"]=='f' & $this->filtro==''  ) 
	     { $sqlarma=$sqlarma.' limit 0'; }
          else {
	     $sqlarma=$sqlarma.($this->camposm["limite"]!='' ? ' limit '.$this->camposm["limite"] : ''); }
	  	 //echo "<error>".$this->argumentos['movto']."</error>"; 	  
	  	  $this->camposm["fuente"]=$sqlarma;
//20070623		lo pase a soldatos.php este registro de log	  	  
//20070623      $reg= new logmenus($this->connection);
//20070623      $reg->registra($this->camposm["idmenu"],trim($from." ".$where));
//20070623      $reg=null;
	  	  
   }
   /**
   *   arma el select de un campos donde la fuente es un catalogo o sea un select dentro del html
   *   @param string $wl nombre del campo el cual va a ser seleccionado por el select
   *   @return string select del campo 
   */
   function dame_sql_sel($wl)
   {
// 20070219	   return "coalesce ((select  ".$this->camposmc[$wl]["fuente_campodes"]." || '&' || sm.".$this->camposmc[$wl]["fuente_campodep"].
// 20070219    esto lo cambie para que en vez de un & sea un = HAY QUE SUPERCHECAR ESTE PUNTO
	   return "coalesce ((select  ".$this->camposmc[$wl]["fuente_campodes"]." || '=' || sm.".$this->camposmc[$wl]["fuente_campodep"].	   
//  20070823   se modifico para manejar esquemas	   
//  20070823	            " from ".$this->camposmc[$wl]["fuente"]." as sm ".
	            " from ".($this->camposmc[$wl]["fuente_nspname"]!='' ? $this->camposmc[$wl]["fuente_nspname"]."." : "").$this->camposmc[$wl]["fuente"]." as sm ".	            
	            " where sm.".$this->camposmc[$wl]["fuente_campodep"]."=".
	            $this->camposm["tabla"].".".$wl.
	            (($this->camposmc[$wl]["fuente_campofil"]!="") ? $this->masfiltros($this->camposmc[$wl]["fuente_campofil"],$this->camposm["tabla"]) : "").
//20070626     incluir que tomara el fuentewhere	            
//20071002 checar ma�ana	            (($this->camposmc[$wl]["fuente_where"]!="") ? " and ".$this->camposmc[$wl]["fuente_where"] : "").	            //20070626
##20070201	            " order by 1),  '&' || ".$this->camposm["tabla"].".".$wl.")" ;
##20070201      Lo corregir ya que tronaba en certificacion por cuenta ya que habia mas de un registro con la mis clave
//20070219	            " group by 1 order by 1),  '&' || ".$this->camposm["tabla"].".".$wl.")" ;	            
	            " group by 1 order by 1),  '=' || ".$this->camposm["tabla"].".".$wl.")" ;  //20070219
   }
  
   /**   20070222
   *  checa si el filtro que viene se esta seleccionando un tiempo si es asi lo convierte
   *  @param  $wl  string filtro
   *  @return string   filtro ya convertido si es que tiene el esquema de tiempo
   */
   function convierte_tiempo($wl)
   {

                if (strpos($wl,"00_HOY")==true)
                {
                                $wl=str_replace("='00_HOY'"," between current_date and current_timestamp",$wl);
                }
                if (strpos($wl,"01_AYER")==true)
                {
                                $wl=str_replace("='01_AYER'"," between current_date-1 and (current_date-1) + time '23:59:59' ",$wl);
                }
                if (strpos($wl,"02_LO_QUE_VA_DE_LA_SEMANA")==true)
                {
                                $wl=str_replace("='02_LO_QUE_VA_DE_LA_SEMANA'"," between current_date - cast(EXTRACT(DOW from current_timestamp) as int) and current_timestamp",$wl);
                }
                if (strpos($wl,"03_LA_SEMANA_PASADA")==true)
                {
                                $wl=str_replace("='03_LA_SEMANA_PASADA'"," between current_date - (cast(EXTRACT(DOW from current_timestamp) as int)+7) and current_date - (cast(EXTRACT(DOW from current_date) as int)+1) + time '23:59:59'",$wl);
                }
                if (strpos($wl,"04_LO_QUE_VA_DEL_MES")==true)
                {
                                $wl=str_replace("='04_LO_QUE_VA_DEL_MES'"," between current_date - (cast(EXTRACT(day from current_timestamp) as int)-1) and current_timestamp ",$wl);
                }
                if (strpos($wl,"PASADO")===false) { } else
                {
                   $des=$this->separadescripcion($wl); 
                   $sql="select * ".
                        " from menus_tiempos as mt".
                        " where descripcion='".$des."'";
                   $sql_result = pg_exec($this->connection,$sql)
                        or die("Couldn't make query damemetata5. ".$sql );
                   $num = pg_numrows($sql_result);
                   if ($num==0)
                   {
                       return "<error>Error no encontro rango ".$wl."</error>";
                   }
                       $Row1 = pg_fetch_array($sql_result, 0);
                       $wl=str_replace("='".$des."'"," between cast((current_date - interval '".$Row1["tiempo"]." month') as date) - (cast(EXTRACT(day from (current_date - interval '".$Row1["tiempo"]." month'))  as int)-1) and  (cast((current_date - interval '".$Row1["tiempo"]." month') as date) - (cast(EXTRACT(day from (current_date - interval '".$Row1["tiempo"]." month'))  as int)-1)) + interval ' 1 month - 1 day' + time '23:59:59' ",$wl);
                }
		return $wl;

   }         

   function separadescripcion($wl)
   {
                        $filtros_c=explode("'",$wl);
                        $i=0;
                        while ($i < count($filtros_c))    // filtro que vienen desde el php
                        {
                              if (strpos($filtros_c[$i],"PASADO")>0)
                              {
                                  return $filtros_c[$i];
                              }
                              $i=$i+1;
                        }
                        return $va;
   }
    
   /**
      *  regresa el ultimo campo especifcado en un filtro
      *  @param string $wl filtro viene separa por comas si es que hay mas de un campo
      *  @return string ultimo campo del string
      */
   function dame_ultimo($wl)
   {
	   return array_pop(explode(",",$wl));
   }   

   /**
     * regresa el ultimo campo especificado el campofil
     * @param string $fuente_campofil campos filtros viene separado por comas
     * @param wltabla $wltabla recibe la tabla de la vista
     * @return string regresa el filtro armado
     */
   function masfiltros($fuente_campofil,$wltabla)
   {
	   		$va="";
//	   		echo "filtros ".$fuente_campofil;
	   		$filtros_c=explode(",",$fuente_campofil);
			$i=0;
			while ($i < count($filtros_c))    // filtro que vienen desde el php
			{
				$va=$va." and sm.".$filtros_c[$i]." = ".$wltabla.".".$filtros_c[$i];
				$i=$i+1;
			}
			return $va;
   }      

}
?>
