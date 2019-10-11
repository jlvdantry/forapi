export PGPASSWORD=inicio
cat > $0.sql << fin
--select idmenu,idmenupadre,descripcion,nspname from forapi.menus where descripcion in('Mtto a menus','Autorizacion de registro');
--select * from forapi.menus_subvistas where idmenu in (select idmenu from forapi.menus where descripcion in('Mtto a menus')); ;
--update forapi.menus set nspname='forpai' where nspname is null;
--select * from forapi.menus_campos where idmenu=6 order by orden; 
--select * from forapi.menus_subvistas where idmenu=23 order by orden; 
--update forapi.menus_subvistas set idsubvista=1 where idmenu=6 and funcion=''; 
--update forapi.menus_subvistas set idsubvista=0 where idmenu=6 and funcion!=''; 
select * from forapi.cat_usuarios;
--select usename , '' as "Password" from forapi.cat_usuarios where usuario_alta is null limit 0

fin
psql inicio -h localhost -U inicio < $0.sql
