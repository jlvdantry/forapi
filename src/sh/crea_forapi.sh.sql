select '<?php'
union all
select 'define(MENU,''' || idmenu || ''');' from forapi.menus where descripcion='Mtto a menus'
union all
select 'define(MENUS_CAMPOS,''' || idmenu || ''');' from forapi.menus where descripcion='Campos de menus'
union all
select 'define(MENUS_BIENVENIDO,''' || idmenu || ''');' from forapi.menus where descripcion='Bienvenido'
union all
select 'define(BD,''jc104'');' 
union all
select 'define(PWD_USER_TMP,''jc104'');' 
union all
select '?>'
