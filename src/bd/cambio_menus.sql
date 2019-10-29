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
-- Name: cambio_menus(); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE or replace FUNCTION cambio_menus() RETURNS trigger
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
-- PostgreSQL database dump complete
--

