
drop trigger if exists tr_car_name_to_upper;
-- podczas dodawania rekordu w encji car, nazwa bolidu będzie przekonwertowana do dużych liter

CREATE TRIGGER tr_car_name_to_upper
BEFORE INSERT 
ON car
FOR EACH ROW
SET NEW.car_chassis_name = UPPER(NEW.car_chassis_name);



drop trigger if exists tr_adult_person;
-- każdy nowa osoba (pracownik/kierowca) musi być pełnoletnia
DELIMITER $$
CREATE TRIGGER tr_adult_person
BEFORE INSERT 
ON personal_data
FOR EACH ROW
IF (TIMESTAMPDIFF(YEAR, NEW.date_of_birth, CURDATE())) < 18 THEN
SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Person must be older than 18';
END IF; $$
DELIMITER ;

-- poniższa komenda rzuca błąd
-- INSERT INTO personal_data VALUE(129, "Phineas ", "Flynn", "2007-08-17", "American", 222);


drop trigger if exists tr_remove_whitespaces;
-- usuń spacje podczas aktualizacji nazwiska i imienia
DELIMITER $$
CREATE TRIGGER tr_remove_whitespaces
BEFORE UPDATE 
ON personal_data
FOR EACH ROW
BEGIN
	SET NEW.name = TRIM(NEW.name);
    SET NEW.surname = TRIM(NEW.surname);
END$$
DELIMITER ;


UPDATE personal_data
SET
	surname = '   Hamilton    '
WHERE
	id_personal_data = 1;

SELECT * FROM personal_data WHERE id_personal_data = 1;
	

