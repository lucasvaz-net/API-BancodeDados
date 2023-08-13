CREATE VIEW vw_AllFoods AS
SELECT 
    f.[id] AS FoodId,
    f.[name] AS FoodName,
    c.[name] AS CategoryName,
    n.[moisture] AS Moisture,
    n.[kcal] AS Kcal,
    n.[kJ] AS kJ,
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
    [foods] f
JOIN 
    [categories] c ON f.[categoryId] = c.[id]
LEFT JOIN 
    [nutrients] n ON f.[id] = n.[foodId];
