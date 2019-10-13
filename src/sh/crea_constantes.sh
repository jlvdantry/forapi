if [ "$#" -ne  "2" ]
   then
     echo "No se recibio ningun argumento"
     echo "$0 $1=nombre de base de datos $2=usuario administrador  "
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
select '?>'
fin
psql -t $1 -U $2 -h localhost  < $0.sql  > idmenus.php
echo "creo constantes"
sed -i -e "s/ //g" idmenus.php
tail -n 1 "idmenus.php" | wc -c | xargs -I {} truncate "idmenus.php" -s -{}
mv idmenus.php src/php/.
rm $0.sql
