pg_dump jc104 -h localhost -U jc104 -Fc -s | pg_restore -P 'alta_menus_campos()' > src/bd/alta_menus_campos.sql
