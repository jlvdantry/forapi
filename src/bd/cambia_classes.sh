cat > $0.sql << fin
--select * from forapi.menus where descripcion='Mtto a menus';
--select * from forapi.menus_campos where idmenu=14;
--update forapi.menus_campos set formato_td=1 where idmenu=14;
--select descripcion,cambiarencambios from forapi.menus_campos where idmenu=17;
--update forapi.menus set columnas=2 where idmenu=14
--select * from forapi.menus_htmltable
select a.descripcion,a.htmltable,pga.attname,pga.attrelid,pga.atttypid        , a.esindex as indice    ,(select pgad.adsrc from pg_attrdef as pgad where a.attnum = pgad.adnum and a.oid = pgad.adrelid) as pdefault            ,(select pgt.typname from pg_type as pgt where pgt.oid = pga.atttypid ) as typname  ,(case when mh.orden is null then htmltable else mh.orden end) ordengrupo   from ( select mc.*, pgc.oid, pgc.relname  from forapi.menus_campos as mc , pg_class as pgc , pg_namespace pgn  where idmenu=20 and pgc.relname  = 'menus_campos'  and pgc.relnamespace=pgn.oid  and pgn.nspname = 'forapi'  order by htmltable,orden ) as a left outer join pg_attribute as pga on (a.oid = pga.attrelid and pga.attnum = cast(a.attnum as smallint)) left outer join forapi.menus_htmltable as mh on (a.htmltable = mh.idhtmltable) order by ordengrupo ,a.fila,a.orden
fin
psql inicio -U inicio -h localhost  < $0.sql
##psql inicio -U inicio -h localhost  <  src/bd/crea_fila_en_menuscampos.sql
##psql inicio -U inicio -h localhost  <   src/bd/crea_funcion_de_columnas_campos_menus.sql
##psql inicio -U inicio -h localhost  < src/bd/crea_clase_en_menuscampos.sql
##psql inicio -U inicio -h localhost  < $0.sql
##psql inicio -U inicio -h localhost  <  src/bd/copiamenu.sql
##psql inicio -U inicio -h localhost  < src/bd/carga_menus_htmltable.sql
rm $0.sql

