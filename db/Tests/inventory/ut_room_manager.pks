create or replace package ut_room_manager as
  -- %suite(Room Manager)

  -- %test
  procedure add_room;

  -- %test
  -- %throws(-1)
  procedure add_same_name_fails;

  -- %test
  -- %tags(long_running)
  procedure read_from_ext_inventory;

  -- %test
  procedure add_to_inventory_from_temp_table;
end;
/