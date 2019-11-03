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
-- Name: alta_menus_campos(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE or replace FUNCTION alta_menus_campos() RETURNS trigger
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
        end if
     return new;
    END;$$;


ALTER FUNCTION forapi.alta_menus_campos() OWNER TO postgres;

--
-- PostgreSQL database dump complete
--

