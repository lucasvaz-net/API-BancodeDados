CREATE PROCEDURE [dbo].[sp_CheckUserCredentials]
    @Email NVARCHAR(255),
    @HashedPassword NVARCHAR(255)
AS
BEGIN
    SELECT 
        [id], 
        [username], 
        [email]
    FROM [dbo].[users]
    WHERE [email] = @Email AND [hashedPassword] = @HashedPassword
END
GO