export PGPASSWORD=jc104
cat > $0.sql << fin
drop table if exists jc.Hoja1;
        create table jc.Hoja1(
        B varchar(255)
        ,C varchar(255)
        ,D varchar(255)
        ,E varchar(255)
        ,F varchar(255)
        ,G varchar(255)
        ,H varchar(255)
        ,id integer not null
        ,fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone
        ,usuario_alta character varying(20) DEFAULT getpgusername()
        ,fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone
        ,usuario_modifico character varying(20) DEFAULT getpgusername()
        );
        drop sequence if exists  jc.Hoja1_id_seq cascade;
        CREATE SEQUENCE jc.Hoja1_id_seq
          START WITH 1 INCREMENT BY 1 CACHE 1;
          ALTER SEQUENCE jc.Hoja1_id_seq OWNED BY jc.Hoja1.id;
          ALTER TABLE ONLY jc.Hoja1 ALTER COLUMN id SET DEFAULT nextval('jc.Hoja1_id_seq'::regclass);
          ALTER TABLE ONLY jc.Hoja1 ADD CONSTRAINT Hoja1_pkey PRIMARY KEY (id);
         comment on column Hoja1.B is 'Tipo';
         comment on column Hoja1.C is 'Unidad de cuenta desde';
         comment on column Hoja1.D is 'Unidad de cuenta hasta';
         comment on column Hoja1.E is 'Horas de Servicio Comunitatio desde';
         comment on column Hoja1.F is 'Horas de Servicio Comunitario hasta';
         comment on column Hoja1.G is 'Horas de arresto desde';
         comment on column Hoja1.H is 'Horas de arresto hasta';

fin
psql jc104 -U jc104 -h localhost  <  $0.sql
##psql jc104 -U jc104  -h localhost < src/bd/ejemplo/boletas.sql
##psql jc104 -U jc104  -h localhost < src/bd/alta_menus_campos.sql
##psql jc104 -U jc104  -h localhost < src/bd/cambia_menus_campos.sql
##psql jc104 -U jc104 -h localhost  <  src/bd/menus_excels.sql
##psql jc104 -U jc104 -h localhost  <  src/bd/cambia_menus.sql
##psql jc9 -U jc9 -h localhost  <  src/bd/cambio_menus.sql
##psql inicio -U inicio -h localhost  <   src/bd/crea_funcion_de_columnas_campos_menus.sql
##psql inicio -U inicio -h localhost  < src/bd/crea_clase_en_menuscampos.sql
##psql inicio -U inicio -h localhost  < $0.sql
##psql inicio -U inicio -h localhost  <  src/bd/copiamenu.sql
##psql inicio -U inicio -h localhost  < src/bd/carga_menus_htmltable.sql
rm $0.sql

