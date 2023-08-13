CREATE PROCEDURE [dbo].[sp_PurchasePremiumSubscription]
    @UserID INT,
    @StartDate DATE,
    @EndDate DATE,
    @PaymentDetails NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- Verifica se o usuário já possui uma assinatura
    IF EXISTS (SELECT 1 FROM premiumSubscription WHERE userId = @UserID)
    BEGIN
        -- Atualiza a assinatura existente
        UPDATE premiumSubscription
        SET startDate = @StartDate, endDate = @EndDate, paymentDetails = @PaymentDetails
        WHERE userId = @UserID;

        -- Log de atualização
        INSERT INTO LOG_premiumSubscription(id, userId, startDate, endDate, paymentDetails, logUserId, operation, actionDate)
        VALUES ((SELECT id FROM premiumSubscription WHERE userId = @UserID), @UserID, @StartDate, @EndDate, @PaymentDetails, @UserID, 'U', GETDATE());
    END
    ELSE
    BEGIN
        -- Insere uma nova assinatura
        INSERT INTO premiumSubscription(userId, startDate, endDate, paymentDetails)
        VALUES (@UserID, @StartDate, @EndDate, @PaymentDetails);

        -- Log de inserção
        INSERT INTO LOG_premiumSubscription(id, userId, startDate, endDate, paymentDetails, logUserId, operation, actionDate)
        VALUES (SCOPE_IDENTITY(), @UserID, @StartDate, @EndDate, @PaymentDetails, @UserID, 'I', GETDATE());
    END
END
