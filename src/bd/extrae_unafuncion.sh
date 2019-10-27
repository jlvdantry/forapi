pg_dump inicio -h localhost -U inicio -Fc -s | pg_restore -P 'copiamenu(integer)' > src/bd/copiamenu.sql
