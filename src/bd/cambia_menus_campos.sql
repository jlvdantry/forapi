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
-- Name: cambia_menus_campos(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE or replace FUNCTION cambia_menus_campos() RETURNS trigger
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

CREATE TRIGGER tu_menus_campos BEFORE update ON menus_campos FOR EACH ROW EXECUTE PROCEDURE cambia_menus_campos();

--
-- PostgreSQL database dump complete
--

