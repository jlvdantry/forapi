/*
CREATE SEQUENCE forapi.menus_campos_fila_seq
    START WITH 1
    INCREMENT BY 20
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

alter table forapi.menus_campos add column fila integer;
alter table forapi.menus_campos alter column fila set 
               DEFAULT nextval(('forapi.menus_campos_fila_seq'::text)::regclass);

comment on column forapi.menus_campos.fila  is 'campo para controlar cuantas columnas va a contener una fila, si dos columnas contienen las misma fila, esta fila tendra dos columnas';

update forapi.menus_campos set fila=orden;
*/

 INSERT INTO forapi.menus_campos( idmenu, reltype, attnum, descripcion, size, male, fuente, fuente_campodes, fuente_campodep, fuente_campofil, fuente_where, fuente_evento, orden, idsubvista, dialogwidth, dialogheight, obligatorio, busqueda, altaautomatico, tcase, checaduplicidad, readonly, valordefault, esindex, tipayuda, espassword, tabla, nspname, fuente_busqueda, val_particulares, htmltable, fuente_nspname, altaautomatico_idmenu, fuente_busqueda_idmenu, upload_file, formato_td, colspantxt, rowspantxt, autocomplete, imprime, totales, cambiarencambios, link_file, fuente_info, fuente_info_idmenu, fuente_actu, fuente_actu_idmenu,eshidden) VALUES ((select idmenu from forapi.menus where nspname='forapi' and descripcion='Campos de menus'),90294,COALESCE((select attnum from forapi.campos where nspname='forapi' and relname='menus_campos' and attname='fila'),'0'),'Fila',30,100,'','','','','',0,400,0,0,0,false,false,false,0,false,false,'',false,'',0,'menus_campos','forapi',false,'',0,'',0,0,false,0,0,0,0,true,false,true,false,false,0,false,0,false);

update forapi.menus_campos set fila=orden;
