--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = ''UTF8'';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = jc, pg_catalog;

SET default_tablespace = '''';

SET default_with_oids = false;

--
-- Name: juzgados; Type: TABLE; Schema: jc; Owner: postgres; Tablespace: 
--

drop TABLE juzgados ;
CREATE TABLE juzgados (
    idjuzgado integer NOT NULL,
    alcaldia varchar(100) ,
    juzgado varchar(100) ,
    direccion varchar(100) ,
    turno varchar(30) ,
    horario varchar(30) ,
    fecha_alta timestamp(0) with time zone DEFAULT (''now''::text)::timestamp(0) with time zone,
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT (''now''::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername()
);


ALTER TABLE jc.juzgados OWNER TO postgres;
COMMENT ON TABLE juzgados IS ''tabla que contiene el catalogo de juzgados | Juzgados'';

COMMENT ON COLUMN juzgados.idjuzgado IS ''id del juzgado'';


COMMENT ON COLUMN juzgados.alcaldia IS ''Alcaldia'';

COMMENT ON COLUMN juzgados.juzgado IS ''Juzgado'' ;

COMMENT ON COLUMN juzgados.direccion IS ''Direccion'';
COMMENT ON COLUMN juzgados.turno IS ''Turno'';
COMMENT ON COLUMN juzgados.horario IS ''horario'';


--
-- Name: juzgados_idjuzgado_seq; Type: SEQUENCE; Schema: jc; Owner: postgres
--

CREATE SEQUENCE juzgados_idjuzgado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE jc.juzgados_idjuzgado_seq OWNER TO postgres;

--
-- Name: juzgados_idjuzgado_seq; Type: SEQUENCE OWNED BY; Schema: jc; Owner: postgres
--

ALTER SEQUENCE juzgados_idjuzgado_seq OWNED BY juzgados.idjuzgado;


--
-- Name: idjuzgado; Type: DEFAULT; Schema: jc; Owner: postgres
--

ALTER TABLE ONLY juzgados ALTER COLUMN idjuzgado SET DEFAULT nextval(''juzgados_idjuzgado_seq''::regclass);


--
-- Name: juzgados_pkey; Type: CONSTRAINT; Schema: jc; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY juzgados
    ADD CONSTRAINT juzgados_pkey PRIMARY KEY (idjuzgado);


--
-- Name: ak1_juzgados; Type: INDEX; Schema: jc; Owner: postgres; Tablespace: 
--



--
-- Name: ak2_juzgados; Type: INDEX; Schema: jc; Owner: postgres; Tablespace: 
--

CREATE INDEX ak2_juzgados ON juzgados USING btree (usuario_alta);


--
-- Name: ak3_juzgados; Type: INDEX; Schema: jc; Owner: postgres; Tablespace: 
--

CREATE INDEX ak3_juzgados ON juzgados USING btree (fecha_alta);


--
-- Name: juzgados; Type: ACL; Schema: jc; Owner: postgres
--

REVOKE ALL ON TABLE juzgados FROM PUBLIC;
REVOKE ALL ON TABLE juzgados FROM postgres;
GRANT ALL ON TABLE juzgados TO postgres;
GRANT SELECT ON TABLE juzgados TO jcjs WITH GRANT OPTION;


--
-- Name: juzgados_idjuzgado_seq; Type: ACL; Schema: jc; Owner: postgres
--

REVOKE ALL ON SEQUENCE juzgados_idjuzgado_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE juzgados_idjuzgado_seq FROM postgres;
GRANT ALL ON SEQUENCE juzgados_idjuzgado_seq TO postgres;
GRANT ALL ON SEQUENCE juzgados_idjuzgado_seq TO tmp_jc WITH GRANT OPTION;
GRANT ALL ON SEQUENCE juzgados_idjuzgado_seq TO jcjs WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

