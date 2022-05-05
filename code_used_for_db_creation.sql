-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pbd_formula1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pbd_formula1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pbd_formula1` DEFAULT CHARACTER SET utf8 ;
USE `pbd_formula1` ;

-- -----------------------------------------------------
-- Table `pbd_formula1`.`season`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`season` (
  `id_season` INT NOT NULL,
  PRIMARY KEY (`id_season`),
  UNIQUE INDEX `id_sezon_UNIQUE` (`id_season` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`personal_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`personal_data` (
  `id_personal_data` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  `salary` INT NOT NULL,
  PRIMARY KEY (`id_personal_data`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`driver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`driver` (
  `id_driver` INT NOT NULL AUTO_INCREMENT,
  `id_personal_data` INT NOT NULL,
  `driver_number` INT NOT NULL,
  PRIMARY KEY (`id_driver`),
  INDEX `fk_driver_personal_data1_idx` (`id_personal_data` ASC) VISIBLE,
  UNIQUE INDEX `id_personal_data_UNIQUE` (`id_personal_data` ASC) VISIBLE,
  CONSTRAINT `fk_driver_personal_data1`
    FOREIGN KEY (`id_personal_data`)
    REFERENCES `pbd_formula1`.`personal_data` (`id_personal_data`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`country` (
  `id_country` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_country`),
  UNIQUE INDEX `country_name_UNIQUE` (`country_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`team` (
  `id_team` INT NOT NULL AUTO_INCREMENT,
  `id_country` INT NOT NULL,
  `team_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_team`),
  INDEX `fk_team_country1_idx` (`id_country` ASC) VISIBLE,
  CONSTRAINT `fk_team_country1`
    FOREIGN KEY (`id_country`)
    REFERENCES `pbd_formula1`.`country` (`id_country`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`city` (
  `id_city` INT NOT NULL AUTO_INCREMENT,
  `id_country` INT NOT NULL,
  `city_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_city`),
  INDEX `fk_city_country1_idx` (`id_country` ASC) VISIBLE,
  CONSTRAINT `fk_city_country1`
    FOREIGN KEY (`id_country`)
    REFERENCES `pbd_formula1`.`country` (`id_country`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`circuit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`circuit` (
  `id_circuit` INT NOT NULL AUTO_INCREMENT,
  `id_country` INT NOT NULL,
  `id_city` INT NOT NULL,
  `circuit_name` VARCHAR(45) NOT NULL,
  `circuit_corners_amount` INT NOT NULL,
  `circuit_length` FLOAT NOT NULL,
  PRIMARY KEY (`id_circuit`),
  INDEX `fk_circuit_city1_idx` (`id_city` ASC) VISIBLE,
  INDEX `fk_circuit_country1_idx` (`id_country` ASC) VISIBLE,
  CONSTRAINT `fk_circuit_city1`
    FOREIGN KEY (`id_city`)
    REFERENCES `pbd_formula1`.`city` (`id_city`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_circuit_country1`
    FOREIGN KEY (`id_country`)
    REFERENCES `pbd_formula1`.`country` (`id_country`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`grand_prix`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`grand_prix` (
  `id_grand_prix` INT NOT NULL AUTO_INCREMENT,
  `id_season` INT NOT NULL,
  `id_circuit` INT NOT NULL,
  `grand_prix_name` VARCHAR(45) NOT NULL,
  `grand_prix_round` INT NOT NULL,
  `grand_prix_date` DATE NOT NULL,
  PRIMARY KEY (`id_grand_prix`),
  INDEX `fk_grand_prix_season1_idx` (`id_season` ASC) VISIBLE,
  INDEX `fk_grand_prix_circuit1_idx` (`id_circuit` ASC) VISIBLE,
  CONSTRAINT `fk_grand_prix_season1`
    FOREIGN KEY (`id_season`)
    REFERENCES `pbd_formula1`.`season` (`id_season`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grand_prix_circuit1`
    FOREIGN KEY (`id_circuit`)
    REFERENCES `pbd_formula1`.`circuit` (`id_circuit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`sponsor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`sponsor` (
  `id_sponsor` INT NOT NULL AUTO_INCREMENT,
  `sponsor_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_sponsor`),
  UNIQUE INDEX `id_sponsor_UNIQUE` (`id_sponsor` ASC) VISIBLE,
  UNIQUE INDEX `sponsor_name_UNIQUE` (`sponsor_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`engine_manufacturer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`engine_manufacturer` (
  `id_engine_manufacturer` INT NOT NULL AUTO_INCREMENT,
  `id_country` INT NOT NULL,
  `engine_manufacturer_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_engine_manufacturer`),
  INDEX `fk_engine_manufacturer_country1_idx` (`id_country` ASC) VISIBLE,
  UNIQUE INDEX `engine_manufacturer_name_UNIQUE` (`engine_manufacturer_name` ASC) VISIBLE,
  CONSTRAINT `fk_engine_manufacturer_country1`
    FOREIGN KEY (`id_country`)
    REFERENCES `pbd_formula1`.`country` (`id_country`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`team_employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`team_employee` (
  `id_team_employee` INT NOT NULL AUTO_INCREMENT,
  `id_personal_data` INT NOT NULL,
  `id_team` INT NOT NULL,
  `job_title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_team_employee`),
  INDEX `fk_team_employee_team1_idx` (`id_team` ASC) VISIBLE,
  INDEX `fk_team_employee_personal_data1_idx` (`id_personal_data` ASC) VISIBLE,
  UNIQUE INDEX `id_personal_data_UNIQUE` (`id_personal_data` ASC) VISIBLE,
  UNIQUE INDEX `id_team_employee_UNIQUE` (`id_team_employee` ASC) VISIBLE,
  CONSTRAINT `fk_team_employee_team1`
    FOREIGN KEY (`id_team`)
    REFERENCES `pbd_formula1`.`team` (`id_team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_team_employee_personal_data1`
    FOREIGN KEY (`id_personal_data`)
    REFERENCES `pbd_formula1`.`personal_data` (`id_personal_data`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`car`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`car` (
  `id_car` INT NOT NULL AUTO_INCREMENT,
  `id_season` INT NOT NULL,
  `id_team` INT NOT NULL,
  `id_engine_manufacturer` INT NOT NULL,
  `car_chassis_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id_car`),
  INDEX `fk_car_team1_idx` (`id_team` ASC) VISIBLE,
  INDEX `fk_car_engine_manufacturer1_idx` (`id_engine_manufacturer` ASC) VISIBLE,
  INDEX `fk_car_season1_idx` (`id_season` ASC) VISIBLE,
  CONSTRAINT `fk_car_team1`
    FOREIGN KEY (`id_team`)
    REFERENCES `pbd_formula1`.`team` (`id_team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_car_engine_manufacturer1`
    FOREIGN KEY (`id_engine_manufacturer`)
    REFERENCES `pbd_formula1`.`engine_manufacturer` (`id_engine_manufacturer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_car_season1`
    FOREIGN KEY (`id_season`)
    REFERENCES `pbd_formula1`.`season` (`id_season`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`race_result`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`race_result` (
  `id_race_result` INT NOT NULL AUTO_INCREMENT,
  `id_grand_prix` INT NOT NULL,
  `race_result_position` INT NOT NULL,
  PRIMARY KEY (`id_race_result`),
  INDEX `fk_race_grand_prix1_idx` (`id_grand_prix` ASC) VISIBLE,
  CONSTRAINT `fk_race_grand_prix1`
    FOREIGN KEY (`id_grand_prix`)
    REFERENCES `pbd_formula1`.`grand_prix` (`id_grand_prix`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`qualifying_result`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`qualifying_result` (
  `id_qualifying_result` INT NOT NULL AUTO_INCREMENT,
  `id_grand_prix` INT NOT NULL,
  `qualifying_position` INT NOT NULL,
  `qualifying_q1_time` TIME NULL,
  `qualifying_q2_time` TIME NULL,
  `qualifying_q3_time` TIME NULL,
  PRIMARY KEY (`id_qualifying_result`),
  INDEX `fk_qualifying_grand_prix1_idx` (`id_grand_prix` ASC) VISIBLE,
  CONSTRAINT `fk_qualifying_grand_prix1`
    FOREIGN KEY (`id_grand_prix`)
    REFERENCES `pbd_formula1`.`grand_prix` (`id_grand_prix`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`team_driver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`team_driver` (
  `id_team` INT NOT NULL,
  `id_driver` INT NOT NULL,
  PRIMARY KEY (`id_team`, `id_driver`),
  INDEX `fk_team_has_driver_driver1_idx` (`id_driver` ASC) VISIBLE,
  INDEX `fk_team_has_driver_team1_idx` (`id_team` ASC) VISIBLE,
  CONSTRAINT `fk_team_has_driver_team1`
    FOREIGN KEY (`id_team`)
    REFERENCES `pbd_formula1`.`team` (`id_team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_team_has_driver_driver1`
    FOREIGN KEY (`id_driver`)
    REFERENCES `pbd_formula1`.`driver` (`id_driver`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`driver_car`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`driver_car` (
  `id_driver` INT NOT NULL,
  `id_car` INT NOT NULL,
  PRIMARY KEY (`id_driver`, `id_car`),
  INDEX `fk_driver_has_car_car1_idx` (`id_car` ASC) VISIBLE,
  INDEX `fk_driver_has_car_driver1_idx` (`id_driver` ASC) VISIBLE,
  CONSTRAINT `fk_driver_has_car_driver1`
    FOREIGN KEY (`id_driver`)
    REFERENCES `pbd_formula1`.`driver` (`id_driver`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_driver_has_car_car1`
    FOREIGN KEY (`id_car`)
    REFERENCES `pbd_formula1`.`car` (`id_car`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`race_result_team_driver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`race_result_team_driver` (
  `id_race_result` INT NOT NULL,
  `id_team` INT NOT NULL,
  `id_driver` INT NOT NULL,
  INDEX `fk_race_result_has_team_driver_team_driver1_idx` (`id_team` ASC, `id_driver` ASC) VISIBLE,
  INDEX `fk_race_result_has_team_driver_race_result1_idx` (`id_race_result` ASC) VISIBLE,
  PRIMARY KEY (`id_team`, `id_driver`, `id_race_result`),
  CONSTRAINT `fk_race_result_has_team_driver_race_result1`
    FOREIGN KEY (`id_race_result`)
    REFERENCES `pbd_formula1`.`race_result` (`id_race_result`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_race_result_has_team_driver_team_driver1`
    FOREIGN KEY (`id_team` , `id_driver`)
    REFERENCES `pbd_formula1`.`team_driver` (`id_team` , `id_driver`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`qualifying_result_team_driver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`qualifying_result_team_driver` (
  `id_qualifying_result` INT NOT NULL,
  `id_team` INT NOT NULL,
  `id_driver` INT NOT NULL,
  PRIMARY KEY (`id_qualifying_result`, `id_team`, `id_driver`),
  INDEX `fk_qualifying_result_has_team_driver_team_driver1_idx` (`id_team` ASC, `id_driver` ASC) VISIBLE,
  INDEX `fk_qualifying_result_has_team_driver_qualifying_result1_idx` (`id_qualifying_result` ASC) VISIBLE,
  CONSTRAINT `fk_qualifying_result_has_team_driver_qualifying_result1`
    FOREIGN KEY (`id_qualifying_result`)
    REFERENCES `pbd_formula1`.`qualifying_result` (`id_qualifying_result`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_qualifying_result_has_team_driver_team_driver1`
    FOREIGN KEY (`id_team` , `id_driver`)
    REFERENCES `pbd_formula1`.`team_driver` (`id_team` , `id_driver`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pbd_formula1`.`season_team_sponsor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pbd_formula1`.`season_team_sponsor` (
  `id_season` INT NOT NULL,
  `id_team` INT NOT NULL,
  `id_sponsor` INT NOT NULL,
  `sponsorship_amount` INT NOT NULL,
  PRIMARY KEY (`id_season`, `id_team`, `id_sponsor`),
  INDEX `fk_season_has_team_sponsor_season1_idx` (`id_season` ASC) VISIBLE,
  INDEX `fk_season_has_team_sponsor_sponsor1_idx` (`id_sponsor` ASC) VISIBLE,
  INDEX `fk_season_has_team_sponsor_team1_idx` (`id_team` ASC) VISIBLE,
  CONSTRAINT `fk_season_has_team_sponsor_season1`
    FOREIGN KEY (`id_season`)
    REFERENCES `pbd_formula1`.`season` (`id_season`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_season_has_team_sponsor_sponsor1`
    FOREIGN KEY (`id_sponsor`)
    REFERENCES `pbd_formula1`.`sponsor` (`id_sponsor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_season_has_team_sponsor_team1`
    FOREIGN KEY (`id_team`)
    REFERENCES `pbd_formula1`.`team` (`id_team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
