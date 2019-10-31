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
      wlusuario varchar(20);
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
		
		wlsentencia = ' create user ' || wlusuario || ' with password ' || quote_literal(trim(wlpasswd)) || ' nocreatedb ; ';
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
            wlsentencia='grant ' || trim(wlper) || '  on ' || trim(mireg.tablename) || ' to ' ||  $1 || ' with grant option ';
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
            wlsentencia=' grant usage,create on schema ' || trim(mireg.nspname) || ' to ' ||  $1 || ' with grant option ';
            execute wlsentencia;
            --raise notice ' sentencia % ', wlsentencia  ;
            wlsentencia=' grant all PRIVILEGES on all sequences in schema ' || trim(mireg.nspname) || ' to ' ||  $1 || ' with grant option ';
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
     delete from forpai.menus_pg_tables where tablename=old.tabla and idmenu=old.idmenu;
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
           wlclase='col-md-12 row';
        end if;
        if new.columnas=2 then 
           wlclase='col-md-6 row';
        end if;
        if new.columnas=3 then 
           wlclase='col-md-4 row';
        end if;
        if new.columnas=4 then 
           wlclase='col-md-3 row';
        end if; 
        if new.columnas=5 then 
           wlclase='col-md-2 row';
        end if; 
        if new.columnas=6 then 
           wlclase='col-md-2 row';
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
    usuario_alta text DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp without time zone,
    usuario_modifico text DEFAULT getpgusername()
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername()
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
    usename character(15) NOT NULL,
    nombre character varying(30),
    apepat character varying(30),
    apemat character varying(30),
    puesto character varying(50),
    depto character varying(50),
    correoe character varying(50),
    direccion_ip numeric(20,0),
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta character varying(20) DEFAULT getpgusername(),
    usuario_modifico character varying(20) DEFAULT getpgusername(),
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
    usename character(15),
    grosysid integer,
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta character varying(20) DEFAULT getpgusername(),
    usuario_modifico character varying(20) DEFAULT getpgusername(),
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername()
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
    usename character(15) NOT NULL,
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
    usuario_modifico character varying(20) DEFAULT getpgusername()
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
    usename character(15),
    grosysid integer,
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta character varying(20) DEFAULT getpgusername(),
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
    usuario_alta character varying(20),
    fecha_modifico timestamp with time zone,
    usuario_modifico character varying(20),
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
    usuario_movto character varying(20) DEFAULT getpgusername(),
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
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
    usuario_modifico character varying(20) DEFAULT getpgusername(),
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername(),
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
    usuario_alta character varying DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying DEFAULT getpgusername(),
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername(),
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
    clase character varying(100) DEFAULT ''::character varying
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername()
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername()
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
-- Name: menus_htmltable; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_htmltable (
    idhtmltable integer NOT NULL,
    descripcion character varying(255),
    esdesistema boolean DEFAULT false,
    columnas smallint DEFAULT 0,
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername(),
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername()
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername()
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
    usuario_modifico character varying(20) DEFAULT getpgusername(),
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
    usuario_modifico character varying(20) DEFAULT getpgusername(),
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername()
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername()
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
    usename character varying(20),
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta character varying(20) DEFAULT getpgusername()
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername(),
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
    usuario_alta character varying(20) DEFAULT getpgusername(),
    usuario_modifico character varying(20) DEFAULT getpgusername(),
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
    SELECT c.relname, c.reltype, c.oid, n.nspname, n.nspname AS fuente_nspname FROM ((pg_class c LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace))) LEFT JOIN pg_tablespace t ON ((t.oid = c.reltablespace))) WHERE ((((c.relkind = 'r'::"char") OR (c.relkind = 'S'::"char")) OR (c.relkind = 'v'::"char")) AND (substr((c.relname)::text, 1, 4) <> 'sql_'::text));


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
-- Data for Name: cat_bitacora; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY cat_bitacora (idbitacora, idproceso, fecha_inicio, fecha_fin, at_inicio, at_fin, estado, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
\.


--
-- Name: cat_bitacora_idbitacora_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('cat_bitacora_idbitacora_seq', 42, true);


--
-- Name: cat_bitacora_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('cat_bitacora_seq', 1, false);


--
-- Data for Name: cat_preguntas; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY cat_preguntas (idpregunta, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
\.


--
-- Name: cat_preguntas_idpregunta_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('cat_preguntas_idpregunta_seq', 1, false);


--
-- Name: cat_preguntas_seq; Type: SEQUENCE SET; Schema: forapi; Owner: inicio
--

SELECT pg_catalog.setval('cat_preguntas_seq', 100, false);


--
-- Data for Name: cat_usuarios; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY cat_usuarios (usename, nombre, apepat, apemat, puesto, depto, correoe, direccion_ip, fecha_alta, fecha_modifico, usuario_alta, usuario_modifico, idpregunta, respuesta, estatus, telefono, direccion, atl, id_direccion, id_persona, password, id_puesto, id_tipomenu, menu, id_modulo, rfc, llaveprivada, llavepublica, numerotel, imagen) FROM stdin;
inicio         	inicio	\N	\N	\N	\N	\N	\N	2019-10-12 14:53:07-06	2019-10-12 15:16:17.631751-06	inicio	inicio	0	\N	1	\N	\N	\N	\N	\N	inicio	\N	1	17	0				\N	\N
usuario20      	JOSE	VASQUEZ	BARBOSA	\N	\N	\N	\N	2019-10-16 08:13:25-06	2019-10-16 08:13:25-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				565672416	\N
usuario21      	JOSE	VASQUEZ	BARBOSA	\N	\N	\N	\N	2019-10-16 08:17:22-06	2019-10-16 08:17:22-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				565672416	\N
usuario80      	JOSE	VASQUEZ	BARBOSA	\N	\N	\N	\N	2019-10-16 12:46:49-06	2019-10-16 12:46:49-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				56572416	\N
usuario81      	JOSE	LUIS	VASQUEZ	\N	\N	\N	\N	2019-10-16 15:49:04-06	2019-10-16 15:49:04-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				5556572416	\N
usuario10      	JOSE	VASQ	BAR	\N	\N	\N	\N	2019-10-20 07:33:01-06	2019-10-20 07:33:01-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				5556572416	\N
usuario11      	JOSE	VASQUEZ	BARBOSA	\N	\N	\N	\N	2019-10-20 07:41:22-06	2019-10-20 07:41:22-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				5556572416	\N
inicio5        	JOSE	LUIS	VASQUEZ	\N	\N	\N	\N	2019-10-20 07:54:23-06	2019-10-20 07:54:23-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				5556572416	\N
usuario4       	JOSE	VAS	BARBOSA	\N	\N	\N	\N	2019-10-20 07:56:51-06	2019-10-20 07:56:51-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				5556572416	\N
inicio78       	JOSE	LUIS	\N	\N	\N	\N	\N	2019-10-20 14:02:34-06	2019-10-20 14:02:34-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				5556572416	\\x31342e786c7378
tmp_jc9        	temporal	\N	\N	\N	\N	\N	\N	2019-10-27 17:02:44-06	2019-10-27 17:02:43.784708-06	jc9	jc9	0	\N	1	\N	\N	\N	\N	\N	jc9	\N	1	\N	0				\N	\N
jc9            	jc9	\N	\N	\N	\N	\N	\N	2019-10-27 17:02:44-06	2019-10-27 17:02:43.833875-06	jc9	jc9	0	\N	1	\N	\N	\N	\N	\N	jc9	\N	1	17	0				\N	\N
juez1          	NOMBRE	PATERNO	\N	\N	\N	\N	\N	2019-10-30 17:18:25-06	2019-10-30 17:23:57.288473-06	tmp_jc9	jc9	0	\N	1	\N	\N	\N	\N	\N	juez11	\N	1	61	0				5556572416	\N
\.


--
-- Data for Name: cat_usuarios_pg_group; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY cat_usuarios_pg_group (usename, grosysid, fecha_alta, fecha_modifico, usuario_alta, usuario_modifico, groname) FROM stdin;
inicio         	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	admon
temporal1      	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	temporalg
forapi         	\N	2019-10-27 15:35:24-06	2019-10-27 15:35:24-06	inicio	inicio	accesosistema
forapi         	\N	2019-10-27 15:35:53-06	2019-10-27 15:35:53-06	inicio	inicio	accesosistema
forapi         	\N	2019-10-27 15:36:50-06	2019-10-27 15:36:50-06	inicio	inicio	accesosistema
tmp_jc9        	\N	2019-10-27 17:02:44-06	2019-10-27 17:02:44-06	jc9	jc9	temporalg
jc9            	\N	2019-10-27 17:02:44-06	2019-10-27 17:02:44-06	jc9	jc9	admon
juez1          	\N	2019-10-30 17:19:30-06	2019-10-30 17:19:30-06	jc9	jc9	juez
\.


--
-- Data for Name: estados_usuarios; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY estados_usuarios (estado, descripcion) FROM stdin;
\.


--
-- Data for Name: eventos; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY eventos (idevento, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
\.


--
-- Name: eventos_idevento_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('eventos_idevento_seq', 1, false);


--
-- Data for Name: his_cambios_pwd; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY his_cambios_pwd (usename, valor_anterior, valor_nuevo, usuario_alta, fecha_alta, hora_alta) FROM stdin;
\.


--
-- Data for Name: his_cat_usuarios; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY his_cat_usuarios (idcambio, usename, nombre, apepat, apemat, puesto, depto, correoe, direccion_ip, fecha_alta, fecha_modifico, idpregunta, respuesta, estatus, telefono, cve_movto, id_personas, atl, id_puesto, usuario_alta, usuario_modifico) FROM stdin;
\.


--
-- Name: his_cat_usuarios_idcambio_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('his_cat_usuarios_idcambio_seq', 86, true);


--
-- Data for Name: his_cat_usuarios_pg_group; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY his_cat_usuarios_pg_group (idcambio, usename, grosysid, fecha_alta, usuario_alta, cve_movto) FROM stdin;
\.


--
-- Name: his_cat_usuarios_pg_group_idcambio_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('his_cat_usuarios_pg_group_idcambio_seq', 8, true);


--
-- Name: his_cat_usuarios_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('his_cat_usuarios_seq', 1, false);


--
-- Data for Name: his_menus; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY his_menus (idmenu, descripcion, objeto, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico, php, modoconsulta, idmenupadre, idmovtos, movtos, fuente, presentacion, columnas, tabla, reltype, filtro, limite, orden, menus_campos, dialogwidth, dialogheight, s_table, s_table_height, cvemovto, fecha_movto, usuario_movto, nspname) FROM stdin;
16	Mtto a grupos		2019-10-12 14:53:07-06	inicio	2019-10-30 16:30:20-06	jc9	man_menus.php	0	10	0	i,d,u,s,a,l		2	1	pg_authid	2842	rolcanlogin=false	100	rolname	0	0	0	0	300	d	2019-10-31 12:53:33-06	jc9	\N
59	infracciones	\N	2019-10-29 07:19:43-06	jc9	2019-10-30 16:15:05-06	jc9	man_menus.php	\N	32	\N	i,d,u,s,l,a	\N	2	2	infracciones	134809	\N	100	\N	0	0	0	0	300	d	2019-10-31 12:53:33-06	jc9	\N
60	sanciones	\N	2019-10-29 07:40:21-06	jc9	2019-10-30 16:15:25-06	jc9	man_menus.php	\N	32	\N	i,d,u,s,l,a	\N	2	2	sanciones	134826	\N	100	\N	0	0	0	0	300	d	2019-10-31 12:53:33-06	jc9	\N
47	juzgados	\N	2019-10-28 21:09:58-06	jc9	2019-10-30 16:15:56-06	jc9	man_menus.php	\N	32	\N	i,d,u,s,l,a	\N	2	2	juzgados	134768	\N	100	\N	0	0	0	0	300	d	2019-10-31 12:53:33-06	jc9	\N
61	boletas	\N	2019-10-29 13:27:15-06	jc9	2019-10-30 16:21:40-06	jc9	man_menus.php	\N	0	\N	i,d,u,s,l,a	\N	2	2	boletas	134852	\N	100	\N	0	0	0	0	300	d	2019-10-31 12:53:33-06	jc9	\N
\.


--
-- Data for Name: his_menus_pg_group; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY his_menus_pg_group (idcambio, idmenu, grosysid, fecha_alta, usuario_alta, cve_movto) FROM stdin;
121	16	\N	2019-10-31 12:53:33-06	jc9	b
122	16	\N	2019-10-31 12:53:33-06	jc9	b
123	59	\N	2019-10-31 12:53:33-06	jc9	b
124	60	\N	2019-10-31 12:53:33-06	jc9	b
125	47	\N	2019-10-31 12:53:33-06	jc9	b
126	61	\N	2019-10-31 12:53:33-06	jc9	b
127	61	\N	2019-10-31 12:53:33-06	jc9	b
\.


--
-- Name: his_menus_pg_group_idcambio_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('his_menus_pg_group_idcambio_seq', 127, true);


--
-- Name: his_menus_pg_group_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('his_menus_pg_group_seq', 1, false);


--
-- Data for Name: his_menus_pg_tables; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY his_menus_pg_tables (idcambio, idmenu, tablename, tselect, tinsert, tupdate, tdelete, tall, cve_movto, fecha_alta, usuario_modifico, tgrant) FROM stdin;
342	16	pg_authid	1	1	1	1	0	b	2019-10-31 12:53:33-06	jc9	 
343	16	menus_pg_group	 	 	 	 	1	b	2019-10-31 12:53:33-06	jc9	 
344	59	infracciones	1	1	1	1	0	b	2019-10-31 12:53:33-06	jc9	 
345	60	sanciones	1	1	1	1	0	b	2019-10-31 12:53:33-06	jc9	 
346	47	juzgados	1	1	1	1	0	b	2019-10-31 12:53:33-06	jc9	 
347	47	juzgados_idjuzgado_seq	1	0	1	0	0	b	2019-10-31 12:53:33-06	jc9	 
348	61	boletas	1	1	1	1	0	b	2019-10-31 12:53:33-06	jc9	 
\.


--
-- Name: his_menus_pg_tables_idcambio_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('his_menus_pg_tables_idcambio_seq', 348, true);


--
-- Data for Name: his_tablas_cambios; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY his_tablas_cambios (nspname, tabla, attnum, idregcambio, valor_anterior, valor_nuevo, usuario_alta, fecha_alta, idmenu) FROM stdin;
\.


--
-- Data for Name: menus; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus (idmenu, descripcion, objeto, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico, php, modoconsulta, idmenupadre, idmovtos, movtos, fuente, presentacion, columnas, tabla, reltype, filtro, limite, orden, menus_campos, dialogwidth, dialogheight, s_table, s_table_height, inicioregistros, nspname, css, imprime, limpiaralta, table_width, table_height, table_align, manual, noconfirmamovtos, icono, ayuda) FROM stdin;
1	Seguridad tablas		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio		0	0	0	i,d,u,s,l		2	1	menus_pg_tables	126341		100		0	0	0	0	300	f	forapi	pupanint.css	0	f	0.00	0.00					
2	Desbloque de usuario		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio		0	0	0	u		2	1	cat_usuarios	126000		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
3	Usuarios grupos		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio		0	0	0	i,d,u,s,l,f,a,ex		2	2	cat_usuarios_pg_group	126048		100	grosysid	0	0	0	0	300	f	forapi	pupanint.css	0	f	0.00	0.00					
4	Registro		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio		0	0	0	i		2	1	cat_usuarios	126000	usename is null	100	usename	0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
5	Historico Usuario		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio		0	0	0	s		2	2	his_cat_usuarios	126104		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
6	Solicita usuario a Desbloquear		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio		0	0	0	s,S		2	1	cat_usuarios	126000		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
7	Menus eventos		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio		0	0	0	i,d,u,s,a,l		2	2	menus_eventos	126274		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
8	accesosistema		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	accesosistema	0	0	0	i,d,u,s		2	2		0		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
11	Mtto a usuarios ventanilla		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	10	0	i,u,s,l,p,d,a		2	4	cat_usuarios	126000		50	nombre	0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
15	Autorizacion de personal		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	10	0	s,u,l,a		2	1	cat_usuarios	126000	estatus=0	100	fecha_alta desc	0	0	0	0	300	t	forapi	pupanint.css	0	t	0.00	0.00					
21	Grupos Menus		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio		0	0	0	i,d,u,s,a,l		2	2	menus_pg_group	126331		100		0	0	0	0	300	f	forapi	pupanint.css	0	f	0.00	0.00					
23	Carga LLave privada y publica		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	0	0	e		2	1	cat_usuarios	126000	usuario_alta is null	100		0	500	0	0	300	f	forapi	pupanint.css	0	t	30.00	0.00	center				
24	Cambio de Contraseña		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	0	0	u		2	1	cat_usuarios	126000	usename='jlv8'	1		0	0	0	0	300	t	forapi	pupanint.css	0	t	0.00	0.00					
25	Cambio de password		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	0	0	u		2	1	cat_usuarios	126000	cast(usename as text) = getpgusername()	100		0	0	0	0	300	t	forapi	pupanint.css	0	t	0.00	0.00					
26	Log de los menus		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	0	0	s,l,a.f		2	2	menus_log	126296		100	fecha_alta desc	0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
27	menus_movtos		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	0	0	i,d,u,s,l		2	2	menus_movtos	126321		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
28	menus_seguimiento		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	0	0	i,d,u,s,l,a		2	2	menus_seguimiento	126363		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
29	menus_tiempos		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	0	0	i,d,u,s,l,a		2	2	menus_tiempos	126389		100		0	0	0	0	300	f	forapi		0	t	0.00	0.00					
20	Campos de menus		2019-10-12 14:53:07-06	inicio	2019-10-20 19:41:22-06	inicio	man_menus.php	0	0	0	i,d,u,s,l,a,cc,f		2	2	menus_campos	126222		100	htmltable,orden	0	0	0	0	280	f	forapi	pupanint.css	0	f	0.00	0.00					
18	Autorizacion de registro		2019-10-12 14:53:07-06	inicio	2019-10-19 19:36:11-06	inicio	man_menus.php	0	10	0	s,u,l,a		2	2	cat_usuarios	126000	estatus=0	100	fecha_alta desc	0	0	0	0	300	t	forapi	pupanint.css	0	t	60.00	0.00	center				
10	Administración		2019-10-12 14:53:07-06	inicio	2019-10-27 07:57:17-06	inicio		0	0	0	i,d,u,s		2	2		0		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
9	Bienvenido		2019-10-12 14:53:07-06	inicio	2019-10-19 19:06:09-06	inicio		0	0	0	l,e,A		2	2	cat_usuarios	126000	usuario_alta is null	100		0	500	0	0	300	f	forapi	pupanint.css	0	t	40.00	0.00	center				
19	Registro Nuevo Usuario		2019-10-12 14:53:07-06	inicio	2019-10-19 19:07:54-06	inicio	man_menus.php	0	0	0	i,a		2	2	cat_usuarios	126000	usename is null	100	usename	0	0	0	0	300	f	forapi	pupanint.css	0	t	60.00	0.00	center				
30	Subvistas		2019-10-12 14:53:07-06	inicio	2019-10-28 19:41:15-06	jc9		0	0	0	i,d,u,s,l,a,cc		2	3	menus_subvistas	126370		100	orden	0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
12	Mtto a grupo de campos		2019-10-12 14:53:07-06	inicio	2019-10-29 14:01:00-06	jc9	man_menus.php	0	10	0	i,d,u,s,l,a		2	2	menus_htmltable	126283		100		0	0	0	0	300	t	forapi	pupanint.css	0	t	0.00	0.00					
13	Reingenieria		2019-10-12 14:53:07-06	inicio	2019-10-29 05:35:23-06	jc9	man_menus.php	0	10	0	s,i,a,l		2	1	tablas	126401		100	relname	0	0	0	0	300	f	forapi	pupanint.css	0	t	30.00	0.00	center				
17	Mtto a usuarios		2019-10-12 14:53:07-06	inicio	2019-10-31 11:28:59-06	jc9	man_menus.php	0	10	0	u,s,l,d,a,ex		2	2	cat_usuarios	126000		50	nombre	0	60	0	0	300	t	forapi	pupanint.css	0	t	60.00	0.00	center				
14	Mtto a menus		2019-10-12 14:53:07-06	inicio	2019-10-19 18:46:23-06	inicio	man_menus.php	0	10	0	i,d,u,s,l,cc,ex,a	select id_voluntario,no_cred_elect, nombre, apepat, apemat, domicilio, no_ext, id_entidad from cat_voluntarios 	2	2	menus	126182		100	fecha_alta desc	0	0	0	0	300	f	forapi	pupanint.css	1	t	80.00	0.00	center				
31	Importa desde Excel		2019-10-20 19:38:33-06	inicio	2019-10-28 11:58:19-06	jc9	man_menus.php	0	10	0	a,l,s		2	1	tablas	126401		100	relname	0	0	0	0	300	f	forapi	pupanint.css	0	t	30.00	0.00	center				
46	Importa desde script	\N	2019-10-28 18:51:03-06	jc9	2019-10-29 06:20:30-06	jc9	man_menus.php	\N	10	\N	i,d,u,s,l,a	\N	2	2	menus_scripts	134741	\N	100	fecha_modifico desc	0	90	0	0	300	t	forapi	\N	0	t	90.00	0.00	center	\N			
62	Mtto. Grupos de campos	\N	2019-10-29 14:01:00-06	jc9	2019-10-29 14:04:13-06	jc9	man_menus.php	\N	10	\N	i,d,u,s,l,a	\N	2	2	menus_htmltable	134448	\N	100	\N	0	0	0	0	300	t	forapi	\N	0	t	80.00	0.00	center	\N			
32	Catalogos		2019-10-27 07:50:24-06	inicio	2019-10-30 16:14:30-06	jc9		0	0	0	i,d,u,s		2	2		0		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
\.


--
-- Data for Name: menus_archivos; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_archivos (idarchivo, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico, version, idtipoarchivo, "tamaño", ubicacion) FROM stdin;
1	A_F01.xlsx	2019-10-20 09:12:54-06	temporal	2019-10-20 09:12:54-06	temporal	\N	0	0	\N
2	1a Quincena de enero 2017 Oficinas Centrales.xlsx	2019-10-20 09:20:47-06	temporal	2019-10-20 09:20:47-06	temporal	\N	0	0	\N
3	193_736262955.pdf	2019-10-20 09:32:58-06	temporal	2019-10-20 09:32:58-06	temporal	\N	0	0	\N
4	1a Quincena de enero 2017 Oficinas Centrales.xlsx	2019-10-20 09:40:41-06	temporal	2019-10-20 09:40:41-06	temporal	\N	0	0	\N
5	factura_201905.pdf	2019-10-20 09:52:28-06	temporal	2019-10-20 09:52:28-06	temporal	\N	0	0	\N
6	factura_201905.pdf	2019-10-20 09:58:00-06	temporal	2019-10-20 09:58:00-06	temporal	\N	0	0	\N
7	AnalisisDeFiltrosEnProteccionCivil.xlsx	2019-10-20 10:05:55-06	temporal	2019-10-20 10:05:55-06	temporal	\N	0	0	\N
8	VPN Windows.pdf	2019-10-20 13:43:52-06	temporal	2019-10-20 13:43:52-06	temporal	\N	0	0	\N
9	VPN Windows.pdf	2019-10-20 13:46:40-06	temporal	2019-10-20 13:46:40-06	temporal	\N	0	0	\N
10	AtenticacionLaravel.docx	2019-10-20 13:47:01-06	temporal	2019-10-20 13:47:01-06	temporal	\N	0	0	\N
11	VPN Windows.pdf	2019-10-20 13:48:08-06	temporal	2019-10-20 13:48:08-06	temporal	\N	0	0	\N
12	VPN Windows.pdf	2019-10-20 13:51:15-06	temporal	2019-10-20 13:51:15-06	temporal	\N	0	0	\N
13	AnalisisDeFiltrosEnProteccionCivil.xlsx	2019-10-20 13:57:14-06	temporal	2019-10-20 13:57:14-06	temporal	\N	0	0	\N
14	AnalisisDeFiltrosEnProteccionCivil.xlsx	2019-10-20 14:01:59-06	temporal	2019-10-20 14:01:59-06	temporal	\N	0	0	\N
15	DEJC CATALOGOS-ADIP.xlsx	2019-10-20 17:50:11-06	temporal	2019-10-20 17:50:11-06	temporal	\N	0	0	\N
16	DEJC CATALOGOS-ADIP.xlsx	2019-10-20 18:24:11-06	temporal	2019-10-20 18:24:11-06	temporal	\N	0	0	\N
17	AnalisisDeFiltrosEnProteccionCivil.xlsx	2019-10-31 10:58:36-06	jc9	2019-10-31 10:58:36-06	jc9	\N	0	0	\N
18	AnalisisDeFiltrosEnProteccionCivil.xlsx	2019-10-31 11:08:31-06	jc9	2019-10-31 11:08:31-06	jc9	\N	0	0	\N
19	AnalisisDeFiltrosEnProteccionCivil.xlsx	2019-10-31 12:13:07-06	jc9	2019-10-31 12:13:07-06	jc9	\N	0	0	\N
\.


--
-- Name: menus_archivos_idarchivo_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_archivos_idarchivo_seq', 19, true);


--
-- Data for Name: menus_campos; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_campos (idcampo, idmenu, reltype, attnum, descripcion, size, male, fuente, fuente_campodes, fuente_campodep, fuente_campofil, fuente_where, fuente_evento, orden, idsubvista, dialogwidth, dialogheight, obligatorio, busqueda, altaautomatico, tcase, checaduplicidad, readonly, valordefault, esindex, tipayuda, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico, espassword, tabla, nspname, fuente_busqueda, val_particulares, htmltable, fuente_nspname, altaautomatico_idmenu, fuente_busqueda_idmenu, upload_file, formato_td, colspantxt, rowspantxt, autocomplete, imprime, totales, cambiarencambios, link_file, fuente_info, fuente_info_idmenu, fuente_actu, fuente_actu_idmenu, eshidden, fila, clase) FROM stdin;
1	25	126000	0	PasswordNuevo	30	30						0	20	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N
7	2	126000	0	Respuesta_	50	50						0	0	0	0	0	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	0	\N
8	4	126000	0	TecleeDeNuevoPassword	20	30						0	250	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	250	\N
9	11	126000	0	Password	20	20						0	160	0	0	0	f	f	f	0	f	f		f	password	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	160	\N
11	25	126000	0	TecleedeNuevoPassword	30	30						0	30	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N
12	25	126000	0	PasswordAnterior	30	30						0	10	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N
13	24	126000	0	TecleedeNuevoPassword	30	30						0	30	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N
15	23	126000	0	LLavePrivada	10	10						0	15	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	t	0	0	0	0	t	f	t	f	f	0	f	0	f	15	\N
16	23	126000	0	LLavePublica	10	10						0	10	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	t	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N
18	5	126104	1	idcambio	8	0						0	10	0	40	30	f	f	f	0	f	t		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N
19	21	126331	1	Opcion:	0	0	menus	descripcion	idmenu			0	10	0	40	30	f	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_group	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N
20	11	126000	1	Usuario	20	15						0	10	0	40	30	t	t	f	2	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	10	\N
22	2	126000	1	usename	19	0						0	10	0	40	30	t	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N
23	25	126000	0	Usuario	30	30						0	5	0	0	0	t	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	5	\N
32	24	126000	1	Usuario	30	30						0	5	0	0	0	t	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	5	\N
33	3	126048	1	Usuario	1	0	cat_usuarios	usename	usename			0	10	0	40	30	t	t	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios_pg_group	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N
10	19	126000	0	TecleeDeNuevoelpassword	30	30						0	250	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6
14	18	126000	0	Password	20	30						0	0	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6
34	18	126000	1	Usuario	20	15						0	10	0	40	30	f	t	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6
17	20	126222	1	Idcampo	30	0						0	110	0	40	30	f	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6
285	20	126222	54	Fila	30	100						0	400	0	0	0	f	f	f	0	f	f		f		2019-10-19 15:45:56-06	inicio	2019-10-19 15:45:56-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	160	col-md-6
27	1	126341	1	idmenu	0	0						0	800	0	40	30	f	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	800	\N
35	4	126000	1	Usuario	10	15						0	10	0	40	30	t	f	f	2	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N
36	26	126296	1	idlog	8	0						0	900	0	40	30	t	f	f	0	f	t		t	registro en la tabla	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	900	\N
40	27	126321	1	idmenu	8	0						0	10	0	40	30	t	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N
41	28	126363	1	idseguimietno	8	0						0	10	0	40	30	t	f	f	0	f	t		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_seguimiento	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N
42	2	126000	2	Nombre	30	0						0	20	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N
43	15	126000	2	Nombre	20	30						0	20	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N
44	4	126000	2	Nombre	20	30						0	20	0	40	30	t	f	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N
45	27	126321	2	idmovto	5	0						0	20	0	40	30	f	f	f	0	f	f		t	i=insert,d=delete,s=select,u=upate,l=limpiar	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N
48	1	126341	2	Tabla	0	0	tablas	relname	relname	nspname		1	12	0	40	30	f	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	12	\N
49	28	126363	2	idmenu	8	0						0	20	0	40	30	t	f	f	0	f	f		f	Numero de menu a dar seguimietno si 9999999=todos	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_seguimiento	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N
54	26	126296	2	idmenu	1	0	menus	descripcion	idmenu			0	20	0	40	30	t	t	f	0	f	f		f	Numero de menu que utilizo el usuario	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N
57	5	126104	2	usename	19	0						0	20	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N
37	9	126000	1	Usuario	0	0						0	10	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6
47	19	126000	2	Nombre	30	30						0	20	0	40	30	t	f	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6
52	20	126222	2	Menu	1	0	menus	descripcion	idmenu			0	120	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6
56	14	126182	2	Descripcion	99	0						0	20	0	40	30	t	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	80	3	0	t	f	t	f	f	0	f	0	f	20	col-md-6
51	11	126000	2	Nombre	20	30						0	20	0	40	30	t	t	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	20	\N
59	7	126274	2	idmenu	8	0						0	20	0	40	30	f	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N
38	12	126283	1	idhtmltable	8	-1						0	10	0	40	30	t	f	f	0	f	t		t	Numero de identificacion de la tabla	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6
31	13	126401	1	Tabla	0	0						0	11	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	tablas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-12
29	17	126000	1	Usuario	20	15						0	10	0	40	30	t	t	f	2	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	f	f	f	0	f	0	f	20	col-md-6 row
60	4	126000	3	Apellido Paterno	20	30						0	30	0	40	30	f	f	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N
61	5	126104	3	nombre	30	0						0	30	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N
62	3	126048	3	Fecha alta	30	0						0	30	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios_pg_group	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N
65	7	126274	3	idevento	1	0	eventos	descripcion	idevento			0	30	0	40	30	t	f	t	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N
68	27	126321	3	descripcion	30	0						0	30	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N
69	2	126000	3	Apellido Paterno	30	0						0	30	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N
70	1	126341	3	tselect	1	1						0	13	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	13	\N
72	28	126363	3	usename	24	0						0	30	0	40	30	f	f	f	0	f	f		f	Usuario a dar seguimiento *=todos	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_seguimiento	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N
73	15	126000	3	Paterno	20	30						0	30	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N
79	5	126104	4	apepat	30	0						0	40	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N
80	7	126274	4	donde	4	0						0	40	0	40	30	t	f	f	0	f	f		t	0=cliente 1=servidor	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N
81	1	126341	4	tinsert	1	1						0	14	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	14	\N
71	19	126000	3	Apellido Paterno	30	30						0	30	0	40	30	f	f	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6
50	18	126000	2	Nombre	20	30						0	20	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6
64	18	126000	3	Paterno	20	30						0	30	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6
75	26	126296	3	movto	5	0						0	910	0	40	30	f	f	f	0	f	t		f	Movimiento que hizo el usuario	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	910	\N
77	11	126000	3	Paterno	20	30						0	30	0	40	30	f	t	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	30	\N
84	28	126363	4	fecha_alta	18	0						0	40	0	40	30	f	f	f	0	f	t		f	Fecha en que hizo el movimiento	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_seguimiento	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N
63	12	126283	3	esdesistema	1	-1						0	30	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6
66	17	126000	3	Paterno	20	30						0	30	0	40	30	f	t	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6 row
82	17	126000	4	Materno	20	30						0	40	0	40	30	f	t	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6 row
85	11	126000	4	Materno	20	30						0	40	0	40	30	f	t	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	40	\N
86	15	126000	4	Materno	20	30						0	40	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N
87	27	126321	4	imagen	30	0						0	40	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N
90	4	126000	4	Apellido Materno	20	30						0	40	0	40	30	f	f	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N
91	26	126296	4	sql	-1	0						0	40	0	40	30	f	t	f	0	f	f		f	Movimiento que hizo el usuario	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N
92	2	126000	4	Apellido Materno	30	0						0	40	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N
93	3	126048	4	Fecha modifico	30	0						0	40	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios_pg_group	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N
101	26	126296	5	fecha_alta	18	0						0	10	0	40	30	f	f	f	0	f	t		f	Fecha en que hizo el movimiento el usuario	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N
102	28	126363	5	usuario_alta	24	0						0	50	0	40	30	f	f	f	0	f	t		f	Usuario hizo el alta 	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_seguimiento	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	50	\N
103	7	126274	5	descripcion	30	0						0	50	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	50	\N
96	20	126222	4	Campo	1	0	campos	attname	attnum	tabla,nspname		2	130	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6
95	19	126000	4	Apellido Materno	30	30						0	40	0	40	30	f	f	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6
94	18	126000	4	Materno	20	30						0	40	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6
97	18	126000	5	Puesto	20	50						0	50	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6
99	15	126000	5	Puesto	20	50						0	50	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	50	\N
100	1	126341	5	tupdate	1	1						0	15	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	15	\N
105	3	126048	5	Usuario alta	30	0						0	50	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios_pg_group	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	50	\N
106	5	126104	5	apemat	30	0						0	50	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	50	\N
107	27	126321	5	fecha_alta	18	0						0	50	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	50	\N
89	12	126283	4	Columnas:	4	-1						0	40	0	40	30	f	f	f	0	f	f		f	Numero de columnas en la tabla si es cero pone las columnas de la tabla maestra	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6
78	13	126401	4	Esquema	1	30	pg_namespace	nspname	nspname			0	0	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	tablas	forapi	f		0	pg_catalog	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-12
110	26	126296	6	usuario_alta	24	0						0	60	0	40	30	f	f	f	0	f	t		f	Usuario hizo el alta 	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	\N
111	5	126104	6	puesto	30	0						0	60	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	\N
112	27	126321	6	usuario_alta	24	0						0	60	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	\N
114	3	126048	6	Usuario modifico	30	0						0	60	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios_pg_group	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	\N
115	7	126274	6	fecha_alta	18	0						0	60	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	\N
117	1	126341	6	tdelete	1	1						0	16	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	16	\N
121	7	126274	7	usuario_alta	24	0						0	70	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	70	\N
127	11	126000	7	Mail	20	0						0	70	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	70	\N
119	18	126000	6	Depto	20	50						0	60	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6
108	20	126222	5	Descripcion	30	0						0	140	0	40	30	t	f	f	0	f	f		f	Descripcion del campo en la vista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6
120	20	126222	6	Tamaño	30	2						0	150	0	40	30	f	f	f	0	f	f		f	size en el html, para el caso de select la cantidad de renglones	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6
122	27	126321	7	fecha_modifico	18	0						0	70	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	70	\N
123	2	126000	7	Correo Electronico	30	0						0	70	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	70	\N
130	4	126000	7	Correo	20	50						0	70	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	70	\N
133	5	126104	7	depto	30	0						0	70	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	70	\N
134	1	126341	7	tall	1	1						0	17	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	17	\N
135	3	126048	7	Grupo:	0	0	pg_group	groname	groname			0	15	0	40	30	t	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios_pg_group	forapi	f		0	pg_catalog	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	15	\N
116	12	126283	6	usuario_alta	24	24						0	60	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6
124	17	126000	7	Mail	20	0						0	70	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6 row
136	26	126296	7	Es movil:	0	0						0	180	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	180	\N
138	27	126321	8	usuario_modifico	24	0						0	80	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	\N
140	1	126341	8	fecha_alta	0	0						0	19	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	19	\N
143	21	126331	8	Grupo	30	30						0	30	0	40	30	t	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_group	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N
144	5	126104	8	correoe	30	0						0	80	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	\N
145	7	126274	8	fecha_modifico	18	0						0	80	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	\N
149	1	126341	9	fecha_modifico	0	0						0	20	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N
150	26	126296	9	IP:	0	0						0	150	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	150	\N
142	14	126182	8	PHP	20	30						0	40	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6
132	20	126222	7	Longitud	30	4						0	160	0	40	30	f	f	f	0	f	f		f	Maxima longitud permitida en el html	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6
137	20	126222	8	Fuente	1	0	tablas	relname	relname	fuente_nspname		1	170	0	40	30	f	f	f	0	f	f		f	Para el campo select se indica la tabla que se va utilizar para seleccionar los valores	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	360	col-md-6
146	26	126296	8	Browser:	0	0						0	160	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	160	\N
151	11	126000	9	Fecha alta	20	14						0	200	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	200	\N
152	5	126104	9	direccion_ip	30	0						0	90	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	90	\N
157	7	126274	9	usuario_modifico	24	0						0	90	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	90	\N
159	1	126341	10	usuario_alta	0	0						0	21	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	21	\N
160	26	126296	10	Mensaje:	1	1	menus_mensajes	mensaje	idmensaje			0	50	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	50	\N
161	11	126000	10	Fecha modifico	20	14						0	220	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	220	\N
166	5	126104	10	fecha_alta	18	0						0	100	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	\N
171	1	126341	11	usuario_modifico	0	0						0	22	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	22	\N
172	5	126104	11	fecha_modifico	18	0						0	110	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	110	\N
173	11	126000	11	Usuario alta	20	20						0	210	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	210	\N
201	14	126182	15	Columnas	20	5						0	57	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6
154	18	126000	9	Fecha alta	20	14						0	90	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6
162	18	126000	10	Fecha modifico	20	14						0	100	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6
158	20	126222	9	Descripcion	1	0	campos	attname	attname	fuente_nspname,fuente		2	180	0	40	30	f	f	f	0	f	f		f	se indica el nombre del campo en que va mostrar en la seleccion	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	380	col-md-6
163	20	126222	10	Liga	1	0	campos	attname	attname	fuente_nspname,fuente		2	190	0	40	30	f	f	f	0	f	f		f	se indica el nombre del campo del cual vale la descripcion	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	380	col-md-6
178	1	126341	12	tgrant	1	1						0	18	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	18	\N
181	11	126000	12	Usuario modifico	20	20						0	230	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	230	\N
183	5	126104	12	idpregunta	4	0						0	120	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	\N
184	11	126000	13	Pregunta	1	1	cat_preguntas	descripcion	idpregunta			0	130	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	130	\N
186	4	126000	13	Pregunta	3	2	cat_preguntas	descripcion	idpregunta			0	130	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	130	\N
187	1	126341	13	Esquema	0	0	pg_namespace	nspname	nspname			0	5	0	40	30	t	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0	pg_catalog	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	5	\N
190	2	126000	13	idpregunta	4	0	cat_preguntas	descripcion	idpregunta			0	130	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	130	\N
192	5	126104	13	respuesta	30	0						0	130	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	130	\N
194	4	126000	14	Respuesta	20	50						0	140	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	\N
153	17	126000	9	Fecha alta	20	14						0	200	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6 row
174	20	126222	11	Filtros	30	0						0	200	0	40	30	f	f	f	0	f	f		f	se indica el nombre del campo del cual tiene un filtro, si hay varios separados por, se liga campos de la fuente contra campos de la tabla del menu, si el filtro compara que no son iguales esto se incluye con un;	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	400	col-md-6
176	20	126222	12	Condicion WHERE	30	0						0	202	0	40	30	f	f	f	0	f	f		f	Filtro a aplicar en la fuente si queremos que tome valores de la pantalla al nombre hay que anteponer wl_	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	400	col-md-6
175	18	126000	11	Usuario alta	20	20						0	110	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6
196	5	126104	14	estatus	4	0						0	140	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	\N
200	11	126000	14	Respuesta	20	100						0	140	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	140	\N
202	11	126000	15	Estatus	1	5	estados_usuarios	descripcion	estado			0	150	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	150	\N
203	5	126104	15	telefono	30	0						0	150	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	150	\N
206	15	126000	15	Estatus	10	5						0	150	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	150	\N
210	11	126000	16	Telefono	20	30						0	75	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	75	\N
211	5	126104	16	cve_movto	5	0						0	160	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	160	\N
212	14	126182	16	Tabla	1	30	tablas	relname	relname	nspname		2	55	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6
198	18	126000	14	Respuesta	20	100						0	140	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6
207	18	126000	15	Estatus	10	5						0	150	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	160	col-md-6
199	20	126222	14	Orden	30	0						0	135	0	40	30	f	f	f	0	f	f		f	Campo por el cual se va a ordenar la información	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6
253	19	126000	30	Foto:	0	0						0	80	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	t	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6
213	17	126000	16	Telefono	20	30						0	75	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6 row
191	17	126000	13	Pregunta	1	1	cat_preguntas	descripcion	idpregunta			0	130	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6 row
179	17	126000	12	Usuario modifico	20	20						0	230	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	160	col-md-6 row
208	20	126222	15	Subvista	30	0						0	300	0	40	30	f	f	f	0	f	f		f	Si el campos tiene una subvista, habre este numbero de subvista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6
209	20	126222	16	Ancho Subvista	30	0						0	320	0	40	30	f	f	f	0	f	f		f	Ancho de la subvista 	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6
215	5	126104	17	id_personas	8	0						0	170	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	170	\N
228	4	126000	21	Password	20	30						0	240	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	240	\N
231	11	126000	21	pwd	20	20						0	240	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	240	\N
241	17	126000	24	Menu default	1	5	menus	descripcion	idmenu			0	155	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6 row
220	14	126182	18	Filtro	20	255						0	70	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6
230	19	126000	21	Password	30	30						0	240	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6
234	14	126182	22	Ancho de ventana	20	10						0	120	0	40	30	f	f	f	0	f	f		f	Ancho en abrir la subvista esta en pixeles	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6
260	20	126222	33	Esquema	1	0	pg_namespace	nspname	nspname			0	123	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0	pg_catalog	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6
258	20	126222	32	Tabla	1	30	tablas	relname	relname	nspname		2	125	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6
217	20	126222	17	Alto Subvista	30	0						0	325	0	40	30	f	f	f	0	f	f		f	Alto de la subvista 	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6
238	11	126000	23	Tipo menu	20	5						0	145	0	0	0	f	f	f	0	f	f		f	0=normal 1=vertical 2=horizontal	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	145	\N
252	19	126000	29	Numero de telefono:	30	50						0	70	0	40	30	t	f	f	2	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6
243	11	126000	24	Menu default	1	5	menus	descripcion	idmenu			0	155	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	155	\N
263	20	126222	35	Validacion	30	30						0	1200	0	40	30	f	f	f	0	f	f		f	Indica la validacion especial que se incorpora para este campo	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	260	col-md-6
248	20	126222	26	Tip de ayuda	30	255						0	1200	0	40	30	f	f	f	0	f	f		f	Ayuda que se muestra cuando es mouse esta en el campo	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	260	col-md-6
259	14	126182	33	Alineacion de tabla	20	10						0	200	0	40	30	f	f	f	2	f	f		f	Alto en porcentaje de la tabla de captura	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	200	col-md-6
226	14	126182	20	Orden	20	255						0	990	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	220	col-md-6
242	20	126222	24	Valor de Default	30	100						0	400	0	0	0	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	160	col-md-6
240	20	126222	23	Solo lectura?	30	0						0	900	0	40	30	f	f	f	0	f	f		f	Este dato no se puede modificar	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	240	col-md-6
246	20	126222	25	Iindex?	30	0						0	1100	0	40	30	f	f	f	0	f	f		f	Define este como index ya que existe el caso de las vistas que no tienen indices	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	240	col-md-6
262	20	126222	34	Busqueda?	30	0						0	205	0	0	0	f	f	f	0	f	f		f	En un campos con opciones se utilizar para hacer una busqueda	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	t		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	440	col-md-6
24	15	126000	1	Usuario	20	15						0	10	0	40	30	f	t	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N
278	20	126222	47	Permitir cambios?	30	0						0	510	0	0	0	f	f	f	0	f	f		f	Con este campo se control que no se puedan cambiar datos en cambios, especificamente sirve para los campos de busqueda	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	f	f	t	f	f	0	f	0	f	200	col-md-6
167	14	126182	10	Menu Padre	1	20	menus	descripcion	idmenu			0	65	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6
28	7	126274	1	idmenus_eventos	8	0						0	10	0	40	30	f	f	f	0	f	t		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N
25	19	126000	1	Usuario	30	15						0	10	0	40	30	t	f	f	2	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6
265	20	126222	36	Tabla HTML	1	0	menus_htmltable	descripcion	idhtmltable			0	137	0	0	0	f	f	t	0	f	f		f	Grupo de campos	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6
229	14	126182	21	Campos de menu	1	255	menus	descripcion	idmenu			0	110	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6
282	20	126222	51	Actualizacion?	30	1						0	625	0	40	30	f	f	f	0	f	f		f	Permite modificar el contenido del campo select	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	500	col-md-6
283	20	126222	52	Menu actualizacion	1	1	menus	descripcion	idmenu			0	630	0	40	30	f	f	f	0	f	f		f	Subvista que se utiliza para modificar la informacion	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	500	col-md-6
177	14	126182	12	Movtos	20	30						0	60	0	40	30	t	f	f	0	f	f		f	i=insert,d=delete,u=update,l=limpiar,cc=copiar,a=autodiseño,I=AltaAutomatica,s=Select,S=select sin opcion de seleccionar registro,f=Genera un archivo txt de la consulta,B=Busqueda	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6
264	14	126182	35	No Confirma movtos.	10	10						0	63	0	40	30	f	f	f	0	f	f		f	No confirma los movimientos por ejemplo si se pone una i no confirma las altas	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6
222	14	126182	19	Limite	20	10						0	80	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6
239	14	126182	23	Altura de ventana	20	10						0	140	0	40	30	f	f	f	0	f	f		f	Altura en que va abrir la subvista esta en pixeles	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	160	col-md-6
247	14	126182	26	Muestra Registros al Inicio	0	0						0	995	0	0	0	f	f	f	0	f	f		f	Indica si muestra los registro al mostrar la pantalla	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	220	col-md-6
67	14	126182	3	Objeto	20	30						0	30	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6
148	14	126182	9	Modo consulta	20	5						0	50	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6
284	20	126222	53	Dato escondido?	1	1						0	1265	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	340	col-md-6
281	20	126222	50	Menu informacion	1	1	menus	descripcion	idmenu			0	620	0	40	30	f	f	f	0	f	f		f	Indica que subvista se utiliza para mostrar la informacion	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	480	col-md-6
2	23	126000	0	Password	0	0						0	20	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N
4	6	126000	0	Usuario	0	0						0	0	0	0	0	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	0	\N
5	24	126000	0	PasswordNuevo	30	30						0	20	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N
3	9	126000	0	Password	0	0						0	20	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6
250	14	126182	28	Hoja de estilo	20	50						0	998	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	240	col-md-6
254	14	126182	30	LimpiarAlta	20	1						0	1000	0	40	30	f	f	f	0	f	f		f	Limpia la pantalla despues de dar de alta	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	260	col-md-6
251	14	126182	29	Imprime	20	1						0	1000	0	40	30	f	f	f	0	f	f		f	0=todo,1=tabla de captura,2=tabla de renglones	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	260	col-md-6
261	14	126182	34	Manual	20	500						0	1100	0	40	30	f	t	f	0	f	f		f	Manual del sistema	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	80	3	0	t	f	t	f	f	0	f	0	f	280	col-md-6
267	14	126182	37	Ayuda	0	0						0	1300	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	280	col-md-6
266	14	126182	36	Icono	0	0						0	1300	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	300	col-md-6
21	14	126182	1	Idmenu	20	5						0	1000	0	800	600	f	f	f	0	f	t		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	t	240	col-md-6
256	14	126182	31	Ancho de tabla	20	10						0	180	0	40	30	f	f	f	0	f	f		f	Ancho en porcentaje de la tabla de captura	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	180	col-md-6
257	14	126182	32	Alto de tabla	20	10						0	190	0	40	30	f	f	f	0	f	f		f	Alto en porcentaje de la tabla de captura	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	200	col-md-6
286	20	126222	55	Clase	30	100						0	410	0	0	0	f	f	f	0	f	f		f		2019-10-19 18:37:08-06	inicio	2019-10-19 18:37:08-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6
182	18	126000	12	Usuario modifico	20	20						0	120	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6
188	18	126000	13	Pegunta	1	0	cat_preguntas	descripcion	idpregunta			0	130	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6
125	18	126000	7	Mail	20	50						0	70	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6
288	31	126401	4	Esquema	1	30						0	0	0	40	30	t	f	f	0	f	f		f		2019-10-20 19:38:33.016632-06	inicio	2019-10-20 19:38:33.016632-06	inicio	0	tablas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-12
287	31	126401	1	Tabla	0	0						0	11	0	40	30	t	f	f	0	f	f		f		2019-10-20 19:38:33.016632-06	inicio	2019-10-20 19:38:33.016632-06	inicio	0	tablas	forapi	f		0		0	0	t	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-12
218	20	126222	18	Obligatorio?	30	0						0	400	0	40	30	f	f	f	0	f	f		f	El campo es obligatorio	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	180	col-md-6
223	20	126222	19	Busqueda?	30	0						0	500	0	40	30	f	f	f	0	f	f		f	El campos se puede utilizar en consulta de informacion	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	180	col-md-6
227	20	126222	21	Case	1	0	tcases	descripcion	tcase			0	700	0	40	30	f	f	f	0	f	f		f	Los datos se convierte a mayusculas o minusculas	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	200	col-md-6
235	20	126222	22	Valida duplicidad?	30	0						0	800	0	40	30	f	f	f	0	f	f		f	Maxima longitud permitida en el html	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	220	col-md-6
255	20	126222	31	Password?	30	4						0	800	0	0	0	f	f	f	0	f	f		f	1=es pwd 2=subir un archivo(pendiente)	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	220	col-md-6
271	20	126222	40	SubeArchivo	30	30						0	1210	0	40	30	f	f	f	0	f	f		f	Indica si el campo sirver para subir un archivo	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	280	col-md-6
276	20	126222	45	Imprime	30	30						0	1212	0	40	30	f	f	f	0	f	f		f	Indica si el campo se imprime	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	280	col-md-6
277	20	126222	46	Totales	30	30						0	1220	0	40	30	f	f	f	0	f	f		f	Indica si se imprimen totales de un columna	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	300	col-md-6
272	20	126222	41	Formato td	30	1						0	1230	0	40	30	f	f	f	0	f	f		f	0=normal,1=etiqueta y texto junto, 2=Etiqueta y texto junto todo el renglón	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	300	col-md-6
274	20	126222	43	No. de filas	30	3						0	1240	0	40	30	f	f	f	0	f	f		f	Registros para el campos textarea	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	320	col-md-6
273	20	126222	42	No.de columnas	30	3						0	1250	0	40	30	f	f	f	0	f	f		f	Columnas para el campos textarea	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	320	col-md-6
279	20	126222	48	Enlace?	30	30						0	1260	0	40	30	f	f	f	0	f	f		f	Indica si el campo es un link	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	340	col-md-6
268	20	126222	37	Esquema	1	30	pg_namespace	nspname	nspname			0	165	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	pg_catalog	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	360	col-md-6
185	20	126222	13	Evento	30	0						0	203	0	40	30	f	f	f	0	f	f		f	En que evento se cargan los campos select 0=cuando la forma se carga,1=cuando el campo padre cambia,2=cuando el campo recibe el focus,3=cuando el campo recibe el focus solo la primera vez	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	420	col-md-6
275	20	126222	44	Autocompletar	30	1						0	204	0	40	30	f	f	f	0	f	f		f	0=no, 1=si	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	420	col-md-6
270	20	126222	39	Menu busqueda	1	0	menus	descripcion	idmenu			0	207	0	0	0	f	f	f	0	f	f		f	No. de menu para buscar datos	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	440	col-md-6
225	20	126222	20	Alta automatica?	30	0						0	600	0	40	30	f	f	f	0	f	f		f	Para los campos select se pueden dar de alta una descripcion	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	460	col-md-6
269	20	126222	38	Menu alta en automatico	1	1	menus	descripcion	idmenu			0	610	0	40	30	f	f	f	0	f	f		f	Indica que subvista se utiliza para dar de alta un registro	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	460	col-md-6
280	20	126222	49	Informacion?	30	1						0	615	0	40	30	f	f	f	0	f	f		f	Muestra informacion relevante del contenido del campo select	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	480	col-md-6
249	14	126182	27	Esquema	1	0	pg_namespace	nspname	nspname			0	52	0	0	0	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0	pg_catalog	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6
244	14	126182	24	Pone Scroll	20	1						0	150	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	160	col-md-6
245	14	126182	25	Altura de Scroll	20	10						0	160	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	180	col-md-6
380	46	134741	1	idscript	8	-1					\N	0	10	\N	40	30	t	f	f	0	\N	t	\N	t	id del script	2019-10-28 18:51:03-06	jc9	2019-10-28 18:51:03-06	jc9	0	menus_scripts	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	20	col-md-4
383	46	134741	4	fecha_alta	18	0					\N	0	40	\N	40	30	f	f	f	0	\N	t	\N	f	Fecha en que hizo el movimiento el usuario	2019-10-28 18:51:03-06	jc9	2019-10-28 18:51:03-06	jc9	0	menus_scripts	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	40	col-md-4
384	46	134741	5	usuario_alta	24	24					\N	0	50	\N	40	30	f	f	f	0	\N	t	\N	f	Usuario hizo el alta 	2019-10-28 18:51:03-06	jc9	2019-10-28 18:51:03-06	jc9	0	menus_scripts	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	40	col-md-4
385	46	134741	6	fecha_modifico	18	0					\N	0	60	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-28 18:51:03-06	jc9	2019-10-28 18:51:03-06	jc9	0	menus_scripts	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	40	col-md-4
386	46	134741	7	usuario_modifico	24	24					\N	0	70	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-28 18:51:03-06	jc9	2019-10-28 18:51:03-06	jc9	0	menus_scripts	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	60	col-md-4
381	46	134741	2	descripcion	30	104					\N	0	20	\N	40	30	f	f	f	0	\N	f	\N	f		2019-10-28 18:51:03-06	jc9	2019-10-28 18:51:03-06	jc9	0	menus_scripts	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-6
382	46	134741	3	sql	-1	-1					\N	0	30	\N	40	30	f	f	f	0	f	f	\N	f	instruccion	2019-10-28 18:51:03-06	jc9	2019-10-28 18:51:03-06	jc9	0	menus_scripts	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-6
232	30	126370	21	Orden	4	4						0	0	0	0	0	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-4
30	30	126370	1	idmenus_subvistas	0	0						0	10	0	40	30	t	f	f	0	f	t		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-4
53	30	126370	2	idmenu	0	0						0	20	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-4
76	30	126370	3	texto	0	0						0	30	0	40	30	f	f	f	0	f	f		f	Texto para activas la subvista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-4
83	30	126370	4	imagen	0	0						0	40	0	40	30	f	f	f	0	f	f		f	Imagen que aparece para activar la subvista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-4
109	30	126370	5	idsubvista	0	0	menus	descripcion	idmenu			0	50	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-4
221	30	126370	19	Clase	0	0						0	58	0	40	30	f	f	f	0	f	f		f	Clase que se va a ejecutar en el servidor	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-4
118	30	126370	6	funcion	0	0						0	60	0	40	30	f	f	f	0	f	f		f	Funcion que se va a ejecutar en el servidor	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-4
236	30	126370	22	Ventana	1	1						0	65	0	40	30	f	f	f	0	f	f		f	0=showModalDialog,1=showModelessDialog,2=open,3=misma ventana	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-4
128	30	126370	7	dialogwidth	0	0						0	70	0	40	30	f	f	f	0	f	f		f	El ancho que va a tener la subvista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-4
139	30	126370	8	dialogheight	0	0						0	80	0	40	30	f	f	f	0	f	f		f	La altura que va a tener la subvista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-4
164	30	126370	10	donde	0	0						0	100	0	40	30	f	f	f	0	f	f		f	En donde se va a ejecutar el evento antes de abrir la subvista 0=cliente 1=servidor	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-4
170	30	126370	11	eventos_antes	0	0						0	110	0	40	30	f	f	f	0	f	f		f	Funcion que se va a ejecutar antes de abrir la subvista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-4
180	30	126370	12	eventos_despues	0	0						0	120	0	40	30	f	f	f	0	f	f		f	Funcion que se va a ejecutar despues de abrir la subvista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-4
189	30	126370	13	campo_filtro	0	0						0	130	0	40	30	f	f	f	0	f	f		f	Nombre del campo de la subvista el cual se va hacer el filtro, mas de uno es separado por ;	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-4
195	30	126370	14	valor_padre	0	0						0	140	0	40	30	f	f	f	0	f	f		f	Valor del campo padre, este lo toma de los campos de captura	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-4
224	30	126370	20	Posicion	1	1						0	145	0	0	0	f	f	f	0	f	f		f	posicion dondes se ubica el boton o subvistas 0=registro, 1=cabecera	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-4
205	30	126370	15	fecha_alta	0	0						0	150	0	40	30	f	f	f	0	f	t		f	Fecha en que el usuario dio de alta el registro	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-4
156	30	126370	9	Esboton	1	1						0	150	0	40	30	f	f	f	0	f	f		f	0=link,1=boton,2=menu select	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-4
214	30	126370	16	usuario_alta	0	0						0	160	0	40	30	f	f	f	0	f	t		f	Usuario que dio de alta el registro	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-4
216	30	126370	17	fecha_modifico	0	0						0	170	0	40	30	f	f	f	0	f	t		f	Fecha en que el usuario modifico el registro	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-4
219	30	126370	18	usuario_modifico	0	0						0	180	0	40	30	f	f	f	0	f	t		f	Usuario que modifico el registro	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	160	col-md-4
590	62	134448	1	Numero de identificacion de la tabla	8	-1					\N	0	10	\N	40	30	t	f	f	0	\N	t	\N	t	Numero de identificacion de la tabla	2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6061	
594	62	134448	5	fecha_alta	18	-1					\N	0	50	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6141	
595	62	134448	6	usuario_alta	24	24					\N	0	60	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6161	
596	62	134448	7	fecha_modifico	18	-1					\N	0	70	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6181	
597	62	134448	8	usuario_modifico	24	24					\N	0	80	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6201	
46	12	126283	2	Descripción:	30	259						0	20	0	40	30	f	f	f	1	f	f		f	Caption que va a tener la tabla	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6
165	12	126283	10	Orden del grupo:	3	3						0	45	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6
104	12	126283	5	fecha_alta	18	-1						0	50	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6
129	12	126283	7	fecha_modifico	18	-1						0	70	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6
147	12	126283	8	usuario_modifico	24	24						0	80	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6
591	62	134448	2	Caption que va a tener la tabla	30	259					\N	0	20	\N	40	30	f	f	f	0	\N	f	\N	f	Caption que va a tener la tabla	2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-6
592	62	134448	3	esdesistema	1	-1					\N	0	30	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-6
593	62	134448	4	Numero de columnas en la tabla si es cero pone las columnas de la tabla maestra	4	-1					\N	0	40	\N	40	30	f	f	f	0	\N	f	\N	f	Numero de columnas en la tabla si es cero pone las columnas de la tabla maestra	2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	40	col-md-6
598	62	134448	9	Id del menu a la que pertenece el grupo de campos	8	-1					\N	0	90	\N	40	30	f	f	f	0	\N	f	\N	f	Id del menu a la que pertenece el grupo de campos	2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	40	col-md-6
599	62	134448	10	orden del grupo de campos	8	-1					\N	0	100	\N	40	30	f	f	f	0	\N	f	\N	f	orden del grupo de campos	2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	60	col-md-6
55	17	126000	2	Nombre	20	30						0	20	0	40	30	t	t	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6 row
197	17	126000	14	Respuesta	20	100						0	140	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6 row
237	17	126000	23	Tipo menu	20	5						0	145	0	0	0	f	f	f	0	f	f		f	0=normal 1=vertical 2=horizontal	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6 row
204	17	126000	15	Estatus	1	5	estados_usuarios	descripcion	estado			0	150	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6 row
169	17	126000	11	Usuario alta	20	20						0	210	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6 row
168	17	126000	10	Fecha modifico	20	14						0	220	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6 row
\.


--
-- Data for Name: menus_campos_eventos; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_campos_eventos (icv, attnum, idmenu, idevento, donde, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
1	21	19	5	0	SoloAlfanumerico	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio
2	21	4	5	0	SoloAlfanumerico	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio
\.


--
-- Name: menus_campos_eventos_icv_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_campos_eventos_icv_seq', 2, true);


--
-- Name: menus_campos_fila_seq; Type: SEQUENCE SET; Schema: forapi; Owner: inicio
--

SELECT pg_catalog.setval('menus_campos_fila_seq', 6381, true);


--
-- Name: menus_campos_idcampo_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_campos_idcampo_seq', 606, true);


--
-- Data for Name: menus_eventos; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_eventos (idmenus_eventos, idmenu, idevento, donde, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
1	24	7	1	cambiodepasswordsol	2017-03-30 14:35:05.754513-06	jlv	2017-03-30 14:35:05.754513-06	jlv
2	15	7	1	autoriza_usuario	2018-09-20 18:20:55.889685-06	jlv	2018-09-20 18:20:55.889685-06	jlv
3	25	7	1	cambiodepassword	2006-06-29 18:53:02-06	siscor	2006-06-29 18:53:02-06	siscor
4	19	3	1	validapwdtecleado	2009-02-04 12:58:35.816872-07	grecar	2009-02-04 12:58:35.816872-07	grecar
5	19	4	1	salidacontra	2009-02-04 12:58:35.816872-07	grecar	2009-02-04 12:58:35.816872-07	grecar
6	2	7	1	validarespuestadesbloqueo	2006-06-29 18:53:02-06	siscor	2006-06-29 18:53:02-06	siscor
7	18	7	1	autoriza_usuario	2006-06-29 18:53:01-06	siscor	2006-06-29 18:53:01-06	siscor
8	4	3	1	validapwdtecleado	2006-06-29 18:53:02-06	siscor	2006-06-29 18:53:02-06	siscor
9	6	9	1	validausuarioadesbloquear	2006-06-29 18:53:02-06	siscor	2006-06-29 18:53:02-06	siscor
10	4	4	1	salida	2006-06-29 18:53:02-06	siscor	2006-06-29 18:53:02-06	siscor
\.


--
-- Name: menus_eventos_idmenus_eventos_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_eventos_idmenus_eventos_seq', 10, true);


--
-- Data for Name: menus_htmltable; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_htmltable (idhtmltable, descripcion, esdesistema, columnas, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico, idmenu, orden) FROM stdin;
1	CAMPOS CON OPCIONES	f	0	2007-06-28 18:15:51-06	jlv	2007-06-28 18:15:51-06	jlv	\N	\N
0	SIN HTMLTABLE	f	0	2007-07-14 14:10:10-06	jlv	2007-07-14 14:10:10-06	jlv	\N	\N
2026	POLICIAS	f	0	2019-10-29 14:03:42-06	jc9	2019-10-29 14:03:42-06	jc9	\N	\N
2027	INFRACTORES	f	0	2019-10-29 21:17:05-06	jc9	2019-10-29 21:17:05-06	jc9	\N	\N
2028	INFRACCIONES	f	0	2019-10-29 21:26:36-06	jc9	2019-10-29 21:26:36-06	jc9	\N	\N
2029	SANCIÓN	f	0	2019-10-29 21:33:26-06	jc9	2019-10-29 21:33:26-06	jc9	\N	\N
\.


--
-- Name: menus_htmltable_idhtmltable_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_htmltable_idhtmltable_seq', 2029, true);


--
-- Name: menus_idmenu_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_idmenu_seq', 62, true);


--
-- Data for Name: menus_log; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_log (idlog, idmenu, movto, sql, fecha_alta, usuario_alta, esmovil, browser, ip, idmensaje) FROM stdin;
\.


--
-- Name: menus_log_idlog_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_log_idlog_seq', 1, false);


--
-- Data for Name: menus_mensajes; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_mensajes (idmensaje, mensaje, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
\.


--
-- Name: menus_mensajes_idmensaje_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_mensajes_idmensaje_seq', 1, false);


--
-- Data for Name: menus_movtos; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_movtos (idmenu, idmovto, descripcion, imagen, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
24	u	CambiarPassword		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio
15	u	Autoriza		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio
18	u	Autoriza		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio
25	u	CambiarPassword		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio
\.


--
-- Data for Name: menus_pg_group; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_pg_group (idmenu, grosysid, fecha_alta, fecha_modifico, usuario_alta, usuario_modifico, idmenupadre, groname, orden, espublico) FROM stdin;
11	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
15	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	admres	0	\N
18	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
15	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
21	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
10	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
14	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
25	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
13	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
8	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	admon	0	\N
17	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	admon	0	\N
12	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
4	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
23	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
14	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	admon	0	\N
24	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
18	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	admon	0	\N
8	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
17	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
10	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	admon	0	\N
13	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	admon	0	\N
31	\N	2019-10-20 19:38:33-06	2019-10-20 19:38:33-06	inicio	inicio	\N		0	\N
31	\N	2019-10-20 19:38:33-06	2019-10-20 19:38:33-06	inicio	inicio	\N	admon	0	\N
32	\N	2019-10-27 07:50:24-06	2019-10-27 07:50:24-06	inicio	inicio	\N	admon	0	\N
19	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	temporalg	0	\N
2	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	temporalg	0	\N
9	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	temporalg	0	\N
8	\N	2019-10-27 15:39:33-06	2019-10-27 15:39:33-06	inicio	inicio	\N	temporalg	0	\N
46	\N	2019-10-28 18:51:03-06	2019-10-28 18:51:03-06	jc9	jc9	\N	admon	0	\N
62	\N	2019-10-29 14:01:00-06	2019-10-29 14:01:00-06	jc9	jc9	\N	admon	0	\N
8	\N	2019-10-30 16:48:47-06	2019-10-30 16:48:47-06	jc9	jc9	\N	juez	0	\N
\.


--
-- Name: menus_pg_group_orden_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_pg_group_orden_seq', 1, false);


--
-- Data for Name: menus_pg_tables; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_pg_tables (idmenu, tablename, tselect, tinsert, tupdate, tdelete, tall, fecha_alta, fecha_modifico, usuario_alta, usuario_modifico, tgrant, nspname) FROM stdin;
1	menus_pg_tables	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
2	cat_usuarios	0	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
3	cat_usuarios_pg_group	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
5	his_cat_usuarios	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
7	menus_eventos	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
12	menus_htmltable	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
13	tablas	1	1	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
14	menus	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
20	menus_campos	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
21	menus_pg_group	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
27	menus_movtos	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
28	menus_seguimiento	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
29	menus_tiempos	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
30	menus_subvistas	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
5	his_cat_usuarios_idcambio_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
7	menus_eventos_idmenus_eventos_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
30	menus_subvistas_idmenus_subvistas_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
26	menus_log_idlog_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
12	menus_htmltable_idhtmltable_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
28	menus_seguimiento_idseguimietno_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
8	his_cambios_pwd	1	1	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	pg_authid	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	pg_catalog
8	menus_presentacion	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	menus_htmltable_idhtmltable_seq	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
18	his_cat_usuarios_pg_group	1	1	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
3	pg_group	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	pg_catalog
11	cat_usuarios	1	1	1	1	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
20	menus_htmltable_idhtmltable_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
14	menus_subvistas	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	pg_shadow	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	pg_catalog
8	menus_htmltable	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	his_menus	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
11	his_cat_usuarios_pg_group_idcambio_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	his_cat_usuarios_pg_group_idcambio_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
11	cat_preguntas	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
8	menus_pg_group	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
20	tablas	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
26	menus_mensajes	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
8	menus	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	menus_campos_eventos	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
26	menus	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
1	pg_namespace	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	pg_catalog
14	menus_eventos_idmenus_eventos_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	pg_shadow	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	pg_catalog
19	cat_usuarios	0	1	0	0	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	eventos	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
1	tablas	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
11	pg_authid	0	0	0	0	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	pg_catalog
17	his_cat_usuarios_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	cat_bitacora	1	1	1	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
18	menus_pg_tables	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
4	cat_preguntas	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	menus_campos_eventos_icv_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
11	estados_usuarios	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	cat_preguntas	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	menus_movtos	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	menus_presentacion	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
8	menus_seguimiento_idseguimietno_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
11	cat_usuarios_pg_group	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	cat_usuarios_pg_group	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
11	his_cat_usuarios	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	cat_usuarios	1	0	1	1	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
18	his_cat_usuarios_pg_group_idcambio_seq	1	0	1	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	menus_idmenu_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
20	menus_campos_idcampo_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	menus_seguimiento	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	pg_namespace	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	pg_catalog
11	pg_shadow	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	pg_catalog
11	his_cat_usuarios_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
19	cat_preguntas	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
7	eventos	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
4	cat_usuarios	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
4	his_cat_usuarios	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	tcases	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	cat_preguntas	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
20	campos	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
8	cat_bitacora_idbitacora_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	campos	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
20	menus	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
20	menus_htmltable	1	1	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
14	tablas	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
19	his_cat_usuarios	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
4	his_cat_usuarios_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	tablas	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	menus_campos_eventos	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
21	his_menus_pg_group	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	menus_movtos	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	estados_usuarios	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
21	his_menus_pg_group_seq	1	 	1	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	pg_authid	0	0	0	1	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	pg_catalog
8	menus_campos	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	menus_log	 	1	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	menus_campos_idcampo_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	menus_campos	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
19	cat_preguntas_seq	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
4	cat_preguntas_seq	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	menus_log_idlog_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
20	tcases	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
19	his_cat_usuarios_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	campos	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
20	pg_namespace	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	pg_catalog
14	menus_eventos	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
21	menus_pg_group_orden_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
26	menus_log	1	0	0	0	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	cat_usuarios	1	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
18	cat_preguntas	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
8	menus_subvistas	1	 	1	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	his_cat_usuarios	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	menus_eventos	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	cat_usuarios_pg_group	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
1	his_menus_pg_tables	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
46	menus_scripts	1	1	1	1	0	2019-10-28 18:51:03-06	2019-10-28 18:51:03-06	jc9	jc9	0	forapi
46	menus_scripts_idscript_seq	1	0	1	0	0	2019-10-28 18:51:03-06	2019-10-28 18:51:03-06	jc9	jc9	0	forapi
\.


--
-- Data for Name: menus_presentacion; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_presentacion (idpresentacion, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
\.


--
-- Name: menus_presentacion_idpresentacion_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_presentacion_idpresentacion_seq', 1, false);


--
-- Data for Name: menus_scripts; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_scripts (idscript, descripcion, sql, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
1	creacion del esquema de juzgados	create schema jc;	2019-10-28 18:51:50-06	jc9	2019-10-28 18:51:50-06	jc9
5	alta del catalogo de juzgados	SET search_path = jc, pg_catalog;\nCREATE TABLE juzgados (\n    idjuzgado integer NOT NULL,\n    alcaldia varchar(100) ,\n    juzgado varchar(100) ,\n    direccion varchar(100) ,\n    turno varchar(30) ,\n    horario varchar(30) ,\n    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    usuario_alta character varying(20) DEFAULT getpgusername(),\n    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    usuario_modifico character varying(20) DEFAULT getpgusername()\n);\n\n\nALTER TABLE jc.juzgados OWNER TO postgres;\nCOMMENT ON TABLE juzgados IS 'tabla que contiene el catalogo de juzgados | Juzgados';\n\nCOMMENT ON COLUMN juzgados.idjuzgado IS 'id del juzgado';\n\n\nCOMMENT ON COLUMN juzgados.alcaldia IS 'Alcaldia';\n\nCOMMENT ON COLUMN juzgados.alcaldia IS 'Alcaldia';\n\nCOMMENT ON COLUMN juzgados.juzgado IS 'Juzgado' ;\n\nCOMMENT ON COLUMN juzgados.direccion IS 'Direccion';\nCOMMENT ON COLUMN juzgados.turno IS 'Turno';\nCOMMENT ON COLUMN juzgados.horario IS 'horario';\n\n\n--\n-- Name: juzgados_idjuzgado_seq; Type: SEQUENCE; Schema: jc; Owner: postgres\n--\n\nCREATE SEQUENCE juzgados_idjuzgado_seq\n    START WITH 1\n    INCREMENT BY 1\n    NO MINVALUE\n    NO MAXVALUE\n    CACHE 1;\n\n\nALTER TABLE jc.juzgados_idjuzgado_seq OWNER TO postgres;\n\n--\n-- Name: juzgados_idjuzgado_seq; Type: SEQUENCE OWNED BY; Schema: jc; Owner: postgres\n--\n\nALTER SEQUENCE juzgados_idjuzgado_seq OWNED BY juzgados.idjuzgado;\n\n\n--\n-- Name: idjuzgado; Type: DEFAULT; Schema: jc; Owner: postgres\n--\n\nALTER TABLE ONLY juzgados ALTER COLUMN idjuzgado SET DEFAULT nextval('juzgados_idjuzgado_seq'::regclass);\n\n\nALTER TABLE ONLY juzgados\n    ADD CONSTRAINT juzgados_pkey PRIMARY KEY (idjuzgado);\n\n\n--\n-- Name: ak1_juzgados; Type: INDEX; Schema: jc; Owner: postgres; Tablespace:\n--\n\n\n\n--\n-- Name: ak2_juzgados; Type: INDEX; Schema: jc; Owner: postgres; Tablespace:\n--	2019-10-28 21:02:29-06	jc9	2019-10-28 21:02:29-06	jc9
10	borra infracciones	drop table jc.infracciones;	2019-10-29 07:03:18-06	jc9	2019-10-29 07:03:18-06	jc9
11	crea infracciones	SET search_path = jc, pg_catalog;\n\nCREATE TABLE infracciones (\n    idinfraccion integer NOT NULL,\n    infraccion varchar(100) not null,\n    articulo integer not null,\n    fraccion varchar(10) not null,\n    descripcion varchar(256) not null,\n    conciliacion varchar(50) ,\n    aplicarsi varchar(100) ,\n    sancion varchar(3) not null,\n    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    usuario_alta character varying(20) DEFAULT getpgusername(),\n    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    usuario_modifico character varying(20) DEFAULT getpgusername()\n);\n\n\nALTER TABLE jc.infracciones OWNER TO postgres;\nCOMMENT ON TABLE infracciones IS 'tabla que contiene el catalogo de infracciones | Juzgados';\nCOMMENT ON COLUMN infracciones.idinfraccion IS 'id de la infraccion';\nCOMMENT ON COLUMN infracciones.infraccion IS 'Infracción ';\nCOMMENT ON COLUMN infracciones.articulo IS 'Artículo' ;\nCOMMENT ON COLUMN infracciones.fraccion IS 'Fracción';\nCOMMENT ON COLUMN infracciones.conciliacion IS 'Conciliación';\nCOMMENT ON COLUMN infracciones.aplicarsi IS 'Aplicar si';\nCOMMENT ON COLUMN infracciones.sancion IS 'Tipo';\nCOMMENT ON COLUMN infracciones.descripcion IS 'Descripción';\nCREATE SEQUENCE infracciones_idinfraccion_seq\n    START WITH 1\n    INCREMENT BY 1\n    NO MINVALUE\n    NO MAXVALUE\n    CACHE 1;\n\n\nALTER TABLE jc.infracciones_idinfraccion_seq OWNER TO postgres;\nALTER SEQUENCE infracciones_idinfraccion_seq OWNED BY infracciones.idinfraccion;\n\nALTER TABLE ONLY infracciones ALTER COLUMN idinfraccion SET DEFAULT nextval('infracciones_idinfraccion_seq'::regclass);\nALTER TABLE ONLY infracciones\n    ADD CONSTRAINT infracciones_pkey PRIMARY KEY (idinfraccion);	2019-10-29 07:15:28-06	jc9	2019-10-29 07:15:28-06	jc9
12	crea sanciones	SET search_path = jc, pg_catalog;\n\nCREATE TABLE sanciones (\n    idsancion integer NOT NULL,\n    tipo varchar(2) not null,\n    uc_desde numeric(3) ,\n    uc_hasta numeric(3),\n    servicio_desde numeric(3),\n    servicio_hasta numeric(3),\n    arresto_desde numeric(3),\n    arresto_hasta numeric(3),\n    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    usuario_alta character varying(20) DEFAULT getpgusername(),\n    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    usuario_modifico character varying(20) DEFAULT getpgusername()\n);\n\n\nALTER TABLE jc.sanciones OWNER TO postgres;\nCOMMENT ON TABLE sanciones IS 'Sanciones';\nCOMMENT ON COLUMN sanciones.idsancion IS 'id de la sancion';\nCOMMENT ON COLUMN sanciones.tipo IS 'Tipo ';\nCOMMENT ON COLUMN sanciones.uc_desde IS 'Unidad de cuenta desde' ;\nCOMMENT ON COLUMN sanciones.uc_hasta IS 'Unidad de cuenta hasta';\nCOMMENT ON COLUMN sanciones.servicio_desde IS 'Horas de Servicio Comunitatio desde';\nCOMMENT ON COLUMN sanciones.servicio_hasta IS 'Horas de Servicio Comunitatio hasta';\nCOMMENT ON COLUMN sanciones.arresto_desde IS 'Horas de arresto desde';\nCOMMENT ON COLUMN sanciones.arresto_hasta IS 'Horas de arresto hasta';\nCREATE SEQUENCE sanciones_idsancion_seq\n    START WITH 1\n    INCREMENT BY 1\n    NO MINVALUE\n    NO MAXVALUE\n    CACHE 1;\n\n\nALTER TABLE jc.sanciones_idsancion_seq OWNER TO postgres;\nALTER SEQUENCE sanciones_idsancion_seq OWNED BY sanciones.idsancion;\n\nALTER TABLE ONLY sanciones ALTER COLUMN idsancion SET DEFAULT nextval('sanciones_idsancion_seq'::regclass);\nALTER TABLE ONLY sanciones\n    ADD CONSTRAINT sanciones_pkey PRIMARY KEY (idsancion);	2019-10-29 07:39:30-06	jc9	2019-10-29 07:39:30-06	jc9
16	crea boletas	SET search_path = jc, pg_catalog;\n\nCREATE TABLE boletas (\n    idboleta integer NOT NULL,\n    boleta_remision varchar(2) not null,\n    id_policia_01 integer not null,\n    id_policia_02 integer ,\n    patrulla varchar(30) not null,\n    id_areaadcripcion integer,\n    nombre_inf varchar(30) not null,\n    primer_apellido_inf varchar(30),\n    segundo_apellido_inf varchar(30),\n    sexo varchar(1),\n    curp varchar(18),\n    id_nacimiento integer,\n    fecha_nacimiento timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    calle_inf varchar(30),\n    interior_inf varchar(15),\n    exterior_inf varchar(15),\n    cp_inf varchar(5),\n    id_colonia_inf integer,\n    id_alcaldia_inf integer,\n    id_foto_inf    integer,\n    fecha_hechos timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    hora_hechos timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    calle_hechos varchar(30),\n    interior_hechos varchar(15),\n    exterior_hechos varchar(15),\n    cp_hechos varchar(5),\n    id_colonia_hechos integer,\n    id_alcaldia_hechos integer,\n    motivo_infraccion text,\n    objetos_recogidos text,\n    idinfraccion integer,\n    sancion_uc integer,\n    sancion_servicio integer,\n    sancion_arresto  integer,\n    sancion_observacion text,\n    estatus integer default 0,\n    expediente varchar(30),\n    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    usuario_alta character varying(20) DEFAULT getpgusername(),\n    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    usuario_modifico character varying(20) DEFAULT getpgusername()\n);\n\nALTER TABLE jc.boletas OWNER TO postgres;\nCOMMENT ON TABLE boletas IS 'Boletas de resmision';\nCOMMENT ON COLUMN boletas.idboleta IS 'id de la boleta';\nCOMMENT ON COLUMN boletas.id_policia_01 IS 'Policia uno ';\nCOMMENT ON COLUMN boletas.id_policia_02 IS 'Policia dos ';\nCOMMENT ON COLUMN boletas.patrulla IS 'Numero de patrulla u medio de transporte' ;\nCOMMENT ON COLUMN boletas.nombre_inf IS 'Nombre(s)';\nCOMMENT ON COLUMN boletas.primer_apellido_inf IS 'Primer apellido';\nCOMMENT ON COLUMN boletas.segundo_apellido_inf IS 'Segundo apellido';\nCOMMENT ON COLUMN boletas.sexo IS 'Sexo';\nCOMMENT ON COLUMN boletas.curp IS 'Curp';\nCOMMENT ON COLUMN boletas.id_nacimiento IS 'Lugar de nacimiento';\nCOMMENT ON COLUMN boletas.fecha_nacimiento IS 'Fecha de nacimiento';\nCOMMENT ON COLUMN boletas.calle_inf IS 'Calle';\nCOMMENT ON COLUMN boletas.interior_inf IS 'No. interior';\nCOMMENT ON COLUMN boletas.exterior_inf IS 'No. exterior';\nCOMMENT ON COLUMN boletas.cp_inf IS 'Código postal';\nCOMMENT ON COLUMN boletas.id_colonia_inf IS 'Colonia';\nCOMMENT ON COLUMN boletas.id_alcaldia_inf IS 'Alcaldia';\nCOMMENT ON COLUMN boletas.id_foto_inf IS 'Fotografía';\nCOMMENT ON COLUMN boletas.fecha_hechos IS 'Fecha en que ocurrieron los hechos';\nCOMMENT ON COLUMN boletas.hora_hechos IS 'Fecha en que ocurrieron los hechos';\nCOMMENT ON COLUMN boletas.calle_hechos IS 'Calle';\nCOMMENT ON COLUMN boletas.interior_hechos IS 'No. interior';\nCOMMENT ON COLUMN boletas.exterior_hechos IS 'No. exterior';\nCOMMENT ON COLUMN boletas.cp_hechos IS 'Código postal';\nCOMMENT ON COLUMN boletas.id_colonia_hechos IS 'Colonia';\nCOMMENT ON COLUMN boletas.id_alcaldia_hechos IS 'Alcaldia';\nCOMMENT ON COLUMN boletas.motivo_infraccion IS 'Datos de la probable infracción';\nCOMMENT ON COLUMN boletas.objetos_recogidos IS 'Objeto(s) recogido(s) relacionado(s) con la(s) probable(s) infracción(es)';\nCOMMENT ON COLUMN boletas.idinfraccion IS 'Artículos';\nCOMMENT ON COLUMN boletas.estatus IS 'Estatus de la boleta';\n\n\n\nCREATE SEQUENCE boletas_idboleta_seq\n    START WITH 1\n    INCREMENT BY 1\n    NO MINVALUE\n    NO MAXVALUE\n    CACHE 1;\n\n\nALTER TABLE jc.boletas_idboleta_seq OWNER TO postgres;\nALTER SEQUENCE boletas_idboleta_seq OWNED BY boletas.idboleta;\n\nALTER TABLE ONLY boletas ALTER COLUMN idboleta SET DEFAULT nextval('boletas_idboleta_seq'::regclass);\nALTER TABLE ONLY boletas\n    ADD CONSTRAINT boletas_pkey PRIMARY KEY (idboleta);	2019-10-29 13:26:47-06	jc9	2019-10-29 13:26:47-06	jc9
\.


--
-- Name: menus_scripts_idscript_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_scripts_idscript_seq', 16, true);


--
-- Data for Name: menus_seguimiento; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_seguimiento (idseguimietno, idmenu, usename, fecha_alta, usuario_alta) FROM stdin;
\.


--
-- Name: menus_seguimiento_idseguimietno_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_seguimiento_idseguimietno_seq', 1, false);


--
-- Data for Name: menus_subvistas; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_subvistas (idmenus_subvistas, idmenu, texto, imagen, idsubvista, funcion, dialogwidth, dialogheight, esboton, donde, eventos_antes, eventos_despues, campo_filtro, valor_padre, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico, clase, posicion, orden, ventana) FROM stdin;
1	11	Historico		5		1049	511	2	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
2	14	tablas		1		966	522	2	1			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
3	18	Grupos		3		1135	568	1	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
5	14	grupos		21		1108	714	2	1			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
6	17	Log		26		976	602	2	0			usuario_alta	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
7	11	Accesos Usuario		0		843	479	2	1			usuario_alta	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
10	14	Log		26		976	602	2	0			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	950	0
13	14	Subvistas		30		1052	560	2	1			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
14	14	Seguimiento		28		555	476	2	0			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	800	0
17	17	Grupos		3		1135	568	2	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
18	17	Historico		5		1049	511	2	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
19	11	Cambio de Password		0		845	448	2	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
20	15	Grupos		3		1135	568	1	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
21	14	Historico		0		790	574	2	1			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
22	17	Accesos Usuario		0		843	479	2	1			usuario_alta	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
26	14	Movtos		27		809	526	2	0			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
27	9	Registro	fas fa-user-plus	19		635	470	1	1					2019-10-12 00:00:00-06	inicio	\N	\N		1	20	0
29	1	Historico		0		737	474	1	1			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
30	3	Historico		0		736	306	1	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
32	14	Eventos		7		1020	463	2	1			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
35	11	Log		26		976	602	2	0			usuario_alta	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
36	17	Cambio de Password		0		845	448	2	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
15	13	Archivo		0	crea_sqlarchivo	40	30	1	1					2019-10-12 00:00:00-06	inicio	\N	\N	src/php/reingenieria_class.php	0	0	0
16	13	Baja Admon		0	baja_admon	0	0	1	1					2019-10-12 00:00:00-06	inicio	\N	\N	src/php/reingenieria_class.php	1	10	0
23	17	Permisos		0	permisos	50	30	1	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N	src/php/seguridad_class.php	0	0	0
25	14	Copia Opcion		0	copiaopcion	40	30	1	0					2019-10-12 00:00:00-06	inicio	\N	\N	src/php/reingenieria_class.php	0	0	0
28	13	Base		0	crea_menusbase	40	30	1	1					2019-10-12 00:00:00-06	inicio	\N	\N	src/php/reingenieria_class.php	0	0	0
37	23	Validar FIEL	entrar.gif	0	validafiel	0	0	1	1					2019-10-12 00:00:00-06	inicio	\N	\N	src/php/firma_digital.php	1	10	0
9	20	Eventos		7		879	433	1	0			idmenu;attnum	idmenu;attnum	2019-10-12 00:00:00-06	inicio	\N	\N		0	10	0
8	14	Campos		20		800	600	2	0			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
33	9	Ingresar	fas fa-sign-in-alt	0	validausuario	0	0	1	1					2019-10-12 00:00:00-06	inicio	\N	\N	src/php/seguridad_class.php	1	10	0
41	31	Base		0	crea_menusbase	40	30	1	1					2019-10-20 19:38:33.016632-06	inicio	2019-10-20 19:38:33.016632-06	inicio	src/php/reingenieria_class.php	1	0	0
42	46	Ejecuta	\N	0	ejecuta	40	30	1	\N	\N	\N	\N	\N	2019-10-28 19:44:45-06	jc9	2019-10-28 19:44:45-06	jc9	src/php/reingenieria_class.php	0	0	0
\.


--
-- Name: menus_subvistas_idmenus_subvistas_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_subvistas_idmenus_subvistas_seq', 42, true);


--
-- Data for Name: menus_tiempos; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_tiempos (idtiempo, descripcion, fecha_alta, fecha_modifico, usuario_alta, usuario_modifico, unidadtiempo, tiempo, orden) FROM stdin;
\.


--
-- Name: menus_tiempos_idtiempo_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_tiempos_idtiempo_seq', 1, false);


--
-- Data for Name: tcases; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY tcases (tcase, descripcion) FROM stdin;
\.


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

