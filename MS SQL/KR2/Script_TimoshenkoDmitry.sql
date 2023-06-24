-- VAR 3
USE SHOP;
GO
/*CREATE PROCEDURE ADDTOVARP @mfr char(3), @productId char(5), @description varchar(20), @price money, @qty int
AS
	BEGIN TRY
		INSERT PRODUCTS(MFR_ID, PRODUCT_ID, DESCRIPTION, PRICE, QTY_ON_HAND)
			VALUES (@mfr, @productId, @description, @price, @qty);
			RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT 'ERROR_NUMBER ' + CAST(ERROR_NUMBER() AS VARCHAR(6));
	PRINT 'ERROR_MESSAGE ' + ERROR_MESSAGE();
	RETURN -1;
	END CATCH;*/
GO
DECLARE @rc INT = 0;
EXEC @rc = ADDTOVARP @mfr = 'IMM', @productId = '92513', @description = 'PRODUCT EXAMPLE2', @price = 212.12, @qty = 11;
PRINT CAST(@rc AS VARCHAR(4));
GO
/*CREATE FUNCTION COUNTTOVAR(@rep INT) RETURNS INT
AS BEGIN
	DECLARE @rc INT = 0;
	SELECT @rc = COUNT(*) FROM ORDERS
		WHERE REP = @rep;
IF @rc = 0
	SET @rc = -1;
RETURN @rc;
END;*/
GO
DECLARE @rc INT = DBO.COUNTTOVAR(106);
PRINT CAST(@rc AS INT);
GO
CREATE PROCEDURE CHOSEORDERS @num int
AS 
DECLARE @rc INT = 0;
BEGIN TRY
	DECLARE @tv char(20), @t char(300) = '';
		DECLARE CHOSE CURSOR FOR 
			SELECT ORDER_NUM FROM ORDERS WHERE QTY > @num;
			OPEN CHOSE;
			FETCH CHOSE INTO @tv;
			PRINT '������';
			WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @t = RTRIM(@tv) + ',' + @t;
				SET @rc = @rc + 1;
				FETCH CHOSE INTO @tv;
			END;
			PRINT @t;
			CLOSE CHOSE;
			RETURN @rc;
END TRY
BEGIN CATCH
	PRINT '������';
	IF ERROR_PROCEDURE() IS NOT NULL
		PRINT '���������: ' + ERROR_PROCEDURE();
	RETURN @rc;
END CATCH;
GO
DECLARE @rc int = 0;
EXEC @rc = CHOSEORDERS @num = 1;
PRINT @rc;
GO
/*CREATE FUNCTION COUNTPERSONA(@mgr INT) RETURNS INT
AS BEGIN
	DECLARE @rc INT = 0;
	SELECT @rc = COUNT(*) FROM SALESREPS WHERE MANAGER = @mgr;
	IF @rc = 0
		SET @rc = -1;
	RETURN @rc;
END;*/
GO
DECLARE @f INT = dbo.COUNTPERSONA(104);
PRINT CAST(@f AS VARCHAR(4));