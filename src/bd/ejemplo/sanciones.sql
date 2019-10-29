--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = ''UTF8'';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = jc, pg_catalog;

CREATE TABLE sanciones (
    idsancion integer NOT NULL,
    tipo varchar(2) not null,
    uc_desde numeric(3) ,
    uc_hasta numeric(3),
    servicio_desde numeric(3),
    servicio_hasta numeric(3),
    arresto_desde numeric(3),
    arresto_hasta numeric(3),
    fecha_alta timestamp(0) with time zone DEFAULT (''now''::text)::timestamp(0) with time zone,
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT (''now''::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername()
);


ALTER TABLE jc.sanciones OWNER TO postgres;
COMMENT ON TABLE sanciones IS ''Sanciones'';
COMMENT ON COLUMN sanciones.idsancion IS ''id de la sancion'';
COMMENT ON COLUMN sanciones.tipo IS ''Tipo '';
COMMENT ON COLUMN sanciones.uc_desde IS ''Unidad de cuenta desde'' ;
COMMENT ON COLUMN sanciones.uc_hasta IS ''Unidad de cuenta hasta'';
COMMENT ON COLUMN sanciones.servicio_desde IS ''Horas de Servicio Comunitatio desde'';
COMMENT ON COLUMN sanciones.servicio_hasta IS ''Horas de Servicio Comunitatio hasta'';
COMMENT ON COLUMN sanciones.arresto_desde IS ''Horas de arresto desde'';
COMMENT ON COLUMN sanciones.arresto_hasta IS ''Horas de arresto hasta'';


CREATE SEQUENCE sanciones_idsancion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE jc.sanciones_idsancion_seq OWNER TO postgres;
ALTER SEQUENCE sanciones_idsancion_seq OWNED BY sanciones.idsancion;

ALTER TABLE ONLY sanciones ALTER COLUMN idsancion SET DEFAULT nextval(''sanciones_idsancion_seq''::regclass);
ALTER TABLE ONLY sanciones
    ADD CONSTRAINT sanciones_pkey PRIMARY KEY (idsancion);

REVOKE ALL ON TABLE sanciones FROM PUBLIC;
REVOKE ALL ON TABLE sanciones FROM postgres;
GRANT ALL ON TABLE sanciones TO postgres;
GRANT SELECT ON TABLE sanciones TO jcjs WITH GRANT OPTION;


--
-- Name: sanciones_idsancion_seq; Type: ACL; Schema: jc; Owner: postgres
--

REVOKE ALL ON SEQUENCE sanciones_idsancion_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE sanciones_idsancion_seq FROM postgres;
GRANT ALL ON SEQUENCE sanciones_idsancion_seq TO postgres;
GRANT ALL ON SEQUENCE sanciones_idsancion_seq TO tmp_jc WITH GRANT OPTION;
GRANT ALL ON SEQUENCE sanciones_idsancion_seq TO jcjs WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

