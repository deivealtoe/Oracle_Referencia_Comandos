SELECT *
FROM dba_users;

SELECT *
FROM V$TABLESPACE;

SELECT *
FROM dba_tablespaces;


CREATE TABLESPACE sankhya
DATAFILE '/opt/oracle/oradata/XE/XEPDB1/sankhya.dbf' SIZE 100M REUSE
AUTOEXTEND ON NEXT 10M MAXSIZE 11000M
ONLINE;

CREATE TABLESPACE sankind
DATAFILE '/opt/oracle/oradata/XE/XEPDB1/sankind.dbf' SIZE 100M REUSE
AUTOEXTEND ON NEXT 10M MAXSIZE 11000M
ONLINE;

CREATE TABLESPACE sanklob
DATAFILE '/opt/oracle/oradata/XE/XEPDB1/sanklob.dbf' SIZE 100M REUSE
AUTOEXTEND ON NEXT 10M MAXSIZE 11000M
ONLINE;

--DROP TABLESPACE sanklob INCLUDING CONTENTS AND DATAFILES;

SELECT name,
       open_mode,
       cdb
FROM v$database;

SELECT name,
       open_mode
FROM v$containers;


/*
ESSES COMANDOS DEVEM SER EXECUTADOS COMO "sqlplus / as sysdba"

show user;

show con_name;

alter session set container = xepdb1;

Para a criação da tablespace, é necessário informar o parâmetro "DATAFILE" e colocar o novo tablespace dentro do PDB que estamos usando (como nas criações acima)
*/

