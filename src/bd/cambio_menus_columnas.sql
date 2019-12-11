CREATE or replace FUNCTION forapi.cambio_menus_columnas() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      wlestado numeric;
      wlfila    numeric;
      lleva    numeric;
      mireg record;
      wlclase   varchar(100);
      registros numeric;
      htmltableant numeric;
      num_rows numeric;
    BEGIN
     if old.columnas!=new.columnas then
      if new.columnas>0 then
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
        registros=0;
        for mireg in select * from forapi.menus_campos where idmenu=old.idmenu and eshidden=false
                   order by htmltable,orden
          loop
            if registros=0 then
               htmltableant=mireg.htmltable;
            end if;
            if htmltableant<>mireg.htmltable then
               lleva=0;
               wlfila=wlfila+20;
               htmltableant=mireg.htmltable;
            end if;
            if lleva=new.columnas then
               lleva=0;
               wlfila=wlfila+20;
            end if;
            update forapi.menus_campos set fila=wlfila,clase=wlclase where idcampo=mireg.idcampo;
            lleva=lleva+1;
            registros=registros+1;
            raise notice ' descripcion % , fila % lleva % ', mireg.descripcion, wlfila, lleva;
          end loop;
      end if;
      if new.columnas=0 then
        for mireg in select coalesce(htmltable,0) htmltable,coalesce(fila,0) fila,count(*) as columnas from forapi.menus_campos where idmenu=old.idmenu and eshidden=false
                  group by htmltable,fila
                  order by htmltable,fila
          loop
          wlclase='col-md-1';
          if mireg.columnas=1 then
             wlclase='col-md-12';
          end if;
          if mireg.columnas=2 then
             wlclase='col-md-6';
          end if;
          if mireg.columnas=3 then
             wlclase='col-md-4';
          end if;
          if mireg.columnas=4 then
             wlclase='col-md-3';
          end if;
          if mireg.columnas=5 then
             wlclase='col-md-2';
          end if;
          if mireg.columnas=6 then
             wlclase='col-md-2';
          end if;
          update forapi.menus_campos set clase=wlclase where idmenu=old.idmenu and fila=mireg.fila and htmltable=mireg.htmltable and coalesce(clase,'')='';
          GET DIAGNOSTICS num_rows = ROW_COUNT;
          raise notice ' clase % , fila % lleva % actualizados % columnas %', wlclase, mireg.fila, mireg.htmltable, num_rows,  mireg.columnas;
          end loop;
      end if;
     end if;
     return new;
    END;$$;


ALTER FUNCTION forapi.cambio_menus_columnas() OWNER TO postgres;

--
-- PostgreSQL database dump complete
--

