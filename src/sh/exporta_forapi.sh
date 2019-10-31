export PGPASSWORD=jc81
cat > $0.sql << fin
delete from forapi.cat_bitacora;
delete from forapi.his_cambios_pwd;
delete from forapi.his_cat_usuarios;
delete from forapi.his_cat_usuarios_pg_group;
delete from forapi.his_menus;
delete from forapi.his_menus_pg_group;
delete from forapi.his_menus_pg_tables;
fin
psql jc81 -U jc81  -h localhost < $0.sql
pg_dump jc81 -U jc81  -h localhost  -s -n forapi -x  > src/bd/forapi_esquema.sql
pg_dump jc81 -U jc81  -h localhost  -a -n forapi -x  > src/bd/forapi_insert.sql
rm $0.sql
