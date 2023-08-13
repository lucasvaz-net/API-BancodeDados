CREATE VIEW vw_UserProfile AS
SELECT 
    u.[id] AS UserId,
    u.[username] AS UserName,
    u.[email] AS Email,
    u.[dateOfBirth] AS DateOfBirth,
    u.[weight] AS CurrentWeight,
    u.[goalWeight] AS GoalWeight,
    u.[activityLevel] AS ActivityLevel,
    u.[dateJoined] AS DateJoined,
    u.[lastLogin] AS LastLogin
FROM 
    [users] u;
