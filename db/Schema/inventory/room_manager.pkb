create or replace package body room_manager as
  procedure add_room( i_id integer, i_name varchar2 ) as
  begin
    insert into rooms ( id, name )
      values (i_id, i_name);
  end;

  procedure add_room( i_name varchar2 ) as
  begin
    insert into rooms ( name )
      values (i_name);
  end;

  procedure import_from_ext_inv as
  begin
    insert into gtt_inventory
      select room, item, item_count
      from ext_inventory;
  end;

  procedure import_from_temp_table as
  begin
    insert into inventory (room_id)
      select
        r.id
        from gtt_inventory gtt
        inner join rooms r
          on gtt.room = r.name;
  end;

end;
/