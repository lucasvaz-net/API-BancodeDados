USE [API]
GO

CREATE PROCEDURE [dbo].[sp_RemoveFoodFromDiary]
    @DiaryEntryID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Salva as informações da entrada antes de deletar para o registro.
    DECLARE @UserID INT, @FoodID INT, @ServingSize REAL, @EntryDate DATE
    SELECT @UserID = userId, @FoodID = foodId, @ServingSize = servingSize, @EntryDate = date
    FROM [dbo].[foodDiary] WHERE id = @DiaryEntryID
    
    -- Deleta a entrada do diário
    DELETE FROM [dbo].[foodDiary] WHERE id = @DiaryEntryID

    -- Log da operação de delete
    INSERT INTO [dbo].[LOG_foodDiary] (id, userId, foodId, servingSize, date, loguserId, operation, actionDate)
    VALUES (@DiaryEntryID, @UserID, @FoodID, @ServingSize, @EntryDate, @UserID, 'D', GETDATE())
END
GO
