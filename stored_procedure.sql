DELIMITER $$

CREATE PROCEDURE AddTrip (
    IN p_user_id INT,
    IN p_scooter_id INT,
    IN p_pricing_id INT,
    IN p_start_time DATETIME,
    IN p_end_time DATETIME,
    IN p_start_location POINT,
    IN p_end_location POINT,
    IN p_distance DECIMAL(6,2),
    IN p_total_price DECIMAL(6,2)
)
BEGIN
    INSERT INTO Trips (
        user_id, scooter_id, pricing_id,
        start_time, end_time,
        start_location, end_location,
        distance, total_price
    ) VALUES (
        p_user_id, p_scooter_id, p_pricing_id,
        p_start_time, p_end_time,
        p_start_location, p_end_location,
        p_distance, p_total_price
    );
END$$

DELIMITER ;
