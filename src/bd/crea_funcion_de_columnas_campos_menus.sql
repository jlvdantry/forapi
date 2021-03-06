
--CREATE TRIGGER tu_menus_columnas BEFORE update ON forapi.menus FOR EACH ROW EXECUTE PROCEDURE forapi.cambio_menus_columnas();


CREATE or replace FUNCTION forapi.cambio_menus_columnas() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
      wlfila    numeric;
      lleva    numeric;
      mireg record;
      wlclase   varchar(100);
    BEGIN
     if old.columnas!=new.columnas then
        if new.columnas=1 then 
           wlclase='col-md-12';
        end if;
        if new.columnas=2 then 
           wlclase='col-md-6';
        end if;
        if new.columnas=3 then 
           wlclase='col-md-4';
        end if;
        if new.columnas=4 then 
           wlclase='col-md-3';
        end if; 
        if new.columnas=5 then 
           wlclase='col-md-2';
        end if; 
        if new.columnas=6 then 
           wlclase='col-md-2';
        end if; 
        wlfila=20;
        lleva=0;
        for mireg in select * from forapi.menus_campos where idmenu=old.idmenu
                   order by htmltable,fila,orden
                loop
            update forapi.menus_campos set fila=wlfila,clase=wlclase where idcampo=mireg.idcampo;
            lleva=lleva+1;
            --raise notice ' descripcion % , fila % lleva % ', mireg.descripcion, wlfila, lleva;
            if lleva=new.columnas then
               lleva=0;
               wlfila=wlfila+20;
            end if;
        end loop;
     end if;
     return new;
    END;$$;


ALTER FUNCTION forapi.cambio_menus_columnas() OWNER TO postgres;

