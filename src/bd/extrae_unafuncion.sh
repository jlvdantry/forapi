pg_dump jc104 -h localhost -U jc104 -Fc -s | pg_restore -P 'alta_cat_usuarios()' > src/bd/alta_cat_usuarios.sql
