--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: forapi; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA forapi;


ALTER SCHEMA forapi OWNER TO postgres;

SET search_path = forapi, pg_catalog;

--
-- Name: menus_sql; Type: TYPE; Schema: forapi; Owner: postgres
--

CREATE TYPE menus_sql AS (
	sql text,
	ordern integer
);


ALTER TYPE forapi.menus_sql OWNER TO postgres;

--
-- Name: TYPE menus_sql; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON TYPE menus_sql IS 'type para generar los menus';


--
-- Name: alta_cat_usuarios(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION alta_cat_usuarios() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
      wlestado numeric;
      wlsi numeric;
      wlsentencia varchar(255);
      wlusuario name;
      wlpasswd varchar(20);
    BEGIN
--        select count(*) into wlsi from contra.cat_personas where id_persona=new.id_persona;
--        if (wlsi>0) then
--           select nombre,apepat,apemat into new.nombre,new.apepat,new.apemat from contra.cat_personas where id_persona=new.id_persona;
--        end if;
		select count(*) into wlsi from pg_shadow where cast(usename as text)=new.usename;
		if wlsi>0 then
		RAISE notice  ' el usuario % ya existe en la base de datos ', new.usename;
		end if;
        insert into forapi.his_cat_usuarios (usename,nombre,apepat,apemat,puesto,depto,correoe,
                    direccion_ip,idpregunta,respuesta,telefono,cve_movto)
               values (new.usename,new.nombre,new.apepat,new.apemat,new.puesto,new.depto,new.correoe,
                    new.direccion_ip,new.idpregunta,new.respuesta,new.telefono,'a');
--        insert into pg_shadow (usename,passwd,usesysid,usecreatedb,usesuper,usecatupd)
--               values (new.usename,md5(new.password),(select max(usesysid)+1 from pg_shadow), false,false,false);
		if wlsi=0 then
		RAISE NOTICE ' $wlsi % ', wlsi;
		wlusuario=new.usename;
		wlpasswd=new.password;
		RAISE NOTICE ' $wlusuario % ', wlusuario;
		RAISE NOTICE ' $wlpasswd % ', wlpasswd;
		
		wlsentencia = ' create user "' || wlusuario || '" with password ' || quote_literal(trim(wlpasswd)) || ' nocreatedb ; ';
--        insert into pg_shadow (usename,passwd,usesysid,usecreatedb,usesuper,usecatupd)
--               values (new.usename,md5(new.password),(select max(usesysid)+1 from pg_shadow), false,false,false);
		RAISE NOTICE ' $wlsentencia % ', wlsentencia;
		execute wlsentencia;
	end if;
--        new.password=md5(new.password);
--        update contra.cat_personas set usename=new.usename where id_persona=new.id_persona;
     return new;
    END;$_$;


ALTER FUNCTION forapi.alta_cat_usuarios() OWNER TO postgres;

--
-- Name: alta_cat_usuarios_pg_group(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION alta_cat_usuarios_pg_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
    BEGIN
        insert into forapi.his_cat_usuarios_pg_group (usename,grosysid,cve_movto)
               values (new.usename,new.grosysid,'a');
     return new;
    END;$$;


ALTER FUNCTION forapi.alta_cat_usuarios_pg_group() OWNER TO postgres;

--
-- Name: alta_menus(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION alta_menus() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
      wlnum numeric;
    BEGIN
        if new.tabla='' or new.tabla is null then
                --select relname,nspname into new.tabla,new.nspname from forapi.tablas where reltype=new.reltype;
                return new;
        else
                if new.reltype!=(select reltype from forapi.tablas where relname=new.tabla and nspname=new.nspname) then
                   select reltype into new.reltype from forapi.tablas where relname=new.tabla and nspname=new.nspname;
                end if;
        end if;
	select count (*) into wlnum from forapi.menus_pg_tables where tablename=new.tabla and nspname=new.nspname;
        --raise notice 'registros % tabla % nspname % ', wlnum, new.tabla, new.nspname;
	if wlnum=0 then
        --raise notice 'entro a insertar % tabla % nspname % ', wlnum, new.tabla, new.nspname;
        insert into forapi.menus_pg_tables (idmenu,tablename,tselect,tinsert,tupdate,tdelete,tall,tgrant,nspname)
               values (new.idmenu,new.tabla
                              ,case when strpos(new.movtos,'s')>0 or strpos(new.movtos,'S')>0 then 1 else 0 end
                              ,case when strpos(new.movtos,'i')>0 or strpos(new.movtos,'cc')>0 then 1 else 0 end
                              ,case when strpos(new.movtos,'u')>0 then 1 else 0 end
                              ,case when strpos(new.movtos,'d')>0 then 1 else 0 end
                              ,0
                              ,0
                              ,new.nspname);
	end if;
     return new;
    END;$$;


ALTER FUNCTION forapi.alta_menus() OWNER TO postgres;

--
-- Name: alta_menus_campos(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION alta_menus_campos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
      wlnum    numeric;
    BEGIN
        select reltype into new.reltype from forapi.menus where idmenu=new.idmenu;
        select count (*) into wlnum from forapi.campos where tabla=new.tabla and nspname=new.nspname and attname=new.descripcion  
               and valor_default like '%nextval%';
        if wlnum>0 then
           raise notice 'alta_menus_campos % % % %' , new.idmenu,new.tabla,new.descripcion,new.nspname;
           insert into forapi.menus_pg_tables (idmenu,tablename,tselect,tinsert,tupdate,tdelete,tall,tgrant,nspname)
                  values (new.idmenu,trim(new.tabla)||'_'||trim(new.descripcion)||'_seq' ,1 ,0 ,1 ,0 ,0 ,0 ,new.nspname);
        end if;
        if new.upload_file=true then
           new.readonly=true;
        end if;
     return new;
    END;$$;


ALTER FUNCTION forapi.alta_menus_campos() OWNER TO postgres;

--
-- Name: alta_menus_pg_group(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION alta_menus_pg_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
    BEGIN
        insert into forapi.his_menus_pg_group (idmenu,grosysid,cve_movto)
               values (new.idmenu,new.grosysid,'a');
     return new;
    END;$$;


ALTER FUNCTION forapi.alta_menus_pg_group() OWNER TO postgres;

--
-- Name: alta_menus_pg_tables(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION alta_menus_pg_tables() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
    BEGIN
        insert into forapi.his_menus_pg_tables (idmenu,tablename,cve_movto,tselect,tinsert,tupdate,tdelete,tall)
               values (new.idmenu,new.tablename,'a',new.tselect,new.tinsert,new.tupdate,new.tdelete,new.tall);
     return new;
    END;$$;


ALTER FUNCTION forapi.alta_menus_pg_tables() OWNER TO postgres;

--
-- Name: autoriza_usuario(text); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION autoriza_usuario(text) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$DECLARE
  mireg record;
  wlcuantos numeric;
  wlper     varchar(255);
  wlsentencia varchar(255);
  begin
--     2005-12-13  jlv modificacion ya que existian tablas sin public esto provocaba que en una tabla
--     2005-12-13      que tenia all y a su vez select al final le poonia select provocando problema de permisos
--     2007-01-08  jlv hay menus que tienen subvistas estas no se les da permisos a los usuarios, se modifico para
--                     que las subvistas las contemple para los permisos
--     2007-03-12  grecar modifique linea 55 porque faltaba espesificar un parametro
--     2007-03-23  jlv cuando no existe el esquema contra esto truena no tiene caso lo quite
--     2007-05-26  jlv lo modifique para que incluyera un esque que viene en la tabla menus_pg_tables,
--                 a esta la tabla se le agrego un campo que es el esquema
--     SET search_path to public,pg_catalog,contra;
--     grant usage on schema contra to $1;
--     wlsentencia=' grant usage on schema contra to ' ||  $1 ;    -- 2007-03-23
--     execute wlsentencia;                                          -- 2007-03-23 
--     2007-07-20  jlv lo modifique para que si la tabla viene en espacion no haga el grant
--            raise notice ' entro  % ', $1  ;
     select count(*) into wlcuantos from forapi.cat_usuarios_pg_group
            where trim(usename)=trim($1);
     if wlcuantos=0 then
        return 'No existe grupo asignado al usuario';
     end if;
     update forapi.cat_usuarios set estatus=1 where trim(usename)=trim($1);
--     for mireg  in select   mpgt.*,me.descripcion 
     for mireg  in select 
        case when (strpos(mpgt.tablename,'.')=0 and strpos(mpgt.tablename,'pg_')!=1)
	           then mpgt.nspname||'.'||mpgt.tablename else mpgt.tablename end as tablename
                   , me.descripcion
                   , sum(case when mpgt.tall='1' then 1 else 0 end) as tall
                   , sum(case when mpgt.tselect='1' then 1 else 0 end) as tselect
                   , sum(case when mpgt.tinsert='1' then 1 else 0 end) as tinsert
                   , sum(case when mpgt.tupdate='1' then 1 else 0 end) as tupdate
                   , sum(case when mpgt.tdelete='1' then 1 else 0 end) as tdelete
                   from forapi.cat_usuarios_pg_group as cupg
		   , forapi.menus_pg_tables as mpgt
                            ,forapi.menus as me
                   where trim(cupg.usename)=trim($1) 
--                   and cupg.groname = mpg.groname
                   and me.idmenu  = mpgt.idmenu
                   and me.idmenu  in ((select idmenu from forapi.menus_pg_group as mpg where
		                                  cupg.groname = mpg.groname
                                     union
				     select idsubvista from forapi.menus_subvistas as ms where
				            ms.idmenu in 
					    (select idmenu from forapi.menus_pg_group as mpg where cupg.groname = mpg.groname)
                                     --group by 1
                                     union
				     select mc.altaautomatico_idmenu from forapi.menus_campos as mc join forapi.menus_pg_group as mpg on (mc.idmenu=mpg.idmenu) where cupg.groname = mpg.groname and mc.altaautomatico_idmenu>0
				     union
				     select distinct mc.fuente_busqueda_idmenu from forapi.menus_campos as mc join forapi.menus_pg_group as mpg on (mc.idmenu=mpg.idmenu) where cupg.groname = mpg.groname and mc.fuente_busqueda_idmenu>0
				     union
				     select distinct mc.idsubvista from forapi.menus_campos as mc join forapi.menus_pg_group as mpg on (mc.idmenu=mpg.idmenu) where cupg.groname = mpg.groname and mc.idsubvista>0
				     union
				     select idsubvista from forapi.menus_subvistas as ms where
				            ms.idmenu in 
					    (select mc.idsubvista from forapi.menus_campos as mc join forapi.menus_pg_group as mpg on (mc.idmenu=mpg.idmenu) where cupg.groname = mpg.groname and mc.idsubvista>0
						union
					     select distinct mc.altaautomatico_idmenu from forapi.menus_campos as mc join forapi.menus_pg_group as mpg on (mc.idmenu=mpg.idmenu) where cupg.groname = mpg.groname and mc.altaautomatico_idmenu>0
						union
					     select distinct mc.fuente_busqueda_idmenu from forapi.menus_campos as mc join forapi.menus_pg_group as mpg on (mc.idmenu=mpg.idmenu) where cupg.groname = mpg.groname and mc.fuente_busqueda_idmenu>0)
                                     group by 1
                                     union
                                     select distinct mc2.altaautomatico_idmenu from forapi.menus_campos as mc2 where mc2.idmenu in
						(select idsubvista from forapi.menus_subvistas as ms where
							ms.idmenu in 
							(select idmenu from forapi.menus_pg_group as mpg where cupg.groname = mpg.groname)) and mc2.altaautomatico_idmenu>0
                                     union
                                     select distinct mc2.fuente_busqueda_idmenu from forapi.menus_campos as mc2 where mc2.idmenu in
						(select idsubvista from forapi.menus_subvistas as ms where
							ms.idmenu in 
							(select idmenu from forapi.menus_pg_group as mpg where cupg.groname = mpg.groname))  and mc2.fuente_busqueda_idmenu>0
					union
					select idsubvista from forapi.menus_subvistas as mss where
				            mss.idmenu in 
					    ( select idsubvista from forapi.menus_subvistas as ms where
				            ms.idmenu in 
					    (select idmenu from forapi.menus_pg_group as mpg where cupg.groname = mpg.groname))
                                     union
                                     select distinct mc2.altaautomatico_idmenu from forapi.menus_campos as mc2 where mc2.idmenu in
						(select idsubvista from forapi.menus_subvistas as mss where
				            mss.idmenu in 
					    ( select idsubvista from forapi.menus_subvistas as ms where
				            ms.idmenu in 
					    (select idmenu from forapi.menus_pg_group as mpg where cupg.groname = mpg.groname))) and mc2.altaautomatico_idmenu>0
                                     union
                                     select distinct mc2.fuente_busqueda_idmenu from forapi.menus_campos as mc2 where mc2.idmenu in
						(select idsubvista from forapi.menus_subvistas as mss where
				            mss.idmenu in 
					    ( select idsubvista from forapi.menus_subvistas as ms where
				            ms.idmenu in 
					    (select idmenu from forapi.menus_pg_group as mpg where cupg.groname = mpg.groname)))  and mc2.fuente_busqueda_idmenu>0
					union
					select idsubvista from forapi.menus_subvistas as msss where
				            msss.idmenu in 
					    (select idsubvista from forapi.menus_subvistas as mss where
				            mss.idmenu in 
					    ( select idsubvista from forapi.menus_subvistas as ms where
				            ms.idmenu in 
					    (select idmenu from forapi.menus_pg_group as mpg where cupg.groname = mpg.groname)))
                                     union
                                     select distinct mc2.altaautomatico_idmenu from forapi.menus_campos as mc2 where mc2.idmenu in
						(select idsubvista from forapi.menus_subvistas as msss where
				            msss.idmenu in 
					    (select idsubvista from forapi.menus_subvistas as mss where
				            mss.idmenu in 
					    ( select idsubvista from forapi.menus_subvistas as ms where
				            ms.idmenu in 
					    (select idmenu from forapi.menus_pg_group as mpg where cupg.groname = mpg.groname)))) and mc2.altaautomatico_idmenu>0
                                     union
                                     select distinct mc2.fuente_busqueda_idmenu from forapi.menus_campos as mc2 where mc2.idmenu in
						(select idsubvista from forapi.menus_subvistas as msss where
				            msss.idmenu in 
					    (select idsubvista from forapi.menus_subvistas as mss where
				            mss.idmenu in 
					    ( select idsubvista from forapi.menus_subvistas as ms where
				            ms.idmenu in 
					    (select idmenu from forapi.menus_pg_group as mpg where cupg.groname = mpg.groname))))  and mc2.fuente_busqueda_idmenu>0
				     ))
                   group by 1,2
                   order by 1,2
                   loop
--         mireg.sentencia=substr(mireg.sentencia,1,strpos(mireg.sentencia,'<')-1) || $1;
--         mireg.sentencia=substr(mireg.sentencia,1,strpos(mireg.sentencia,'<')-1) || $1;
         wlper='';
         wlsentencia='';
--         raise notice ' tablename % tselect % tall % ',  mireg.tablename, mireg.tselect ,
--               mireg.tall ;
           if mireg.tall>0 then
              wlper=' all ';
           else
           if mireg.tselect>0 then
              if length(trim(wlper))=0 then
                 wlper=' select ';
              else
                 wlper= wlper || ', select ';
              end if;
           end if;

           if mireg.tinsert>0 then
              if length(trim(wlper))=0 then
                 wlper=' insert ';
              else
                 wlper= wlper || ', insert ';
              end if;
           end if;

           if mireg.tupdate>0 then
              if length(trim(wlper))=0 then
                 wlper=' update ';
              else
                 wlper= wlper || ', update ';
              end if;
           end if;

           if mireg.tdelete>0 then
              if length(trim(wlper))=0 then
                 wlper=' delete ';
              else
                 wlper= wlper || ', delete ';
              end if;
           end if;
           end if;
         if trim(mireg.tablename)!='' then   -- 20070720
            wlsentencia='grant ' || trim(wlper) || '  on ' || trim(mireg.tablename) || ' to "' ||  $1 || '" with grant option ';
            --raise notice ' sentencia % %', wlsentencia,mireg.descripcion  ;
            if wlper!='' then
               execute wlsentencia;     -- 20070720
            end if;
         end if;
     end loop ;
--  20070602  incluit este for para dar permisos de uso al usuario a los esquemas
--            esquemas que no son publicos
     for mireg  in select
                   mpgt.nspname 
                   from forapi.cat_usuarios_pg_group as cupg
                   , forapi.menus_pg_tables as mpgt
                            ,forapi.menus as me
                   where trim(cupg.usename)=trim($1)
                   and me.idmenu  = mpgt.idmenu
                   and me.idmenu  in ((select idmenu from forapi.menus_pg_group as mpg where
                                                  cupg.groname = mpg.groname
                                     union
                                     select idsubvista from forapi.menus_subvistas as ms where
                                            ms.idmenu in
                                            (select idmenu from forapi.menus_pg_group as mpg where cupg.groname = mpg.groname)
                                     group by 1
                                     ))
                   group by 1
                   loop
         if mireg.nspname!='public' then
            --wlsentencia=' revoke all on schema ' || trim(mireg.nspname) || ' from ' ||  $1  || ' cascade' ;
            --execute wlsentencia;
            wlsentencia=' grant usage,create on schema ' || trim(mireg.nspname) || ' to "' ||  $1 || '" with grant option ';
            execute wlsentencia;
            --raise notice ' sentencia % ', wlsentencia  ;
            wlsentencia=' grant all PRIVILEGES on all sequences in schema ' || trim(mireg.nspname) || ' to "' ||  $1 || '" with grant option ';
            execute wlsentencia;
            --raise notice ' sentencia % ', wlsentencia  ;
         end if;
--   termina 20070602
     end loop ;

  return 'El usuario ' || $1 || ' se autorizo';
end;$_$;


ALTER FUNCTION forapi.autoriza_usuario(text) OWNER TO postgres;

--
-- Name: baja_cat_usuarios(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION baja_cat_usuarios() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
      sql      text;
      existe   numeric;
    BEGIN
        existe=0;
        insert into forapi.his_cat_usuarios (usename,nombre,apepat,apemat,puesto,depto,correoe,direccion_ip,
               idpregunta,respuesta,estatus,telefono,cve_movto)
               values (old.usename,old.nombre,old.apepat,old.apemat,old.puesto,old.depto,old.correoe,old.direccion_ip,
               old.idpregunta,old.respuesta,old.estatus,old.telefono,'b');
           sql='drop user ' || old.usename;
           execute sql ;
     return old;
    END;$$;


ALTER FUNCTION forapi.baja_cat_usuarios() OWNER TO postgres;

--
-- Name: baja_cat_usuarios_pg_group(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION baja_cat_usuarios_pg_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
    BEGIN
        insert into forapi.his_cat_usuarios_pg_group (usename,grosysid,cve_movto)
               values (old.usename,old.grosysid,'b');
     return old;
    END;$$;


ALTER FUNCTION forapi.baja_cat_usuarios_pg_group() OWNER TO postgres;

--
-- Name: baja_menus(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION baja_menus() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
    BEGIN
        insert into forapi.his_menus (
  idmenu,
  descripcion,
  objeto,
  fecha_alta,
  usuario_alta,
  fecha_modifico,
  usuario_modifico,
  php,
  modoconsulta,
  idmenupadre,
  idmovtos,
  movtos,
  fuente,
  presentacion,
  columnas,
  tabla,
  reltype,
  filtro,
  limite,
  orden,
  menus_campos,
  dialogWidth,
  dialogHeight,
  s_table,
  s_table_height,
  cvemovto
  )
  values  (
  old.idmenu,
  old.descripcion,
  old.objeto,
  old.fecha_alta,
  old.usuario_alta,
  old.fecha_modifico,
  old.usuario_modifico,
  old.php,
  old.modoconsulta,
  old.idmenupadre,
  old.idmovtos,
  old.movtos,
  old.fuente,
  old.presentacion,
  old.columnas,
  old.tabla,
  old.reltype,
  old.filtro,
  old.limite,
  old.orden,
  old.menus_campos,
  old.dialogWidth,
  old.dialogHeight,
  old.s_table,
  old.s_table_height,
  'd'
  );  
  delete from forapi.menus_campos where idmenu=old.idmenu;
  delete from forapi.menus_subvistas where idmenu=old.idmenu;
  delete from forapi.menus_pg_group where idmenu=old.idmenu;
  delete from forapi.menus_pg_tables where idmenu=old.idmenu; 
  delete from forapi.menus_eventos where idmenu=old.idmenu;   
 return old;
    END;$$;


ALTER FUNCTION forapi.baja_menus() OWNER TO postgres;

--
-- Name: baja_menus_pg_group(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION baja_menus_pg_group() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
    BEGIN
        insert into forapi.his_menus_pg_group (idmenu,grosysid,cve_movto)
               values (old.idmenu,old.grosysid,'b');
     return old;
    END;$$;


ALTER FUNCTION forapi.baja_menus_pg_group() OWNER TO postgres;

--
-- Name: baja_menus_pg_tables(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION baja_menus_pg_tables() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
    BEGIN
        insert into forapi.his_menus_pg_tables (idmenu,tablename,cve_movto,tselect,tinsert,tupdate,tdelete,tall)
               values (old.idmenu,old.tablename,'b',old.tselect,old.tinsert,old.tupdate,old.tdelete,old.tall);
     return old;
    END;$$;


ALTER FUNCTION forapi.baja_menus_pg_tables() OWNER TO postgres;

--
-- Name: cambia_menus(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION cambia_menus() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
    BEGIN
  if new.tabla!=old.tabla then
     update forapi.menus_campos set tabla=new.tabla
            where idmenu=old.idmenu;
     delete from forapi.menus_pg_tables where tablename=old.tabla and idmenu=old.idmenu;
     if new.movtos!=old.movtos then
        insert into forapi.menus_pg_tables (idmenu,tablename,tselect,tinsert,tupdate,tdelete,tall,tgrant,nspname)
               values (old.idmenu,new.tabla
                              ,case when strpos(old.movtos,'s')>0 or strpos(old.movtos,'S')>0 then 1 else 0 end
                              ,case when strpos(old.movtos,'i')>0 or strpos(old.movtos,'cc')>0 then 1 else 0 end
                              ,case when strpos(old.movtos,'u')>0 then 1 else 0 end
                              ,case when strpos(old.movtos,'d')>0 then 1 else 0 end
                              ,0
                              ,0
                              ,new.nspname);
     else
        insert into forapi.menus_pg_tables (idmenu,tablename,tselect,tinsert,tupdate,tdelete,tall,tgrant,nspname)
               values (old.idmenu,new.tabla
                              ,case when strpos(new.movtos,'s')>0 or strpos(new.movtos,'S')>0 then 1 else 0 end
                              ,case when strpos(new.movtos,'i')>0 or strpos(new.movtos,'cc')>0 then 1 else 0 end
                              ,case when strpos(new.movtos,'u')>0 then 1 else 0 end
                              ,case when strpos(new.movtos,'d')>0 then 1 else 0 end
                              ,0
                              ,0
                              ,new.nspname);
     end if;
  else
     if old.movtos!=new.movtos then
        update  forapi.menus_pg_tables set
                tselect=case when strpos(new.movtos,'s')>0 or strpos(new.movtos,'S')>0 then 1 else 0 end
                ,tinsert=case when strpos(new.movtos,'i')>0 or strpos(new.movtos,'cc')>0 then 1 else 0 end
                ,tupdate=case when strpos(new.movtos,'u')>0 then 1 else 0 end
                ,tdelete=case when strpos(new.movtos,'d')>0 then 1 else 0 end
        where idmenu=old.idmenu
              and tablename=old.tabla;
     end if;
  end if;
  if new.nspname!=old.nspname then
     update forapi.menus_campos set nspname=new.nspname
            where idmenu=old.idmenu;
  end if;
  new.usuario_modifico = getpgusername();
  new.fecha_modifico = current_timestamp;

  insert into forapi.his_menus (
  idmenu,
  descripcion,
  objeto,
  fecha_alta,
  usuario_alta,
  fecha_modifico,
  usuario_modifico,
  php,
  modoconsulta,
  idmenupadre,
  idmovtos,
  movtos,
  fuente,
  presentacion,
  columnas,
  tabla,
  reltype,
  filtro,
  limite,
  orden,
  menus_campos,
  dialogWidth,
  dialogHeight,
  s_table,
  s_table_height,
  cvemovto
  ,nspname
  )
  values  (
  old.idmenu,
  old.descripcion,
  old.objeto,
  old.fecha_alta,
  old.usuario_alta,
  old.fecha_modifico,
  old.usuario_modifico,
  old.php,
  old.modoconsulta,
  old.idmenupadre,
  old.idmovtos,
  old.movtos,
  old.fuente,
  old.presentacion,
  old.columnas,
  old.tabla,
  old.reltype,
  old.filtro,
  old.limite,
  old.orden,
  old.menus_campos,
  old.dialogWidth,
  old.dialogHeight,
  old.s_table,
  old.s_table_height,
  'u'
  ,old.nspname
  ); 
 return new;
    END;$$;


ALTER FUNCTION forapi.cambia_menus() OWNER TO postgres;

--
-- Name: cambia_menus_campos(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION cambia_menus_campos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
      wlnum    numeric;
      wlfuente_nspname  forapi.menus_campos.fuente_nspname%TYPE;
      wlfuente          forapi.menus_campos.fuente%TYPE;
    BEGIN
        if new.upload_file!=old.upload_file then
           if new.upload_file=true then
                 new.readonly=true;
           end if;
        end if;
        if new.fuente_nspname!=old.fuente_nspname then
           wlfuente_nspname=new.fuente_nspname; 
        else
           wlfuente_nspname=old.fuente_nspname; 
        end if;
        if new.fuente!=old.fuente then
           wlfuente=new.fuente; 
        else
           wlfuente=old.fuente; 
        end if;
        if (wlfuente_nspname!='' and wlfuente!='')  then
           select count (*) into wlnum from forapi.menus_pg_tables where tablename=wlfuente and nspname=wlfuente_nspname and idmenu=old.idmenu;
           raise notice 'cambio la tabla de opciones % tabla % nspname % ', wlnum, wlfuente, wlfuente_nspname;
           if wlnum=0 then
              raise notice 'entro a insertar % tabla % nspname % ', wlnum, wlfuente, wlfuente_nspname;
              insert into forapi.menus_pg_tables (idmenu,tablename,tselect,tinsert,tupdate,tdelete,tall,tgrant,nspname)
               values (old.idmenu,wlfuente ,1 ,1 ,1 ,1 ,0 ,0 ,wlfuente_nspname);
           end if;
        end if;

        
     return new;
    END;$$;


ALTER FUNCTION forapi.cambia_menus_campos() OWNER TO postgres;

--
-- Name: cambio_cat_usuarios(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION cambio_cat_usuarios() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
      wlyapuesto numeric;
      wlatl smallint;
      wlid_puesto smallint;
      wlsentencia varchar(255);
      wlcm varchar(1);
    BEGIN
        wlatl=old.atl;
        wlid_puesto=old.id_puesto;
        if old.atl!=new.atl then
	   wlatl=new.atl;
	end if;
        if old.id_puesto!=new.id_puesto then
	   wlid_puesto=new.id_puesto;
	end if;
/*
        if old.id_puesto!=new.id_puesto or old.atl!=new.atl then
	   select count(*) into wlyapuesto from forapi.cat_usuarios where atl=wlatl and id_puesto=wlid_puesto 
                  and (select titular from cat_puestos where id_puesto=wlid_puesto)=true; 
	   if wlyapuesto>0 then
              raise exception ' EL AREA O PR YA TIENE ASIGNADO EL PUESTO A OTRA PERSONA ';
	   end if;
	end if;
*/
        new.usuario_modifico = getpgusername();
        new.fecha_modifico = current_timestamp;
        insert into forapi.his_cat_usuarios (usename,nombre,apepat,apemat,puesto,depto,correoe,
                    direccion_ip,idpregunta,respuesta,telefono,cve_movto,estatus,atl,id_puesto)
               values (old.usename,old.nombre,old.apepat,old.apemat,old.puesto,old.depto,old.correoe,
                    old.direccion_ip,old.idpregunta,old.respuesta,old.telefono,'c',
		    old.estatus,old.atl,old.id_puesto);
	/*wlcm=''';
	if new.estatus=3 then
		wlsentencia='select revoca_usuario ('||wlcm||''||trim(new.usename)||''||wlcm||');';
		execute wlsentencia;
	end if;*/

     return new;
    END;$$;


ALTER FUNCTION forapi.cambio_cat_usuarios() OWNER TO postgres;

--
-- Name: cambio_menus(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION cambio_menus() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
      wlfila    numeric;
      lleva    numeric;
      mireg record;
    BEGIN
     if old.columnas!=new.columnas then
        wlfila=20;
        lleva=0;
        for mireg in select * from forapi1.menus_campos where idmenu=old.idmenu and eshidden=false
                   order by htmltable,orden
                loop
            update menus_campos set fila=wlfila where idcampo=mireg.idcampo;
            lleva=lleva+1;
            raise notice 'campo actualizado %, wlfila % columnas % ', mireg.attname, wlfila, new.columnas;
            if lleva=new.columnas then
               lleva=0;
               wlfila=wlfila+20;
            end if;
        end loop;
     end if;
     return new;
    END;$$;


ALTER FUNCTION forapi.cambio_menus() OWNER TO postgres;

--
-- Name: cambio_menus_columnas(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION cambio_menus_columnas() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
      wlfila    numeric;
      lleva    numeric;
      mireg record;
      wlclase   varchar(100);
      registros numeric;
      htmltableant numeric;
    BEGIN
     if old.columnas!=new.columnas then
        if new.columnas=1 then 
           wlclase='col-md-12';
        end if;
        if new.columnas=2 then 
           wlclase='col-md-6';
        end if;
        if new.columnas=3 then 
           wlclase='col-md-4';
        end if;
        if new.columnas=4 then 
           wlclase='col-md-3';
        end if; 
        if new.columnas=5 then 
           wlclase='col-md-2';
        end if; 
        if new.columnas=6 then 
           wlclase='col-md-2';
        end if; 
        wlfila=20;
        lleva=0;
        registros=0;
        for mireg in select * from forapi.menus_campos where idmenu=old.idmenu and eshidden=false
                   order by htmltable,orden
          loop
            if registros=0 then
               htmltableant=mireg.htmltable;
            end if;
            if htmltableant<>mireg.htmltable then
               lleva=0;
               wlfila=wlfila+20;
               htmltableant=mireg.htmltable;
            end if;
            if lleva=new.columnas then
               lleva=0;
               wlfila=wlfila+20;
            end if;
            update forapi.menus_campos set fila=wlfila,clase=wlclase where idcampo=mireg.idcampo;
            lleva=lleva+1;
            registros=registros+1;
            raise notice ' descripcion % , fila % lleva % ', mireg.descripcion, wlfila, lleva;
          end loop;
     end if;
     return new;
    END;$$;


ALTER FUNCTION forapi.cambio_menus_columnas() OWNER TO postgres;

--
-- Name: cambio_menus_pg_tables(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION cambio_menus_pg_tables() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
    BEGIN
        insert into forapi.his_menus_pg_tables (idmenu,tablename,cve_movto,tselect,tinsert,tupdate,tdelete,tall)
               values (new.idmenu,new.tablename,'c',new.tselect,new.tinsert,new.tupdate,new.tdelete,new.tall);
     return new;
    END;$$;


ALTER FUNCTION forapi.cambio_menus_pg_tables() OWNER TO postgres;

--
-- Name: copiamenu(integer); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION copiamenu(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$DECLARE
        wlatl smallint;
        wlidmenu numeric;
        v_cnt numeric;
BEGIN
--  menus
     v_cnt := 0;

    SET search_path = forapi, pg_catalog;
    create temp table menu_tmp as
    select *  from menus
    where idmenu=$1;
    select nextval('menus_idmenu_seq') into wlidmenu;
    update menu_tmp set idmenu=wlidmenu,descripcion=descripcion||' Copia'
           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    insert into menus select * from menu_tmp;
    select count(*) into v_cnt from menus_pg_tables where idmenu=wlidmenu;
    raise notice '1 encontro registros en la nueva opcion %' , v_cnt;
--  menus_campos
    create temp table menus_campos_tmp as
    select * from menus_campos
    where idmenu=$1;
    update menus_campos_tmp set idmenu=wlidmenu
           ,idcampo=(select nextval('menus_campos_idcampo_seq') from menus_campos_tmp as mct where mct.idcampo=menus_campos_tmp.idcampo)
           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    insert into menus_campos select * from menus_campos_tmp;
    select count(*) into v_cnt from menus_pg_tables where idmenu=wlidmenu;
    raise notice '2 encontro registros en la nueva opcion %' , v_cnt;

--  menus_tablas
    create temp table menus_pg_tables_tmp as
    select * from menus_pg_tables
    where idmenu=$1;
    GET DIAGNOSTICS v_cnt = ROW_COUNT;
    raise notice 'creado %' , v_cnt;
    raise notice 'idmenu % , wlidmenu %', $1, wlidmenu;
    update menus_pg_tables_tmp set idmenu=wlidmenu;
--           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
--           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    GET DIAGNOSTICS v_cnt = ROW_COUNT;
    raise notice 'actualizado %' , v_cnt;
    select count(*) into v_cnt from menus_pg_tables where idmenu=wlidmenu;
    raise notice 'encontro registros en la nueva opcion %' , v_cnt;
    insert into menus_pg_tables select * from menus_pg_tables_tmp pgtt where (select count(*) from menus_pg_tables pgt where pgt.tablename=pgtt.tablename
                                                                              and pgt.nspname=pgtt.nspname and pgt.idmenu=$1)=0;

--  menus_subvistas
    create temp table menus_subvistas_tmp as 
    select * from menus_subvistas
    where idmenu=$1;
    update menus_subvistas_tmp set idmenu=wlidmenu
           ,idmenus_subvistas=(select nextval('menus_subvistas_idmenus_subvistas_seq') from menus_subvistas as mct where mct.idmenus_subvistas=menus_subvistas_tmp.idmenus_subvistas)
           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    insert into menus_subvistas select * from menus_subvistas_tmp;


--  menus_grupos
    create temp table menus_pg_group_tmp as
    select * from menus_pg_group
    where idmenu=$1;
    update menus_pg_group_tmp set idmenu=wlidmenu
           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    insert into menus_pg_group select * from menus_pg_group_tmp;

--  menus_movtos
    create temp table menus_movtos_tmp as
    select * from menus_movtos
    where idmenu=$1;
    update menus_movtos_tmp set idmenu=wlidmenu
           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    insert into menus_movtos select * from menus_movtos_tmp;


--  menus_eventos
    create temp table menus_eventos_tmp as
    select * from menus_eventos
    where idmenu=$1;
    update menus_eventos_tmp set idmenu=wlidmenu
           ,idmenus_eventos=(select nextval('menus_eventos_idmenus_eventos_seq') from menus_eventos as mct where mct.idmenus_eventos=menus_eventos_tmp.idmenus_eventos)
           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    insert into menus_eventos select * from menus_eventos_tmp;

--  menus_campos_eventos
    create temp table menus_campos_eventos_tmp as
    select * from menus_campos_eventos
    where idmenu=$1;
    update menus_campos_eventos_tmp set idmenu=wlidmenu
           ,icv=(select nextval('menus_campos_eventos_icv_seq') from menus_campos_eventos as mct where mct.icv=menus_campos_eventos_tmp.icv)
           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    insert into menus_campos_eventos select * from menus_campos_eventos_tmp;

RETURN 'ok';
END;$_$;


ALTER FUNCTION forapi.copiamenu(integer) OWNER TO postgres;

--
-- Name: debe_cambiarpwd(text, integer); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION debe_cambiarpwd(text, integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$DECLARE
  wldias smallint;  
  begin
          SELECT coalesce((current_date-max(fecha_alta)),'0') into wldias from forapi.his_cambios_pwd cu where cu.usuario_alta=cast($1 as name);
          if wldias>$2 then
          		return 'Usuario debe cambia pwd';
          end if;
          
          return '';
end;$_$;


ALTER FUNCTION forapi.debe_cambiarpwd(text, integer) OWNER TO postgres;

--
-- Name: estatus_usuario(text); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION estatus_usuario(text) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$DECLARE
  wlestatus smallint;  
  wlmenu    smallint;  
  begin
          SELECT cu.estatus,cu.menu into wlestatus,wlmenu from pg_shadow pgs, forapi.cat_usuarios cu where pgs.usename=cast($1 as name)
                 and pgs.usename =cast(cu.usename as name);
          if wlestatus=0 then
                        return 'Tu usuario no esta autorizado';
          end if;
          
          if wlestatus=2 then
                        return 'Tu usuario esta bloqueado';
          end if;                       

          if wlestatus=3 then
                        return 'Tu usuario esta inhabilitado definitivamente';
          end if;                                           
          return wlmenu::varchar;
end;$_$;


ALTER FUNCTION forapi.estatus_usuario(text) OWNER TO postgres;

--
-- Name: gen_menu_sqlp(integer); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION gen_menu_sqlp(integer) RETURNS SETOF menus_sql
    LANGUAGE plpgsql
    AS $_$
declare
r forapi.menus_sql%rowtype;
wlnspname name;
wldescripcion varchar(100);
begin
select trim(nspname),trim(descripcion) into wlnspname,wldescripcion from forapi.menus where idmenu = $1;
for r in
select trim('delete from forapi.menus where idmenu in (select idmenu from forapi.menus where nspname=''' || coalesce(wlnspname,'') || ''' and descripcion=''' || wldescripcion || ''');'), 10 as orden
from forapi.menus where idmenu = $1
union
select 'insert into forapi.menus( descripcion, objeto, php, modoconsulta, idmenupadre, idmovtos, movtos, fuente, presentacion, columnas, tabla, reltype, filtro, limite, orden, menus_campos, dialogwidth, dialogheight, s_table, s_table_height,inicioregistros, nspname, css, imprime, limpiaralta, table_width, table_height, table_align, manual,noconfirmamovtos  ) VALUES (' || '''' ||  COALESCE(descripcion,'') || ''',''' ||  COALESCE(objeto,'') || ''','''  ||  COALESCE(php,'') || ''',' ||  COALESCE(modoconsulta,'0') || ',' || COALESCE( '(select idmenu from forapi.menus where descripcion=''' || COALESCE((select descripcion from forapi.menus where idmenu=mes.idmenupadre),'') || ''')' ,'0') || ',' ||  COALESCE(idmovtos,'0') || ',''' ||  COALESCE(movtos,'') || ''',''' ||  COALESCE(fuente,'') || ''',' ||  COALESCE(presentacion,'0') || ',' ||  COALESCE(columnas,'0') || ',''' ||  COALESCE(tabla,'') || ''',' ||  COALESCE(reltype,'0') || ',''' ||  COALESCE(replace(filtro,'''',''''''),'') || ''',' ||  COALESCE(limite,'0') || ',''' ||  COALESCE(orden,'') || ''',' ||  COALESCE(menus_campos,'0') || ',' ||  dialogwidth || ',' ||  COALESCE(dialogheight,'0') || ',' ||  COALESCE(s_table,'0') || ',' ||  COALESCE(s_table_height,'0') || ',' ||  COALESCE(inicioregistros,'0') || ',''' ||  COALESCE(nspname,'') || ''',''' ||  COALESCE(css,'') || ''',' ||  COALESCE(imprime,'0') || ',' ||  COALESCE(limpiaralta,'0') || ',' ||  COALESCE(table_width,'0') || ',' ||  COALESCE(table_height,'0') || ',''' ||  COALESCE(table_align,'') || ''',''' ||  COALESCE(manual,'') || ''',''' || COALESCE(noconfirmamovtos,'') || ''');' , 20 as orden from forapi.menus as mes where idmenu = $1
union
select 'insert into forapi.menus_pg_group (idmenu,groname) values(' || '(select idmenu from forapi.menus where nspname=''' || coalesce(wlnspname,'') || ''' and descripcion=''' || wldescripcion || ''')' || ',''' || COALESCE(groname,'') || ''');'  , 30 as orden
 from  forapi.menus_pg_group as mpg
where idmenu =$1
-- and (select groname from pg_group where pg_group.grosysid=mpg.grosysid)='admon'
union
select
'INSERT INTO forapi.menus_eventos( idmenu, idevento, donde, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) VALUES (' ||  '(select idmenu from forapi.menus where nspname=''' || wlnspname || ''' and descripcion=''' || wldescripcion || ''')'  || ',' ||  idevento  || ',' ||  donde || ',''' ||  COALESCE(descripcion,'') || ''',''' || fecha_alta || ''',''' ||  COALESCE(usuario_alta,'') || ''',''' ||  fecha_modifico || ''',''' ||  COALESCE(usuario_modifico,'') || '''' || ');'  , 40 as orden from forapi.menus_eventos where idmenu=$1
union
select
'insert into forapi.menus_subvistas( idmenu, texto, imagen, idsubvista, funcion, dialogwidth, dialogheight, esboton, donde, eventos_antes, eventos_despues, campo_filtro, valor_padre, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico, clase, posicion, orden, ventana) VALUES (' || '(select idmenu from forapi.menus where nspname=''' || wlnspname || ''' and descripcion=''' || wldescripcion || ''')' || ',''' ||  COALESCE(texto,'') || ''',''' ||  COALESCE(imagen,'') || ''',' ||  
            '(select idmenu from forapi.menus where descripcion=''' || COALESCE((select descripcion from forapi.menus where idmenu=idsubvista),'') || ''')' || ',''' ||  COALESCE(funcion,'') || ''',' || COALESCE(dialogwidth,'0') || ',' || COALESCE(dialogheight,'0') || ',' ||  COALESCE(esboton,'0') || ',' ||  COALESCE(donde,'0') || ',''' ||  COALESCE(eventos_antes,'') || ''',''' ||  COALESCE(eventos_despues,'') || ''',''' ||  COALESCE(campo_filtro,'') || ''',''' ||  COALESCE(valor_padre,'') || ''',current_date,current_user,null,' || 'null,''' ||  COALESCE(clase,'') || ''',' ||  COALESCE(posicion,'0') || ',' ||  COALESCE(orden,'0') || ',' ||  COALESCE(ventana,'0') || ');'   , 40 as orden
	from forapi.menus_subvistas as ms where idmenu=$1
union
select
'INSERT INTO forapi.menus_movtos( idmenu, idmovto, descripcion, imagen) VALUES (' || '(select idmenu from forapi.menus where nspname=''' || wlnspname || ''' and descripcion=''' || COALESCE(wldescripcion,'') || ''')' || ',''' || COALESCE(idmovto,'') || ''',''' || COALESCE(descripcion,'') || ''',''' || COALESCE(imagen,'') || ''');'  , 50 as orden
from forapi.menus_movtos where idmenu=$1

union
select 
'INSERT INTO forapi.menus_campos( idmenu, reltype, attnum, descripcion, size, male, fuente, fuente_campodes, fuente_campodep, fuente_campofil, fuente_where, fuente_evento, orden, idsubvista, dialogwidth, dialogheight, obligatorio, busqueda, altaautomatico, tcase, checaduplicidad, readonly, valordefault, esindex, tipayuda, espassword, tabla, nspname, fuente_busqueda, val_particulares, htmltable, fuente_nspname, altaautomatico_idmenu, fuente_busqueda_idmenu, upload_file, formato_td, colspantxt, rowspantxt, autocomplete, imprime, totales, cambiarencambios, link_file, fuente_info, fuente_info_idmenu, fuente_actu, fuente_actu_idmenu,eshidden) VALUES (' ||
            '(select idmenu from forapi.menus where nspname=''' || wlnspname || ''' and descripcion=''' || wldescripcion || ''')' || ',' ||  COALESCE(reltype,'0') || ',' ||  'COALESCE((select attnum from forapi.campos where nspname=''' || wlnspname || ''' and relname=''' || tabla || ''' and attname=''' || COALESCE((select attname from forapi.campos where campos.nspname=wlnspname and campos.relname=menus_campos.tabla and campos.attnum=menus_campos.attnum),'') || '''),''0'')' || ',''' ||  COALESCE(descripcion,'') || ''',' ||  COALESCE(size,'0') || ',' ||  COALESCE(male,'0') || ',''' ||  COALESCE(fuente,'') || ''',''' ||  COALESCE(fuente_campodes,'') || ''',''' ||  COALESCE(fuente_campodep,'') || ''',''' ||  COALESCE(fuente_campofil,'') || ''',''' ||  COALESCE( fuente_where,'') || ''',' ||  COALESCE(fuente_evento,'0') || ',' ||  COALESCE(orden,'0') || ',' ||  COALESCE(idsubvista,'0') || ',' ||  COALESCE(dialogwidth,'0') || ',' ||  COALESCE( dialogheight,'0') || ',' ||  COALESCE(obligatorio,'0') || ',' ||  COALESCE(busqueda,'0') || ',' ||  COALESCE(altaautomatico,'0') || ',' ||  COALESCE(tcase,'0') || ',' ||  COALESCE(checaduplicidad,'f') || ',' ||  COALESCE(readonly,'0') || ',''' ||  COALESCE(valordefault,'') || ''',' ||  COALESCE(esindex,'0') || ',''' ||  COALESCE(tipayuda,'') || ''',' || COALESCE(espassword,'0') || ',''' ||  COALESCE(tabla,'') || ''',''' ||  COALESCE(nspname,'') || ''',' ||  COALESCE(fuente_busqueda,'0') || ',''' ||  COALESCE(val_particulares,'') || ''',' ||  COALESCE(htmltable,'0') || ',''' ||  COALESCE(fuente_nspname,'0') || ''',' ||  COALESCE(altaautomatico_idmenu,'0') || ',' ||  COALESCE(fuente_busqueda_idmenu,'0') || ',' ||  COALESCE(upload_file,'0') || ',' ||  COALESCE( formato_td,'0') || ',' ||  COALESCE(colspantxt,'0') || ',' ||  COALESCE(rowspantxt,'0') || ',' ||  COALESCE(autocomplete,'0') || ',' ||  COALESCE(imprime,'0') || ',' ||  COALESCE(totales,'0') || ',' ||  COALESCE(cambiarencambios,'0') || ',' || COALESCE(link_file,'0') || ',' ||  COALESCE(fuente_info,'0') || ',' ||  COALESCE(fuente_info_idmenu,'0') || ',' ||  COALESCE(fuente_actu,'0') || ',' ||  COALESCE(fuente_actu_idmenu,'0') || ',' || COALESCE(eshidden,'0') || ');', 60+attnum as orden from forapi.menus_campos where idmenu=$1
union
select
'INSERT INTO forapi.menus_campos_eventos( attnum, idmenu, idevento, donde, descripcion) VALUES (' || attnum || ',' || '(select idmenu from forapi.menus where nspname=''' || wlnspname || ''' and descripcion=''' || wldescripcion || ''')' || ',' || idevento || ',' || donde || ',''' || descripcion || ''');' , 310 as orden from forapi.menus_campos_eventos where idmenu=$1
            union
select 'INSERT INTO forapi.menus_pg_tables( idmenu, tablename, tselect, tinsert, tupdate, tdelete, tall, tgrant,  nspname) VALUES (' || '(select idmenu from forapi.menus where nspname=''' || wlnspname || ''' and descripcion=''' || wldescripcion || ''')' || ',''' || tablename || ''',''' || COALESCE(tselect,'0') || ''',''' || COALESCE(tinsert,'0') || ''',''' ||  COALESCE(tupdate,'0') || ''',''' || COALESCE(tdelete,'0') || ''',''' || COALESCE(tall,'0') || ''',''' || COALESCE(tgrant,'0') || ''','''  || nspname || ''');' , 400 as orden
from forapi.menus_pg_tables where idmenu=$1 order by orden
 loop
return next r;
end loop;
return;

end;

$_$;


ALTER FUNCTION forapi.gen_menu_sqlp(integer) OWNER TO postgres;

--
-- Name: gen_menu_todo(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION gen_menu_todo() RETURNS SETOF menus_sql
    LANGUAGE plpgsql
    AS $_$
declare
r forapi.menus_sql%rowtype;
wlnspname name;
wldescripcion varchar(100);
begin
--select trim(nspname),trim(descripcion) into wlnspname,wldescripcion from forapi.menus where idmenu = $1;
for r in
select trim('delete from forapi.menus where idmenu in (select idmenu from forapi.menus where nspname=''' || coalesce(nspname,'') || ''' and descripcion=''' || descripcion || ''');'), 10 as orden,0 as idmenupadre
from forapi.menus where (nspname = 'forapi' or (nspname='pg_catalog' and tabla='pg_authid'))
union all
select * from (
select 'insert into forapi.menus( descripcion, objeto, php, modoconsulta, idmenupadre, idmovtos, movtos, fuente, presentacion, columnas, tabla, reltype, filtro, limite, orden, menus_campos, dialogwidth, dialogheight, s_table, s_table_height,inicioregistros, nspname, css, imprime, limpiaralta, table_width, table_height, table_align, manual,noconfirmamovtos  ) VALUES (' || '''' ||  COALESCE(descripcion,'') || ''',''' ||  COALESCE(objeto,'') || ''','''  ||  COALESCE(php,'') || ''',' ||  COALESCE(modoconsulta,'0') || ',' || COALESCE( 'coalesce((select idmenu from forapi.menus where descripcion=''' || COALESCE((select descripcion from forapi.menus where idmenu=mes.idmenupadre),'') || '''),0)' ,'0') || ',' ||  COALESCE(idmovtos,'0') || ',''' ||  COALESCE(movtos,'') || ''',''' ||  COALESCE(fuente,'') || ''',' ||  COALESCE(presentacion,'0') || ',' ||  COALESCE(columnas,'0') || ',''' ||  COALESCE(tabla,'') || ''',' ||  COALESCE(reltype,'0') || ',''' ||  COALESCE(replace(filtro,'''',''''''),'') || ''',' ||  COALESCE(limite,'0') || ',''' ||  COALESCE(orden,'') || ''',' ||  COALESCE(menus_campos,'0') || ',' ||  dialogwidth || ',' ||  COALESCE(dialogheight,'0') || ',' ||  COALESCE(s_table,'0') || ',' ||  COALESCE(s_table_height,'0') || ',' ||  COALESCE(inicioregistros,'0') || ',''' ||  COALESCE(nspname,'') || ''',''' ||  COALESCE(css,'') || ''',' ||  COALESCE(imprime,'0') || ',' ||  COALESCE(limpiaralta,'0') || ',' ||  COALESCE(table_width,'0') || ',' ||  COALESCE(table_height,'0') || ',''' ||  COALESCE(table_align,'') || ''',''' ||  COALESCE(manual,'') || ''',''' || COALESCE(noconfirmamovtos,'') || ''');' , 20 as orden, idmenupadre from forapi.menus as mes where (nspname = 'forapi' or (nspname='pg_catalog' and tabla='pg_authid')) ) a
union all
select 'insert into forapi.menus_pg_group (idmenu,groname) values(' || '(select idmenu from forapi.menus where nspname=''' || coalesce(nspname,'') || ''' and descripcion=''' || descripcion || ''')' || ',''' || COALESCE(groname,'') || ''');'  , 30 as orden,0 as idmenupadre
 from  forapi.menus_pg_group as mpg , forapi.menus m where mpg.idmenu=m.idmenu and (m.nspname = 'forapi' or (m.nspname='pg_catalog' and m.tabla='pg_authid'))
-- and (select groname from pg_group where pg_group.grosysid=mpg.grosysid)='admon'
union all
select
'INSERT INTO forapi.menus_eventos( idmenu, idevento, donde, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) VALUES (' ||  '(select idmenu from forapi.menus where nspname=''' || m.nspname || ''' and descripcion=''' || m.descripcion || ''')'  || ',' ||  idevento  || ',' ||  donde || ',''' ||  COALESCE(me.descripcion,'') || ''',''' || me.fecha_alta || ''',''' ||  COALESCE(me.usuario_alta,'') || ''',''' ||  me.fecha_modifico || ''',''' ||  COALESCE(me.usuario_modifico,'') || '''' || ');'  , 40 as orden,0 as idmenupadre from forapi.menus_eventos me, forapi.menus m where me.idmenu=m.idmenu and (m.nspname = 'forapi' or (m.nspname='pg_catalog' and m.tabla='pg_authid'))
union all
select
'insert into forapi.menus_subvistas( idmenu, texto, imagen, idsubvista, funcion, dialogwidth, dialogheight, esboton, donde, eventos_antes, eventos_despues, campo_filtro, valor_padre, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico, clase, posicion, orden, ventana) VALUES (' || '(select idmenu from forapi.menus where nspname=''' || m.nspname || ''' and descripcion=''' || m.descripcion || ''')' || ',''' ||  COALESCE(texto,'') || ''',''' ||  COALESCE(imagen,'') || ''',' ||  
            'coalesce((select idmenu from forapi.menus where descripcion=''' || COALESCE((select descripcion from forapi.menus where idmenu=idsubvista),'') || '''),0)' || ',''' ||  COALESCE(funcion,'') || ''',' || COALESCE(ms.dialogwidth,'0') || ',' || COALESCE(ms.dialogheight,'0') || ',' ||  COALESCE(esboton,'0') || ',' ||  COALESCE(donde,'0') || ',''' ||  COALESCE(eventos_antes,'') || ''',''' ||  COALESCE(eventos_despues,'') || ''',''' ||  COALESCE(campo_filtro,'') || ''',''' ||  COALESCE(valor_padre,'') || ''',current_date,current_user,null,' || 'null,''' ||  COALESCE(clase,'') || ''',' ||  COALESCE(posicion,'0') || ',' ||  COALESCE(ms.orden,'0') || ',' ||  COALESCE(ventana,'0') || ');'   , 40 as orden,0 as idmenupadre
	from forapi.menus_subvistas as ms, forapi.menus m where ms.idmenu=m.idmenu and (m.nspname = 'forapi' or (m.nspname='pg_catalog' and m.tabla='pg_authid'))
union all
select
'INSERT INTO forapi.menus_movtos( idmenu, idmovto, descripcion, imagen) VALUES (' || '(select idmenu from forapi.menus where nspname=''' || m.nspname || ''' and descripcion=''' || COALESCE(m.descripcion,'') || ''')' || ',''' || COALESCE(idmovto,'') || ''',''' || COALESCE(mm.descripcion,'') || ''',''' || COALESCE(imagen,'') || ''');'  , 50 as orden ,0 as idmenupadre
from forapi.menus_movtos mm, forapi.menus m where mm.idmenu=m.idmenu and (m.nspname = 'forapi' or (m.nspname='pg_catalog' and m.tabla='pg_authid'))
union all
select 
'INSERT INTO forapi.menus_campos( idmenu, reltype, attnum, descripcion, size, male, fuente, fuente_campodes, fuente_campodep, fuente_campofil, fuente_where, fuente_evento, orden, idsubvista, dialogwidth, dialogheight, obligatorio, busqueda, altaautomatico, tcase, checaduplicidad, readonly, valordefault, esindex, tipayuda, espassword, tabla, nspname, fuente_busqueda, val_particulares, htmltable, fuente_nspname, altaautomatico_idmenu, fuente_busqueda_idmenu, upload_file, formato_td, colspantxt, rowspantxt, autocomplete, imprime, totales, cambiarencambios, link_file, fuente_info, fuente_info_idmenu, fuente_actu, fuente_actu_idmenu,eshidden) VALUES (' ||
            '(select idmenu from forapi.menus where nspname=''' || m.nspname || ''' and descripcion=''' || m.descripcion || ''')' || ',' ||  COALESCE(mc.reltype,'0') || ',' ||  'COALESCE((select attnum from forapi.campos where nspname=''' || m.nspname || ''' and relname=''' || mc.tabla || ''' and attname=''' || COALESCE((select attname from forapi.campos where campos.nspname=m.nspname and campos.relname=mc.tabla and campos.attnum=mc.attnum),'') || '''),''0'')' || ',''' ||  COALESCE(mc.descripcion,'') || ''',' ||  COALESCE(size,'0') || ',' ||  COALESCE(male,'0') || ',''' ||  COALESCE(mc.fuente,'') || ''',''' ||  COALESCE(fuente_campodes,'') || ''',''' ||  COALESCE(fuente_campodep,'') || ''',''' ||  COALESCE(fuente_campofil,'') || ''',''' ||  COALESCE( fuente_where,'') || ''',' ||  COALESCE(fuente_evento,'0') || ',' ||  COALESCE(mc.orden,'0') || ',' ||  COALESCE(idsubvista,'0') || ',' ||  COALESCE(mc.dialogwidth,'0') || ',' ||  COALESCE( mc.dialogheight,'0') || ',' ||  COALESCE(obligatorio,'0') || ',' ||  COALESCE(busqueda,'0') || ',' ||  COALESCE(altaautomatico,'0') || ',' ||  COALESCE(tcase,'0') || ',' ||  COALESCE(checaduplicidad,'f') || ',' ||  COALESCE(readonly,'0') || ',''' ||  COALESCE(valordefault,'') || ''',' ||  COALESCE(esindex,'0') || ',''' ||  COALESCE(tipayuda,'') || ''',' || COALESCE(espassword,'0') || ',''' ||  COALESCE(mc.tabla,'') || ''',''' ||  COALESCE(mc.nspname,'') || ''',' ||  COALESCE(fuente_busqueda,'0') || ',''' ||  COALESCE(val_particulares,'') || ''',' ||  COALESCE(htmltable,'0') || ',''' ||  COALESCE(fuente_nspname,'0') || ''',' ||  COALESCE(altaautomatico_idmenu,'0') || ',' ||  COALESCE(fuente_busqueda_idmenu,'0') || ',' ||  COALESCE(upload_file,'0') || ',' ||  COALESCE( formato_td,'0') || ',' ||  COALESCE(colspantxt,'0') || ',' ||  COALESCE(rowspantxt,'0') || ',' ||  COALESCE(autocomplete,'0') || ',' ||  COALESCE(mc.imprime,'0') || ',' ||  COALESCE(totales,'0') || ',' ||  COALESCE(cambiarencambios,'0') || ',' || COALESCE(link_file,'0') || ',' ||  COALESCE(fuente_info,'0') || ',' ||  COALESCE(fuente_info_idmenu,'0') || ',' ||  COALESCE(fuente_actu,'0') || ',' ||  COALESCE(fuente_actu_idmenu,'0') || ',' || COALESCE(eshidden,'0') || ');', 60+attnum as orden,0 as idmenupadre from forapi.menus_campos mc,forapi.menus m where mc.idmenu=m.idmenu and (m.nspname = 'forapi' or (m.nspname='pg_catalog' and m.tabla='pg_authid'))
union all
select
'INSERT INTO forapi.menus_campos_eventos( attnum, idmenu, idevento, donde, descripcion) VALUES (' || attnum || ',' || '(select idmenu from forapi.menus where nspname=''' || m.nspname || ''' and descripcion=''' || m.descripcion || ''')' || ',' || idevento || ',' || donde || ',''' || me.descripcion || ''');' , 310 as orden,0 as idmenupadre from forapi.menus_campos_eventos me, forapi.menus m where me.idmenu=m.idmenu and (m.nspname = 'forapi' or (m.nspname='pg_catalog' and m.tabla='pg_authid'))
            union
select 'INSERT INTO forapi.menus_pg_tables( idmenu, tablename, tselect, tinsert, tupdate, tdelete, tall, tgrant,  nspname) VALUES (' || '(select idmenu from forapi.menus where nspname=''' || m.nspname || ''' and descripcion=''' || m.descripcion || ''')' || ',''' || tablename || ''',''' || COALESCE(tselect,'0') || ''',''' || COALESCE(tinsert,'0') || ''',''' ||  COALESCE(tupdate,'0') || ''',''' || COALESCE(tdelete,'0') || ''',''' || COALESCE(tall,'0') || ''',''' || COALESCE(tgrant,'0') || ''','''  || mt.nspname || ''');' , 400 as orden,0 as idmenupadre
from forapi.menus_pg_tables mt , forapi.menus m where mt.idmenu=m.idmenu and (m.nspname = 'forapi' or (m.nspname='pg_catalog' and m.tabla='pg_authid'))
union all
select
'update forapi.menus_subvistas ms set idsubvista=' || 'coalesce((select idmenu from forapi.menus where descripcion=''' || COALESCE((select descripcion from forapi.menus where idmenu=ms.idsubvista),'') || '''),'''') where idmenu=' || '(select idmenu from forapi.menus where nspname=''' || m.nspname || ''' and descripcion=''' || m.descripcion 
            || ''');', 500 as orden,0 as idmenu  from forapi.menus_subvistas as ms, forapi.menus m where ms.idmenu=m.idmenu and (m.nspname = 'forapi' or (m.nspname='pg_catalog' and m.tabla='pg_authid'))
and ms.idsubvista!=0
 order by orden, idmenupadre
 loop
return next r;
end loop;
return;

end;

$_$;


ALTER FUNCTION forapi.gen_menu_todo() OWNER TO postgres;

--
-- Name: grababitacora(integer, integer, integer, integer, date, date, text); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION grababitacora(integer, integer, integer, integer, date, date, text) RETURNS text
    LANGUAGE plpgsql
    AS $_$
DECLARE
  wlestado numeric;
  aoutput  text;
  begin
   if $1 = 0 then
--      raise notice ' antes de insert %, fecha inicial % ', $7,$5;
--      aoutput := ' insert into cat_bitacora (idproceso,fecha_inicio,fecha_fin,at_inicio,at_fin,descripcion) ' ||
--         ' values (' || $2 || ',''' || $5 || ''',''' || $6 || ''',' ||
--            $3 || ',' || $4 || ',''' || $7 || ''');' ;
--      raise notice ' va a ejecutar insert % ', aoutput;
--      execute aoutput;
        insert into forapi.cat_bitacora (idproceso,fecha_inicio,fecha_fin,at_inicio,at_fin,descripcion) 
          values ( $2 , $5 , $6, $3 , $4 , $7 );
--      raise notice ' va a ejecutar insert % ', aoutput;
      select currval('forapi.cat_bitacora_idbitacora_seq') into wlestado;
   else
      if $7 <> '' then
          update forapi.cat_bitacora set estado=1, descripcion=$7
             where idbitacora=$1;
      else
          update forapi.cat_bitacora set estado=1
             where idbitacora=$1;
      end if;
   end if;
--  commit transaction;
  return wlestado;
  end;$_$;


ALTER FUNCTION forapi.grababitacora(integer, integer, integer, integer, date, date, text) OWNER TO postgres;

--
-- Name: tiene_grupo(text); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION tiene_grupo(text) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$DECLARE
  wlcuantos numeric;
  begin
     select count(*) into wlcuantos from cat_usuarios_pg_group where 
             trim(usename)=trim($1);
  return wlcuantos;
end;$_$;


ALTER FUNCTION forapi.tiene_grupo(text) OWNER TO postgres;

--
-- Name: up_usuario_fecha(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION up_usuario_fecha() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
      new.usuario_modifico = getpgusername();
      new.fecha_modifico = current_timestamp(0);
     return new;
    END;$$;


ALTER FUNCTION forapi.up_usuario_fecha() OWNER TO postgres;

--
-- Name: usuario_bloqueado(text); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION usuario_bloqueado(text) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$DECLARE
  wlcuantos numeric;
  begin
     select count(*) into wlcuantos from cat_usuarios where estatus=2
            and trim(usename)=trim($1);
  return wlcuantos;
end;$_$;


ALTER FUNCTION forapi.usuario_bloqueado(text) OWNER TO postgres;

--
-- Name: valida_res_des(text, text); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE FUNCTION valida_res_des(text, text) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$DECLARE
  wlcuantos numeric;
  begin
     select count(*) into wlcuantos from cat_usuarios where respuesta=$2
            and trim(usename)=trim($1);
  return wlcuantos;
end;$_$;


ALTER FUNCTION forapi.valida_res_des(text, text) OWNER TO postgres;

--
-- Name: campos; Type: VIEW; Schema: forapi; Owner: postgres
--

CREATE VIEW campos AS
    SELECT pgc.relname, pga.attrelid, pga.attname, pga.atttypid, pga.attstattarget, pga.attlen, pga.attnum, pga.attndims, pga.attcacheoff, pga.atttypmod, pga.attbyval, pga.attstorage, pga.attalign, pga.attnotnull, pga.atthasdef, pga.attisdropped, pga.attislocal, pga.attinhcount, pgt.typname, pgc.relname AS fuente, pgc.oid AS reltype, pgc.relname AS tabla, (SELECT pgad.adsrc FROM pg_attrdef pgad WHERE ((pga.attnum = pgad.adnum) AND (pgc.oid = pgad.adrelid))) AS valor_default, (SELECT count(*) AS count FROM pg_index pgi WHERE (((pgc.oid = pgi.indrelid) AND (pgi.indisunique = true)) AND ((((pgi.indkey[0] = pga.attnum) OR (pgi.indkey[1] = pga.attnum)) OR (pgi.indkey[2] = pga.attnum)) OR (pgi.indkey[3] = pga.attnum)))) AS indice, (SELECT pg_description.description FROM pg_description WHERE ((pg_description.objoid = pgc.oid) AND (pg_description.objsubid = pga.attnum))) AS descripcion, pgn.nspname, pgn.nspname AS fuente_nspname FROM pg_class pgc, pg_attribute pga, pg_type pgt, pg_namespace pgn WHERE (((pgc.oid = pga.attrelid) AND (pgt.oid = pga.atttypid)) AND (pgc.relnamespace = pgn.oid)) ORDER BY pga.attnum;


ALTER TABLE forapi.campos OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cat_bitacora; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE cat_bitacora (
    idbitacora integer DEFAULT nextval(('forapi.cat_bitacora_idbitacora_seq'::text)::regclass),
    idproceso integer,
    fecha_inicio date,
    fecha_fin date,
    at_inicio smallint,
    at_fin smallint,
    estado smallint DEFAULT 0,
    descripcion text,
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp without time zone,
    usuario_alta name DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp without time zone,
    usuario_modifico name DEFAULT getpgusername()
);


ALTER TABLE forapi.cat_bitacora OWNER TO postgres;

--
-- Name: cat_bitacora_idbitacora_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE cat_bitacora_idbitacora_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.cat_bitacora_idbitacora_seq OWNER TO postgres;

--
-- Name: cat_bitacora_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE cat_bitacora_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE forapi.cat_bitacora_seq OWNER TO postgres;

--
-- Name: cat_preguntas; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE cat_preguntas (
    idpregunta integer DEFAULT nextval(('forapi.cat_preguntas_idpregunta_seq'::text)::regclass),
    descripcion character varying(100),
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico name DEFAULT getpgusername()
);


ALTER TABLE forapi.cat_preguntas OWNER TO postgres;

--
-- Name: cat_preguntas_idpregunta_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE cat_preguntas_idpregunta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.cat_preguntas_idpregunta_seq OWNER TO postgres;

--
-- Name: cat_preguntas_seq; Type: SEQUENCE; Schema: forapi; Owner: inicio
--

CREATE SEQUENCE cat_preguntas_seq
    START WITH 100
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE forapi.cat_preguntas_seq OWNER TO inicio;

--
-- Name: cat_usuarios; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE cat_usuarios (
    usename name NOT NULL,
    nombre character varying(30),
    apepat character varying(30),
    apemat character varying(30),
    puesto character varying(50),
    depto character varying(50),
    correoe character varying(50),
    direccion_ip numeric(20,0),
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    usuario_modifico name DEFAULT getpgusername(),
    idpregunta smallint DEFAULT 0,
    respuesta character varying(100),
    estatus smallint DEFAULT 0,
    telefono character varying(30),
    direccion character varying(50),
    atl smallint,
    id_direccion smallint,
    id_persona integer,
    password character varying(20),
    id_puesto integer,
    id_tipomenu smallint DEFAULT 1,
    menu integer,
    id_modulo integer DEFAULT 0,
    rfc character varying(13) DEFAULT ''::character varying,
    llaveprivada character varying(120) DEFAULT ''::character varying,
    llavepublica character varying(120) DEFAULT ''::character varying,
    numerotel numeric(10,0),
    imagen bytea
);


ALTER TABLE forapi.cat_usuarios OWNER TO postgres;

--
-- Name: COLUMN cat_usuarios.rfc; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN cat_usuarios.rfc IS 'RFC del usuario';


--
-- Name: COLUMN cat_usuarios.llaveprivada; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN cat_usuarios.llaveprivada IS 'Ubicacion de la llave privada';


--
-- Name: COLUMN cat_usuarios.llavepublica; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN cat_usuarios.llavepublica IS 'Ubicacion de la llave publica';


--
-- Name: COLUMN cat_usuarios.numerotel; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN cat_usuarios.numerotel IS 'Numero telefonico';


--
-- Name: COLUMN cat_usuarios.imagen; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN cat_usuarios.imagen IS 'Foto del usuario';


--
-- Name: cat_usuarios_pg_group; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE cat_usuarios_pg_group (
    usename name,
    grosysid integer,
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    usuario_modifico name DEFAULT getpgusername(),
    groname name
);


ALTER TABLE forapi.cat_usuarios_pg_group OWNER TO postgres;

--
-- Name: estados_usuarios; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE estados_usuarios (
    estado smallint,
    descripcion character(30)
);


ALTER TABLE forapi.estados_usuarios OWNER TO postgres;

--
-- Name: eventos; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE eventos (
    idevento integer NOT NULL,
    descripcion character varying(60),
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico name DEFAULT getpgusername()
);


ALTER TABLE forapi.eventos OWNER TO postgres;

--
-- Name: eventos_idevento_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE eventos_idevento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.eventos_idevento_seq OWNER TO postgres;

--
-- Name: eventos_idevento_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE eventos_idevento_seq OWNED BY eventos.idevento;


--
-- Name: his_cambios_pwd; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE his_cambios_pwd (
    usename name,
    valor_anterior name,
    valor_nuevo name,
    usuario_alta name DEFAULT getpgusername(),
    fecha_alta date DEFAULT ('now'::text)::date,
    hora_alta time without time zone DEFAULT ('now'::text)::time(6) with time zone
);


ALTER TABLE forapi.his_cambios_pwd OWNER TO postgres;

--
-- Name: his_cat_usuarios; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE his_cat_usuarios (
    idcambio integer DEFAULT nextval(('forapi.his_cat_usuarios_idcambio_seq'::text)::regclass) NOT NULL,
    usename name NOT NULL,
    nombre character varying(30),
    apepat character varying(30),
    apemat character varying(30),
    puesto character varying(50),
    depto character varying(50),
    correoe character varying(50),
    direccion_ip numeric(20,0),
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    idpregunta smallint DEFAULT 0,
    respuesta character varying(100),
    estatus smallint DEFAULT 0,
    telefono character varying(30),
    cve_movto character(1) DEFAULT ' '::bpchar,
    id_personas integer,
    atl smallint,
    id_puesto integer,
    usuario_alta name DEFAULT getpgusername(),
    usuario_modifico name DEFAULT getpgusername()
);


ALTER TABLE forapi.his_cat_usuarios OWNER TO postgres;

--
-- Name: his_cat_usuarios_idcambio_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE his_cat_usuarios_idcambio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.his_cat_usuarios_idcambio_seq OWNER TO postgres;

--
-- Name: his_cat_usuarios_pg_group; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE his_cat_usuarios_pg_group (
    idcambio integer DEFAULT nextval(('forapi.his_cat_usuarios_pg_group_idcambio_seq'::text)::regclass) NOT NULL,
    usename name,
    grosysid integer,
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    cve_movto character(1) DEFAULT ' '::bpchar
);


ALTER TABLE forapi.his_cat_usuarios_pg_group OWNER TO postgres;

--
-- Name: his_cat_usuarios_pg_group_idcambio_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE his_cat_usuarios_pg_group_idcambio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.his_cat_usuarios_pg_group_idcambio_seq OWNER TO postgres;

--
-- Name: his_cat_usuarios_pg_group_idcambio_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE his_cat_usuarios_pg_group_idcambio_seq OWNED BY his_cat_usuarios_pg_group.idcambio;


--
-- Name: his_cat_usuarios_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE his_cat_usuarios_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE forapi.his_cat_usuarios_seq OWNER TO postgres;

--
-- Name: his_menus; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE his_menus (
    idmenu integer,
    descripcion text,
    objeto character varying(100),
    fecha_alta timestamp with time zone,
    usuario_alta name,
    fecha_modifico timestamp with time zone,
    usuario_modifico name,
    php character varying(100) DEFAULT ''::character varying,
    modoconsulta smallint,
    idmenupadre integer DEFAULT 0,
    idmovtos integer,
    movtos character varying(20) DEFAULT 'i,d,u,s'::character varying,
    fuente character varying(255),
    presentacion smallint DEFAULT 2,
    columnas smallint DEFAULT 2,
    tabla character varying(50),
    reltype oid DEFAULT 0,
    filtro character varying(255),
    limite integer DEFAULT 100,
    orden character varying(255),
    menus_campos integer DEFAULT 0,
    dialogwidth integer DEFAULT 0,
    dialogheight integer DEFAULT 0,
    s_table integer DEFAULT 0,
    s_table_height integer DEFAULT 300,
    cvemovto character varying(1),
    fecha_movto timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_movto name DEFAULT getpgusername(),
    nspname name
);


ALTER TABLE forapi.his_menus OWNER TO postgres;

--
-- Name: his_menus_pg_group; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE his_menus_pg_group (
    idcambio integer DEFAULT nextval(('forapi.his_menus_pg_group_idcambio_seq'::text)::regclass),
    idmenu integer,
    grosysid integer,
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    cve_movto character(1) DEFAULT ' '::bpchar
);


ALTER TABLE forapi.his_menus_pg_group OWNER TO postgres;

--
-- Name: his_menus_pg_group_idcambio_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE his_menus_pg_group_idcambio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.his_menus_pg_group_idcambio_seq OWNER TO postgres;

--
-- Name: his_menus_pg_group_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE his_menus_pg_group_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE forapi.his_menus_pg_group_seq OWNER TO postgres;

--
-- Name: his_menus_pg_tables; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE his_menus_pg_tables (
    idcambio integer DEFAULT nextval(('forapi.his_menus_pg_tables_idcambio_seq'::text)::regclass),
    idmenu integer,
    tablename name,
    tselect character(1) DEFAULT ''::bpchar,
    tinsert character(1) DEFAULT ''::bpchar,
    tupdate character(1) DEFAULT ''::bpchar,
    tdelete character(1) DEFAULT ''::bpchar,
    tall character(1) DEFAULT ''::bpchar,
    cve_movto character(1),
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico name DEFAULT getpgusername(),
    tgrant character(1) DEFAULT ''::bpchar
);


ALTER TABLE forapi.his_menus_pg_tables OWNER TO postgres;

--
-- Name: his_menus_pg_tables_idcambio_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE his_menus_pg_tables_idcambio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.his_menus_pg_tables_idcambio_seq OWNER TO postgres;

--
-- Name: his_tablas_cambios; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE his_tablas_cambios (
    nspname name,
    tabla text,
    attnum integer DEFAULT 0 NOT NULL,
    idregcambio integer,
    valor_anterior text,
    valor_nuevo text,
    usuario_alta name DEFAULT getpgusername(),
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp without time zone,
    idmenu integer
);


ALTER TABLE forapi.his_tablas_cambios OWNER TO postgres;

--
-- Name: menus; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus (
    idmenu integer NOT NULL,
    descripcion text,
    objeto character varying(100),
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico name DEFAULT getpgusername(),
    php character varying(100),
    modoconsulta smallint,
    idmenupadre integer,
    idmovtos integer,
    movtos character varying(20) DEFAULT 'i,d,u,s,l,a'::character varying,
    fuente character varying(255),
    presentacion smallint DEFAULT 2,
    columnas smallint DEFAULT 2,
    tabla character varying(50),
    reltype oid DEFAULT 0,
    filtro character varying(255),
    limite integer DEFAULT 100,
    orden character varying(255),
    menus_campos integer DEFAULT 0,
    dialogwidth integer DEFAULT 0,
    dialogheight integer DEFAULT 0,
    s_table integer DEFAULT 0,
    s_table_height integer DEFAULT 300,
    inicioregistros boolean DEFAULT false,
    nspname name,
    css character varying(50),
    imprime smallint DEFAULT 0,
    limpiaralta boolean DEFAULT true,
    table_width numeric(10,2),
    table_height numeric(10,2),
    table_align character varying(10),
    manual text,
    noconfirmamovtos character varying(20) DEFAULT ''::character varying,
    icono text DEFAULT ''::text,
    ayuda text DEFAULT ''::text
);


ALTER TABLE forapi.menus OWNER TO postgres;

--
-- Name: COLUMN menus.movtos; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus.movtos IS 'i=insert,d=delete,u=update,s=select,l=limpiar,a=autodiseño,cc=copia un renglon';


--
-- Name: COLUMN menus.imprime; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus.imprime IS '0=todo,1=tabla de captura,3=tabla de renglones';


--
-- Name: COLUMN menus.limpiaralta; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus.limpiaralta IS 'true=limpia los datos despues de dar una alta';


--
-- Name: COLUMN menus.icono; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus.icono IS 'Icono o imagen que se utiliza en el armado de los menus';


--
-- Name: COLUMN menus.ayuda; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus.ayuda IS 'Archivo que se utiliza para presentar una guia de ayuda';


--
-- Name: menus_archivos; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_archivos (
    idarchivo integer NOT NULL,
    descripcion character varying,
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico name DEFAULT getpgusername(),
    version integer,
    idtipoarchivo smallint DEFAULT 0,
    "tamaño" integer DEFAULT 0,
    ubicacion character varying
);


ALTER TABLE forapi.menus_archivos OWNER TO postgres;

--
-- Name: menus_archivos_idarchivo_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_archivos_idarchivo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_archivos_idarchivo_seq OWNER TO postgres;

--
-- Name: menus_archivos_idarchivo_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_archivos_idarchivo_seq OWNED BY menus_archivos.idarchivo;


--
-- Name: menus_campos; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_campos (
    idcampo integer NOT NULL,
    idmenu integer,
    reltype oid DEFAULT 0 NOT NULL,
    attnum integer DEFAULT 0 NOT NULL,
    descripcion character varying(100),
    size integer,
    male integer,
    fuente character varying(100) DEFAULT ''::character varying,
    fuente_campodes character varying(30) DEFAULT ''::character varying,
    fuente_campodep character varying(30) DEFAULT ''::character varying,
    fuente_campofil character varying(255) DEFAULT ''::character varying,
    fuente_where character varying(4000),
    fuente_evento smallint DEFAULT 0,
    orden integer,
    idsubvista integer,
    dialogwidth integer DEFAULT 40,
    dialogheight integer DEFAULT 30,
    obligatorio boolean,
    busqueda boolean DEFAULT false,
    altaautomatico boolean DEFAULT false,
    tcase smallint DEFAULT 0,
    checaduplicidad boolean,
    readonly boolean DEFAULT false,
    valordefault character varying(299),
    esindex boolean DEFAULT false,
    tipayuda character varying(255),
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico name DEFAULT getpgusername(),
    espassword smallint DEFAULT 0,
    tabla character varying(50),
    nspname name,
    fuente_busqueda boolean DEFAULT false,
    val_particulares character varying(30),
    htmltable smallint DEFAULT 0,
    fuente_nspname name DEFAULT ''::name,
    altaautomatico_idmenu integer DEFAULT 0,
    fuente_busqueda_idmenu integer DEFAULT 0,
    upload_file boolean DEFAULT false,
    formato_td smallint,
    colspantxt smallint,
    rowspantxt smallint,
    autocomplete smallint DEFAULT 0,
    imprime boolean DEFAULT true,
    totales boolean DEFAULT false,
    cambiarencambios boolean DEFAULT true,
    link_file boolean DEFAULT false,
    fuente_info boolean DEFAULT false,
    fuente_info_idmenu integer DEFAULT 0,
    fuente_actu boolean DEFAULT false,
    fuente_actu_idmenu integer DEFAULT 0,
    eshidden boolean DEFAULT false,
    fila integer DEFAULT nextval(('forapi.menus_campos_fila_seq'::text)::regclass),
    clase character varying(100) DEFAULT ''::character varying,
    clase_label character varying(255),
    clase_dato character varying(255)
);


ALTER TABLE forapi.menus_campos OWNER TO postgres;

--
-- Name: COLUMN menus_campos.fuente_busqueda; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.fuente_busqueda IS 'Indica si en un campo select se tiene la opcion de busqueda esto se utiliza cuando las opciones son bastantes y el browse no se pasme';


--
-- Name: COLUMN menus_campos.val_particulares; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.val_particulares IS 'Se indica que validacion utilizar en el cliente si es mas de una es separado por ; y hay que corregir el ';


--
-- Name: COLUMN menus_campos.htmltable; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.htmltable IS 'Numero de tabla en el html, por default es 0, si se pone otro numero crea otra tabla en region de captura de datos';


--
-- Name: COLUMN menus_campos.altaautomatico_idmenu; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.altaautomatico_idmenu IS 'Numero de menu con la cual se va a dara alta en automatico';


--
-- Name: COLUMN menus_campos.fuente_busqueda_idmenu; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.fuente_busqueda_idmenu IS 'Numero de menu con la cual se van a buscar datos';


--
-- Name: COLUMN menus_campos.upload_file; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.upload_file IS 'Indica si el campo sirve para subir archivos false=no true=si';


--
-- Name: COLUMN menus_campos.formato_td; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.formato_td IS '0=normal,1=etiqueta y texto juntos,2=etiqueta y texto juntos todo el renglon';


--
-- Name: COLUMN menus_campos.colspantxt; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.colspantxt IS 'col span del texto en td, en caso de textarea es el ancho del renglon';


--
-- Name: COLUMN menus_campos.rowspantxt; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.rowspantxt IS 'row span del texto en td, en caso de textarea es la altura del renglon';


--
-- Name: COLUMN menus_campos.autocomplete; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.autocomplete IS 'Indica si se completa el campos en estos momento funciona para campos select, la idea es que funcione para campos texto 0=no,1=si';


--
-- Name: COLUMN menus_campos.imprime; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.imprime IS 'Indica si el campo se imprime true=si false=no';


--
-- Name: COLUMN menus_campos.totales; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.totales IS 'Indica si en la columna de campos se arega un total true=si, false=no';


--
-- Name: COLUMN menus_campos.cambiarencambios; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.cambiarencambios IS 'Con este campo se control que no se puedan cambiar datos en cambios, especificamente sirve para los campos de busqueda';


--
-- Name: COLUMN menus_campos.fila; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.fila IS 'campo para controlar cuantas columnas va a contener una fila, si dos columnas contienen las misma fila, esta fila tendra dos columnas';


--
-- Name: COLUMN menus_campos.clase; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.clase IS 'aqui apunta a la clase de bootstra a nivel de label e input o select';


--
-- Name: menus_campos_eventos; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_campos_eventos (
    icv integer NOT NULL,
    attnum integer,
    idmenu integer,
    idevento integer,
    donde smallint,
    descripcion character varying(255),
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico name DEFAULT getpgusername()
);


ALTER TABLE forapi.menus_campos_eventos OWNER TO postgres;

--
-- Name: menus_campos_eventos_icv_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_campos_eventos_icv_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_campos_eventos_icv_seq OWNER TO postgres;

--
-- Name: menus_campos_eventos_icv_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_campos_eventos_icv_seq OWNED BY menus_campos_eventos.icv;


--
-- Name: menus_campos_fila_seq; Type: SEQUENCE; Schema: forapi; Owner: inicio
--

CREATE SEQUENCE menus_campos_fila_seq
    START WITH 1
    INCREMENT BY 20
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_campos_fila_seq OWNER TO inicio;

--
-- Name: menus_campos_idcampo_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_campos_idcampo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_campos_idcampo_seq OWNER TO postgres;

--
-- Name: menus_campos_idcampo_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_campos_idcampo_seq OWNED BY menus_campos.idcampo;


--
-- Name: menus_eventos; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_eventos (
    idmenus_eventos integer NOT NULL,
    idmenu integer,
    idevento integer,
    donde smallint,
    descripcion character varying(255),
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico name DEFAULT getpgusername()
);


ALTER TABLE forapi.menus_eventos OWNER TO postgres;

--
-- Name: menus_eventos_idmenus_eventos_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_eventos_idmenus_eventos_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_eventos_idmenus_eventos_seq OWNER TO postgres;

--
-- Name: menus_eventos_idmenus_eventos_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_eventos_idmenus_eventos_seq OWNED BY menus_eventos.idmenus_eventos;


--
-- Name: menus_excels; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_excels (
    idexcel integer NOT NULL,
    descripcion character varying(100),
    nspname name,
    relname name,
    archivo character varying(100),
    movimiento numeric(1,0) DEFAULT 0,
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico name DEFAULT getpgusername()
);


ALTER TABLE forapi.menus_excels OWNER TO postgres;

--
-- Name: TABLE menus_excels; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON TABLE menus_excels IS 'tabla para subir archivos que se utilizan para crear una tabla y una nueva vista';


--
-- Name: COLUMN menus_excels.idexcel; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_excels.idexcel IS 'id del registro';


--
-- Name: COLUMN menus_excels.descripcion; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_excels.descripcion IS 'Nombre de la vista';


--
-- Name: COLUMN menus_excels.nspname; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_excels.nspname IS 'Esquema ';


--
-- Name: COLUMN menus_excels.relname; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_excels.relname IS 'Tabla a la que se va a crear una vista  ';


--
-- Name: COLUMN menus_excels.archivo; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_excels.archivo IS 'id del archivo que se esta subiendo';


--
-- Name: COLUMN menus_excels.movimiento; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_excels.movimiento IS 'Movimiento que se quiere hacer 0=crea tabla y vista, 1=crea solo vista';


--
-- Name: COLUMN menus_excels.fecha_alta; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_excels.fecha_alta IS 'Fecha en que hizo el movimiento el usuario';


--
-- Name: COLUMN menus_excels.usuario_alta; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_excels.usuario_alta IS 'Usuario hizo el alta ';


--
-- Name: menus_excels_idexcel_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_excels_idexcel_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_excels_idexcel_seq OWNER TO postgres;

--
-- Name: menus_excels_idexcel_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_excels_idexcel_seq OWNED BY menus_excels.idexcel;


--
-- Name: menus_htmltable; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_htmltable (
    idhtmltable integer NOT NULL,
    descripcion character varying(255),
    esdesistema boolean DEFAULT false,
    columnas smallint DEFAULT 0,
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico name DEFAULT getpgusername(),
    idmenu integer,
    orden integer
);


ALTER TABLE forapi.menus_htmltable OWNER TO postgres;

--
-- Name: TABLE menus_htmltable; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON TABLE menus_htmltable IS 'Tablas de html';


--
-- Name: COLUMN menus_htmltable.idhtmltable; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_htmltable.idhtmltable IS 'Numero de identificacion de la tabla';


--
-- Name: COLUMN menus_htmltable.descripcion; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_htmltable.descripcion IS 'Caption que va a tener la tabla';


--
-- Name: COLUMN menus_htmltable.columnas; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_htmltable.columnas IS 'Numero de columnas en la tabla si es cero pone las columnas de la tabla maestra';


--
-- Name: COLUMN menus_htmltable.idmenu; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_htmltable.idmenu IS 'Id del menu a la que pertenece el grupo de campos';


--
-- Name: COLUMN menus_htmltable.orden; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_htmltable.orden IS 'orden del grupo de campos';


--
-- Name: menus_htmltable_idhtmltable_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_htmltable_idhtmltable_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_htmltable_idhtmltable_seq OWNER TO postgres;

--
-- Name: menus_htmltable_idhtmltable_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_htmltable_idhtmltable_seq OWNED BY menus_htmltable.idhtmltable;


--
-- Name: menus_idmenu_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_idmenu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_idmenu_seq OWNER TO postgres;

--
-- Name: menus_idmenu_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_idmenu_seq OWNED BY menus.idmenu;


--
-- Name: menus_log; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_log (
    idlog integer NOT NULL,
    idmenu integer NOT NULL,
    movto character(1),
    sql text,
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    esmovil integer DEFAULT 0,
    browser integer DEFAULT 0,
    ip character varying(20),
    idmensaje integer DEFAULT 0
);


ALTER TABLE forapi.menus_log OWNER TO postgres;

--
-- Name: TABLE menus_log; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON TABLE menus_log IS 'tabla para dar seguimiento a lo que los usuarios hacen en el sistema';


--
-- Name: COLUMN menus_log.idlog; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_log.idlog IS 'registro en la tabla';


--
-- Name: COLUMN menus_log.idmenu; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_log.idmenu IS 'Numero de menu que utilizo el usuario';


--
-- Name: COLUMN menus_log.movto; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_log.movto IS 'Movimiento que hizo el usuario';


--
-- Name: COLUMN menus_log.sql; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_log.sql IS 'Movimiento que hizo el usuario';


--
-- Name: COLUMN menus_log.fecha_alta; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_log.fecha_alta IS 'Fecha en que hizo el movimiento el usuario';


--
-- Name: COLUMN menus_log.usuario_alta; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_log.usuario_alta IS 'Usuario hizo el alta ';


--
-- Name: menus_log_idlog_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_log_idlog_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_log_idlog_seq OWNER TO postgres;

--
-- Name: menus_log_idlog_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_log_idlog_seq OWNED BY menus_log.idlog;


--
-- Name: menus_mensajes; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_mensajes (
    idmensaje integer NOT NULL,
    mensaje text,
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico name DEFAULT getpgusername()
);


ALTER TABLE forapi.menus_mensajes OWNER TO postgres;

--
-- Name: TABLE menus_mensajes; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON TABLE menus_mensajes IS 'Catalogo de mensajes ';


--
-- Name: menus_mensajes_idmensaje_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_mensajes_idmensaje_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_mensajes_idmensaje_seq OWNER TO postgres;

--
-- Name: menus_mensajes_idmensaje_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_mensajes_idmensaje_seq OWNED BY menus_mensajes.idmensaje;


--
-- Name: menus_movtos; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_movtos (
    idmenu integer NOT NULL,
    idmovto character(1),
    descripcion character varying(255),
    imagen character varying(255),
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico name DEFAULT getpgusername()
);


ALTER TABLE forapi.menus_movtos OWNER TO postgres;

--
-- Name: COLUMN menus_movtos.idmovto; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_movtos.idmovto IS 'i=insert,d=delete,s=select,u=upate,l=limpiar';


--
-- Name: menus_pg_group; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_pg_group (
    idmenu integer,
    grosysid integer,
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    usuario_modifico name DEFAULT getpgusername(),
    idmenupadre integer,
    groname name,
    orden integer DEFAULT 0,
    espublico integer
);


ALTER TABLE forapi.menus_pg_group OWNER TO postgres;

--
-- Name: COLUMN menus_pg_group.groname; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_pg_group.groname IS 'nombre del grupo al que pertenece el menu';


--
-- Name: COLUMN menus_pg_group.orden; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_pg_group.orden IS 'Indica si la opcione es publica, esto es no se requiere esta autentificado en el servidor';


--
-- Name: menus_pg_group_orden_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_pg_group_orden_seq
    START WITH 1
    INCREMENT BY 10
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_pg_group_orden_seq OWNER TO postgres;

--
-- Name: menus_pg_tables; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_pg_tables (
    idmenu integer,
    tablename name,
    tselect character(1) DEFAULT 0,
    tinsert character(1) DEFAULT 0,
    tupdate character(1) DEFAULT 0,
    tdelete character(1) DEFAULT 0,
    tall character(1) DEFAULT 0,
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    usuario_modifico name DEFAULT getpgusername(),
    tgrant character(1) DEFAULT 0,
    nspname name
);


ALTER TABLE forapi.menus_pg_tables OWNER TO postgres;

--
-- Name: menus_presentacion; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_presentacion (
    idpresentacion integer NOT NULL,
    descripcion character varying(100),
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico name DEFAULT getpgusername()
);


ALTER TABLE forapi.menus_presentacion OWNER TO postgres;

--
-- Name: menus_presentacion_idpresentacion_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_presentacion_idpresentacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_presentacion_idpresentacion_seq OWNER TO postgres;

--
-- Name: menus_presentacion_idpresentacion_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_presentacion_idpresentacion_seq OWNED BY menus_presentacion.idpresentacion;


--
-- Name: menus_scripts; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_scripts (
    idscript integer NOT NULL,
    descripcion character varying(100),
    sql text,
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico name DEFAULT getpgusername()
);


ALTER TABLE forapi.menus_scripts OWNER TO postgres;

--
-- Name: TABLE menus_scripts; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON TABLE menus_scripts IS 'tabla para dar de alta un script ddl o dml';


--
-- Name: COLUMN menus_scripts.idscript; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_scripts.idscript IS 'id del script';


--
-- Name: COLUMN menus_scripts.sql; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_scripts.sql IS 'instruccion';


--
-- Name: COLUMN menus_scripts.fecha_alta; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_scripts.fecha_alta IS 'Fecha en que hizo el movimiento el usuario';


--
-- Name: COLUMN menus_scripts.usuario_alta; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_scripts.usuario_alta IS 'Usuario hizo el alta ';


--
-- Name: menus_scripts_idscript_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_scripts_idscript_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_scripts_idscript_seq OWNER TO postgres;

--
-- Name: menus_scripts_idscript_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_scripts_idscript_seq OWNED BY menus_scripts.idscript;


--
-- Name: menus_seguimiento; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_seguimiento (
    idseguimietno integer NOT NULL,
    idmenu integer NOT NULL,
    usename name,
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername()
);


ALTER TABLE forapi.menus_seguimiento OWNER TO postgres;

--
-- Name: TABLE menus_seguimiento; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON TABLE menus_seguimiento IS 'tabla para indicar a que se le va a dar seguimiento';


--
-- Name: COLUMN menus_seguimiento.idmenu; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_seguimiento.idmenu IS 'Numero de menu a dar seguimietno si 9999999=todos';


--
-- Name: COLUMN menus_seguimiento.usename; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_seguimiento.usename IS 'Usuario a dar seguimiento *=todos';


--
-- Name: COLUMN menus_seguimiento.fecha_alta; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_seguimiento.fecha_alta IS 'Fecha en que hizo el movimiento';


--
-- Name: COLUMN menus_seguimiento.usuario_alta; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_seguimiento.usuario_alta IS 'Usuario hizo el alta ';


--
-- Name: menus_seguimiento_idseguimietno_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_seguimiento_idseguimietno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_seguimiento_idseguimietno_seq OWNER TO postgres;

--
-- Name: menus_seguimiento_idseguimietno_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_seguimiento_idseguimietno_seq OWNED BY menus_seguimiento.idseguimietno;


--
-- Name: menus_subvistas; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_subvistas (
    idmenus_subvistas integer NOT NULL,
    idmenu integer,
    texto character varying(50),
    imagen character varying(255),
    idsubvista integer DEFAULT 0,
    funcion character varying(255),
    dialogwidth integer DEFAULT 40,
    dialogheight integer DEFAULT 30,
    esboton integer DEFAULT 1,
    donde smallint,
    eventos_antes character varying(255),
    eventos_despues character varying(255),
    campo_filtro character varying(255),
    valor_padre character varying(255),
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico name DEFAULT getpgusername(),
    clase character varying(255),
    posicion smallint DEFAULT 0,
    orden smallint DEFAULT 0,
    ventana smallint DEFAULT 0
);


ALTER TABLE forapi.menus_subvistas OWNER TO postgres;

--
-- Name: COLUMN menus_subvistas.ventana; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_subvistas.ventana IS '0=showModalDialog,1=showModelessDialog,2=open';


--
-- Name: menus_subvistas_idmenus_subvistas_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_subvistas_idmenus_subvistas_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_subvistas_idmenus_subvistas_seq OWNER TO postgres;

--
-- Name: menus_subvistas_idmenus_subvistas_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_subvistas_idmenus_subvistas_seq OWNED BY menus_subvistas.idmenus_subvistas;


--
-- Name: menus_tiempos; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_tiempos (
    idtiempo integer NOT NULL,
    descripcion character varying(30),
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta name DEFAULT getpgusername(),
    usuario_modifico name DEFAULT getpgusername(),
    unidadtiempo integer DEFAULT 0,
    tiempo integer DEFAULT 0,
    orden integer DEFAULT 0
);


ALTER TABLE forapi.menus_tiempos OWNER TO postgres;

--
-- Name: COLUMN menus_tiempos.unidadtiempo; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_tiempos.unidadtiempo IS 'Unidad de tiempo 1=dia,2=semana,3=mes';


--
-- Name: COLUMN menus_tiempos.tiempo; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_tiempos.tiempo IS 'Cantidad de tiempo';


--
-- Name: COLUMN menus_tiempos.orden; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_tiempos.orden IS 'Orden en que aparacen en el combo';


--
-- Name: menus_tiempos_idtiempo_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_tiempos_idtiempo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_tiempos_idtiempo_seq OWNER TO postgres;

--
-- Name: menus_tiempos_idtiempo_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_tiempos_idtiempo_seq OWNED BY menus_tiempos.idtiempo;


--
-- Name: tablas; Type: VIEW; Schema: forapi; Owner: postgres
--

CREATE VIEW tablas AS
    SELECT c.relname, c.reltype, c.oid, n.nspname, n.nspname AS fuente_nspname FROM ((pg_class c LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace))) LEFT JOIN pg_tablespace t ON ((t.oid = c.reltablespace))) WHERE (((c.relkind = 'r'::"char") OR (c.relkind = 'v'::"char")) AND (substr((c.relname)::text, 1, 4) <> 'sql_'::text));


ALTER TABLE forapi.tablas OWNER TO postgres;

--
-- Name: tcases; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE tcases (
    tcase smallint NOT NULL,
    descripcion character varying(10)
);


ALTER TABLE forapi.tcases OWNER TO postgres;

--
-- Name: idevento; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY eventos ALTER COLUMN idevento SET DEFAULT nextval('eventos_idevento_seq'::regclass);


--
-- Name: idmenu; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus ALTER COLUMN idmenu SET DEFAULT nextval('menus_idmenu_seq'::regclass);


--
-- Name: idarchivo; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_archivos ALTER COLUMN idarchivo SET DEFAULT nextval('menus_archivos_idarchivo_seq'::regclass);


--
-- Name: idcampo; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_campos ALTER COLUMN idcampo SET DEFAULT nextval('menus_campos_idcampo_seq'::regclass);


--
-- Name: icv; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_campos_eventos ALTER COLUMN icv SET DEFAULT nextval('menus_campos_eventos_icv_seq'::regclass);


--
-- Name: idmenus_eventos; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_eventos ALTER COLUMN idmenus_eventos SET DEFAULT nextval('menus_eventos_idmenus_eventos_seq'::regclass);


--
-- Name: idexcel; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_excels ALTER COLUMN idexcel SET DEFAULT nextval('menus_excels_idexcel_seq'::regclass);


--
-- Name: idhtmltable; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_htmltable ALTER COLUMN idhtmltable SET DEFAULT nextval('menus_htmltable_idhtmltable_seq'::regclass);


--
-- Name: idlog; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_log ALTER COLUMN idlog SET DEFAULT nextval('menus_log_idlog_seq'::regclass);


--
-- Name: idmensaje; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_mensajes ALTER COLUMN idmensaje SET DEFAULT nextval('menus_mensajes_idmensaje_seq'::regclass);


--
-- Name: idpresentacion; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_presentacion ALTER COLUMN idpresentacion SET DEFAULT nextval('menus_presentacion_idpresentacion_seq'::regclass);


--
-- Name: idscript; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_scripts ALTER COLUMN idscript SET DEFAULT nextval('menus_scripts_idscript_seq'::regclass);


--
-- Name: idseguimietno; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_seguimiento ALTER COLUMN idseguimietno SET DEFAULT nextval('menus_seguimiento_idseguimietno_seq'::regclass);


--
-- Name: idmenus_subvistas; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_subvistas ALTER COLUMN idmenus_subvistas SET DEFAULT nextval('menus_subvistas_idmenus_subvistas_seq'::regclass);


--
-- Name: idtiempo; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_tiempos ALTER COLUMN idtiempo SET DEFAULT nextval('menus_tiempos_idtiempo_seq'::regclass);


--
-- Name: eventos_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY eventos
    ADD CONSTRAINT eventos_pkey PRIMARY KEY (idevento);


--
-- Name: his_cat_usuarios_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY his_cat_usuarios
    ADD CONSTRAINT his_cat_usuarios_pkey PRIMARY KEY (idcambio);


--
-- Name: menus_archivos_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus_archivos
    ADD CONSTRAINT menus_archivos_pkey PRIMARY KEY (idarchivo);


--
-- Name: menus_campos_eventos_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus_campos_eventos
    ADD CONSTRAINT menus_campos_eventos_pkey PRIMARY KEY (icv);


--
-- Name: menus_campos_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus_campos
    ADD CONSTRAINT menus_campos_pkey PRIMARY KEY (idcampo);


--
-- Name: menus_eventos_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus_eventos
    ADD CONSTRAINT menus_eventos_pkey PRIMARY KEY (idmenus_eventos);


--
-- Name: menus_excels_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus_excels
    ADD CONSTRAINT menus_excels_pkey PRIMARY KEY (idexcel);


--
-- Name: menus_htmltable_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus_htmltable
    ADD CONSTRAINT menus_htmltable_pkey PRIMARY KEY (idhtmltable);


--
-- Name: menus_log_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus_log
    ADD CONSTRAINT menus_log_pkey PRIMARY KEY (idlog);


--
-- Name: menus_mensajes_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus_mensajes
    ADD CONSTRAINT menus_mensajes_pkey PRIMARY KEY (idmensaje);


--
-- Name: menus_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus
    ADD CONSTRAINT menus_pkey PRIMARY KEY (idmenu);


--
-- Name: menus_presentacion_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus_presentacion
    ADD CONSTRAINT menus_presentacion_pkey PRIMARY KEY (idpresentacion);


--
-- Name: menus_scripts_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus_scripts
    ADD CONSTRAINT menus_scripts_pkey PRIMARY KEY (idscript);


--
-- Name: menus_seguimiento_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus_seguimiento
    ADD CONSTRAINT menus_seguimiento_pkey PRIMARY KEY (idseguimietno);


--
-- Name: menus_subvistas_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus_subvistas
    ADD CONSTRAINT menus_subvistas_pkey PRIMARY KEY (idmenus_subvistas);


--
-- Name: tcases_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tcases
    ADD CONSTRAINT tcases_pkey PRIMARY KEY (tcase);


--
-- Name: ak1_cat_usuarios; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak1_cat_usuarios ON cat_usuarios USING btree (estatus);


--
-- Name: ak1_cat_usuarios_pg_group; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak1_cat_usuarios_pg_group ON cat_usuarios_pg_group USING btree (usename);


--
-- Name: ak1_menus; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak1_menus ON his_menus USING btree (idmenu);


--
-- Name: ak1_menus_campos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak1_menus_campos ON menus_campos USING btree (idmenu, attnum);


--
-- Name: ak1_menus_htmltable; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX ak1_menus_htmltable ON menus_htmltable USING btree (descripcion, idmenu);


--
-- Name: ak1_menus_log; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak1_menus_log ON menus_log USING btree (idmenu);


--
-- Name: ak1_menus_movtos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak1_menus_movtos ON menus_movtos USING btree (idmenu);


--
-- Name: ak1_menus_pg_group; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak1_menus_pg_group ON menus_pg_group USING btree (grosysid);


--
-- Name: ak1_menus_seguimiento; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak1_menus_seguimiento ON menus_seguimiento USING btree (idmenu);


--
-- Name: ak1_menus_subvistas; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak1_menus_subvistas ON menus_subvistas USING btree (idmenu);


--
-- Name: ak1_menusarchivos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak1_menusarchivos ON menus_archivos USING btree (fecha_alta);


--
-- Name: ak1his_tablas_cambios; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak1his_tablas_cambios ON his_tablas_cambios USING btree (nspname, tabla);


--
-- Name: ak2_menus_campos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak2_menus_campos ON menus_campos USING btree (fuente_busqueda_idmenu);


--
-- Name: ak2_menus_excels; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak2_menus_excels ON menus_excels USING btree (usuario_alta);


--
-- Name: ak2_menus_log; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak2_menus_log ON menus_log USING btree (usuario_alta);


--
-- Name: ak2_menus_pg_group; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak2_menus_pg_group ON menus_pg_group USING btree (idmenu);


--
-- Name: ak2_menus_scripts; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak2_menus_scripts ON menus_scripts USING btree (usuario_alta);


--
-- Name: ak2_menus_seguimiento; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak2_menus_seguimiento ON menus_seguimiento USING btree (usename);


--
-- Name: ak2_menus_subvistas; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak2_menus_subvistas ON menus_subvistas USING btree (idsubvista);


--
-- Name: ak2his_tablas_cambios; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak2his_tablas_cambios ON his_tablas_cambios USING btree (idregcambio);


--
-- Name: ak3_menus_campos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak3_menus_campos ON menus_campos USING btree (fuente_info_idmenu);


--
-- Name: ak3_menus_excels; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak3_menus_excels ON menus_excels USING btree (fecha_alta);


--
-- Name: ak3_menus_log; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak3_menus_log ON menus_log USING btree (fecha_alta);


--
-- Name: ak3_menus_scripts; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak3_menus_scripts ON menus_scripts USING btree (fecha_alta);


--
-- Name: ak4_menus_campos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak4_menus_campos ON menus_campos USING btree (fuente_actu_idmenu);


--
-- Name: ak4his_tablas_cambios; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak4his_tablas_cambios ON his_tablas_cambios USING btree (usuario_alta);


--
-- Name: ak5_menus_campos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak5_menus_campos ON menus_campos USING btree (idsubvista);


--
-- Name: ak5his_tablas_cambios; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak5his_tablas_cambios ON his_tablas_cambios USING btree (nspname, tabla, usuario_alta);


--
-- Name: ak6_menus_campos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak6_menus_campos ON menus_campos USING btree (altaautomatico_idmenu);


--
-- Name: akhis_tablas_cambios; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX akhis_tablas_cambios ON his_tablas_cambios USING btree (nspname, tabla, idregcambio);


--
-- Name: pk_menus_movtos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_menus_movtos ON menus_movtos USING btree (idmenu, idmovto);


--
-- Name: pkcat_usuarios; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pkcat_usuarios ON cat_usuarios USING btree (usename);


--
-- Name: pkcat_usuarios_b; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX pkcat_usuarios_b ON cat_usuarios USING btree (atl);


--
-- Name: pkcat_usuarios_c; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX pkcat_usuarios_c ON cat_usuarios USING btree (nombre);


--
-- Name: pkcat_usuarios_d; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX pkcat_usuarios_d ON cat_usuarios USING btree (apepat);


--
-- Name: pkcat_usuarios_e; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX pkcat_usuarios_e ON cat_usuarios USING btree (apemat);


--
-- Name: pkestados_usuarios; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pkestados_usuarios ON estados_usuarios USING btree (estado);


--
-- Name: pkhis_cat_usuarios; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX pkhis_cat_usuarios ON his_cat_usuarios USING btree (usename);


--
-- Name: pkhis_usuariosidcambio; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pkhis_usuariosidcambio ON his_cat_usuarios USING btree (idcambio);


--
-- Name: xakhis_cambios_pwdfcpnva; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX xakhis_cambios_pwdfcpnva ON his_cambios_pwd USING btree (usuario_alta, fecha_alta);


--
-- Name: xalcat_bitacora; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX xalcat_bitacora ON cat_bitacora USING btree (idproceso, fecha_inicio, fecha_fin);


--
-- Name: xpkcat_bitacora; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX xpkcat_bitacora ON cat_bitacora USING btree (idbitacora);


--
-- Name: xpkcat_preguntas; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX xpkcat_preguntas ON cat_preguntas USING btree (idpregunta);


--
-- Name: xpkcat_usuarios_pg_group; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX xpkcat_usuarios_pg_group ON cat_usuarios_pg_group USING btree (usename, grosysid);


--
-- Name: xpkhis_cambios_pwdfcpnva; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX xpkhis_cambios_pwdfcpnva ON his_cambios_pwd USING btree (usename, valor_anterior);


--
-- Name: xpkhis_cat_usuarios_pg_group; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX xpkhis_cat_usuarios_pg_group ON his_cat_usuarios_pg_group USING btree (usename, grosysid);


--
-- Name: xpkhis_menus_pg_group; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX xpkhis_menus_pg_group ON his_menus_pg_group USING btree (idmenu, grosysid);


--
-- Name: xpkhis_menus_pg_tables; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX xpkhis_menus_pg_tables ON his_menus_pg_tables USING btree (idmenu, tablename);


--
-- Name: xpkmenus_pg_group; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX xpkmenus_pg_group ON menus_pg_group USING btree (idmenu, grosysid);


--
-- Name: xpkmenus_pg_tables; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX xpkmenus_pg_tables ON menus_pg_tables USING btree (idmenu, tablename, nspname);


--
-- Name: xpkmenus_tiempos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX xpkmenus_tiempos ON menus_tiempos USING btree (idtiempo);


--
-- Name: catu_up_usuario_fecha; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER catu_up_usuario_fecha BEFORE UPDATE ON cat_usuarios FOR EACH ROW EXECUTE PROCEDURE up_usuario_fecha();


--
-- Name: td_cat_usuarios; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER td_cat_usuarios BEFORE DELETE ON cat_usuarios FOR EACH ROW EXECUTE PROCEDURE baja_cat_usuarios();


--
-- Name: td_cat_usuarios_pg_group; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER td_cat_usuarios_pg_group BEFORE DELETE ON cat_usuarios_pg_group FOR EACH ROW EXECUTE PROCEDURE baja_cat_usuarios_pg_group();


--
-- Name: td_menus; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER td_menus BEFORE DELETE ON menus FOR EACH ROW EXECUTE PROCEDURE baja_menus();


--
-- Name: td_menus_pg_group; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER td_menus_pg_group BEFORE DELETE ON menus_pg_group FOR EACH ROW EXECUTE PROCEDURE baja_menus_pg_group();


--
-- Name: td_menus_pg_tables; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER td_menus_pg_tables BEFORE DELETE ON menus_pg_tables FOR EACH ROW EXECUTE PROCEDURE baja_menus_pg_tables();


--
-- Name: ti_cat_usuarios; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER ti_cat_usuarios BEFORE INSERT ON cat_usuarios FOR EACH ROW EXECUTE PROCEDURE alta_cat_usuarios();


--
-- Name: ti_cat_usuarios_pg_group; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER ti_cat_usuarios_pg_group BEFORE INSERT ON cat_usuarios_pg_group FOR EACH ROW EXECUTE PROCEDURE alta_cat_usuarios_pg_group();


--
-- Name: ti_menus; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER ti_menus BEFORE INSERT ON menus FOR EACH ROW EXECUTE PROCEDURE alta_menus();


--
-- Name: ti_menus_campos; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER ti_menus_campos BEFORE INSERT ON menus_campos FOR EACH ROW EXECUTE PROCEDURE alta_menus_campos();


--
-- Name: ti_menus_pg_group; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER ti_menus_pg_group BEFORE INSERT ON menus_pg_group FOR EACH ROW EXECUTE PROCEDURE alta_menus_pg_group();


--
-- Name: ti_menus_pg_tables; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER ti_menus_pg_tables BEFORE INSERT ON menus_pg_tables FOR EACH ROW EXECUTE PROCEDURE alta_menus_pg_tables();


--
-- Name: tu_cat_bitacora; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER tu_cat_bitacora BEFORE UPDATE ON cat_bitacora FOR EACH ROW EXECUTE PROCEDURE up_usuario_fecha();


--
-- Name: tu_cat_usuarios; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER tu_cat_usuarios BEFORE UPDATE ON cat_usuarios FOR EACH ROW EXECUTE PROCEDURE cambio_cat_usuarios();


--
-- Name: tu_menus; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER tu_menus BEFORE UPDATE ON menus FOR EACH ROW EXECUTE PROCEDURE cambia_menus();


--
-- Name: tu_menus_campos; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER tu_menus_campos BEFORE UPDATE ON menus_campos FOR EACH ROW EXECUTE PROCEDURE cambia_menus_campos();


--
-- Name: tu_menus_columnas; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER tu_menus_columnas BEFORE UPDATE ON menus FOR EACH ROW EXECUTE PROCEDURE cambio_menus_columnas();


--
-- Name: tu_menus_pg_tables; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER tu_menus_pg_tables BEFORE UPDATE ON menus_pg_tables FOR EACH ROW EXECUTE PROCEDURE cambio_menus_pg_tables();


--
-- PostgreSQL database dump complete
--

