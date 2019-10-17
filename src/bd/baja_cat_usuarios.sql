CREATE or replace FUNCTION forapi.baja_cat_usuarios() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
      sql      text;
      existe   numeric;
    BEGIN
        existe=0;
        insert into forapi.his_cat_usuarios (usename,nombre,apepat,apemat,puesto,depto,correoe,direccion_ip,
               idpregunta,respuesta,estatus,telefono,cve_movto)
               values (old.usename,old.nombre,old.apepat,old.apemat,old.puesto,old.depto,old.correoe,old.direccion_ip,
               old.idpregunta,old.respuesta,old.estatus,old.telefono,'b');
           sql='drop user ' || old.usename;
           execute sql ;
     return old;
    END;$$;


ALTER FUNCTION forapi.baja_cat_usuarios() OWNER TO postgres;

