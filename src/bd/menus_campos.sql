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
-- Name: menus_campos; Type: TABLE; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE TABLE menus_campos (
    idcampo integer NOT NULL,
    idmenu integer,
    reltype oid DEFAULT 0 NOT NULL,
    attnum integer DEFAULT 0 NOT NULL,
    descripcion character varying(100),
    size integer,
    male integer,
    fuente character varying(100) DEFAULT ''::character varying,
    fuente_campodes character varying(30) DEFAULT ''::character varying,
    fuente_campodep character varying(30) DEFAULT ''::character varying,
    fuente_campofil character varying(255) DEFAULT ''::character varying,
    fuente_where character varying(4000),
    fuente_evento smallint DEFAULT 0,
    orden integer,
    idsubvista integer,
    dialogwidth integer DEFAULT 40,
    dialogheight integer DEFAULT 30,
    obligatorio boolean,
    busqueda boolean DEFAULT false,
    altaautomatico boolean DEFAULT false,
    tcase smallint DEFAULT 0,
    checaduplicidad boolean,
    readonly boolean DEFAULT false,
    valordefault character varying(299),
    esindex boolean DEFAULT false,
    tipayuda character varying(255),
    fecha_alta timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_alta character varying(20) DEFAULT getpgusername(),
    fecha_modifico timestamp with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usuario_modifico character varying(20) DEFAULT getpgusername(),
    espassword smallint DEFAULT 0,
    tabla character varying(50),
    nspname name,
    fuente_busqueda boolean DEFAULT false,
    val_particulares character varying(30),
    htmltable smallint DEFAULT 0,
    fuente_nspname name DEFAULT ''::name,
    altaautomatico_idmenu integer DEFAULT 0,
    fuente_busqueda_idmenu integer DEFAULT 0,
    upload_file boolean DEFAULT false,
    formato_td smallint,
    colspantxt smallint,
    rowspantxt smallint,
    autocomplete smallint DEFAULT 0,
    imprime boolean DEFAULT true,
    totales boolean DEFAULT false,
    cambiarencambios boolean DEFAULT true,
    link_file boolean DEFAULT false,
    fuente_info boolean DEFAULT false,
    fuente_info_idmenu integer DEFAULT 0,
    fuente_actu boolean DEFAULT false,
    fuente_actu_idmenu integer DEFAULT 0,
    eshidden boolean DEFAULT false,
    fila integer DEFAULT nextval(('forapi.menus_campos_fila_seq'::text)::regclass),
    clase character varying(100) DEFAULT ''::character varying
);


ALTER TABLE forapi.menus_campos OWNER TO postgres;

--
-- Name: COLUMN menus_campos.fuente_busqueda; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.fuente_busqueda IS 'Indica si en un campo select se tiene la opcion de busqueda esto se utiliza cuando las opciones son bastantes y el browse no se pasme';


--
-- Name: COLUMN menus_campos.val_particulares; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.val_particulares IS 'Se indica que validacion utilizar en el cliente si es mas de una es separado por ; y hay que corregir el ';


--
-- Name: COLUMN menus_campos.htmltable; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.htmltable IS 'Numero de tabla en el html, por default es 0, si se pone otro numero crea otra tabla en region de captura de datos';


--
-- Name: COLUMN menus_campos.altaautomatico_idmenu; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.altaautomatico_idmenu IS 'Numero de menu con la cual se va a dara alta en automatico';


--
-- Name: COLUMN menus_campos.fuente_busqueda_idmenu; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.fuente_busqueda_idmenu IS 'Numero de menu con la cual se van a buscar datos';


--
-- Name: COLUMN menus_campos.upload_file; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.upload_file IS 'Indica si el campo sirve para subir archivos false=no true=si';


--
-- Name: COLUMN menus_campos.formato_td; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.formato_td IS '0=normal,1=etiqueta y texto juntos,2=etiqueta y texto juntos todo el renglon';


--
-- Name: COLUMN menus_campos.colspantxt; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.colspantxt IS 'col span del texto en td, en caso de textarea es el ancho del renglon';


--
-- Name: COLUMN menus_campos.rowspantxt; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.rowspantxt IS 'row span del texto en td, en caso de textarea es la altura del renglon';


--
-- Name: COLUMN menus_campos.autocomplete; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.autocomplete IS 'Indica si se completa el campos en estos momento funciona para campos select, la idea es que funcione para campos texto 0=no,1=si';


--
-- Name: COLUMN menus_campos.imprime; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.imprime IS 'Indica si el campo se imprime true=si false=no';


--
-- Name: COLUMN menus_campos.totales; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.totales IS 'Indica si en la columna de campos se arega un total true=si, false=no';


--
-- Name: COLUMN menus_campos.cambiarencambios; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.cambiarencambios IS 'Con este campo se control que no se puedan cambiar datos en cambios, especificamente sirve para los campos de busqueda';


--
-- Name: COLUMN menus_campos.fila; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.fila IS 'campo para controlar cuantas columnas va a contener una fila, si dos columnas contienen las misma fila, esta fila tendra dos columnas';


--
-- Name: COLUMN menus_campos.clase; Type: COMMENT; Schema: forapi; Owner: postgres
--

COMMENT ON COLUMN menus_campos.clase IS 'aqui apunta a la clase de bootstra a nivel de label e input o select';


--
-- Name: menus_campos_idcampo_seq; Type: SEQUENCE; Schema: forapi; Owner: postgres
--

CREATE SEQUENCE menus_campos_idcampo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE forapi.menus_campos_idcampo_seq OWNER TO postgres;

--
-- Name: menus_campos_idcampo_seq; Type: SEQUENCE OWNED BY; Schema: forapi; Owner: postgres
--

ALTER SEQUENCE menus_campos_idcampo_seq OWNED BY menus_campos.idcampo;


--
-- Name: idcampo; Type: DEFAULT; Schema: forapi; Owner: postgres
--

ALTER TABLE ONLY menus_campos ALTER COLUMN idcampo SET DEFAULT nextval('menus_campos_idcampo_seq'::regclass);


--
-- Name: menus_campos_pkey; Type: CONSTRAINT; Schema: forapi; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menus_campos
    ADD CONSTRAINT menus_campos_pkey PRIMARY KEY (idcampo);


--
-- Name: ak1_menus_campos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak1_menus_campos ON menus_campos USING btree (idmenu, attnum);


--
-- Name: ak2_menus_campos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak2_menus_campos ON menus_campos USING btree (fuente_busqueda_idmenu);


--
-- Name: ak3_menus_campos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak3_menus_campos ON menus_campos USING btree (fuente_info_idmenu);


--
-- Name: ak4_menus_campos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak4_menus_campos ON menus_campos USING btree (fuente_actu_idmenu);


--
-- Name: ak5_menus_campos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak5_menus_campos ON menus_campos USING btree (idsubvista);


--
-- Name: ak6_menus_campos; Type: INDEX; Schema: forapi; Owner: postgres; Tablespace: 
--

CREATE INDEX ak6_menus_campos ON menus_campos USING btree (altaautomatico_idmenu);


--
-- Name: ti_menus_campos; Type: TRIGGER; Schema: forapi; Owner: postgres
--

CREATE TRIGGER ti_menus_campos BEFORE INSERT ON menus_campos FOR EACH ROW EXECUTE PROCEDURE alta_menus_campos();


--
-- Name: menus_campos; Type: ACL; Schema: forapi; Owner: postgres
--

REVOKE ALL ON TABLE menus_campos FROM PUBLIC;
REVOKE ALL ON TABLE menus_campos FROM postgres;
GRANT ALL ON TABLE menus_campos TO postgres;
GRANT SELECT ON TABLE menus_campos TO tmp_jc104 WITH GRANT OPTION;
GRANT ALL ON TABLE menus_campos TO jc104 WITH GRANT OPTION;


--
-- Name: menus_campos_idcampo_seq; Type: ACL; Schema: forapi; Owner: postgres
--

REVOKE ALL ON SEQUENCE menus_campos_idcampo_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE menus_campos_idcampo_seq FROM postgres;
GRANT ALL ON SEQUENCE menus_campos_idcampo_seq TO postgres;
GRANT ALL ON SEQUENCE menus_campos_idcampo_seq TO tmp_jc104 WITH GRANT OPTION;
GRANT ALL ON SEQUENCE menus_campos_idcampo_seq TO jc104 WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

