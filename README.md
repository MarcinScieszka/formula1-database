
## Formula 1 database

This Formula 1 database project is related to the topic of formula 1.

Project consists of sample data, queries, triggers, views and an ER diagram.

### Description

ER diagram shows relations which can occur between the various entities that make up a Formula 1 world championship.

The design of the database takes into account the division of the championship into seasons.

A given season involves:
- teams
- drivers 
- engine manufacturers
- sponsors

The modeling process took into account aspects that can be described using sponsorship as an example:
- a given sponsor can sponsor one team, but in different seasons the sponsorship amount may vary
- a sponsor may have breaks in sponsorship of the same team
- the sponsor can also sponsor various teams - in each case with a different amount of money

During the season there are competitions (Grand Prix) where drivers take part in the qualifying and the race itself.

A Grand Prix takes place on a specific track, which has features such as the length and number of turns, and is located in a specific city.

A distinction is made between the country
- where the team and engine manufacturer come from,
- where the city is located,
- where the competition takes place

The team consists of staff members and drivers.

Qualifications is modeled based on current rules:
- If a driver does not participate in any qualifying round, he can still start the race at the end of the grid (The 107% rule includes the times set during the training sessions).
- Drivers can participate in three rounds: Q1, Q2, Q3 in which times are reported to the nearest thousandth of a second.


### Detailed relations are shown in erd diagram:
[ERD diagram](https://github.com/MarcinScieszka/formula1-database/blob/047cc451bf0e42972ff3a669679bac15280e9cc8/ERD_diagram.png)
