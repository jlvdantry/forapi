export PGPASSWORD=jc9
cat > $0.sql << fin
update forapi.menus set columnas=3 where idmenu=46;
--select * from forapi.menus_campos where idmenu=46 and eshidden=false order by htmltable,orden
fin
psql jc9 -U jc9 -h localhost  <  src/bd/cambio_menus_columnas.sql
psql jc9 -U jc9  -h localhost < $0.sql
##psql jc9 -U jc9 -h localhost  <  src/bd/menus_scripts.sql
##psql jc9 -U jc9 -h localhost  <  src/bd/cambio_menus.sql
##psql inicio -U inicio -h localhost  <   src/bd/crea_funcion_de_columnas_campos_menus.sql
##psql inicio -U inicio -h localhost  < src/bd/crea_clase_en_menuscampos.sql
##psql inicio -U inicio -h localhost  < $0.sql
##psql inicio -U inicio -h localhost  <  src/bd/copiamenu.sql
##psql inicio -U inicio -h localhost  < src/bd/carga_menus_htmltable.sql
rm $0.sql

