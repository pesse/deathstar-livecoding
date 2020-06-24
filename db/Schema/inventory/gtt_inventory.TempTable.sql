drop table gtt_inventory;
create global temporary table gtt_inventory (
  room varchar2(200),
  item varchar2(2000),
  item_count varchar2(10)
);

