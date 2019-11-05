--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = jc, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: boletas; Type: TABLE; Schema: jc; Owner: postgres; Tablespace: 
--

CREATE TABLE boletas (
    idboleta integer NOT NULL,
    boleta_remision character varying(20),
    id_policia_01 integer,
    id_policia_02 integer,
    patrulla character varying(30),
    id_areaadcripcion integer,
    nombre_inf character varying(30),
    primer_apellido_inf character varying(30),
    segundo_apellido_inf character varying(30),
    sexo character varying(1),
    curp character varying(18),
    id_nacimiento integer,
    fecha_nacimiento timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    calle_inf character varying(30),
    interior_inf character varying(15),
    exterior_inf character varying(15),
    cp_inf character varying(5),
    id_colonia_inf integer,
    id_alcaldia_inf integer,
    id_foto_inf integer,
    fecha_hechos timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    hora_hechos timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    calle_hechos character varying(30),
    interior_hechos character varying(15),
    exterior_hechos character varying(15),
    cp_hechos character varying(5),
    id_colonia_hechos integer,
    id_alcaldia_hechos integer,
    motivo_infraccion text,
    objetos_recogidos text,
    idinfraccion integer,
    sancion_uc integer,
    sancion_servicio integer,
    sancion_arresto integer,
    sancion_observacion text,
    estatus integer DEFAULT 0,
    expediente character varying(30),
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername()
);


ALTER TABLE jc.boletas OWNER TO postgres;

--
-- Name: TABLE boletas; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON TABLE boletas IS 'Boletas de resmision';


--
-- Name: COLUMN boletas.idboleta; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.idboleta IS 'id de la boleta';


--
-- Name: COLUMN boletas.id_policia_01; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.id_policia_01 IS 'Policia uno ';


--
-- Name: COLUMN boletas.id_policia_02; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.id_policia_02 IS 'Policia dos ';


--
-- Name: COLUMN boletas.patrulla; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.patrulla IS 'Numero de patrulla u medio de transporte';


--
-- Name: COLUMN boletas.nombre_inf; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.nombre_inf IS 'Nombre(s)';


--
-- Name: COLUMN boletas.primer_apellido_inf; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.primer_apellido_inf IS 'Primer apellido';


--
-- Name: COLUMN boletas.segundo_apellido_inf; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.segundo_apellido_inf IS 'Segundo apellido';


--
-- Name: COLUMN boletas.sexo; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.sexo IS 'Sexo';


--
-- Name: COLUMN boletas.curp; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.curp IS 'Curp';


--
-- Name: COLUMN boletas.id_nacimiento; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.id_nacimiento IS 'Lugar de nacimiento';


--
-- Name: COLUMN boletas.fecha_nacimiento; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.fecha_nacimiento IS 'Fecha de nacimiento';


--
-- Name: COLUMN boletas.calle_inf; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.calle_inf IS 'Calle';


--
-- Name: COLUMN boletas.interior_inf; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.interior_inf IS 'No. interior';


--
-- Name: COLUMN boletas.exterior_inf; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.exterior_inf IS 'No. exterior';


--
-- Name: COLUMN boletas.cp_inf; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.cp_inf IS 'Código postal';


--
-- Name: COLUMN boletas.id_colonia_inf; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.id_colonia_inf IS 'Colonia';


--
-- Name: COLUMN boletas.id_alcaldia_inf; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.id_alcaldia_inf IS 'Alcaldia';


--
-- Name: COLUMN boletas.id_foto_inf; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.id_foto_inf IS 'Fotografía';


--
-- Name: COLUMN boletas.fecha_hechos; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.fecha_hechos IS 'Fecha en que ocurrieron los hechos';


--
-- Name: COLUMN boletas.hora_hechos; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.hora_hechos IS 'Fecha en que ocurrieron los hechos';


--
-- Name: COLUMN boletas.calle_hechos; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.calle_hechos IS 'Calle';


--
-- Name: COLUMN boletas.interior_hechos; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.interior_hechos IS 'No. interior';


--
-- Name: COLUMN boletas.exterior_hechos; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.exterior_hechos IS 'No. exterior';


--
-- Name: COLUMN boletas.cp_hechos; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.cp_hechos IS 'Código postal';


--
-- Name: COLUMN boletas.id_colonia_hechos; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.id_colonia_hechos IS 'Colonia';


--
-- Name: COLUMN boletas.id_alcaldia_hechos; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.id_alcaldia_hechos IS 'Alcaldia';


--
-- Name: COLUMN boletas.motivo_infraccion; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.motivo_infraccion IS 'Datos de la probable infracción';


--
-- Name: COLUMN boletas.objetos_recogidos; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.objetos_recogidos IS 'Objeto(s) recogido(s) relacionado(s) con la(s) probable(s) infracción(es)';


--
-- Name: COLUMN boletas.idinfraccion; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.idinfraccion IS 'Artículos';


--
-- Name: COLUMN boletas.estatus; Type: COMMENT; Schema: jc; Owner: postgres
--

COMMENT ON COLUMN boletas.estatus IS 'Estatus de la boleta';


--
-- Name: boletas_idboleta_seq; Type: SEQUENCE; Schema: jc; Owner: postgres
--

CREATE SEQUENCE boletas_idboleta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE jc.boletas_idboleta_seq OWNER TO postgres;

--
-- Name: boletas_idboleta_seq; Type: SEQUENCE OWNED BY; Schema: jc; Owner: postgres
--

ALTER SEQUENCE boletas_idboleta_seq OWNED BY boletas.idboleta;


--
-- Name: idboleta; Type: DEFAULT; Schema: jc; Owner: postgres
--

ALTER TABLE ONLY boletas ALTER COLUMN idboleta SET DEFAULT nextval('boletas_idboleta_seq'::regclass);


--
-- Name: boletas_pkey; Type: CONSTRAINT; Schema: jc; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY boletas
    ADD CONSTRAINT boletas_pkey PRIMARY KEY (idboleta);


--
-- PostgreSQL database dump complete
--

