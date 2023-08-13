USE [API]
GO

CREATE PROCEDURE sp_UpdateUserProfile 
    @userId INT,
    @username NVARCHAR(255) = NULL,
    @email NVARCHAR(255) = NULL,
    @hashedPassword NVARCHAR(255) = NULL,
    @dateOfBirth DATE = NULL,
    @weight REAL = NULL,
    @goalWeight REAL = NULL,
    @activityLevel NVARCHAR(255) = NULL
AS
BEGIN
    -- Atualiza o perfil do usuário na tabela users
    UPDATE [users]
    SET 
        [username] = ISNULL(@username, [username]),
        [email] = ISNULL(@email, [email]),
        [hashedPassword] = ISNULL(@hashedPassword, [hashedPassword]),
        [dateOfBirth] = ISNULL(@dateOfBirth, [dateOfBirth]),
        [weight] = ISNULL(@weight, [weight]),
        [goalWeight] = ISNULL(@goalWeight, [goalWeight]),
        [activityLevel] = ISNULL(@activityLevel, [activityLevel])
    WHERE
        [id] = @userId;

    -- Registra a ação de atualização na tabela LOG_users
    INSERT INTO [LOG_users] 
    (
        [id],
        [username],
        [email],
        [hashedPassword],
        [dateOfBirth],
        [weight],
        [goalWeight],
        [activityLevel],
        [userId],
        [operation],
        [actionDate]
    )
    VALUES
    (
        @userId,
        ISNULL(@username, (SELECT [username] FROM [users] WHERE [id] = @userId)),
        ISNULL(@email, (SELECT [email] FROM [users] WHERE [id] = @userId)),
        ISNULL(@hashedPassword, (SELECT [hashedPassword] FROM [users] WHERE [id] = @userId)),
        ISNULL(@dateOfBirth, (SELECT [dateOfBirth] FROM [users] WHERE [id] = @userId)),
        ISNULL(@weight, (SELECT [weight] FROM [users] WHERE [id] = @userId)),
        ISNULL(@goalWeight, (SELECT [goalWeight] FROM [users] WHERE [id] = @userId)),
        ISNULL(@activityLevel, (SELECT [activityLevel] FROM [users] WHERE [id] = @userId)),
        @userId,
        'U', -- Representa a operação de UPDATE
        GETDATE()
    );
    
END
