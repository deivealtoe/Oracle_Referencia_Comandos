SELECT * FROM dba_users;

CREATE TABLESPACE sankhya
DATAFILE 'sankhya.dbf' SIZE 100M REUSE
AUTOEXTEND ON NEXT 10M MAXSIZE 11000M
ONLINE;

CREATE TABLESPACE sankind
DATAFILE 'sankind.dbf' SIZE 100M REUSE
AUTOEXTEND ON NEXT 10M MAXSIZE 11000M
ONLINE;

CREATE TABLESPACE sanklob
DATAFILE 'sanklob.dbf' SIZE 100M REUSE
AUTOEXTEND ON NEXT 10M MAXSIZE 11000M
ONLINE;

--DROP USER teste CASCADE;

--DROP TABLESPACE sanklob;


/* ====================================================================================================================================================================== */

-- MOSTRA TABLESPACES
select b.tablespace_name,
       tbs_size SizeMb,
       a.free_space FreeMb
FROM
(
	select tablespace_name,
           round(sum(bytes)/1024/1024 ,2) as free_space
    from dba_free_space
    group by tablespace_name
) a,
(
    select tablespace_name,
           sum(bytes)/1024/1024 as tbs_size
    from dba_data_files
    group by tablespace_name
    UNION
    select tablespace_name,
           sum(bytes)/1024/1024 tbs_size
    from dba_temp_files
    group by tablespace_name
) b
where a.tablespace_name(+) = b.tablespace_name
ORDER BY 2;s

-- MOSTRA USUÁRIOS CONECTADOS
select s.sid as "Sid", s.serial# as "Serial#", nvl(s.username, ' ') as "Username", s.machine as "Machine", s.schemaname as "Schema name", s.logon_time as "Login time", s.program as "Program", s.osuser as "Os user", s.status as "Status", nvl(s.process, ' ') as "OS Process id"
from v$session s
where nvl(s.username, 'a') not like 'a' and status like 'ACTIVE'
order by 1,2;


