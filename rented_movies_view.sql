CREATE VIEW rented_movies_info AS
SELECT c.name, m.title, r.rent_start_date, r.rent_end_date
FROM rentals r
INNER JOIN customers c ON r.cid = c.cid
INNER JOIN movies m ON r.mid = m.mid
WHERE m.availability = 'Rented';