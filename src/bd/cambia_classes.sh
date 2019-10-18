cat > $0.sql << fin
select * from forapi.menus where descripcion='Mtto a usuarios';
select descripcion,cambiarencambios from forapi.menus_campos where idmenu=17;
fin
psql inicio -U inicio -h localhost  < $0.sql

