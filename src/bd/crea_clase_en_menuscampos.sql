
/*
alter table forapi.menus_campos add column clase varchar(100);
alter table forapi.menus_campos alter column clase set 
               DEFAULT '';

comment on column forapi.menus_campos.clase  is 'aqui apunta a la clase de bootstra a nivel de label e input o select';
*/

 INSERT INTO forapi.menus_campos( idmenu, reltype, attnum, descripcion, size, male, fuente, fuente_campodes, fuente_campodep, fuente_campofil, fuente_where, fuente_evento, orden, idsubvista, dialogwidth, dialogheight, obligatorio, busqueda, altaautomatico, tcase, checaduplicidad, readonly, valordefault, esindex, tipayuda, espassword, tabla, nspname, fuente_busqueda, val_particulares, htmltable, fuente_nspname, altaautomatico_idmenu, fuente_busqueda_idmenu, upload_file, formato_td, colspantxt, rowspantxt, autocomplete, imprime, totales, cambiarencambios, link_file, fuente_info, fuente_info_idmenu, fuente_actu, fuente_actu_idmenu,eshidden) VALUES ((select idmenu from forapi.menus where nspname='forapi' and descripcion='Campos de menus'),90294,COALESCE((select attnum from forapi.campos where nspname='forapi' and relname='menus_campos' and attname='clase'),'0'),'Fila',30,100,'','','','','',0,410,0,0,0,false,false,false,0,false,false,'',false,'',0,'menus_campos','forapi',false,'',0,'',0,0,false,0,0,0,0,true,false,true,false,false,0,false,0,false);
