-- SHOW PARAMETER PFILE;
CREATE SPFILE='TDV_SPFILEXE.ora' FROM PFILE='TDV_PFILE.ORA';
CREATE PFILE='TDV_PFILE.ORA' FROM SPFILE='D:\DB_HOME\DATABASE\SPFILEXE.ORA';

SELECT * FROM V$PARAMETER where name='open_cursors';

ALTER SYSTEM SET open_cursors=300 SCOPE=SPFILE;

STARTUP FORCE;

STARTUP PFILE="D:\ORACLE-DB\DBHOMEXE\DATABASE\SPFILEXE1.ORA";

SELECT name FROM v$controlfile;

ALTER DATABASE BACKUP CONTROLFILE TO TRACE;

SHOW PARAMETER password_file;

SHOW PARAMETER diagnostic_dest;

select * from v$pwfile_users;

Switch logfile;

SELECT name, value
FROM v$parameter
WHERE value LIKE 'D:\%';

SELECT value
FROM v$diag_info
WHERE name = 'Diag Trace';