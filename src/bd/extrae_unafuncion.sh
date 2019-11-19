pg_dump jc104 -h localhost -U jc104 -Fc -s | pg_restore -P 'cambia_menus()' > src/bd/cambia_menus.sql
