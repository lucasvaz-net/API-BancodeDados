USE [API]
GO

CREATE PROCEDURE [dbo].[sp_RemoveFoodFromDiary]
    @DiaryEntryID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Salva as informa��es da entrada antes de deletar para o registro.
    DECLARE @UserID INT, @FoodID INT, @ServingSize REAL, @EntryDate DATE
    SELECT @UserID = userId, @FoodID = foodId, @ServingSize = servingSize, @EntryDate = date
    FROM [dbo].[foodDiary] WHERE id = @DiaryEntryID
    
    -- Deleta a entrada do di�rio
    DELETE FROM [dbo].[foodDiary] WHERE id = @DiaryEntryID

    -- Log da opera��o de delete
    INSERT INTO [dbo].[LOG_foodDiary] (id, userId, foodId, servingSize, date, loguserId, operation, actionDate)
    VALUES (@DiaryEntryID, @UserID, @FoodID, @ServingSize, @EntryDate, @UserID, 'D', GETDATE())
END
GO
