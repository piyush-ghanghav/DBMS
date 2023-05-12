/*
        HMS
        OBJECTIVE:CREATE CURSOR patient_cursor TO BACKUP THE PATIENT TABLE
        NAME:-PIYUSH GHANGHAV
        ROLL NO:-51
        PRN NO:-UCS21M1051
        BATCH:-AS3

*/

DELIMITER $$
CREATE PROCEDURE backup_patient_table()
BEGIN
    DECLARE VFINISHED INT DEFAULT 0;
    DECLARE p_pid INT ;
    DECLARE p_fname VARCHAR(50) ;
    DECLARE p_lname  VARCHAR(50);
    DECLARE p_dob DATE ;
    DECLARE p_gender VARCHAR(10) ;
    DECLARE p_address VARCHAR(100) ;
    DECLARE p_phone VARCHAR(20) ;
    DECLARE p_bg VARCHAR(10) ;
    DECLARE p_medhistory VARCHAR(100) ;
    DECLARE p_tc INT ;
    DECLARE p_height DECIMAL(5,2) ;
    DECLARE p_weight DECIMAL(5,2) ;
    DECLARE p_bmi DECIMAL(5,2) ;

    DECLARE patient_cursor CURSOR FOR 
    SELECT pid, f_name, L_name, dob, gender, address, phone, blood_group, medical_history, test_count, height, weight, bmi
    FROM patient;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET VFINISHED = 1;
  
    OPEN patient_cursor;

    GETDATA : LOOP

        FETCH patient_cursor INTO p_pid, p_fname, p_lname, p_dob, p_gender, p_address, p_phone, p_bg, p_medhistory, p_tc, p_height, p_weight, p_bmi ;
        IF VFINISHED = 1 THEN 
        LEAVE GETDATA;
        END IF;

        INSERT INTO patient_backup(pid, f_name, l_name, dob, gender, address, phone, blood_group, medical_history, test_count, height, weight, bmi)
        VALUES(p_pid, p_fname, p_lname, p_dob, p_gender, p_address, p_phone, p_bg, p_medhistory, p_tc, p_height, p_weight, p_bmi) ;
        END LOOP GETDATA;

    CLOSE patient_cursor;
    END;
    $$

DELIMITER ;



/*
  
OUTPUT:

 MySQL  localhost:33060+ ssl  hms  SQL > DESC PATIENT;
+-----------------+--------------+------+-----+---------+-------+
| Field           | Type         | Null | Key | Default | Extra |
+-----------------+--------------+------+-----+---------+-------+
| pid             | int          | NO   | PRI | NULL    |       |
| f_name          | varchar(30)  | YES  |     | NULL    |       |
| l_name          | varchar(30)  | YES  |     | NULL    |       |
| dob             | date         | YES  |     | NULL    |       |
| gender          | varchar(10)  | YES  |     | NULL    |       |
| address         | varchar(100) | YES  |     | NULL    |       |
| phone           | varchar(20)  | YES  |     | NULL    |       |
| blood_group     | varchar(10)  | YES  |     | NULL    |       |
| medical_history | varchar(100) | YES  |     | NULL    |       |
| test_count      | int          | YES  |     | NULL    |       |
| height          | int          | YES  |     | NULL    |       |
| weight          | int          | YES  |     | NULL    |       |
| bmi             | float(5,2)   | YES  |     | NULL    |       |
+-----------------+--------------+------+-----+---------+-------+
13 rows in set (0.0021 sec)

MySQL  localhost:33060+ ssl  hms  SQL > CREATE TABLE patient_backup(pid int,f_name varchar(30),l_name varchar(30),dob date,gender varchar(10),address varchar(100), phone varchar(20),blood_group varchar(10),medical_history varchar(100),test_count int,height DECIMAL(5,2),weight DECIMAL(5,2),bmi DECIMAL(5,2));
Query OK, 0 rows affected (0.0410 sec)

 MySQL  localhost:33060+ ssl  hms  SQL > DELIMITER $$
 MySQL  localhost:33060+ ssl  hms  SQL > CREATE PROCEDURE backup_patient_table()
                                      -> BEGIN
                                      ->     DECLARE VFINISHED INT DEFAULT 0;
                                      ->     DECLARE p_pid INT ;
                                      ->     DECLARE p_fname VARCHAR(50) ;
                                      ->     DECLARE p_lname  VARCHAR(50);
                                      ->     DECLARE p_dob DATE ;
                                      ->     DECLARE p_gender VARCHAR(10) ;
                                      ->     DECLARE p_address VARCHAR(100) ;
                                      ->     DECLARE p_phone VARCHAR(20) ;
                                      ->     DECLARE p_bg VARCHAR(10) ;
                                      ->     DECLARE p_medhistory VARCHAR(100) ;
                                      ->     DECLARE p_tc INT ;
                                      ->     DECLARE p_height DECIMAL(5,2) ;
                                      ->     DECLARE p_weight DECIMAL(5,2) ;
                                      ->     DECLARE p_bmi DECIMAL(5,2) ;
                                      ->
                                      ->     DECLARE patient_cursor CURSOR FOR
                                      ->     SELECT pid, f_name, L_name, dob, gender, address, phone, blood_group, medical_history, test_count, height, weight, bmi
                                      ->     FROM patient;
                                      ->     DECLARE CONTINUE HANDLER FOR NOT FOUND SET VFINISHED = 1;
                                      ->
                                      ->     OPEN patient_cursor;
                                      ->
                                      ->     GETDATA : LOOP
                                      ->
                                      ->         FETCH patient_cursor INTO p_pid, p_fname, p_lname, p_dob, p_gender, p_address, p_phone, p_bg, p_medhistory, p_tc, p_height, p_weight, p_bmi ;
                                      ->         IF VFINISHED = 1 THEN
                                      ->         LEAVE GETDATA;
                                      ->         END IF;
                                      ->
                                      ->         INSERT INTO patient_backup(pid, f_name, l_name, dob, gender, address, phone, blood_group, medical_history, test_count, height, weight, bmi)
                                      ->         VALUES(p_pid, p_fname, p_lname, p_dob, p_gender, p_address, p_phone, p_bg, p_medhistory, p_tc, p_height, p_weight, p_bmi) ;
                                      ->         END LOOP GETDATA;
                                      ->
                                      ->     CLOSE patient_cursor;
                                      ->     END;
                                      ->     $$
Query OK, 0 rows affected (0.0032 sec)
 MySQL  localhost:33060+ ssl  hms  SQL >
 MySQL  localhost:33060+ ssl  hms  SQL > DELIMITER ;
 MySQL  localhost:33060+ ssl  hms  SQL >
 MySQL  localhost:33060+ ssl  hms  SQL > CALL backup_patient_table();
Query OK, 0 rows affected (0.0130 sec)
 MySQL  localhost:33060+ ssl  hms  SQL > SELECT * FROM patient_backup;
+-----+----------+----------+------------+--------+---------------+------------+-------------+----------------------+------------+--------+--------+-------+
| pid | f_name   | l_name   | dob        | gender | address       | phone      | blood_group | medical_history      | test_count | height | weight | bmi   |
+-----+----------+----------+------------+--------+---------------+------------+-------------+----------------------+------------+--------+--------+-------+
|   1 | Yash     | Jondhale | 2003-02-19 | Male   | Kolpewadi     | 9090905555 | AB+         | High blood pressure  |          3 | 160.00 |  50.00 | 19.53 |
|   2 | Swapnil  | Jadhav   | 2000-04-11 | Male   | SambhajiNagar | 9090905556 | B+          | None                 |          1 | 175.00 |  70.00 | 22.86 |
|   3 | Prashant | Hinge    | 2004-08-18 | Male   | Nashik        | 9090905557 | O+          | Asthma               |          1 | 180.00 |  90.00 | 27.78 |
|   4 | Adesh    | Avhad    | 1993-08-18 | Male   | Yeola         | 9090905501 | O+          | Skin conditions:Acne |          1 | 165.00 | 100.00 | 36.73 |
|   5 | Sonali   | Gore     | 2007-03-29 | Female | Satara        | 9090905553 | A+          | None                 |          1 | 163.00 |  45.00 | 16.94 |
+-----+----------+----------+------------+--------+---------------+------------+-------------+----------------------+------------+--------+--------+-------+
5 rows in set (0.0009 sec)
 MySQL  localhost:33060+ ssl  hms  SQL > SQL MySQL  localhost:33060+ ssl  hms  SQL > DELIMITER $$ MySQL  localhost:33060+ ssl  hms  SQL > DELIMITER $$
*/

