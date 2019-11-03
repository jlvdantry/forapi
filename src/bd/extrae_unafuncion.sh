pg_dump jc104 -h localhost -U jc104 -Fc -s | pg_restore -P 'autoriza_usuario(text)' > src/bd/autoriza_usuario.sql
