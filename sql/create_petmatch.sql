-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema petmatch_dev
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema petmatch_dev
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `petmatch_dev` DEFAULT CHARACTER SET utf8 ;
USE `petmatch_dev` ;

-- -----------------------------------------------------
-- Table `petmatch_dev`.`owner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`owner` (
  `id_owner` INT NOT NULL,
  `names` VARCHAR(200) NOT NULL,
  `last_names` VARCHAR(200) NULL,
  `phone` VARCHAR(20) NOT NULL,
  `password` VARCHAR(200) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_owner`),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`pet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`pet` (
  `id_pet` INT NOT NULL,
  `owner_pet` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `gender` VARCHAR(1) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_pet`),
  INDEX `fk_pet_owner_idx` (`owner_pet` ASC) VISIBLE,
  UNIQUE INDEX `created_at_UNIQUE` (`created_at` ASC) VISIBLE,
  UNIQUE INDEX `updated_at_UNIQUE` (`updated_at` ASC) VISIBLE,
  CONSTRAINT `fk_pet_owner`
    FOREIGN KEY (`owner_pet`)
    REFERENCES `petmatch_dev`.`owner` (`id_owner`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`match`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`match` (
  `id_match` INT NOT NULL AUTO_INCREMENT,
  `like_male` INT NOT NULL,
  `like_female` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_match`),
  INDEX `fk_pet_has_pet_pet2_idx` (`like_female` ASC) VISIBLE,
  INDEX `fk_pet_has_pet_pet1_idx` (`like_male` ASC) VISIBLE,
  CONSTRAINT `fk_pet_has_pet_pet1`
    FOREIGN KEY (`like_male`)
    REFERENCES `petmatch_dev`.`pet` (`id_pet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pet_has_pet_pet2`
    FOREIGN KEY (`like_female`)
    REFERENCES `petmatch_dev`.`pet` (`id_pet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`like`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`like` (
  `id_like` INT NOT NULL AUTO_INCREMENT,
  `from_pet` INT NOT NULL,
  `to_pet` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  INDEX `fk_pet_has_pet_pet4_idx` (`to_pet` ASC) VISIBLE,
  INDEX `fk_pet_has_pet_pet3_idx` (`from_pet` ASC) VISIBLE,
  PRIMARY KEY (`id_like`),
  CONSTRAINT `fk_pet_has_pet_pet3`
    FOREIGN KEY (`from_pet`)
    REFERENCES `petmatch_dev`.`pet` (`id_pet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pet_has_pet_pet4`
    FOREIGN KEY (`to_pet`)
    REFERENCES `petmatch_dev`.`pet` (`id_pet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`breed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`breed` (
  `id_breed` INT NOT NULL,
  `breed` VARCHAR(100) NOT NULL,
  `description` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_breed`),
  UNIQUE INDEX `breed_UNIQUE` (`breed` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
