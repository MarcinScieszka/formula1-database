CREATE VIEW 
	drivers_with_num_between_10_and_30
AS
SELECT 
	pd.name, 
	pd.surname,
	d.driver_number
FROM
	driver d
INNER JOIN
	personal_data pd
	ON pd.id_personal_data = d.id_personal_data
WHERE
	d.driver_number BETWEEN 10 AND 30
ORDER BY
	d.driver_number;



CREATE VIEW 
	2021_engine_manufacturers
AS
SELECT DISTINCT
	em.engine_manufacturer_name as "2021 engine manufacturer"
FROM 
	engine_manufacturer em
INNER JOIN
	car c
	ON 
	c.id_engine_manufacturer = em.id_engine_manufacturer
WHERE
	c.id_season = 2021;


CREATE VIEW 
	2021_teams_that_were_qualified
AS
SELECT DISTINCT 
	t.team_name as "2021 team"
FROM
	qualifying_result_team_driver qr
INNER JOIN
	team t
	ON
	qr.id_team = t.id_team
INNER JOIN
	qualifying_result q
	ON q.id_qualifying_result = qr.id_qualifying_result
INNER JOIN
	grand_prix gp
	ON
	gp.id_grand_prix = q.id_grand_prix
WHERE
	gp.id_season = 2021;
	

CREATE VIEW 
	2021_Ferrari_p_sponsors_over_500000
AS
SELECT 
	s.sponsor_name AS "sponsor", 
	sts.sponsorship_amount AS "sponsorsip amount" 
FROM 
	season_team_sponsor sts, 
	sponsor s, 
	team t 
WHERE
	sts.id_team = t.id_team AND 
	s.id_sponsor = sts.id_sponsor AND 
	sts.id_season = 2021 AND
	t.team_name LIKE "Ferrari" AND 
	sts.sponsorship_amount > 500000 AND
  s.sponsor_name LIKE 'p%'
ORDER BY 
	sts.sponsorship_amount DESC;


CREATE VIEW 
	five_oldest_employees
AS
SELECT 
	pd.name,
	pd.surname, 
	t.team_name AS "team",
	pd.date_of_birth,
	TIMESTAMPDIFF(YEAR, pd.date_of_birth, CURDATE()) AS age
FROM 
	team_employee te
INNER JOIN 
	personal_data pd 
	ON te.id_personal_data = pd.id_personal_data
INNER JOIN 
	team t
	ON t.id_team = te.id_team
ORDER BY 
	pd.date_of_birth
LIMIT 5;





CREATE VIEW 
	teams_from_Great_Britan
AS
SELECT 
	t.team_name, c.country_name 
FROM 
	team t, country c 
WHERE 
	c.id_country = t.id_country AND 
	c.country_name LIKE "Great Britan"; 

	
CREATE VIEW 
	90s_drivers_on_podium
AS
SELECT pd.surname "nazwisko", pd.date_of_birth "data narodzin", gp.grand_prix_name as "grand prix", rr.race_result_position AS "pozycja"
FROM 
	driver d
INNER JOIN
	personal_data pd
	ON
	pd.id_personal_data = d.id_personal_data
INNER JOIN
	race_result_team_driver rrtd
	ON
	rrtd.id_driver = d.id_driver
INNER JOIN
	race_result rr
	ON
	rr.id_race_result = rrtd.id_race_result
INNER JOIN
	grand_prix gp
	ON
	gp.id_grand_prix = rr.id_grand_prix
WHERE 
	gp.id_season = 2021 AND
	rr.race_result_position < 4 AND
	pd.date_of_birth BETWEEN '1990-01-01' AND  '1999-12-31'
ORDER BY 
	rr.race_result_position, pd.date_of_birth;


CREATE VIEW 
	tracks_over_4km_starting_starting_with_a
AS
SELECT c.circuit_name , co.country_name, ci.city_name, c.circuit_length
FROM circuit c
INNER JOIN 
	country co
	ON
	co.id_country = c.id_country
INNER JOIN
	city ci
	ON ci.id_city = c.id_city
WHERE 
	c.circuit_name LIKE 'a%'
ORDER by 
	c.circuit_length DESC;


CREATE VIEW 
	nr_of_employees_in_teams
AS
SELECT
	t.team_name, COUNT(*) AS "nr of empoyees"
FROM 
	team_employee te
INNER JOIN
	team t
	ON
	t.id_team= te.id_team
GROUP BY
	te.id_team;


CREATE VIEW 
	2021_top_3_teams_with_most_sponsors
AS
SELECT 
	t.team_name, COUNT(*) AS "nr of sponsors"
FROM
	season_team_sponsor sts 
INNER JOIN
	team t
	ON
	sts.id_team = t.id_team
WHERE
	sts.id_season = 2021
GROUP BY
	sts.id_team
ORDER BY
	COUNT(*) DESC
LIMIT 3;