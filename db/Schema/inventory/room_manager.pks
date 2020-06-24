create or replace package room_manager as
  procedure add_room( i_id integer, i_name varchar2 );
  procedure add_room( i_name varchar2 );

  procedure import_from_ext_inv;
  procedure import_from_temp_table;
end;