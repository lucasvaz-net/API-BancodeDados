CREATE VIEW vw_UserFoodDiary AS
SELECT 
    u.[id] AS UserId,
    u.[username] AS UserName,
    fd.[date] AS EntryDate,
    f.[name] AS FoodName,
    n.[moisture] AS Moisture,
    n.[kcal] AS Calories,
    n.[kJ] AS EnergykJ,
    n.[protein] AS Protein,
    n.[lipids] AS Lipids,
    n.[cholesterol] AS Cholesterol,
    n.[carbohydrates] AS Carbohydrates,
    n.[dietaryFiber] AS DietaryFiber,
    n.[ash] AS Ash,
    n.[calcium] AS Calcium,
    n.[magnesium] AS Magnesium,
    n.[manganese] AS Manganese,
    n.[phosphorus] AS Phosphorus,
    n.[iron] AS Iron,
    n.[sodium] AS Sodium,
    n.[potassium] AS Potassium,
    n.[copper] AS Copper,
    n.[zinc] AS Zinc,
    n.[retinol] AS Retinol,
    n.[re] AS RE,
    n.[rae] AS RAE,
    n.[thiamin] AS Thiamin,
    n.[riboflavin] AS Riboflavin,
    n.[pyridoxine] AS Pyridoxine,
    n.[niacin] AS Niacin,
    n.[vitaminC] AS VitaminC
FROM 
    [users] u
JOIN 
    [foodDiary] fd ON u.[id] = fd.[userId]
JOIN 
    [foods] f ON fd.[foodId] = f.[id]
JOIN 
    [nutrients] n ON f.[id] = n.[foodId];
