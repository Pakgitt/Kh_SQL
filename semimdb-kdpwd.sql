alter session set "_ORACLE_SCRIPT" = true;
create user semimdb identified by kdpwd;
grant connect, resource, unlimited tablespace, create view to semimdb;


