
if [ "$#" -eq  "0" ]
   then
     echo "No se recibio ningun argumento"
     echo "$0 $1=nombre de base de datos $2=usuario administrador  $3=pwd del administrador"
     exit 1
fi

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
select 'define(CORREO_HOST,'''');'
union all
select 'define(CORREO_PUERTO,'''');'
union all
select 'define(MANDRILL_USUARIO,'''');'
union all
select 'define(MANDRILL_APIKEY,'''');'
union all
select '?>'
fin
psql -t $1 -U $2 -h localhost  < $0.sql  > config.php
echo "creo constantes"
sed -i -e "s/ //g" config.php
tail -n 1 "config.php" | wc -c | xargs -I {} truncate "config.php" -s -{}
mv config.php src/php/.
rm $0.sql
