pg_dump jc9 -h localhost -U jc9 -Fc -s | pg_restore -P 'alta_menus_campos()' > src/bd/alta_menus_campos.sql
