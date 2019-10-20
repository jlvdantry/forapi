cat > $0.sql << fin
--select * from forapi.menus where descripcion='Mtto a menus';
--select * from forapi.menus_campos where idmenu=14;
--update forapi.menus_campos set formato_td=1 where idmenu=14;
--select descripcion,cambiarencambios from forapi.menus_campos where idmenu=17;
--update forapi.menus set columnas=2 where idmenu=14
fin
##psql inicio -U inicio -h localhost  < $0.sql
##psql inicio -U inicio -h localhost  <  src/bd/crea_fila_en_menuscampos.sql
psql inicio -U inicio -h localhost  <   src/bd/crea_funcion_de_columnas_campos_menus.sql
##psql inicio -U inicio -h localhost  < src/bd/crea_clase_en_menuscampos.sql
##psql inicio -U inicio -h localhost  < $0.sql
rm $0.sql

