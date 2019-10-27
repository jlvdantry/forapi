pg_dump inicio -U inicio -h localhost  -s -n forapi -x > src/bd/forapi_esquema.sql
pg_dump inicio -U inicio -h localhost  -a -n forapi -x > src/bd/forapi_insert.sql
