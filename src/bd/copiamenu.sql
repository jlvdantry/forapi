--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = forapi, pg_catalog;

--
-- Name: copiamenu(integer); Type: FUNCTION; Schema: forapi; Owner: postgres
--

CREATE or replace FUNCTION copiamenu(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$DECLARE
        wlatl smallint;
        wlidmenu numeric;
        v_cnt numeric;
BEGIN
--  menus
     v_cnt := 0;

    SET search_path = forapi, pg_catalog;
    create temp table menu_tmp as
    select *  from menus
    where idmenu=$1;
    select nextval('menus_idmenu_seq') into wlidmenu;
    update menu_tmp set idmenu=wlidmenu,descripcion=descripcion||' Copia'
           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    insert into menus select * from menu_tmp;
    select count(*) into v_cnt from menus_pg_tables where idmenu=wlidmenu;
    raise notice '1 encontro registros en la nueva opcion %' , v_cnt;
--  menus_campos
    create temp table menus_campos_tmp as
    select * from menus_campos
    where idmenu=$1;
    update menus_campos_tmp set idmenu=wlidmenu
           ,idcampo=(select nextval('menus_campos_idcampo_seq') from menus_campos_tmp as mct where mct.idcampo=menus_campos_tmp.idcampo)
           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    insert into menus_campos select * from menus_campos_tmp;
    select count(*) into v_cnt from menus_pg_tables where idmenu=wlidmenu;
    raise notice '2 encontro registros en la nueva opcion %' , v_cnt;

--  menus_tablas
    create temp table menus_pg_tables_tmp as
    select * from menus_pg_tables
    where idmenu=$1;
    GET DIAGNOSTICS v_cnt = ROW_COUNT;
    raise notice 'creado %' , v_cnt;
    raise notice 'idmenu % , wlidmenu %', $1, wlidmenu;
    update menus_pg_tables_tmp set idmenu=wlidmenu;
--           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
--           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    GET DIAGNOSTICS v_cnt = ROW_COUNT;
    raise notice 'actualizado %' , v_cnt;
    select count(*) into v_cnt from menus_pg_tables where idmenu=wlidmenu;
    raise notice 'encontro registros en la nueva opcion %' , v_cnt;
    insert into menus_pg_tables select * from menus_pg_tables_tmp pgtt where (select count(*) from menus_pg_tables pgt where pgt.tablename=pgtt.tablename
                                                                              and pgt.nspname=pgtt.nspname and pgt.idmenu=$1)=0;

--  menus_subvistas
    create temp table menus_subvistas_tmp as 
    select * from menus_subvistas
    where idmenu=$1;
    update menus_subvistas_tmp set idmenu=wlidmenu
           ,idmenus_subvistas=(select nextval('menus_subvistas_idmenus_subvistas_seq') from menus_subvistas as mct where mct.idmenus_subvistas=menus_subvistas_tmp.idmenus_subvistas)
           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    insert into menus_subvistas select * from menus_subvistas_tmp;


--  menus_grupos
    create temp table menus_pg_group_tmp as
    select * from menus_pg_group
    where idmenu=$1;
    update menus_pg_group_tmp set idmenu=wlidmenu
           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    insert into menus_pg_group select * from menus_pg_group_tmp;

--  menus_movtos
    create temp table menus_movtos_tmp as
    select * from menus_movtos
    where idmenu=$1;
    update menus_movtos_tmp set idmenu=wlidmenu
           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    insert into menus_movtos select * from menus_movtos_tmp;


--  menus_eventos
    create temp table menus_eventos_tmp as
    select * from menus_eventos
    where idmenu=$1;
    update menus_eventos_tmp set idmenu=wlidmenu
           ,idmenus_eventos=(select nextval('menus_eventos_idmenus_eventos_seq') from menus_eventos as mct where mct.idmenus_eventos=menus_eventos_tmp.idmenus_eventos)
           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    insert into menus_eventos select * from menus_eventos_tmp;

--  menus_campos_eventos
    create temp table menus_campos_eventos_tmp as
    select * from menus_campos_eventos
    where idmenu=$1;
    update menus_campos_eventos_tmp set idmenu=wlidmenu
           ,icv=(select nextval('menus_campos_eventos_icv_seq') from menus_campos_eventos as mct where mct.icv=menus_campos_eventos_tmp.icv)
           ,fecha_alta=current_timestamp ,usuario_alta=getpgusername()
           ,fecha_modifico=current_timestamp ,usuario_modifico=getpgusername();
    insert into menus_campos_eventos select * from menus_campos_eventos_tmp;

RETURN 'ok';
END;$_$;


ALTER FUNCTION forapi.copiamenu(integer) OWNER TO postgres;

--
-- PostgreSQL database dump complete
--

