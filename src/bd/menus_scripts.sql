--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = forapi, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: menus_scripts; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

drop TABLE menus_scripts ;
CREATE TABLE menus_scripts (
    idscript integer NOT NULL,
    descripcion varchar(100) ,
    sql text,
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername()
);


ALTER TABLE forapi.menus_scripts OWNER TO postgres;
COMMENT ON TABLE menus_scripts IS 'tabla para dar de alta un script ddl o dml';

COMMENT ON COLUMN menus_scripts.idscript IS 'id del script';


--
-- Name: COLUMN menus_scripts.idmenu; Type: COMMENT; Schema: forapi; Owner: postgres
--



COMMENT ON COLUMN menus_scripts.sql IS 'instruccion';

COMMENT ON COLUMN menus_scripts.fecha_alta IS 'Fecha en que hizo el movimiento el usuario';

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
-- Name: idscript; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_scripts ALTER COLUMN idscript SET DEFAULT nextval('menus_scripts_idscript_seq'::regclass);


--
-- Name: menus_scripts_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus_scripts
    ADD CONSTRAINT menus_scripts_pkey PRIMARY KEY (idscript);


--
-- Name: ak1_menus_scripts; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--



--
-- Name: ak2_menus_scripts; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak2_menus_scripts ON menus_scripts USING btree (usuario_alta);


--
-- Name: ak3_menus_scripts; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak3_menus_scripts ON menus_scripts USING btree (fecha_alta);


--
-- Name: menus_scripts; Type: ACL; Schema: forapi; Owner: postgres
--

REVOKE ALL ON TABLE menus_scripts FROM PUBLIC;
REVOKE ALL ON TABLE menus_scripts FROM postgres;
GRANT ALL ON TABLE menus_scripts TO postgres;
GRANT SELECT ON TABLE menus_scripts TO jcjs WITH GRANT OPTION;


--
-- Name: menus_scripts_idscript_seq; Type: ACL; Schema: forapi; Owner: postgres
--

REVOKE ALL ON SEQUENCE menus_scripts_idscript_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE menus_scripts_idscript_seq FROM postgres;
GRANT ALL ON SEQUENCE menus_scripts_idscript_seq TO postgres;
GRANT ALL ON SEQUENCE menus_scripts_idscript_seq TO tmp_jc WITH GRANT OPTION;
GRANT ALL ON SEQUENCE menus_scripts_idscript_seq TO jcjs WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

