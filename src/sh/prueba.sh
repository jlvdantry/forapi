export PGPASSWORD=inicio
cat > $0.sql << fin
--select * from forapi.menus_pg_tables where tablename='cat_bitacora_seq';
--select * from forapi.menus where idmenu=8;
--select forapi.autoriza_usuario('usuario1');
--select * from forapi.menus_subvistas where clase<>'';
--update forapi.menus_subvistas set clase='src/php/' || clase where clase<>'';
select * from forapi.cat_usuarios where usename='inicio';
fin
psql inicio -h localhost -U inicio < $0.sql
##psql inicio -h localhost -U inicio < cat_bitacora.sql
rm $0.sql

