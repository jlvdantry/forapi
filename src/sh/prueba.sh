export PGPASSWORD=Ffarahi7_
cat > $0.sql << fin
--select * from forapi.menus_pg_tables where tablename='cat_bitacora_seq';
--select * from forapi.menus where idmenu=17;
--update forapi.menus set inicioregistros=true where idmenu=17;
--select forapi.autoriza_usuario('usuario1');
--select * from forapi.menus_subvistas where clase<>'';
--update forapi.menus_subvistas set clase='src/php/' || clase where clase<>'';
--select * from forapi.cat_usuarios where usename='inicio';
--select * from pg_shadow
--select idmenu,descripcion from forapi.menus order by descripcion
--COPY forapi.tcases (tcase, descripcion) FROM stdin;
--1	UPPER
--2	lower
--..\.
select * from forapi.menus;
fin
psql fotos -h localhost -U farahi7 < $0.sql
##psql inicio -h localhost -U inicio < cat_bitacora.sql
##my_name=$(basename -- "$0")
##echo $my_name
##| sed -r "s/.+\/(.+)\..+/\1/"
rm $0.sql

