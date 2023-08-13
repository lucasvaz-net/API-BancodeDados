CREATE VIEW vw_UserDailyCalories AS
SELECT 
    u.[id] AS UserId,
    u.[username] AS UserName,
    CAST(fd.[date] AS DATE) AS ConsumptionDate,
    SUM(n.[kcal]) AS TotalCalories
FROM 
    [users] u
JOIN 
    [foodDiary] fd ON u.[id] = fd.[userId]
JOIN 
    [foods] f ON fd.[foodId] = f.[id]
JOIN 
    [nutrients] n ON f.[id] = n.[foodId]
GROUP BY 
    u.[id], u.[username], CAST(fd.[date] AS DATE);
