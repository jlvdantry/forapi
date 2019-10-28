export PGPASSWORD=jc9
cat > $0.sql << fin
--select * from forapi.menus where descripcion='Mtto a menus';
--select * from forapi.menus_campos where idmenu=14;
--update forapi.menus_campos set formato_td=1 where idmenu=14;
--select descripcion,cambiarencambios from forapi.menus_campos where idmenu=17;
--update forapi.menus set columnas=2 where idmenu=14
--select * from forapi.menus_htmltable
--alter user temporal1 with password 'inicio';
--select * from pg_shadow;
/*
select * from pg_group;
update forapi.menus_pg_group set groname='temporalg' where groname='usosistema';
update forapi.cat_usuarios_pg_group set usename='temporal1' where usename='Temporal1';
*/
--insert into forapi.menus_pg_group(idmenu,groname) values (8,'temporalg');
--select groname,(select descripcion from forapi.menus m where m.idmenu=mpg.idmenu) menu,mpg.idmenu,mpg.grosysid from forapi.menus_pg_group mpg;
--select * from forapi.cat_usuarios_pg_group;
--update forapi.menus_pg_tables set tinsert=0,tupdate=1 where tablename='his_cat_usuarios_pg_group_idcambio_seq' and idmenu=18;
--select * from forapi.menus_pg_tables where tablename='his_cat_usuarios_pg_group_idcambio_seq';
--update forapi.menus_pg_tables set nspname='forapi' where nspname='public';
--select * from forapi.menus_pg_tables where nspname=''
select * from pg_shadow;
fin
##psql inicio -U inicio  -h localhost < $0.sql
psql jc9 -U jc9 -h localhost  <  src/bd/menus_scripts.sql
##psql inicio -U inicio -h localhost  <   src/bd/crea_funcion_de_columnas_campos_menus.sql
##psql inicio -U inicio -h localhost  < src/bd/crea_clase_en_menuscampos.sql
##psql inicio -U inicio -h localhost  < $0.sql
##psql inicio -U inicio -h localhost  <  src/bd/copiamenu.sql
##psql inicio -U inicio -h localhost  < src/bd/carga_menus_htmltable.sql
rm $0.sql

