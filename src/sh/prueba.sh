export PGPASSWORD=inicio
cat > $0.sql << fin
--select * from forapi.menus_pg_tables where tablename='cat_bitacora_seq';
--select * from forapi.menus where idmenu=17;
--update forapi.menus set inicioregistros=true where idmenu=17;
--select forapi.autoriza_usuario('usuario1');
--select * from forapi.menus_subvistas where clase<>'';
--update forapi.menus_subvistas set clase='src/php/' || clase where clase<>'';
--select * from forapi.cat_usuarios where usename='inicio';
select * from pg_shadow
fin
psql prueba -h localhost -U inicio < $0.sql
##psql inicio -h localhost -U inicio < cat_bitacora.sql
##my_name=$(basename -- "$0")
##echo $my_name
##| sed -r "s/.+\/(.+)\..+/\1/"
rm $0.sql

