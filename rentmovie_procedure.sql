delimiter $$


CREATE PROCEDURE rent_movie(IN cid INT, IN mid INT)
BEGIN
    UPDATE movies
    SET availability = 'Rented'
    WHERE mid = mid AND availability = 'Available';
    
    INSERT INTO rentals (cid, mid, rent_start_date, rent_end_date, rent_fee)
    VALUES (cid, mid, CURDATE(), NULL, NULL);
END;
$$
delimiter ;