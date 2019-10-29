pg_dump jc9 -h localhost -U jc9 -Fc -s | pg_restore -P 'cambio_menus_columnas()' > src/bd/cambio_menus_columnas.sql
