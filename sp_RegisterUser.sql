USE [API]
GO

CREATE PROCEDURE sp_RegisterUser 
    @username NVARCHAR(255),
    @email NVARCHAR(255),
    @hashedPassword NVARCHAR(255),
    @dateOfBirth DATE,
    @weight REAL,
    @goalWeight REAL,
    @activityLevel NVARCHAR(255),
    @userIdOut INT OUTPUT
AS
BEGIN
    -- Insere o novo usu�rio na tabela users
    INSERT INTO [users] 
    (
        [username],
        [email],
        [hashedPassword],
        [dateOfBirth],
        [weight],
        [goalWeight],
        [activityLevel],
        [dateJoined]
    )
    VALUES
    (
        @username,
        @email,
        @hashedPassword,
        @dateOfBirth,
        @weight,
        @goalWeight,
        @activityLevel,
        GETDATE() -- DateJoined � preenchido automaticamente com a data atual
    );

    -- Obt�m o ID do usu�rio que acabou de ser inserido
    SET @userIdOut = SCOPE_IDENTITY();

    -- Insere a a��o na tabela LOG_users
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
        [dateJoined],
        [userId],
        [operation],
        [actionDate]
    )
    VALUES
    (
        @userIdOut,
        @username,
        @email,
        @hashedPassword,
        @dateOfBirth,
        @weight,
        @goalWeight,
        @activityLevel,
        GETDATE(),
        @userIdOut,
        'I', -- Representa a opera��o de INSERT
        GETDATE()
    );

END
