
CREATE or replace FUNCTION forapi.estatus_usuario(text) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$DECLARE
  wlestatus smallint;  
  wlmenu    smallint;  
  begin
          SELECT cu.estatus,cu.menu into wlestatus,wlmenu from pg_shadow pgs, forapi.cat_usuarios cu where pgs.usename=cast($1 as name)
                 and pgs.usename =cast(cu.usename as name);
          if wlestatus=0 then
                        return 'Tu usuario no esta autorizado';
          end if;
          
          if wlestatus=2 then
                        return 'Tu usuario esta bloqueado';
          end if;                       

          if wlestatus=3 then
                        return 'Tu usuario esta inhabilitado definitivamente';
          end if;                                           
          return wlmenu::varchar;
end;$_$;


ALTER FUNCTION forapi.estatus_usuario(text) OWNER TO postgres;

