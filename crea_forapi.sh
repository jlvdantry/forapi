if [ "$#" -eq  "0" ]
   then
     echo "No se recibio ningun argumento"
     echo "$0 $1=nombre de base de datos $2=usuario administrador  $3=pwd del administrador"
     exit 1
fi
##sudo mkdir /var/lib/pgsql9/$1
##sudo chown postgres /var/lib/pgsql9/$1
##sudo initdb -D /var/lib/pgsql9/$1
cp ../csjl_nvo/forapi_* .
export PGPASSWORD=$3
cat > $0.sql << fin
drop database $1;
drop user $2 ;
drop user Temporal_forapi;
drop role temporal;
drop role admon;
create user $2 with password '$3' superuser;
create database $1 owner $2;
comment on database $1 is 'Formas rapidas';
create user Temporal_forapi with password '$3' ;
create role temporalg;
create role admon;
fin
psql -U postgres < $0.sql
psql inicio -U inicio -h localhost  < forapi_esquema.sql > $0.log
psql inicio -U inicio -h localhost  < forapi_insert.sql >> $0.log
cat > $0.sql << fin
insert into forapi.cat_usuarios (usename,nombre,id_tipomenu,password) values ('Temporal1','temporal',1,'$3');
insert into forapi.cat_usuarios (usename,nombre,id_tipomenu,password,menu) values ('$2','$2',1,'$3',
(select idmenu from forapi.menus where descripcion='Mtto a usuarios'));
insert into forapi.cat_usuarios_pg_group(usename,groname) values ('Temporal1','temporalg');
insert into forapi.cat_usuarios_pg_group(usename,groname) values ('$2','admon');
select forapi.autoriza_usuario('Temporal_forapi');
select forapi.autoriza_usuario('$2');
delete from pg_authid where rolcanlogin=false and rolname not in ('admon','temporalg');
fin
psql inicio -U inicio -h localhost  < $0.sql  >> $0.log
cat > $0.sql << fin
select '<?php'
union all
select 'define(MENU,''' || idmenu || ''');' from forapi.menus where descripcion='Mtto a menus'
union all
select 'define(MENUS_CAMPOS,''' || idmenu || ''');' from forapi.menus where descripcion='Campos de menus'
union all
select '?>'
fin
tar -xvzf forapi_php.tar.gz
echo "desempaco archivo"
psql -t inicio -U inicio -h localhost  < $0.sql  > idmenus.php
echo "creo constantes"
sed -i -e "s/ //g" idmenus.php
tail -n 1 "idmenus.php" | wc -c | xargs -I {} truncate "idmenus.php" -s -{}
sed -i -e "s/wldbname='forapi1.1'/wldbname='$1'/g" -e "s/password='Temporal_forapi'/password='$3'/g" conneccion.php
echo "cambio variales de la base"
rm $0.sql
