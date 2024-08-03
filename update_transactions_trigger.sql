Delimiter $$
CREATE TRIGGER update_transactions
AFTER INSERT ON rentals
FOR EACH ROW
BEGIN
  DECLARE next_tid INT;
  SELECT MAX(tid) + 1 INTO next_tid FROM transactions;
  IF next_tid IS NULL THEN
    SET next_tid = 1;
  END IF;
  
  INSERT INTO transactions (tid,cid, t_date, t_amount)
  VALUES (next_tid,NEW.cid, NEW.rent_start_date, NEW.rent_fee);
END;
$$
Delimiter ;
