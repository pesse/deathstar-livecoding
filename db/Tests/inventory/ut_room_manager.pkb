create or replace package body ut_room_manager as

  gc_test_chamber_name constant varchar2(200) :=
    'Darth Vaders Chamber35146381,35135';
  id_room constant integer := -1;

  procedure add_room as
    l_count integer;
  begin
    room_manager.add_room(id_room, gc_test_chamber_name);

    select count(*) into l_count
      from rooms
      where id = id_room;
    ut.expect(l_count).to_equal(1);
  end;

  procedure add_same_name_fails as
  begin
    room_manager.add_room('Engine Room 1');
    room_manager.add_room('Engine Room 1');
  end;

  procedure read_from_ext_inventory as
    l_ext sys_refcursor;
  begin

    room_manager.import_from_ext_inv;

    open l_ext for select * from gtt_inventory;
    ut.expect(l_ext).not_to_be_empty();
  end;

  procedure  add_to_inventory_from_temp_table as
    l_actual sys_refcursor;
    l_expected sys_refcursor;
  begin
    room_manager.add_room(id_room, gc_test_chamber_name);
    insert into gtt_inventory (room)
      values (gc_test_chamber_name);
    insert into gtt_inventory (room)
      values (gc_test_chamber_name);

    room_manager.import_from_temp_table;

    open l_actual for select room_id from inventory;
    open l_expected for
      select id_room as room_id from dual union all
      select id_room            from dual;

    ut.expect(l_actual).to_equal(l_expected);
  end;
end;
/