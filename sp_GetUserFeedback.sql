USE [API]
GO

CREATE PROCEDURE [dbo].[sp_GetUserFeedback]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Obtém o objetivo diário de calorias do usuário
    DECLARE @DailyCaloriesGoal REAL
    SELECT @DailyCaloriesGoal = dailyCalories FROM userGoals WHERE userId = @UserID

    -- Calcula o total de calorias consumidas hoje
    DECLARE @TotalCaloriesConsumedToday REAL
    SELECT @TotalCaloriesConsumedToday = SUM(n.kcal * f.servingSize)
    FROM foodDiary AS f
    JOIN nutrients AS n ON f.foodId = n.foodId
    WHERE f.userId = @UserID AND f.date = CAST(GETDATE() AS DATE)

    -- Determina o feedback com base na comparação entre o consumo e o objetivo
    DECLARE @Feedback NVARCHAR(MAX)
    IF @TotalCaloriesConsumedToday < @DailyCaloriesGoal
        SET @Feedback = 'Você consumiu menos calorias do que sua meta hoje. Continue assim!'
    ELSE IF @TotalCaloriesConsumedToday > @DailyCaloriesGoal
        SET @Feedback = 'Você ultrapassou sua meta diária de calorias. Cuidado com sua ingestão!'
    ELSE
        SET @Feedback = 'Você atingiu exatamente sua meta diária de calorias. Bom trabalho!'

    SELECT @Feedback AS Feedback
END
GO
