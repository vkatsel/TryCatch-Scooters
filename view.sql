CREATE VIEW UserTripsSummary AS
SELECT
    u.user_id,
    u.username,
    COUNT(t.trip_id) AS total_trips,
    SUM(t.total_price) AS total_spent
FROM Trips t
JOIN Users u ON t.user_id = u.user_id
GROUP BY u.user_id, u.username;
