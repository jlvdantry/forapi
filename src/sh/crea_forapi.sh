if [ "$#" -eq  "0" ]
   then
     echo "No se recibio ningun argumento"
     echo "$0 $1=nombre de base de datos $2=usuario administrador  $3=pwd del administrador"
     exit 1
fi
mn=$(basename -- "$0")
##sudo mkdir /var/lib/pgsql9/$1
##sudo chown postgres /var/lib/pgsql9/$1
##sudo initdb -D /var/lib/pgsql9/$1
##cp ../csjl_nvo/forapi_* .
export PGPASSWORD=$3
cat > $0.sql << fin
drop database $1;
drop user $2 ;
drop role admon;
drop role temporalg;
drop user $2 ;
create user $2 with password '$3' superuser;
create database $1 owner $2;
comment on database $1 is 'Formas rapidas';
drop user tmp_$2 ;
create user Temporal_$1 with password '$3' CREATEUSER;
create role temporalg;
create role admon;
drop schema forapi cascade;
fin
psql -U postgres < $0.sql > tmp/$mn.log
echo "creo base y usuarios en pg_authid" 
psql $1 -U $2 -h localhost  < src/bd/forapi_esquema.sql >> tmp/$mn.log
echo "creo el esquema" 
cat > $0.sql << fin
alter table forapi.menus_campos disable trigger ti_menus_campos;
alter table forapi.menus disable trigger ti_menus;
alter table forapi.menus disable trigger tu_menus;
fin
psql $1 -U $2 -h localhost  < $0.sql >> tmp/$mn.log
echo "deshabilito triggers" 
psql $1 -U $2 -h localhost  < src/bd/forapi_insert.sql >> tmp/$mn.log
echo "inserto datos forapi" 
cat > $0.sql << fin
alter table forapi.menus_campos enable trigger ti_menus_campos;
alter table forapi.menus enable  trigger ti_menus;
alter table forapi.menus enable  trigger tu_menus;
fin
psql $1 -U $2 -h localhost  < $0.sql >> tmp/$mn.log
echo "habilito triggers" 
cat > $0.sql << fin
insert into forapi.cat_usuarios (usename,nombre,id_tipomenu,password,estatus) values ('tmp_$1','temporal',1,'$3',1);
insert into forapi.cat_usuarios (usename,nombre,id_tipomenu,password,menu,estatus) values ('$2','$2',1,'$3',
(select idmenu from forapi.menus where descripcion='Mtto a usuarios'),1);
insert into forapi.cat_usuarios_pg_group(usename,groname) values ('tmp_$1','temporalg');
insert into forapi.cat_usuarios_pg_group(usename,groname) values ('$2','admon');
delete from forapi.menus_pg_tables where nspname not in ('forapi','pg_catalog','estadistica','public');
delete from forapi.menus where nspname not in ('forapi','pg_catalog','estadistica','public');
select forapi.autoriza_usuario('tmp_$1');
select forapi.autoriza_usuario('$2');
delete from pg_authid where rolcanlogin=false and rolname not in ('admon','temporalg');
fin
psql $1 -U $2 -h localhost  < $0.sql  >> tmp/$mn.log
echo "creo usuarios autorizo usuarios en forapi" 
cat > $0.sql << fin
select '<?php'
union all
select 'define(MENU,''' || idmenu || ''');' from forapi.menus where descripcion='Mtto a menus'
union all
select 'define(MENUS_CAMPOS,''' || idmenu || ''');' from forapi.menus where descripcion='Campos de menus'
union all
select 'define(MENUS_BIENVENIDO,''' || idmenu || ''');' from forapi.menus where descripcion='Bienvenido'
union all
select 'define(BD,''$1'');' 
union all
select 'define(PWD_USER_TMP,''$3'');' 
union all
select '?>'
fin
psql -t $1 -U $2 -h localhost  < $0.sql  > ./src/php/idmenus.php
echo "creo constantes"
sed -i -e "s/ //g" ./src/php/idmenus.php
tail -n 1 "./src/php/idmenus.php" | wc -c | xargs -I {} truncate "./src/php/idmenus.php" -s -{}
echo "cambio variales de la base"
