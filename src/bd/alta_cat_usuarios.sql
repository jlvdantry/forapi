--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = forapi, pg_catalog;

--
-- Name: alta_cat_usuarios(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE or replace FUNCTION alta_cat_usuarios() RETURNS trigger
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
-- PostgreSQL database dump complete
--

