USE UNIVER;
SET NOCOUNT ON
	IF  EXISTS (SELECT * FROM  SYS.OBJECTS
	            WHERE OBJECT_ID= object_id(N'DBO.X') )	            
	DROP TABLE X;           
	DECLARE @c int, @flag char = 'c';
	SET IMPLICIT_TRANSACTIONS  ON
	CREATE TABLE X(K int );
		INSERT X VALUES (1),(2),(3);
		SET @c = (SELECT COUNT(*) FROM X);
		PRINT '���������� ����� � ������� X: ' + CAST( @c as varchar(2));
		if @flag = 'c'  commit;
	          else   rollback;
      SET IMPLICIT_TRANSACTIONS  OFF
	
	IF  EXISTS (SELECT * FROM  SYS.OBJECTS
	            WHERE OBJECT_ID= object_id(N'DBO.X') )
	PRINT '������� X ����';  
      ELSE PRINT '������� X ���'
GO
BEGIN TRY
	BEGIN TRAN
		INSERT AUDITORIUM VALUES(121-1, '��-�', 200, 121-1);
		COMMIT TRAN;
END TRY
BEGIN CATCH
	PRINT 'ERROR ' + CASE
	WHEN ERROR_NUMBER() = 2627
		THEN 'DUPLICATE'
		ELSE 'UNREGISTRED ERROR'
	END;
	IF @@TRANCOUNT > 0 ROLLBACK TRAN;
END CATCH;
GO
DECLARE @p NVARCHAR(4);
BEGIN TRY
	BEGIN TRAN
		INSERT AUDITORIUM VALUES('334-1', '��-�', 20, '334-1');
		SET @p = '1'; SAVE TRAN @p;
		DELETE AUDITORIUM WHERE AUDITORIUM.AUDITORIUM = '334-1';
		SET @p = '2'; SAVE TRAN @p;
		INSERT AUDITORIUM VALUES(121-1, '��-�', 200, 121-1);
		COMMIT TRAN;
END TRY
BEGIN CATCH
	PRINT 'ERROR ' + CASE
	WHEN ERROR_NUMBER() = 2627
		THEN 'DUPLICATE'
		ELSE 'UNREGISTRED ERROR'
	END;
	IF @@TRANCOUNT > 0
	BEGIN
		PRINT '����������� ����� ' + @p;
		ROLLBACK TRAN @p;
		COMMIT TRAN;
	END;
END CATCH;
GO
--A
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRAN
	SELECT @@SPID, 'INS RES', * FROM AUDITORIUM;
	SELECT @@SPID, 'UPD RES', AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM
								WHERE AUDITORIUM.AUDITORIUM = '344-1';
COMMIT;
--B
BEGIN TRAN
	SELECT @@SPID
		INSERT AUDITORIUM VALUES('344-1', '��-�', 30, '344-1');
		UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = 60 WHERE AUDITORIUM.AUDITORIUM = '344-1';
		--A
		--B
ROLLBACK;
GO
--A
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN
SELECT AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM
								WHERE AUDITORIUM.AUDITORIUM = '344-1';
								--B
	SELECT @@SPID, 'UPD RES', AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM
								WHERE AUDITORIUM.AUDITORIUM = '344-1';
COMMIT;
--B
BEGIN TRAN
		UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = 120 WHERE AUDITORIUM.AUDITORIUM = '344-1';
COMMIT;
GO
--A
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
SELECT AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM
								WHERE AUDITORIUM.AUDITORIUM = '346-1';
								--B
SELECT CASE
WHEN AUDITORIUM.AUDITORIUM_CAPACITY = 123	 THEN 'INS RES' ELSE ''
END 'RES', AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM WHERE AUDITORIUM.AUDITORIUM = '346-1';
COMMIT;
--B
BEGIN TRAN
		INSERT AUDITORIUM VALUES('346-1', '��', 123, '346-1');
COMMIT;
GO
GO
--A
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRAN
DELETE AUDITORIUM WHERE AUDITORIUM = '347-1';
INSERT AUDITORIUM VALUES('347-1', '��', 100, '347-1');
SELECT AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM WHERE AUDITORIUM = '347-1';
--B
SELECT AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM WHERE AUDITORIUM = '347-1';
COMMIT;
--B
BEGIN TRAN
DELETE AUDITORIUM WHERE AUDITORIUM = '347-1';
INSERT AUDITORIUM VALUES('347-1', '��', 100, '347-1');
SELECT AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM WHERE AUDITORIUM = '347-1';
COMMIT;
SELECT AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM WHERE AUDITORIUM = '347-1';
GO
BEGIN TRAN
DELETE AUDITORIUM WHERE AUDITORIUM = '347-1';
BEGIN TRAN
INSERT AUDITORIUM VALUES('347-1', '��', 100, '347-1');
COMMIT
IF @@TRANCOUNT > 0 ROLLBACK ELSE COMMIT;
SELECT AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM WHERE AUDITORIUM = '347-1';
GO