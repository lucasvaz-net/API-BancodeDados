CREATE PROCEDURE [dbo].[sp_CancelPremiumSubscription]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Registra o log antes de deletar
    INSERT INTO LOG_premiumSubscription(id, userId, startDate, endDate, paymentDetails, logUserId, operation, actionDate)
    SELECT id, userId, startDate, endDate, paymentDetails, @UserID, 'D', GETDATE()
    FROM premiumSubscription
    WHERE userId = @UserID;

    -- Cancela a assinatura
    DELETE FROM premiumSubscription WHERE userId = @UserID;
END
