<?php
require_once("class_men.php");
require_once("xmlhttp_class.php");
require "../../vendor/autoload.php";
use PhpOffice\PhpSpreadsheet\IOFactory;
class reingenieria extends xmlhttp_class
{
   var $tabla="";  /* tabla o sql */
   var $nspname="";  /* esquema   20070818 */   
   var $campost=array();  /* arreglo que contiene el tipo de cada uno de los campos de la tabla */
   var $camposl=array();  /* arreglo que contiene la len  de cada uno de los campos de la tabla */
   var $camposs=array();  /* arreglo que contiene si es una secuencia de cada uno de los campos de la tabla */
   var $camposk=array();  /* arreglo que contiene si el campo es un indice */
   var $connection="";  /* tabla o sql */
   var $idmenu=0;  /* id del menu que genero */   
   var $worksheet;

   function crea_desdeexcel()
   {
	if ($this->argumentos["wl_archivo"]=="") {
    	  echo "<error>No esta definido el numero archivo </error>";
    	  return; 
        }
	if ($this->argumentos["wl_nspname"]=="") {
    	  echo "<error>No esta seleccionado en que esquema se va a crear la tabla </error>";
    	  return; 
        }
        $tieneetiquetas=false;
        $tienecampos=false;
        $reader = IOFactory::createReader('Xlsx');
        $reader->setReadDataOnly(TRUE);
        $spreadsheet = $reader->load("../../upload_ficheros/".$this->argumentos["wl_archivo"]);
        $this->worksheet = $spreadsheet->getActiveSheet();
        //echo "<error>".$worksheet->getTitle().PHP_EOL;
        foreach ($this->worksheet->getRowIterator() as $row) {
            //echo "row=".$row->getRowIndex();
            $cellIterator = $row->getCellIterator();
            $cellIterator->setIterateOnlyExistingCells(FALSE); 
            foreach ($cellIterator as $cell) {
              if ($cell->getColumn()=="A" && $cell->getValue()=="Etiquetas") {
                  $tieneetiquetas=true;
              }
              if ($cell->getColumn()=="A" && $cell->getValue()=="Campos") {
                  $tienecampos=true;
              }
              //echo $cell->getColumn().":".$cell->getValue()."-";
            }
            //echo PHP_EOL;
        }
        $this->tabla=strtolower($this->worksheet->getTitle());
        $this->nspname=strtolower($this->argumentos["wl_nspname"]);
        if (!$tieneetiquetas) {
            echo "<error>No tiene etiquetas</error>";
            return;
        }
        if ($tieneetiquetas && !$tienecampos) {
            if (!$this->crea_sincampos($this->worksheet)) return false;
        }
        echo "<error>Creo la tabla</error>";
        $this->crea_vista();
        $this->filas($this->worksheet);
        $this->obligatorios($this->worksheet);
        $this->anexardocumentos($this->worksheet);
        $this->opciones($this->worksheet);
   }


   function opciones($worksheet) {
        foreach ($worksheet->getRowIterator() as $row) {
            $cellIterator = $row->getCellIterator();
            $cellIterator->setIterateOnlyExistingCells(FALSE);
            $tienefilas=0;
            foreach ($cellIterator as $cell) {
              if ($cell->getColumn()=="A" && $cell->getValue()=="Opciones") {
                  $tienefilas=1;
              } else  {
                  if ($tienefilas==1) {
                      if ($cell->getvalue()=='si') {
                         $col=strtolower($cell->getColumn());
                         $this->crea_tablaopciones($worksheet,$col);
                         $strsql="update forapi.menus_campos set fuente_nspname='".$this->nspname."',fuente='".$this->tabla."_".$col.
                                      "',fuente_campodes='descripcion',fuente_campodep='id',altaautomatico=true where idmenu=".$this->idmenu." and attnum=".
                                      "(select attnum from forapi.campos where relname='".$this->tabla."' and nspname='".$this->nspname."' and attname='".
                                      $col."');";
                         $sql_result = @pg_exec($this->connection,$strsql);
                         if (strlen(pg_last_error($this->connection))>0) {
                             echo "<error>Error al actualizar las filas</error>";
                             error_log(parent::dame_tiempo()." src/php/reingenieria_class.php filas \n"
                                                      .pg_last_error($this->connection)."\n",3,"/var/tmp/errores.log");
                             return false;
                         }
                      }
                  }
              }

            }
        }
        return true;
   }

   function obligatorios($worksheet) {
        foreach ($worksheet->getRowIterator() as $row) {
            $cellIterator = $row->getCellIterator();
            $cellIterator->setIterateOnlyExistingCells(FALSE);
            $tienefilas=0;
            foreach ($cellIterator as $cell) {
              if ($cell->getColumn()=="A" && $cell->getValue()=="Obligatorios") {
                  $tienefilas=1;
              } else  {
                  if ($tienefilas==1) {
                      if ($cell->getvalue()=='si') {
                         $strsql="update forapi.menus_campos set obligatorio=true where idmenu=".$this->idmenu." and attnum=".
                                      "(select attnum from forapi.campos where relname='".$this->tabla."' and nspname='".$this->nspname."' and attname='".
                                      strtolower($cell->getColumn())."');";
                         $sql_result = @pg_exec($this->connection,$strsql);
                         if (strlen(pg_last_error($this->connection))>0) {
                             echo "<error>Error al actualizar las filas</error>";
                             error_log(parent::dame_tiempo()." src/php/reingenieria_class.php filas \n"
                                                      .pg_last_error($this->connection)."\n",3,"/var/tmp/errores.log");
                             return false;
                         }
                      }
                  }
              }

            }
        }
        return true;
   }

   function anexardocumentos($worksheet) {
        foreach ($worksheet->getRowIterator() as $row) {
            $cellIterator = $row->getCellIterator();
            $cellIterator->setIterateOnlyExistingCells(FALSE);
            $tienefilas=0;
            foreach ($cellIterator as $cell) {
              if ($cell->getColumn()=="A" && $cell->getValue()=="AnexarDocumentos") {
                  $tienefilas=1;
              } else  {
                  if ($tienefilas==1) {
                      if ($cell->getvalue()=='si') {
                         $strsql="update forapi.menus_campos set upload_file=true where idmenu=".$this->idmenu." and attnum=".
                                      "(select attnum from forapi.campos where relname='".$this->tabla."' and nspname='".$this->nspname."' and attname='".
                                      strtolower($cell->getColumn())."');";
                         $sql_result = @pg_exec($this->connection,$strsql);
                         if (strlen(pg_last_error($this->connection))>0) {
                             echo "<error>Error al actualizar las filas</error>";
                             error_log(parent::dame_tiempo()." src/php/reingenieria_class.php filas \n"
                                                      .pg_last_error($this->connection)."\n",3,"/var/tmp/errores.log");
                             return false;
                         }
                      }
                  }
              }

            }
        }
        return true;
   }

   function filas($worksheet) {
        foreach ($worksheet->getRowIterator() as $row) {
            $cellIterator = $row->getCellIterator();
            $cellIterator->setIterateOnlyExistingCells(FALSE);
            $tienefilas=0;
            foreach ($cellIterator as $cell) {
              if ($cell->getColumn()=="A" && $cell->getValue()=="Filas") {
                  $tienefilas=1;
              } else  {
                  if ($tienefilas==1) {
                      if ($cell->getvalue()!=='') {
                         $strsql="update forapi.menus_campos set fila=".$cell->getvalue()." where idmenu=".$this->idmenu." and attnum=".
                                      "(select attnum from forapi.campos where relname='".$this->tabla."' and nspname='".$this->nspname."' and attname='".
                                      strtolower($cell->getColumn())."');";
                         $sql_result = @pg_exec($this->connection,$strsql);
                         if (strlen(pg_last_error($this->connection))>0) {
                             echo "<error>Error al actualizar las filas</error>";
                             error_log(parent::dame_tiempo()." src/php/reingenieria_class.php filas \n"
                                                      .pg_last_error($this->connection)."\n",3,"/var/tmp/errores.log");
                             return false;
                         }
                      }
                  }
              }
             
            }
        }
        return true;
   }

   /* crea la tabla de opciones */
   function crea_tablaopciones($worksheet,$col) {
        $strsql = "drop table if exists ".$this->nspname.".".$worksheet->getTitle(). "_".$col.";".PHP_EOL;
        $strsql.= "create table ".$this->nspname.".".$worksheet->getTitle()."_".$col. "(".PHP_EOL;
        $strsql.=" descripcion varchar(100)".PHP_EOL;
        $strsql.=$this->arma_campos_fijos();
        $strsql.=");".PHP_EOL;
        $strsql.=$this->arma_secuencia_pk($worksheet->getTitle(),"_".$col);
        $sql_result = @pg_exec($this->connection,$strsql);
        if (strlen(pg_last_error($this->connection))>0) {
           echo "<error>hubo error al ejecutar el script</error>";
           error_log(parent::dame_tiempo()." src/php/reingenieria_class.php crea_tablaopciones \n".pg_last_error($this->connection)."\n",3,"/var/tmp/errores.log");
           return false;
        }
   }

   /* crea la tabla sin nombre de campos */
   function crea_sincampos($worksheet) {
        $strsql = "drop table if exists ".$this->nspname.".".$worksheet->getTitle(). ";".PHP_EOL;
        $strsql .= "create table ".$this->nspname.".".$worksheet->getTitle(). "(".PHP_EOL;
        foreach ($worksheet->getRowIterator() as $row) {
            $cellIterator = $row->getCellIterator();
            $cellIterator->setIterateOnlyExistingCells(FALSE);
            foreach ($cellIterator as $cell) {
              if ($cell->getColumn()=="A" && $cell->getValue()=="Etiquetas") {
                  $strsql.=$this->arma_campos($cellIterator);
                  $strsql.=$this->arma_campos_fijos();
                  $etiquetas=$this->arma_etiquetas($cellIterator,$worksheet->getTitle());
              }
            }
        }
        $strsql.=");".PHP_EOL;
        $strsql.=$this->arma_secuencia_pk($worksheet->getTitle());
        $strsql.=$etiquetas;
        $sql_result = @pg_exec($this->connection,$strsql);
        if (strlen(pg_last_error($this->connection))>0) {
           echo "<error>hubo error al ejecutar el script</error>";
           error_log(parent::dame_tiempo()." src/php/reingenieria_class.php crea_sincampos script \n".pg_last_error($this->connection)."\n",3,"/var/tmp/errores.log");
           return false;
        }
        return true;
   }

   function arma_etiquetas($cellIterator,$tabla) {
            $etiquetas="";
            foreach ($cellIterator as $cell) {
              if ($cell->getColumn()=="A" && $cell->getValue()=="Etiquetas") {
              } else {
                $etiquetas.=" comment on column ".$this->nspname.".".$tabla.".".$cell->getColumn()." is '".$cell->getValue()."';".PHP_EOL;
              }
            }
            return $etiquetas;
   }

   function arma_campos($cellIterator) {
            $campos="";
            foreach ($cellIterator as $cell) {
              if ($cell->getColumn()=="A" && $cell->getValue()=="Etiquetas") {
              } else {
                $col=$cell->getColumn();
                $tipo=($this->tiene_opciones($col)==true ? " integer " : " varchar(255) ");
                error_log(parent::dame_tiempo()." src/php/reingenieria_class.php arma_campos col=$col tipo=$tipo \n",3,"/var/tmp/errores.log");
                $campos.=($campos!="" ? ",".$col.$tipo : $col.$tipo).PHP_EOL;
              }
            }
            return $campos;
   }

   /* checa si una columna tiene 
      opciones 
      */
   function tiene_opciones($col) {
        $tieneopcionescol=false;
        foreach ($this->worksheet->getRowIterator() as $row) {
            $cellIterator = $row->getCellIterator();
            $cellIterator->setIterateOnlyExistingCells(FALSE);
            $tieneopcionesrow=false;
            foreach ($cellIterator as $cell) {
              if ($cell->getColumn()=="A" && $cell->getValue()=="Opciones") {
                  $tieneopcionesrow=true;
              }
              if ($cell->getColumn()==$col && $tieneopcionesrow==true && $cell->getValue()=="si") {
                  $tieneopcionescol=true;
                  error_log(parent::dame_tiempo()." src/php/reingenieria_class.php tiene_opciones col=".$col." getColumn=".$cell->getColumn()." \n",3,"/var/tmp/errores.log");
                  return $tieneopcionescol;
              }
            }
        }
        return $tieneopcionescol;
   }

   function arma_campos_fijos() {
            $strsql=",id integer not null".PHP_EOL;
            $strsql.=",fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone".PHP_EOL;
            $strsql.=",usuario_alta character varying(20) DEFAULT getpgusername()".PHP_EOL;
            $strsql.=",fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone".PHP_EOL;
            $strsql.=",usuario_modifico character varying(20) DEFAULT getpgusername()".PHP_EOL;
            return $strsql;
   }

   function arma_secuencia_pk($tabla,$col="") {
            $strsql="drop sequence if exists  ".$this->nspname.".".$tabla.$col."_id_seq cascade;".PHP_EOL;
            $strsql.="CREATE SEQUENCE ".$this->nspname.".".$tabla.$col."_id_seq".PHP_EOL;
            $strsql.="  START WITH 1 INCREMENT BY 1 CACHE 1;".PHP_EOL;
            //$strsql.="  ALTER TABLE ".$tabla."_id_seq OWNER TO postgres;".PHP_EOL;
            $strsql.="  ALTER SEQUENCE ".$this->nspname.".".$tabla.$col."_id_seq OWNED BY ".$this->nspname.".".$tabla.$col.".id".";".PHP_EOL;
            $strsql.="  ALTER TABLE ONLY ".$this->nspname.".".$tabla.$col." ALTER COLUMN id SET DEFAULT nextval('"
                                              .$this->nspname.".".$tabla.$col."_id_seq'::regclass);".PHP_EOL;
            $strsql.="  ALTER TABLE ONLY ".$this->nspname.".".$tabla.$col." ADD CONSTRAINT ".$tabla.$col."_pkey PRIMARY KEY (id);".PHP_EOL;
            return $strsql;
   }

   function copiaopcion()
   {
	if ($this->argumentos["wl_idmenu"]=="") {
    	  echo "<error>No esta definido el numero de menu</error>";
    	  return; 
    	}			   
       $sql=" select forapi.copiamenu(".$this->argumentos["wl_idmenu"].");";
       $sql_result = pg_exec($this->connection,$sql);
       if (strlen(pg_last_error($this->connection))>0) { echo "<error>Error al ejecutar ".pg_last_error($this->connection)."</error>"; }
     	echo "<error>Se copio todo el menu ".$wlidmenu."</error>";                                
   }   

/* ejecuta un script desde forappi */
   function ejecuta()
   {
        if ($this->argumentos["wl_idscript"]=="")
        {
          echo "<error>No esta definido el id del script</error>";
          return;
        }
        if ($this->argumentos["wl_sql"]=="")
        {
          echo "<error>No esta definido el sql del script</error>";
          return;
        }
        //$sql=utf8_encode($this->argumentos["wl_sql"]);
        //$sql = filter_var($this->argumentos["wl_sql"], FILTER_UNSAFE_RAW, FILTER_FLAG_STRIP_HIGH);
        //$sql = preg_replace( '/[^[:print:]]/', '',$this->argumentos["wl_sql"]);
        $sql = preg_replace('/[\x00-\x1F\x7F-\xA0\xAD]/u', '', $this->argumentos["wl_sql"]);
        $sql_result = @pg_exec($this->connection,$sql);
        if (strlen(pg_last_error($this->connection))>0) { 
             echo "<error>hubo error al ejecutar el script</error>"; 
             error_log(parent::dame_tiempo()." src/php/reingenieria_class.php error al ejecutar el script \n".pg_last_error($this->connection)."\n",3,"/var/tmp/errores.log");
             return;
        }
        echo "<error>Se ejecuto el script </error>";
   }

   function crea_vista()
   {

      $men = new class_men();
      $sql=" insert into forapi.menus(descripcion,tabla,reltype,php,nspname,table_height,table_width,table_align,columnas) ".
                   " select relname,relname,reltype,'man_menus.php',nspname,0,80,'col-lg-6',1".
           " from forapi.tablas ".
           " where relname = '".$this->tabla."' ".
           " and nspname = '".$this->nspname."'";
      $sql_result = pg_exec($this->connection,$sql)
                    or die("No se pudo ejecutar el sql1 en menus");
      $sql=" select currval('forapi.menus_idmenu_seq');";
      $sql_result = pg_exec($this->connection,$sql)
                    or die("No se pudo ejecutar el sql2 en menus");
          $row=pg_fetch_array($sql_result, 0);
      $wlidmenu=$row["currval"];
      $this->idmenu=$row["currval"];
      $sql= "select * ".
                   " from forapi.campos ".
           " where relname = '".$this->tabla."' ".
           " and nspname = '".$this->nspname."'".   //20070818
           " and attnum > 0 ";
      $sql_result = pg_exec($this->connection,$sql)
                    or die("No se pudo ejecutar el sql3 en menus");
      $num = pg_numrows($sql_result);
      if ( $num == 0 ) {$men->menerror("No tiene campos la tabla  ".$this->tabla); die();};
          for ($z=0; $z < $num ;$z++)
      {
                        $row=pg_fetch_array($sql_result, $z);
                        $sql="insert into forapi.menus_campos(idmenu ,descripcion,attnum,orden,obligatorio,readonly,esindex,tipayuda,size,tabla,nspname,male,eshidden) values (\n".
                  $wlidmenu.
                  ",'".($row["descripcion"]!="" ? $row["descripcion"] : $row["attname"])."'".
                  ",'".$row["attnum"]."'".
                  ",'".($row["attnum"]*10)."'".
                  ",".($row["attnotnull"]=='t' ? 'true' : 'false').
                  ",".($row["atthasdef"]=='t' && $row["valor_default"]!='0' ? 'true' : 'false').
                  ",".($row["indice"]>=1 ? 'true' : 'false').
                  ",'".$row["descripcion"]."'".
                  ",".$this->dame_size($row).
                  ",'".$this->tabla."'".
                  ",'".$row["nspname"]."'".
                  ",'".$row["atttypmod"]."'".
                  ",".(($row["attname"]=='fecha_alta' || $row["attname"]=='usuario_alta' || $row["attname"]=='fecha_modifico' || $row["attname"]=='usuario_modifico' || ($row["indice"]==true && strpos($row["valor_default"],"nextval")!==false)) ? 'true' : 'false' ).
                  ");\n";
                $sql_resulti = pg_exec($this->connection,$sql)
                                or die("No se pudo ejecutar el sql4 en menus: ".$sql." ".pg_last_error($this->connection));
                //error_log(parent::dame_tiempo()." src/php/reingenieria_class.php ".print_r($row,true)."\n",3,"/var/tmp/errores.log");
          }
          $sql="insert into forapi.menus_pg_group(idmenu ,groname) select ".$wlidmenu.",groname from pg_group where groname='admon'";
      $sql_resulti = pg_exec($this->connection,$sql)
                                or die("No se pudo ejecutar el sql5 en menus: ".$sql." ".pg_last_error($this->connection));

      $sql=" update forapi.menus set columnas=2 ".
           " where tabla = '".$this->tabla."' ".
           " and nspname = '".$this->nspname."'";
      $sql_result = pg_exec($this->connection,$sql)
                    or die("No se pudo ejecutar el sql1 en menus");
   } 

   function crea_menusbase()
   {
	  $this->tabla=$this->argumentos['wl_relname'];      
	  $this->nspname=$this->argumentos['wl_nspname'];      	  
      $this->crea_vista();
      echo "<error>Inserto en la base la tabla ".$this->tabla."</error>";	  
   }
   
   function baja_admon()
   {
	  $this->tabla=$this->argumentos['wl_relname'];
      $men = new class_men();
      $sql=" select 'insert into forapi.menus(".
  		   " idmenu ".
  		   ",descripcion ".
  		   ",objeto ".
  		   ", fecha_alta ".
  		   ", usuario_alta ".
  		   ", fecha_modifico ".
  		   ", usuario_modifico ".
  		   ", php ".
  		   ", modoconsulta ".
  		   ", idmenupadre ".
  		   ", idmovtos ".
  		   ", movtos ".
  		   ", fuente ".
  		   ", presentacion ".
  		   ", columnas ".
  		   ", tabla ".
  		   ", reltype ".
  		   ", filtro ".
  		   ", limite ".
  		   ", orden ".
  		   ", menus_campos ".
  		   ", dialogWidth ".
  		   ", dialogHeight ".
  		   ", s_table ".
  		   ", s_table_height ".
      	   " )\n values ( '".
		   " || idmenu \n".
  		   " || ',' || '''' || coalesce(descripcion,'') || '''' \n".
  		   " || ',' || '''' || coalesce(objeto,'')      || '''' \n".
  		   " || ',' || '''' || fecha_alta || '''' \n".
  		   " || ',' || '''' || usuario_alta || ''''  \n".
  		   " || ',' || '''' || fecha_modifico || ''''  \n".
  		   " || ',' || '''' || usuario_modifico || ''''  \n".
  		   " || ',' || '''' || coalesce(php	,'''') || ''''  \n".
  		   " || ',' || coalesce(modoconsulta,0) \n".
  		   " || ',' || coalesce(idmenupadre,0) \n".
  		   " || ',' || coalesce(idmovtos,0) \n".
  		   " || ',' || '''' || coalesce(movtos,'') || ''''  \n".
  		   " || ',' || '''' || coalesce(fuente,'') || ''''  \n".
  		   " || ',' || coalesce(presentacion,0) \n".
  		   " || ',' || coalesce(columnas,0) \n".
  		   " || ',' || '''' || coalesce(tabla,'') || ''''  \n".
##  		   " || ',' || coalesce(reltype,0) \n".
  		   " || '\n,(select t.reltype from tablas as t where t.relname=''' || menus.tabla || ''')' \n".
  		   " || ',' || '''' || coalesce(filtro,'') || ''''  \n".
  		   " || ',' || coalesce(limite,0) \n".
  		   " || ',' || '''' || coalesce(orden,'') || ''''  \n".
  		   " || ',' || coalesce(menus_campos,0) \n".
  		   " || ',' || coalesce(dialogWidth,0) \n".
  		   " || ',' || coalesce(dialogHeight,0) \n".
  		   " || ',' || coalesce(s_table,0) \n".
  		   " || ',' || coalesce(s_table_height,0) \n".
      	   " || ');\n'".		   
           " from forapi.menus where idmenu>998";
      $sql_result = pg_exec($this->connection,$sql)
                    or die("No se pudo ejecutar el sql de insertar en menus".$sql);
      $num = pg_numrows($sql_result);
      if ( $num == 0 ) {$men->menerror("No Encontro la definicion de un menu ".$sql); die();};   
      $wlarchivo1=$this->tabla."m.sql";
      $handlew = fopen($wlarchivo1, "w");
	  for ($z=0; $z < $num ;$z++)
      {      
      		$Row=pg_fetch_array($sql_result, $z);
      		if (!fwrite ($handlew,$Row[0])) {echo "error al grabar salida ".$wlarchivo1;}
	  }      		


##  		$sql="select * from menus_campos ";

      $sql=" select 'insert into forapi.menus_campos(".
##  		   "  idcampo 		     ".
  		   " idmenu 		      ".
  		   ", reltype  		    ".
  		   ", attnum 		      ".
  		   ", descripcion 	  ".
  		   ", size 			       ".
  		   ", male 			       ".
  		   ", fuente 		      ".
  		   ", fuente_campodes".
  		   ", fuente_campodep".
  		   ", fuente_campofil".
  		   ", fuente_where 			".
  		   ", fuente_evento 			".
  		   ", orden 			        ".
  		   ", idsubvista 		    ".
  		   ", dialogwidth 		   ".
  		   ", dialogheight  	  ".
  		   ", obligatorio 		   ".
  		   ", busqueda 			     ".
  		   ", altaautomatico 	 ".
  		   ", tcase 			        ".
  		   ", checaduplicidad 	".
  		   ", readonly 			     ".
  		   ", valordefault 			".
  		   ", esindex 	".
  		   ", tipayuda 	 ".
##  		   ", fecha_alta 			        ".  		   
##  		   ", usuario_alta 	".  		   
##  		   ", fecha_modifico 			     ".  		   
##  		   ", usuario_modifico 			".   		   
  		   ", espassword 	".          		     		   
      	   " )\n values (' ".
##		   " || 'coalesce((select c.attnum from campos c where c.reltype = (select t.reltype from tablas as t where t.relname=''' || me.tabla || ''')'".
##		   " || ' and c.attname = ''' || (select t.attname from campos as t where t.relname=me.tabla and t.attnum=mc.attnum) || '''),-2)'".
		   " || '\n(select idmenu from forapi.menus c where idmenu>998 and c.descripcion = ''' || me.descripcion || ''')'".
##		   " || '\n,(select c.attnum from campos c where c.reltype = (select t.reltype from tablas as t where t.relname=''' || me.tabla || '''))'".
  		   " || '\n,(select t.reltype from tablas as t where t.relname=''' || me.tabla || ''')' \n".
		   " || '\n,coalesce((select c.attnum from campos c where c.reltype = (select t.reltype from tablas as t where t.relname=''' || me.tabla || ''')'".
		   " || ' and c.attname = ''' || (select t.attname from campos as t where t.relname=me.tabla and t.attnum=mc.attnum) || '''),-2)'".
  		   " || '\n,' || '''' || coalesce(mc.descripcion,'') || '''' \n".
  		   " || ',' || coalesce(size,0) \n".
  		   " || ',' || coalesce(male,0) \n".
  		   " || ',' || '''' || coalesce(mc.fuente,'') || '''' \n".
  		   " || ',' || '''' || coalesce(mc.fuente_campodes,'') || '''' \n".
  		   " || ',' || '''' || coalesce(mc.fuente_campodep,'') || '''' \n".
  		   " || ',' || '''' || coalesce(mc.fuente_campofil,'') || '''' \n".
  		   " || ',' || '''' || coalesce(mc.fuente_where,'') || '''' \n".
  		   " || ',' || coalesce(mc.fuente_evento,0) \n".
  		   " || ',' || coalesce(mc.orden,0) \n".
  		   " || ',' || coalesce(mc.idsubvista,0) \n".
  		   " || ',' || coalesce(mc.dialogwidth,0) \n".
  		   " || ',' || coalesce(mc.dialogheight,0) \n".
  		   " || ',' || case when mc.obligatorio then '''t''' else '''f''' end \n".
  		   " || ',' || case when mc.busqueda then '''t''' else '''f''' end \n".
  		   " || ',' || case when mc.altaautomatico then '''t''' else '''f''' end \n".
  		   " || ',' || coalesce(mc.tcase,0) \n".
  		   " || ',' || case when mc.checaduplicidad then '''t''' else '''f''' end \n".
  		   " || ',' || case when mc.readonly then '''t''' else '''f''' end \n".
  		   " || ',' || '''' || coalesce(mc.valordefault,'') || '''' \n".
  		   " || ',' || case when mc.esindex then '''t''' else '''f''' end \n".
  		   " || ',' || '''' || coalesce(mc.tipayuda,'') || '''' \n".
##  		   " || ',' || '''' || mc.fecha_alta || '''' \n".
##  		   " || ',' || '''' || coalesce(mc.usuario_alta,'') || '''' \n".
##  		   " || ',' || '''' || mc.fecha_modifico || '''' \n".
##  		   " || ',' || '''' || coalesce(mc.usuario_modifico,'') || '''' \n".
  		   " || ',' || coalesce(mc.espassword,0) \n".
      	   " || ');\n'".		   
           " from forapi.menus_campos mc, forapi.menus me ".
           " where mc.idmenu=me.idmenu  and mc.idmenu>998 order by me.descripcion ";
           
           
      $sql_result = pg_exec($this->connection,$sql)
                    or die("No se pudo ejecutar el sql de insertar en menus".$sql);
      $num = pg_numrows($sql_result);
      if ( $num == 0 ) {$m->menerror("No tiene campos la tabla  "); die();};          
	  for ($z=0; $z < $num ;$z++)
      {
			$Row=pg_fetch_array($sql_result, $z);      
      		if (!fwrite ($handlew,$Row[0])) {echo "error al grabar salida ".$wlarchivo1;}			
	  }			      

      fclose($handlew);	                          
      echo "<error>creo el archivo ".$wlarchivo1."</error>";
   }
   function dame_size($row)
   {
	       $wlsize="0";
               switch ($row["attlen"])
                      {
	                      case -1:
	                      	$wlsize=(($row["atttypmod"]>30) ? 30 : $row["atttypmod"]);
	                      	break;
	                      case 1:
	                      	$wlsize="1";
	                      	break;
	                      case 2:
	                        $wlsize="4";
	                      	break;	                            
	                      case 4:
	                        $wlsize="8";
	                      	break;	                            
	                      case 8:
	                        $wlsize="18";
	                      	break;
	                      default:
	                        $wlsize="8";
              	    }
	   return $wlsize;
   }
}
	if (isset($_POST['opcion']))
	{
		session_start();
		include("conneccion.php");
		require_once("reingenieria_class.php");
		$va = new reingenieria();
		$va->connection = $connection;
		$va->argumentos = $_POST; 
		$va->funcion = $_POST['opcion'];		
		$va->procesa();		
	}
?>
