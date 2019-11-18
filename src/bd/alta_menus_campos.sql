CREATE or replace FUNCTION forapi.alta_menus_campos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
      wlnum    numeric;
    BEGIN
        select reltype into new.reltype from forapi.menus where idmenu=new.idmenu;
        select count (*) into wlnum from forapi.campos where tabla=new.tabla and nspname=new.nspname and attname=new.descripcion  
               and valor_default like '%nextval%';
        if wlnum>0 then
           raise notice 'alta_menus_campos % % % %' , new.idmenu,new.tabla,new.descripcion,new.nspname;
           insert into forapi.menus_pg_tables (idmenu,tablename,tselect,tinsert,tupdate,tdelete,tall,tgrant,nspname)
                  values (new.idmenu,trim(new.tabla)||'_'||trim(new.descripcion)||'_seq' ,1 ,0 ,1 ,0 ,0 ,0 ,new.nspname);
        end if;
        if new.upload_file=true then
           new.readonly=true;
        end if;
     return new;
    END;$$;


ALTER FUNCTION forapi.alta_menus_campos() OWNER TO postgres;

--
-- PostgreSQL database dump complete
--

