-- MySQL Script generated by MySQL Workbench
-- Thu Mar 15 16:33:59 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb`;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb`
  DEFAULT CHARACTER SET utf8;
USE `mydb`;

-- -----------------------------------------------------
-- Table `mydb`.`Treningsøkt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Treningsøkt`;

CREATE TABLE IF NOT EXISTS `mydb`.`Treningsøkt` (
  `idTreningsøkt` INT     NOT NULL AUTO_INCREMENT,
  `Dato`          DATE    NOT NULL,

  `Varighet`      INT     NOT NULL,
  `Form`          INT(10) NOT NULL,
  `Innsats`       INT(10) NOT NULL,
  PRIMARY KEY (`idTreningsøkt`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Notat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Notat`;

CREATE TABLE IF NOT EXISTS `mydb`.`Notat` (
  `idNotat`       INT          NOT NULL AUTO_INCREMENT,
  `Tekst`         VARCHAR(450) NOT NULL,
  `idTreningsøkt` INT          NOT NULL,
  PRIMARY KEY (`idNotat`, `idTreningsøkt`),
  INDEX `fk_Notat_Treningsøkt_idx` (`idTreningsøkt` ASC),
  CONSTRAINT `fk_Notat_Treningsøkt`
  FOREIGN KEY (`idTreningsøkt`)
  REFERENCES `mydb`.`Treningsøkt` (`idTreningsøkt`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Øvelsegruppe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Øvelsegruppe`;

CREATE TABLE IF NOT EXISTS `mydb`.`Øvelsegruppe` (
  `idØvelsegruppe` INT         NOT NULL AUTO_INCREMENT,
  `Navn`           VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idØvelsegruppe`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Friøvelse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Friøvelse`;

CREATE TABLE IF NOT EXISTS `mydb`.`Friøvelse` (
  `idFriøvelse` INT          NOT NULL AUTO_INCREMENT,
  `Navn`        VARCHAR(45)  NOT NULL,
  `Beskrivelse` VARCHAR(450) NOT NULL,
  PRIMARY KEY (`idFriøvelse`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Friøvelse_has_Øvelsegruppe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Friøvelse_has_Øvelsegruppe`;

CREATE TABLE IF NOT EXISTS `mydb`.`Friøvelse_has_Øvelsegruppe` (
  `idFriøvelse`    INT NOT NULL,
  `idØvelsegruppe` INT NOT NULL,
  PRIMARY KEY (`idFriøvelse`, `idØvelsegruppe`),
  INDEX `fk_Friøvelse_has_Øvelsegruppe_Øvelsegruppe1_idx` (`idØvelsegruppe` ASC),
  INDEX `fk_Friøvelse_has_Øvelsegruppe_Friøvelse1_idx` (`idFriøvelse` ASC),
  CONSTRAINT `fk_Friøvelse_has_Øvelsegruppe_Friøvelse1`
  FOREIGN KEY (`idFriøvelse`)
  REFERENCES `mydb`.`Friøvelse` (`idFriøvelse`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Friøvelse_has_Øvelsegruppe_Øvelsegruppe1`
  FOREIGN KEY (`idØvelsegruppe`)
  REFERENCES `mydb`.`Øvelsegruppe` (`idØvelsegruppe`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Apparat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Apparat`;

CREATE TABLE IF NOT EXISTS `mydb`.`Apparat` (
  `apparatID`   INT          NOT NULL AUTO_INCREMENT,
  `Navn`        VARCHAR(45)  NOT NULL,
  `Beskrivelse` VARCHAR(450) NOT NULL,
  PRIMARY KEY (`apparatID`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Apparatøvelse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Apparatøvelse`;

CREATE TABLE IF NOT EXISTS `mydb`.`Apparatøvelse` (
  `idApparatØvelse` INT          NOT NULL AUTO_INCREMENT,
  `Navn`            VARCHAR(45)  NOT NULL,
  `apparatID`       INT          NOT NULL,
  `Beskrivelse`     VARCHAR(450) NOT NULL,
  PRIMARY KEY (`idApparatØvelse`),
  INDEX `fk_ApparatØvelse_Apparat1_idx` (`apparatID` ASC),
  CONSTRAINT `fk_ApparatØvelse_Apparat1`
  FOREIGN KEY (`apparatID`)
  REFERENCES `mydb`.`Apparat` (`apparatID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Treningsøkt_has_Friøvelse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Treningsøkt_has_Friøvelse`;

CREATE TABLE IF NOT EXISTS `mydb`.`Treningsøkt_has_Friøvelse` (
  `idTreningsøkt` INT          NOT NULL,
  `idFriøvelse`   INT          NOT NULL,
  `Beskrivelse`   VARCHAR(450) NOT NULL,
  PRIMARY KEY (`idTreningsøkt`, `idFriøvelse`),
  INDEX `fk_Treningsøkt_has_Friøvelse_Friøvelse1_idx` (`idFriøvelse` ASC),
  INDEX `fk_Treningsøkt_has_Friøvelse_Treningsøkt1_idx` (`idTreningsøkt` ASC),
  CONSTRAINT `fk_Treningsøkt_has_Friøvelse_Treningsøkt1`
  FOREIGN KEY (`idTreningsøkt`)
  REFERENCES `mydb`.`Treningsøkt` (`idTreningsøkt`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Treningsøkt_has_Friøvelse_Friøvelse1`
  FOREIGN KEY (`idFriøvelse`)
  REFERENCES `mydb`.`Friøvelse` (`idFriøvelse`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Treningsøkt_has_ApparatØvelse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Treningsøkt_has_ApparatØvelse`;

CREATE TABLE IF NOT EXISTS `mydb`.`Treningsøkt_has_ApparatØvelse` (
  `idTreningsøkt`   INT NOT NULL,
  `idApparatØvelse` INT NOT NULL,
  `Kilo`            INT NOT NULL,
  `Reps`            INT NOT NULL,
  `Set`             INT NOT NULL,
  PRIMARY KEY (`idTreningsøkt`, `idApparatØvelse`),
  INDEX `fk_Treningsøkt_has_ApparatØvelse_ApparatØvelse1_idx` (`idApparatØvelse` ASC),
  INDEX `fk_Treningsøkt_has_ApparatØvelse_Treningsøkt1_idx` (`idTreningsøkt` ASC),
  CONSTRAINT `fk_Treningsøkt_has_ApparatØvelse_Treningsøkt1`
  FOREIGN KEY (`idTreningsøkt`)
  REFERENCES `mydb`.`Treningsøkt` (`idTreningsøkt`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Treningsøkt_has_ApparatØvelse_ApparatØvelse1`
  FOREIGN KEY (`idApparatØvelse`)
  REFERENCES `mydb`.`Apparatøvelse` (`idApparatØvelse`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`ApparatØvelse_has_Øvelsegruppe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ApparatØvelse_has_Øvelsegruppe`;

CREATE TABLE IF NOT EXISTS `mydb`.`ApparatØvelse_has_Øvelsegruppe` (
  `idApparatØvelse` INT NOT NULL,
  `idØvelsegruppe`  INT NOT NULL,
  PRIMARY KEY (`idApparatØvelse`, `idØvelsegruppe`),
  INDEX `fk_ApparatØvelse_has_Øvelsegruppe_Øvelsegruppe1_idx` (`idØvelsegruppe` ASC),
  INDEX `fk_ApparatØvelse_has_Øvelsegruppe_ApparatØvelse1_idx` (`idApparatØvelse` ASC),
  CONSTRAINT `fk_ApparatØvelse_has_Øvelsegruppe_ApparatØvelse1`
  FOREIGN KEY (`idApparatØvelse`)
  REFERENCES `mydb`.`Apparatøvelse` (`idApparatØvelse`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ApparatØvelse_has_Øvelsegruppe_Øvelsegruppe1`
  FOREIGN KEY (`idØvelsegruppe`)
  REFERENCES `mydb`.`Øvelsegruppe` (`idØvelsegruppe`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
