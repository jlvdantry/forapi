
SET search_path = jc, pg_catalog;

drop TABLE boletas ;
CREATE TABLE boletas (
    idboleta integer NOT NULL,
    boleta_remision varchar(20) ,
    id_policia_01 integer ,
    id_policia_02 integer ,
    patrulla varchar(30) ,
    id_areaadcripcion integer,
    nombre_inf varchar(30) ,
    primer_apellido_inf varchar(30),
    segundo_apellido_inf varchar(30),
    sexo varchar(1),
    curp varchar(18),
    id_nacimiento integer,
    fecha_nacimiento timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    calle_inf varchar(30),
    interior_inf varchar(15),
    exterior_inf varchar(15),
    cp_inf varchar(5),
    id_colonia_inf integer,
    id_alcaldia_inf integer,
    id_foto_inf    integer,
    fecha_hechos timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    hora_hechos timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    calle_hechos varchar(30),
    interior_hechos varchar(15),
    exterior_hechos varchar(15),
    cp_hechos varchar(5),
    id_colonia_hechos integer,
    id_alcaldia_hechos integer,
    motivo_infraccion text,
    objetos_recogidos text,
    idinfraccion integer,
    sancion_uc integer,
    sancion_servicio integer,
    sancion_arresto  integer,
    sancion_observacion text,
    estatus integer default 0,
    expediente varchar(30),
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername()
);


ALTER TABLE jc.boletas OWNER TO postgres;
COMMENT ON TABLE boletas IS 'Boletas de resmision';
COMMENT ON COLUMN boletas.idboleta IS 'id de la boleta';
COMMENT ON COLUMN boletas.id_policia_01 IS 'Policia uno ';
COMMENT ON COLUMN boletas.id_policia_02 IS 'Policia dos ';
COMMENT ON COLUMN boletas.patrulla IS 'Numero de patrulla u medio de transporte' ;
COMMENT ON COLUMN boletas.nombre_inf IS 'Nombre(s)';
COMMENT ON COLUMN boletas.primer_apellido_inf IS 'Primer apellido';
COMMENT ON COLUMN boletas.segundo_apellido_inf IS 'Segundo apellido';
COMMENT ON COLUMN boletas.sexo IS 'Sexo';
COMMENT ON COLUMN boletas.curp IS 'Curp';
COMMENT ON COLUMN boletas.id_nacimiento IS 'Lugar de nacimiento';
COMMENT ON COLUMN boletas.fecha_nacimiento IS 'Fecha de nacimiento';
COMMENT ON COLUMN boletas.calle_inf IS 'Calle';
COMMENT ON COLUMN boletas.interior_inf IS 'No. interior';
COMMENT ON COLUMN boletas.exterior_inf IS 'No. exterior';
COMMENT ON COLUMN boletas.cp_inf IS 'Código postal';
COMMENT ON COLUMN boletas.id_colonia_inf IS 'Colonia';
COMMENT ON COLUMN boletas.id_alcaldia_inf IS 'Alcaldia';
COMMENT ON COLUMN boletas.id_foto_inf IS 'Fotografía';
COMMENT ON COLUMN boletas.fecha_hechos IS 'Fecha en que ocurrieron los hechos';
COMMENT ON COLUMN boletas.hora_hechos IS 'Fecha en que ocurrieron los hechos';
COMMENT ON COLUMN boletas.calle_hechos IS 'Calle';
COMMENT ON COLUMN boletas.interior_hechos IS 'No. interior';
COMMENT ON COLUMN boletas.exterior_hechos IS 'No. exterior';
COMMENT ON COLUMN boletas.cp_hechos IS 'Código postal';
COMMENT ON COLUMN boletas.id_colonia_hechos IS 'Colonia';
COMMENT ON COLUMN boletas.id_alcaldia_hechos IS 'Alcaldia';
COMMENT ON COLUMN boletas.motivo_infraccion IS 'Datos de la probable infracción';
COMMENT ON COLUMN boletas.objetos_recogidos IS 'Objeto(s) recogido(s) relacionado(s) con la(s) probable(s) infracción(es)';
COMMENT ON COLUMN boletas.idinfraccion IS 'Artículos';
COMMENT ON COLUMN boletas.estatus IS 'Estatus de la boleta';



CREATE SEQUENCE boletas_idboleta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE jc.boletas_idboleta_seq OWNER TO postgres;
ALTER SEQUENCE boletas_idboleta_seq OWNED BY boletas.idboleta;

ALTER TABLE ONLY boletas ALTER COLUMN idboleta SET DEFAULT nextval('boletas_idboleta_seq'::regclass);
ALTER TABLE ONLY boletas
    ADD CONSTRAINT boletas_pkey PRIMARY KEY (idboleta);

REVOKE ALL ON TABLE boletas FROM PUBLIC;
REVOKE ALL ON TABLE boletas FROM postgres;
GRANT ALL ON TABLE boletas TO postgres;
GRANT SELECT ON TABLE boletas TO jcjs WITH GRANT OPTION;


--
-- Name: boletas_idboleta_seq; Type: ACL; Schema: jc; Owner: postgres
--

REVOKE ALL ON SEQUENCE boletas_idboleta_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE boletas_idboleta_seq FROM postgres;
GRANT ALL ON SEQUENCE boletas_idboleta_seq TO postgres;
GRANT ALL ON SEQUENCE boletas_idboleta_seq TO tmp_jc WITH GRANT OPTION;
GRANT ALL ON SEQUENCE boletas_idboleta_seq TO jcjs WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

