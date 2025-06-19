INSERT INTO TechnicalCharacteristics (model_id, model_name, max_speed, battery_capacity, weight, release_year)
VALUES
(1, 'Model A', 25, 5000, 12.5, 2023),
(2, 'Model B', 30, 6000, 13.0, 2024),
(3, 'Model C', 35, 5500, 11.0, 2022);

DELIMITER $$

DROP PROCEDURE IF EXISTS GenerateScooters$$
CREATE PROCEDURE GenerateScooters()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE rand_model INT;

    WHILE i < 1000 DO
        SET rand_model = FLOOR(1 + (RAND() * 3));
        INSERT INTO Scooters (model_id, scooter_geolocation, charge_status, kilometers_left, is_active, last_maintenance)
        VALUES (
            rand_model,
            ST_GeomFromText(CONCAT('POINT(', -122.4 + (RAND()/10), ' ', 37.7 + (RAND()/10), ')')),
            FLOOR(RAND() * 101),
            ROUND(1 + (RAND() * 40), 2),
            TRUE,
            NOW() - INTERVAL FLOOR(RAND()*100) DAY
        );
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL GenerateScooters();

DELIMITER $$

DROP PROCEDURE IF EXISTS GenerateUsers$$
CREATE PROCEDURE GenerateUsers()
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < 1000 DO
        INSERT INTO Users (username, email, phone_number)
        VALUES (
            CONCAT('user', i),
            CONCAT('user', i, '@example.com'),
            CONCAT('+380', LPAD(FLOOR(RAND() * 1000000000), 9, '0'))
        );
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL GenerateUsers();

INSERT INTO Pricing (price_per_minute, unlock_fee, is_active)
VALUES
(0.20, 1.00, TRUE),
(0.25, 0.80, TRUE),
(0.30, 1.20, FALSE),
(0.15, 1.00, TRUE),
(0.22, 0.90, TRUE);


DELIMITER $$

DROP PROCEDURE IF EXISTS GenerateTrips$$
CREATE PROCEDURE GenerateTrips()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE rand_user INT;
    DECLARE rand_scooter INT;
    DECLARE rand_pricing INT;
    DECLARE start_t DATETIME;
    DECLARE end_t DATETIME;
    DECLARE dist DECIMAL(6,2);
    DECLARE total DECIMAL(6,2);

    WHILE i < 500000 DO
        SELECT user_id INTO rand_user
        FROM Users
        ORDER BY RAND()
        LIMIT 1;

        SELECT scooter_id INTO rand_scooter
        FROM Scooters
        ORDER BY RAND()
        LIMIT 1;

        SELECT pricing_id INTO rand_pricing
        FROM Pricing
        WHERE is_active = TRUE
        ORDER BY RAND()
        LIMIT 1;

        SET start_t = TIMESTAMP(DATE_SUB(NOW(), INTERVAL FLOOR(RAND()*365) DAY), SEC_TO_TIME(FLOOR(RAND()*86400)));
        SET end_t = DATE_ADD(start_t, INTERVAL FLOOR(5 + (RAND() * 30)) MINUTE);
        SET dist = ROUND(1 + (RAND() * 9), 2);
        SET total = ROUND(dist * (3 + RAND()), 2);

        INSERT INTO Trips (
            user_id,
            scooter_id,
            pricing_id,
            start_time,
            end_time,
            start_location,
            end_location,
            distance,
            total_price
        )
        VALUES (
            rand_user,
            rand_scooter,
            rand_pricing,
            start_t,
            end_t,
            ST_GeomFromText(CONCAT('POINT(', -122.4 + (RAND()/10), ' ', 37.7 + (RAND()/10), ')')),
            ST_GeomFromText(CONCAT('POINT(', -122.4 + (RAND()/10), ' ', 37.7 + (RAND()/10), ')')),
            dist,
            total
        );

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL GenerateTrips();
