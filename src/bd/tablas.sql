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
-- Name: tablas; Type: VIEW; Schema: forapi; Owner: postgres
--

drop VIEW tablas ;
CREATE VIEW tablas AS
    SELECT c.relname, c.reltype, c.oid, n.nspname, n.nspname AS fuente_nspname 
FROM pg_class c LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
  LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
   WHERE ((c.relkind = 'r'::"char")  OR (c.relkind = 'v'::"char")) AND (substr((c.relname)::text, 1, 4) <> 'sql_'::text);


ALTER TABLE forapi.tablas OWNER TO postgres;

--
-- Name: tablas; Type: ACL; Schema: forapi; Owner: postgres
--

REVOKE ALL ON TABLE tablas FROM PUBLIC;
REVOKE ALL ON TABLE tablas FROM postgres;
GRANT ALL ON TABLE tablas TO postgres;
GRANT SELECT ON TABLE tablas TO tmp_jc104 WITH GRANT OPTION;
GRANT SELECT,INSERT ON TABLE tablas TO jc104 WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

