DELIMITER $$

CREATE TRIGGER UpdateMaintenanceAfterLongTrip
AFTER INSERT ON Trips
FOR EACH ROW
BEGIN
    IF NEW.distance > 30 THEN
        UPDATE Scooters
        SET last_maintenance = NOW()
        WHERE scooter_id = NEW.scooter_id;
    END IF;
END$$

DELIMITER ;
