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
-- Name: menus_excels; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

drop TABLE menus_excels ;
CREATE TABLE menus_excels (
    idexcel integer NOT NULL,
    descripcion varchar(100) ,
    nspname name,
    relname name,
    archivo varchar(100),
    movimiento numeric(1) default 0,
    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername()
);


ALTER TABLE forapi.menus_excels OWNER TO postgres;
COMMENT ON TABLE menus_excels IS 'tabla para subir archivos que se utilizan para crear una tabla y una nueva vista';

COMMENT ON COLUMN menus_excels.idexcel IS 'id del registro';


--
-- Name: COLUMN menus_excels.idmenu; Type: COMMENT; Schema: forapi; Owner: postgres
--



COMMENT ON COLUMN menus_excels.descripcion IS 'Nombre de la vista';
COMMENT ON COLUMN menus_excels.nspname IS 'Esquema ';
COMMENT ON COLUMN menus_excels.relname IS 'Tabla a la que se va a crear una vista  ';
COMMENT ON COLUMN menus_excels.movimiento IS 'Movimiento que se quiere hacer 0=crea tabla y vista, 1=crea solo vista';
COMMENT ON COLUMN menus_excels.archivo IS 'id del archivo que se esta subiendo';

COMMENT ON COLUMN menus_excels.fecha_alta IS 'Fecha en que hizo el movimiento el usuario';

COMMENT ON COLUMN menus_excels.usuario_alta IS 'Usuario hizo el alta ';

--
-- Name: menus_excels_idexcel_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_excels_idexcel_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_excels_idexcel_seq OWNER TO postgres;

--
-- Name: menus_excels_idexcel_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_excels_idexcel_seq OWNED BY menus_excels.idexcel;


--
-- Name: idexcel; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_excels ALTER COLUMN idexcel SET DEFAULT nextval('menus_excels_idexcel_seq'::regclass);


--
-- Name: menus_excels_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus_excels
    ADD CONSTRAINT menus_excels_pkey PRIMARY KEY (idexcel);


--
-- Name: ak1_menus_excels; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--



--
-- Name: ak2_menus_excels; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak2_menus_excels ON menus_excels USING btree (usuario_alta);


--
-- Name: ak3_menus_excels; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak3_menus_excels ON menus_excels USING btree (fecha_alta);


--
-- Name: menus_excels; Type: ACL; Schema: forapi; Owner: postgres
--

REVOKE ALL ON TABLE menus_excels FROM PUBLIC;
REVOKE ALL ON TABLE menus_excels FROM postgres;
GRANT ALL ON TABLE menus_excels TO postgres;
GRANT SELECT ON TABLE menus_excels TO jcjs WITH GRANT OPTION;


--
-- Name: menus_excels_idexcel_seq; Type: ACL; Schema: forapi; Owner: postgres
--

REVOKE ALL ON SEQUENCE menus_excels_idexcel_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE menus_excels_idexcel_seq FROM postgres;
GRANT ALL ON SEQUENCE menus_excels_idexcel_seq TO postgres;
GRANT ALL ON SEQUENCE menus_excels_idexcel_seq TO tmp_jc WITH GRANT OPTION;
GRANT ALL ON SEQUENCE menus_excels_idexcel_seq TO jcjs WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

