USE [API]
GO

CREATE PROCEDURE [dbo].[sp_UpdateFoodInDiary]
    @DiaryEntryID INT,
    @UserID INT,
    @FoodID INT,
    @ServingSize REAL,
    @EntryDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Atualiza a entrada no diário
    UPDATE [dbo].[foodDiary]
    SET 
        userId = @UserID,
        foodId = @FoodID,
        servingSize = @ServingSize,
        date = @EntryDate
    WHERE 
        id = @DiaryEntryID

    -- Log da operação de atualização com dados atualizados
    INSERT INTO [dbo].[LOG_foodDiary] (id, userId, foodId, servingSize, date, logUserId, operation, actionDate)
    VALUES (@DiaryEntryID, @UserID, @FoodID, @ServingSize, @EntryDate, @UserID, 'U', GETDATE())
END
GO
