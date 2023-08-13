USE [API]
GO

CREATE PROCEDURE [dbo].[sp_GetUserFeedback]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Obt�m o objetivo di�rio de calorias do usu�rio
    DECLARE @DailyCaloriesGoal REAL
    SELECT @DailyCaloriesGoal = dailyCalories FROM userGoals WHERE userId = @UserID

    -- Calcula o total de calorias consumidas hoje
    DECLARE @TotalCaloriesConsumedToday REAL
    SELECT @TotalCaloriesConsumedToday = SUM(n.kcal * f.servingSize)
    FROM foodDiary AS f
    JOIN nutrients AS n ON f.foodId = n.foodId
    WHERE f.userId = @UserID AND f.date = CAST(GETDATE() AS DATE)

    -- Determina o feedback com base na compara��o entre o consumo e o objetivo
    DECLARE @Feedback NVARCHAR(MAX)
    IF @TotalCaloriesConsumedToday < @DailyCaloriesGoal
        SET @Feedback = 'Voc� consumiu menos calorias do que sua meta hoje. Continue assim!'
    ELSE IF @TotalCaloriesConsumedToday > @DailyCaloriesGoal
        SET @Feedback = 'Voc� ultrapassou sua meta di�ria de calorias. Cuidado com sua ingest�o!'
    ELSE
        SET @Feedback = 'Voc� atingiu exatamente sua meta di�ria de calorias. Bom trabalho!'

    SELECT @Feedback AS Feedback
END
GO
