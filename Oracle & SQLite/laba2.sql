ALTER SESSION SET "_oracle_script" = TRUE;

CREATE TABLESPACE TS_TDV
DATAFILE 'D:\TS_TDV.dbf'
SIZE 7M
AUTOEXTEND ON
NEXT 5M
MAXSIZE 30M;

CREATE TEMPORARY TABLESPACE TS_TDV_TEMP
TEMPFILE 'D:\TS_TDV_TEMP.dbf'
SIZE 5M
AUTOEXTEND ON
NEXT 3M
MAXSIZE 20M;

SELECT * FROM SYS.DBA_TABLESPACES;

SELECT tablespace_name, file_name
FROM dba_data_files;

CREATE ROLE RL_TDVCORE;
GRANT CREATE SESSION TO RL_TDVCORE;
GRANT CREATE TABLE TO RL_TDVCORE;
GRANT CREATE VIEW TO RL_TDVCORE;
GRANT CREATE PROCEDURE TO RL_TDVCORE;
SELECT role FROM dba_roles WHERE role = 'RL_TDVCORE';
SELECT privilege
FROM dba_sys_privs
WHERE grantee = 'RL_TDVCORE';

CREATE PROFILE PF_TDVCORE LIMIT
  SESSIONS_PER_USER 3
  CONNECT_TIME 180
  PASSWORD_LIFE_TIME 180
  FAILED_LOGIN_ATTEMPTS 7
  PASSWORD_LOCK_TIME 1
  PASSWORD_REUSE_TIME 10
  pASSWORD_GRACE_TIME DEFAULT
  IDLE_TIME 30;
  SELECT * FROM DBA_PROFILES;
  SELECT * FROM DBA_PROFILES WHERE PROFILE = 'PF_TDVCORE';
  SELECT * FROM DBA_PROFILES WHERE PROFILE = 'DEFAULT';
  CREATE USER TDV IDENTIFIED BY password
  DEFAULT TABLESPACE TS_TDV
  TEMPORARY TABLESPACE TS_TDV_TEMP
  PROFILE PF_TDVCORE
  ACCOUNT UNLOCK
  PASSWORD EXPIRE;
  GRANT RL_TDVCORE TO TDV;
  SELECT * FROM SYS.DBA_USERS;

CREATE TABLE TDV_T (INTER INT PRIMARY KEY);
INSERT INTO TDV_T VALUES (232);
SELECT * FROM TDV_T;
ALTER USER TDV QUOTA 2M ON TS_TDV;
ALTER TABLESPACE TS_TDV OFFLINE;
INSERT INTO TDV_T VALUES (243);
SELECT * FROM TDV_T;
