create table rooms (
  id integer generated by default as identity primary key ,
  name varchar2(200)
);

alter table rooms
  add constraint rooms_uq_name unique (name);