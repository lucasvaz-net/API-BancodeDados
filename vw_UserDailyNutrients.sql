CREATE VIEW vw_UserDailyNutrients AS
SELECT 
    u.[id] AS UserId,
    u.[username] AS UserName,
    CAST(fd.[date] AS DATE) AS ConsumptionDate,
    SUM(n.[moisture]) AS TotalMoisture,
    SUM(n.[kcal]) AS TotalKcal,
    SUM(n.[kJ]) AS TotalkJ,
    SUM(n.[protein]) AS TotalProtein,
    SUM(n.[lipids]) AS TotalLipids,
    SUM(n.[cholesterol]) AS TotalCholesterol,
    SUM(n.[carbohydrates]) AS TotalCarbohydrates,
    SUM(n.[dietaryFiber]) AS TotalDietaryFiber,
    SUM(n.[ash]) AS TotalAsh,
    SUM(n.[calcium]) AS TotalCalcium,
    SUM(n.[magnesium]) AS TotalMagnesium,
    SUM(n.[manganese]) AS TotalManganese,
    SUM(n.[phosphorus]) AS TotalPhosphorus,
    SUM(n.[iron]) AS TotalIron,
    SUM(n.[sodium]) AS TotalSodium,
    SUM(n.[potassium]) AS TotalPotassium,
    SUM(n.[copper]) AS TotalCopper,
    SUM(n.[zinc]) AS TotalZinc,
    SUM(n.[retinol]) AS TotalRetinol,
    SUM(n.[re]) AS TotalRE,
    SUM(n.[rae]) AS TotalRAE,
    SUM(n.[thiamin]) AS TotalThiamin,
    SUM(n.[riboflavin]) AS TotalRiboflavin,
    SUM(n.[pyridoxine]) AS TotalPyridoxine,
    SUM(n.[niacin]) AS TotalNiacin,
    SUM(n.[vitaminC]) AS TotalVitaminC
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
