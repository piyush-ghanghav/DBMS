
Delimiter $$
CREATE TRIGGER update_availability_status AFTER INSERT ON rentals
FOR EACH ROW
BEGIN
    UPDATE movies
    SET availability = 'Rented'
    WHERE mid = NEW.mid;
END;
$$
Delimiter ;