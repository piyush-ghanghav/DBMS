
Delimiter $$
CREATE TRIGGER update_movie_availability AFTER DELETE ON rentals
FOR EACH ROW
BEGIN
    UPDATE movies
    SET availability = 'Available'
    WHERE mid = OLD.mid;
END;

$$
Delimiter ;