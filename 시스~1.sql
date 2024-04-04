alter session set "_ORACLE_SCRIPT" = true;
create user memo identified by 1234;
grant connect, resource, unlimited tablespace, create view to memo;
