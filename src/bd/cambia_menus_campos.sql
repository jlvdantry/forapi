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
    BEGIN
        if new.upload_file!=old.upload_file then
           if new.upload_file=true then
                 new.readonly=true;
           end if;
        end if;
     return new;
    END;$$;


ALTER FUNCTION forapi.cambia_menus_campos() OWNER TO postgres;

CREATE TRIGGER tu_menus_campos BEFORE update ON menus_campos FOR EACH ROW EXECUTE PROCEDURE cambia_menus_campos();

--
-- PostgreSQL database dump complete
--

