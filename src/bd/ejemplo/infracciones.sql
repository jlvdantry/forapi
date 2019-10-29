--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = ''UTF8'';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = jc, pg_catalog;

CREATE TABLE infracciones (
    idinfraccion integer NOT NULL,
    infraccion varchar(100) ,
    articulo integer ,
    fraccion varchar(10) ,
    descripcion varchar(256) ,
    conciliacion varchar(50) ,
    aplicarsi varchar(100) ,
    sancion varchar(3) ,
    fecha_alta timestamp(0) with time zone DEFAULT (''now''::text)::timestamp(0) with time zone,
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT (''now''::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername()
);


ALTER TABLE jc.infracciones OWNER TO postgres;
COMMENT ON TABLE infracciones IS ''tabla que contiene el catalogo de infracciones | Juzgados'';
COMMENT ON COLUMN infracciones.idinfraccion IS ''id de la infraccion'';
COMMENT ON COLUMN infracciones.infraccion IS ''Infracción '';
COMMENT ON COLUMN infracciones.articulo IS ''Artículo'' ;
COMMENT ON COLUMN infracciones.fraccion IS ''Fracción'';
COMMENT ON COLUMN infracciones.conciliacion IS ''Conciliación'';
COMMENT ON COLUMN infracciones.aplicarsi IS ''Aplicar si'';
COMMENT ON COLUMN infracciones.sancion IS ''Tipo'';

CREATE SEQUENCE infracciones_idinfraccion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE jc.infracciones_idinfraccion_seq OWNER TO postgres;

--
-- Name: infracciones_idinfraccion_seq; Type: SEQUENCE OWNED BY; Schema: jc; Owner: postgres
--

ALTER SEQUENCE infracciones_idinfraccion_seq OWNED BY infracciones.idinfraccion;


--
-- Name: idinfraccion; Type: DEFAULT; Schema: jc; Owner: postgres
--

ALTER TABLE ONLY infracciones ALTER COLUMN idinfraccion SET DEFAULT nextval(''infracciones_idinfraccion_seq''::regclass);


--
-- Name: infracciones_pkey; Type: CONSTRAINT; Schema: jc; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY infracciones
    ADD CONSTRAINT infracciones_pkey PRIMARY KEY (idinfraccion);


--
-- Name: ak1_infracciones; Type: INDEX; Schema: jc; Owner: postgres; Tablespace: 
--



--
-- Name: ak2_infracciones; Type: INDEX; Schema: jc; Owner: postgres; Tablespace: 
--

CREATE INDEX ak2_infracciones ON infracciones USING btree (usuario_alta);


--
-- Name: ak3_infracciones; Type: INDEX; Schema: jc; Owner: postgres; Tablespace: 
--

CREATE INDEX ak3_infracciones ON infracciones USING btree (fecha_alta);


--
-- Name: infracciones; Type: ACL; Schema: jc; Owner: postgres
--

REVOKE ALL ON TABLE infracciones FROM PUBLIC;
REVOKE ALL ON TABLE infracciones FROM postgres;
GRANT ALL ON TABLE infracciones TO postgres;
GRANT SELECT ON TABLE infracciones TO jcjs WITH GRANT OPTION;


--
-- Name: infracciones_idinfraccion_seq; Type: ACL; Schema: jc; Owner: postgres
--

REVOKE ALL ON SEQUENCE infracciones_idinfraccion_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE infracciones_idinfraccion_seq FROM postgres;
GRANT ALL ON SEQUENCE infracciones_idinfraccion_seq TO postgres;
GRANT ALL ON SEQUENCE infracciones_idinfraccion_seq TO tmp_jc WITH GRANT OPTION;
GRANT ALL ON SEQUENCE infracciones_idinfraccion_seq TO jcjs WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

