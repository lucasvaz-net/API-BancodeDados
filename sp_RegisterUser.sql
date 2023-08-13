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
    -- Insere o novo usuário na tabela users
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
        GETDATE() -- DateJoined é preenchido automaticamente com a data atual
    );

    -- Obtém o ID do usuário que acabou de ser inserido
    SET @userIdOut = SCOPE_IDENTITY();

    -- Insere a ação na tabela LOG_users
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
        'I', -- Representa a operação de INSERT
        GETDATE()
    );

END
