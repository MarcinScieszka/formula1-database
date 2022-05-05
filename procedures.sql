DELIMITER $$
CREATE PROCEDURE `get_city_names` ()
BEGIN
	SELECT 
        c.city_name 
    FROM 
        city c;
END$$

DELIMITER ;


CALL get_city_names();


DELIMITER $$
CREATE PROCEDURE `get_county_names`()
BEGIN
	SELECT
		c.country_name
	FROM
		country c;
END$$
DELIMITER ;

CALL get_county_names();


DELIMITER $$
CREATE PROCEDURE `employees_with_salary_above`(IN salary INT)
BEGIN
    SELECT 
		pd.name,
        pd.surname,
        pd.salary
    FROM 
		personal_data pd
	INNER JOIN
		team_employee te
        ON
        te.id_personal_data = pd.id_personal_data
	WHERE
		pd.salary > salary;
END$$

DELIMITER ;

CALL `employees_with_salary_above`(85000); 


DELIMITER $$
CREATE PROCEDURE `get_chassis_names_from_season` (IN season INT)
BEGIN
	SELECT
		c.car_chassis_name
    FROM
		car c
	WHERE
		c.id_season = season;
END$$

DELIMITER ;

CALL `get_chassis_names_from_season`(2021); 
