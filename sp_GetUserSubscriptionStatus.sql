CREATE PROCEDURE [dbo].[sp_GetUserSubscriptionStatus]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        CASE 
            WHEN endDate >= CAST(GETDATE() AS DATE) THEN 'Active'
            ELSE 'Expired'
        END AS SubscriptionStatus,
        startDate,
        endDate,
        paymentDetails
    FROM premiumSubscription
    WHERE userId = @UserID;
END
