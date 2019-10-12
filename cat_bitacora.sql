CREATE or replace FUNCTION forapi.grababitacora(integer, integer, integer, integer, date, date, text) RETURNS text
    LANGUAGE plpgsql
    AS $_$
DECLARE
  wlestado numeric;
  aoutput  text;
  begin
   if $1 = 0 then
--      raise notice ' antes de insert %, fecha inicial % ', $7,$5;
--      aoutput := ' insert into cat_bitacora (idproceso,fecha_inicio,fecha_fin,at_inicio,at_fin,descripcion) ' ||
--         ' values (' || $2 || ',''' || $5 || ''',''' || $6 || ''',' ||
--            $3 || ',' || $4 || ',''' || $7 || ''');' ;
--      raise notice ' va a ejecutar insert % ', aoutput;
--      execute aoutput;
        insert into forapi.cat_bitacora (idproceso,fecha_inicio,fecha_fin,at_inicio,at_fin,descripcion) 
          values ( $2 , $5 , $6, $3 , $4 , $7 );
--      raise notice ' va a ejecutar insert % ', aoutput;
      select currval('forapi.cat_bitacora_idbitacora_seq') into wlestado;
   else
      if $7 <> '' then
          update forapi.cat_bitacora set estado=1, descripcion=$7
             where idbitacora=$1;
      else
          update forapi.cat_bitacora set estado=1
             where idbitacora=$1;
      end if;
   end if;
--  commit transaction;
  return wlestado;
  end;$_$;


ALTER FUNCTION forapi.grababitacora(integer, integer, integer, integer, date, date, text) OWNER TO postgres;

