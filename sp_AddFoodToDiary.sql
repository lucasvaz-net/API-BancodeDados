USE [API]
GO

CREATE PROCEDURE [dbo].[sp_AddFoodToDiary]
    @UserID INT,
    @FoodID INT,
    @ServingSize REAL,
    @EntryDate DATE = NULL  -- � opcional, pois a tabela tem um valor padr�o de GETDATE() para a data.
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Se @EntryDate for NULL, a coluna date ir� pegar o valor padr�o.
    INSERT INTO [dbo].[foodDiary] (userId, foodId, servingSize, date)
    VALUES (@UserID, @FoodID, @ServingSize, @EntryDate)

    DECLARE @InsertedID INT
    SET @InsertedID = SCOPE_IDENTITY()  -- Pega o ID da �ltima inser��o.

    -- Log da opera��o
    INSERT INTO [dbo].[LOG_foodDiary] (id, userId, foodId, servingSize, date, loguserId, operation, actionDate)
    VALUES (@InsertedID, @UserID, @FoodID, @ServingSize, @EntryDate, @UserID, 'I', GETDATE())
END
GO
