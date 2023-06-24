SELECT SUM(VALUE)/1024/1024 sga_size FROM V$SGA;

ALTER SYSTEM SET DB_KEEP_CACHE_SIZE=1000M SCOPE=SPFILE;

SELECT COMPONENT, CURRENT_SIZE FROM V$SGA_DYNAMIC_COMPONENTS
WHERE COMPONENT IN ('shared pool', 'large pool', 'java pool', 'streams pool');

SELECT Pool, BYTES/1024/1024 granule_size_mb
FROM V_$SGASTAT
where pool IN ('shared pool', 'large pool', 'java pool', 'buffer cache', 'streams pool');

SELECT Pool, BYTES/1024/1024 free_size_mb
FROM V$SGASTAT
WHERE pool IN ('shared pool', 'large pool', 'java pool', 'buffer cache', 'streams pool');

--SQL PLUS
SHOW PARAMETER SGA;

SELECT name, VALUE FROM V$SGA;

SELECT *
FROM V_$SGA_DYNAMIC_COMPONENTS;

SELECT NAME, BLOCK_SIZE, CURRENT_SIZE
FROM V$BUFFER_POOL
WHERE NAME IN ('KEEP', 'DEFAULT', 'RECYCLE');

CREATE TABLE keep_table (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50)
) TABLESPACE TS_TDV STORAGE (BUFFER_POOL KEEP);
-- Показать сегмент таблицы
SELECT *
FROM V$BH
WHERE FILE# = (SELECT FILE# FROM DBA_DATA_FILES WHERE TABLESPACE_NAME = 'TS_TDV')
  AND BLOCK# = (SELECT BLOCK# FROM DBA_EXTENTS WHERE SEGMENT_NAME = 'KEEP_TABLE');
DROP TABLE KEEP_TABLE;

CREATE TABLE default_table (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50)
) TABLESPACE TS_TDV STORAGE (BUFFER_POOL DEFAULT);

SELECT *
FROM V$BH
WHERE FILE# = (SELECT FILE# FROM DBA_DATA_FILES WHERE TABLESPACE_NAME = 'TS_TDV')
  AND BLOCK# = (SELECT BLOCK# FROM DBA_EXTENTS WHERE SEGMENT_NAME = 'DEFAULT_TABLE');
DROP TABLE default_table;

SELECT group#, bytes/1024/1024 AS "Size (MB)"
FROM v$log;

SELECT NAME, POOL, bytes/1024/1024 AS "Free (MB)"
FROM v$sgastat
WHERE pool='LARGE_POOL'
AND name='free memory';

SELECT sid, serial#, username, program, server
FROM v$session;

--фон процессы
SELECT pid, spid, pname
FROM v$process
WHERE background=1;

--no background
SELECT pid, spid, pname
FROM v$process
WHERE background=0;

--14
SELECT count(*)
FROM v$process
WHERE pname LIKE 'DBW%';

SELECT name, NETWORK_NAME
FROM V_$SERVICES;

SELECT name, value
FROM v$parameter
WHERE name LIKE '%dispatcher%';



--19
--    cmd -> lsnrctl
-- start, stop, reload, status, services
--20
--19 + services


