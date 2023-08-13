CREATE PROCEDURE [dbo].[sp_GetUserByEmail]
    @Email NVARCHAR(255)
AS
BEGIN
    SELECT 
        [id], 
        [username], 
        [email], 
        [dateOfBirth], 
        [weight], 
        [goalWeight], 
        [activityLevel], 
        [dateJoined], 
        [lastLogin]
    FROM [dbo].[users]
    WHERE [email] = @Email
END
GO
