export PGPASSWORD=jc104
cat > $0.sql << fin
update forapi.menus_campos set nspname='jc',fuente='opciones_b',fuente_campodes='descricion',fuente_campodep='id',altaautomatico=true where idmenu=96 and attnum=
( select attnum from forapi.campos where relname='opciones' and nspname='jc' and attname='b' );
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

