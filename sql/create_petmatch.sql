-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema petmatch_dev
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `petmatch_dev` ;

-- -----------------------------------------------------
-- Schema petmatch_dev
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `petmatch_dev` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish2_ci ;
USE `petmatch_dev` ;

-- -----------------------------------------------------
-- Table `petmatch_dev`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`role` (
  `id_role` INT NOT NULL,
  `role` VARCHAR(800) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `description` VARCHAR(500) NULL,
  PRIMARY KEY (`id_role`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`subscription_configuration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`subscription_configuration` (
  `id_subscription_configuration` INT NOT NULL,
  `discount_percentaje_monthly` DOUBLE NOT NULL DEFAULT 0,
  `description` VARCHAR(45) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  `monthly_susbcription` TINYINT NULL DEFAULT 1,
  `yearly_subscription` TINYINT NULL DEFAULT 1,
  `discount_percentaje_yearly` DOUBLE NULL DEFAULT 0.1,
  PRIMARY KEY (`id_subscription_configuration`),
  UNIQUE INDEX `breed_UNIQUE` (`discount_percentaje_monthly` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`subscription` (
  `id_subscription` INT NOT NULL,
  `subscription` VARCHAR(100) NOT NULL,
  `description` VARCHAR(500) NULL,
  `amount` DOUBLE NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `subscription_configuration_id_subscription_configuration` INT NULL,
  PRIMARY KEY (`id_subscription`),
  UNIQUE INDEX `subscription_UNIQUE` (`subscription` ASC) VISIBLE,
  INDEX `fk_subscription_subscription_configuration1_idx` (`subscription_configuration_id_subscription_configuration` ASC) VISIBLE,
  CONSTRAINT `fk_subscription_subscription_configuration1`
    FOREIGN KEY (`subscription_configuration_id_subscription_configuration`)
    REFERENCES `petmatch_dev`.`subscription_configuration` (`id_subscription_configuration`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`document_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`document_type` (
  `id_document_type` INT NOT NULL,
  `document_type` VARCHAR(100) NOT NULL,
  `description` VARCHAR(45) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  `abbreviate` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_document_type`),
  UNIQUE INDEX `breed_UNIQUE` (`document_type` ASC) VISIBLE,
  UNIQUE INDEX `abbreviate_UNIQUE` (`abbreviate` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`document`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`document` (
  `id_document` INT NOT NULL,
  `document` VARCHAR(100) NOT NULL,
  `description` VARCHAR(45) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  `document_type_document` INT NOT NULL,
  PRIMARY KEY (`id_document`),
  UNIQUE INDEX `breed_UNIQUE` (`document` ASC) VISIBLE,
  INDEX `fk_document_document_type1_idx` (`document_type_document` ASC) VISIBLE,
  CONSTRAINT `fk_document_document_type1`
    FOREIGN KEY (`document_type_document`)
    REFERENCES `petmatch_dev`.`document_type` (`id_document_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `last_name` VARCHAR(200) NULL,
  `phone` VARCHAR(20) NULL,
  `password` VARCHAR(200) NOT NULL,
  `email` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `birthdate` DATE NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `role_user` INT NOT NULL,
  `subscription_user` INT NOT NULL,
  `document_user` INT NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_owner_role1_idx` (`role_user` ASC) VISIBLE,
  INDEX `fk_owner_subscription1_idx` (`subscription_user` ASC) VISIBLE,
  INDEX `fk_user_document1_idx` (`document_user` ASC) VISIBLE,
  CONSTRAINT `fk_owner_role1`
    FOREIGN KEY (`role_user`)
    REFERENCES `petmatch_dev`.`role` (`id_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_owner_subscription1`
    FOREIGN KEY (`subscription_user`)
    REFERENCES `petmatch_dev`.`subscription` (`id_subscription`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_document1`
    FOREIGN KEY (`document_user`)
    REFERENCES `petmatch_dev`.`document` (`id_document`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`pet_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`pet_type` (
  `id_pet_type` INT NOT NULL AUTO_INCREMENT,
  `pet_type` VARCHAR(100) NOT NULL,
  `description` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_pet_type`),
  UNIQUE INDEX `breed_UNIQUE` (`pet_type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`breed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`breed` (
  `id_breed` INT NOT NULL AUTO_INCREMENT,
  `breed` VARCHAR(100) NOT NULL,
  `description` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  `pet_type_breed` INT NOT NULL,
  PRIMARY KEY (`id_breed`),
  UNIQUE INDEX `breed_UNIQUE` (`breed` ASC) VISIBLE,
  INDEX `fk_breed_pet_type1_idx` (`pet_type_breed` ASC) VISIBLE,
  CONSTRAINT `fk_breed_pet_type1`
    FOREIGN KEY (`pet_type_breed`)
    REFERENCES `petmatch_dev`.`pet_type` (`id_pet_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`pet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`pet` (
  `id_pet` INT NOT NULL AUTO_INCREMENT,
  `user_pet` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `gender` VARCHAR(1) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `breed_pet` INT NOT NULL,
  PRIMARY KEY (`id_pet`),
  INDEX `fk_pet_owner_idx` (`user_pet` ASC) VISIBLE,
  INDEX `fk_pet_breed1_idx` (`breed_pet` ASC) VISIBLE,
  CONSTRAINT `fk_pet_owner`
    FOREIGN KEY (`user_pet`)
    REFERENCES `petmatch_dev`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pet_breed1`
    FOREIGN KEY (`breed_pet`)
    REFERENCES `petmatch_dev`.`breed` (`id_breed`)
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
-- Table `petmatch_dev`.`feature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`feature` (
  `id_feature` INT NOT NULL,
  `feature` VARCHAR(100) NOT NULL,
  `description` VARCHAR(45) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_feature`),
  UNIQUE INDEX `breed_UNIQUE` (`feature` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`pet_feature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`pet_feature` (
  `id_pet` INT NOT NULL,
  `id_feature` INT NOT NULL,
  PRIMARY KEY (`id_pet`, `id_feature`),
  INDEX `fk_pet_has_feature_feature1_idx` (`id_feature` ASC) VISIBLE,
  INDEX `fk_pet_has_feature_pet1_idx` (`id_pet` ASC) VISIBLE,
  CONSTRAINT `fk_pet_has_feature_pet1`
    FOREIGN KEY (`id_pet`)
    REFERENCES `petmatch_dev`.`pet` (`id_pet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pet_has_feature_feature1`
    FOREIGN KEY (`id_feature`)
    REFERENCES `petmatch_dev`.`feature` (`id_feature`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`chat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`chat` (
  `id_chat` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_chat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`message` (
  `id_message` INT NOT NULL AUTO_INCREMENT,
  `sender_user` INT NOT NULL,
  `message_chat` INT NOT NULL,
  `message` VARCHAR(800) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  INDEX `fk_owner_has_chat_chat1_idx` (`message_chat` ASC) VISIBLE,
  INDEX `fk_owner_has_chat_owner1_idx` (`sender_user` ASC) VISIBLE,
  PRIMARY KEY (`id_message`),
  CONSTRAINT `fk_user_has_chat_owner1`
    FOREIGN KEY (`sender_user`)
    REFERENCES `petmatch_dev`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_owner_has_chat_chat1`
    FOREIGN KEY (`message_chat`)
    REFERENCES `petmatch_dev`.`chat` (`id_chat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`message` (
  `id_message` INT NOT NULL AUTO_INCREMENT,
  `sender_user` INT NOT NULL,
  `message_chat` INT NOT NULL,
  `message` VARCHAR(800) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  INDEX `fk_owner_has_chat_chat1_idx` (`message_chat` ASC) VISIBLE,
  INDEX `fk_owner_has_chat_owner1_idx` (`sender_user` ASC) VISIBLE,
  PRIMARY KEY (`id_message`),
  CONSTRAINT `fk_user_has_chat_owner1`
    FOREIGN KEY (`sender_user`)
    REFERENCES `petmatch_dev`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_owner_has_chat_chat1`
    FOREIGN KEY (`message_chat`)
    REFERENCES `petmatch_dev`.`chat` (`id_chat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`photo` (
  `id_photo` INT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(800) NOT NULL,
  `user_photo` INT NULL,
  `pet_photo` INT NULL,
  `description` VARCHAR(500) NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_photo`),
  INDEX `fk_photo_owner1_idx` (`user_photo` ASC) VISIBLE,
  INDEX `fk_photo_pet1_idx` (`pet_photo` ASC) VISIBLE,
  CONSTRAINT `fk_photo_owner1`
    FOREIGN KEY (`user_photo`)
    REFERENCES `petmatch_dev`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_photo_pet1`
    FOREIGN KEY (`pet_photo`)
    REFERENCES `petmatch_dev`.`pet` (`id_pet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`auth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`auth` (
  `id_auth` INT NOT NULL AUTO_INCREMENT,
  `token` VARCHAR(800) NOT NULL,
  `token_user` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_auth`),
  INDEX `fk_auth_owner1_idx` (`token_user` ASC) VISIBLE,
  CONSTRAINT `fk_auth_owner1`
    FOREIGN KEY (`token_user`)
    REFERENCES `petmatch_dev`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`dislike`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`dislike` (
  `id_dislike` INT NOT NULL AUTO_INCREMENT,
  `from_pet` INT NOT NULL,
  `to_pet` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  INDEX `fk_pet_has_pet_pet4_idx` (`to_pet` ASC) VISIBLE,
  INDEX `fk_pet_has_pet_pet3_idx` (`from_pet` ASC) VISIBLE,
  PRIMARY KEY (`id_dislike`),
  CONSTRAINT `fk_pet_has_pet_pet30`
    FOREIGN KEY (`from_pet`)
    REFERENCES `petmatch_dev`.`pet` (`id_pet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pet_has_pet_pet40`
    FOREIGN KEY (`to_pet`)
    REFERENCES `petmatch_dev`.`pet` (`id_pet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`country` (
  `id_country` INT NOT NULL AUTO_INCREMENT,
  `iso` VARCHAR(10) NULL,
  `country` VARCHAR(300) NOT NULL,
  `iso3` VARCHAR(4) NULL,
  `description` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `num_code` VARCHAR(10) NULL,
  `phone_code` VARCHAR(10) NULL,
  PRIMARY KEY (`id_country`),
  UNIQUE INDEX `iso3_UNIQUE` (`iso3` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`department` (
  `id_department` INT NOT NULL AUTO_INCREMENT,
  `department` VARCHAR(300) NOT NULL,
  `description` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `country_department` INT NOT NULL,
  PRIMARY KEY (`id_department`, `country_department`),
  INDEX `fk_department_country1_idx` (`country_department` ASC) VISIBLE,
  CONSTRAINT `fk_department_country1`
    FOREIGN KEY (`country_department`)
    REFERENCES `petmatch_dev`.`country` (`id_country`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`city` (
  `id_city` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(300) NOT NULL,
  `description` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `department_city` INT NOT NULL,
  PRIMARY KEY (`id_city`),
  INDEX `fk_city_department1_idx` (`department_city` ASC) VISIBLE,
  CONSTRAINT `fk_city_department1`
    FOREIGN KEY (`department_city`)
    REFERENCES `petmatch_dev`.`department` (`id_department`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`address` (
  `id_address` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(300) NOT NULL,
  `description` VARCHAR(500) NULL,
  `neightborhood` VARCHAR(200) NULL,
  `postal_code` VARCHAR(20) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `user_address` INT NOT NULL,
  `city_address` INT NOT NULL,
  PRIMARY KEY (`id_address`),
  INDEX `fk_address_owner1_idx` (`user_address` ASC) VISIBLE,
  INDEX `fk_address_city1_idx` (`city_address` ASC) VISIBLE,
  CONSTRAINT `fk_address_owner1`
    FOREIGN KEY (`user_address`)
    REFERENCES `petmatch_dev`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_city1`
    FOREIGN KEY (`city_address`)
    REFERENCES `petmatch_dev`.`city` (`id_city`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`device`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`device` (
  `id_device` INT NOT NULL AUTO_INCREMENT,
  `device` VARCHAR(100) NOT NULL,
  `description` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  `uid` VARCHAR(100) NULL,
  PRIMARY KEY (`id_device`),
  UNIQUE INDEX `breed_UNIQUE` (`device` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`session` (
  `id_session` INT NOT NULL AUTO_INCREMENT,
  `latitude` VARCHAR(100) NULL,
  `longitude` VARCHAR(100) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `pet_session` INT NOT NULL,
  `last_connection` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `device_session` INT NOT NULL,
  PRIMARY KEY (`id_session`),
  INDEX `fk_session_pet1_idx` (`pet_session` ASC) VISIBLE,
  INDEX `fk_session_device1_idx` (`device_session` ASC) VISIBLE,
  CONSTRAINT `fk_session_pet1`
    FOREIGN KEY (`pet_session`)
    REFERENCES `petmatch_dev`.`pet` (`id_pet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_session_device1`
    FOREIGN KEY (`device_session`)
    REFERENCES `petmatch_dev`.`device` (`id_device`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`social_account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`social_account` (
  `id_social_account` INT NOT NULL AUTO_INCREMENT,
  `id_user` INT NOT NULL,
  `uid` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_social_account`, `id_user`),
  INDEX `fk_social_account_provider_has_owner_owner1_idx` (`id_user` ASC) VISIBLE,
  INDEX `fk_social_account_provider_has_owner_social_account_provide_idx` (`id_social_account` ASC) VISIBLE,
  CONSTRAINT `fk_social_account_provider_has_owner_social_account_provider1`
    FOREIGN KEY (`id_social_account`)
    REFERENCES `petmatch_dev`.`social_account_provider` (`id_social_account_provider`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_social_account_provider_has_owner_owner1`
    FOREIGN KEY (`id_user`)
    REFERENCES `petmatch_dev`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`social_account_provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`social_account_provider` (
  `id_social_account_provider` INT NOT NULL,
  `social_account_provider` VARCHAR(400) NOT NULL DEFAULT 'GOOGLE',
  `description` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_social_account_provider`),
  UNIQUE INDEX `uid_UNIQUE` (`social_account_provider` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`social_account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`social_account` (
  `id_social_account` INT NOT NULL AUTO_INCREMENT,
  `id_user` INT NOT NULL,
  `uid` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_social_account`, `id_user`),
  INDEX `fk_social_account_provider_has_owner_owner1_idx` (`id_user` ASC) VISIBLE,
  INDEX `fk_social_account_provider_has_owner_social_account_provide_idx` (`id_social_account` ASC) VISIBLE,
  CONSTRAINT `fk_social_account_provider_has_owner_social_account_provider1`
    FOREIGN KEY (`id_social_account`)
    REFERENCES `petmatch_dev`.`social_account_provider` (`id_social_account_provider`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_social_account_provider_has_owner_owner1`
    FOREIGN KEY (`id_user`)
    REFERENCES `petmatch_dev`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`chat_match`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`chat_match` (
  `id_chat` INT NOT NULL,
  `id_match` INT NOT NULL,
  PRIMARY KEY (`id_chat`, `id_match`),
  INDEX `fk_chat_has_match_match1_idx` (`id_match` ASC) VISIBLE,
  INDEX `fk_chat_has_match_chat1_idx` (`id_chat` ASC) VISIBLE,
  CONSTRAINT `fk_chat_has_match_chat1`
    FOREIGN KEY (`id_chat`)
    REFERENCES `petmatch_dev`.`chat` (`id_chat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_chat_has_match_match1`
    FOREIGN KEY (`id_match`)
    REFERENCES `petmatch_dev`.`match` (`id_match`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`device_permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`device_permission` (
  `id_device_permission` INT NOT NULL AUTO_INCREMENT,
  `device_permission` VARCHAR(100) NOT NULL,
  `description` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_device_permission`),
  UNIQUE INDEX `breed_UNIQUE` (`device_permission` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`device_has_device_permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`device_has_device_permission` (
  `device_id_device` INT NOT NULL,
  `device_permission_id_device_permission` INT NOT NULL,
  `conceded` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`device_id_device`, `device_permission_id_device_permission`),
  INDEX `fk_device_has_device_permission_device_permission1_idx` (`device_permission_id_device_permission` ASC) VISIBLE,
  INDEX `fk_device_has_device_permission_device1_idx` (`device_id_device` ASC) VISIBLE,
  CONSTRAINT `fk_device_has_device_permission_device1`
    FOREIGN KEY (`device_id_device`)
    REFERENCES `petmatch_dev`.`device` (`id_device`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_device_has_device_permission_device_permission1`
    FOREIGN KEY (`device_permission_id_device_permission`)
    REFERENCES `petmatch_dev`.`device_permission` (`id_device_permission`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`role` (
  `id_role` INT NOT NULL,
  `role` VARCHAR(800) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `description` VARCHAR(500) NULL,
  PRIMARY KEY (`id_role`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`modulo` (
  `id_modulo` INT NOT NULL,
  `modulo` VARCHAR(100) NOT NULL,
  `description` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_modulo`),
  UNIQUE INDEX `breed_UNIQUE` (`modulo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`permission` (
  `id_permission` INT NOT NULL,
  `permission` VARCHAR(100) NOT NULL,
  `description` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_permission`),
  UNIQUE INDEX `breed_UNIQUE` (`permission` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`operation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`operation` (
  `id_operation` VARCHAR(45) NOT NULL,
  `role_operation` INT NOT NULL,
  `modulo_operation` INT NOT NULL,
  `permission_operation` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` VARCHAR(45) NULL,
  INDEX `fk_role_has_modulo_modulo1_idx` (`modulo_operation` ASC) VISIBLE,
  INDEX `fk_role_has_modulo_role1_idx` (`role_operation` ASC) VISIBLE,
  INDEX `fk_operation_permission1_idx` (`permission_operation` ASC) VISIBLE,
  PRIMARY KEY (`id_operation`),
  CONSTRAINT `fk_role_has_modulo_role1`
    FOREIGN KEY (`role_operation`)
    REFERENCES `petmatch_dev`.`role` (`id_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_has_modulo_modulo1`
    FOREIGN KEY (`modulo_operation`)
    REFERENCES `petmatch_dev`.`modulo` (`id_modulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_operation_permission1`
    FOREIGN KEY (`permission_operation`)
    REFERENCES `petmatch_dev`.`permission` (`id_permission`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`subscription_feature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`subscription_feature` (
  `id_subscription_feature` INT NOT NULL AUTO_INCREMENT,
  `subscription_feature` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NULL,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_subscription_feature`),
  UNIQUE INDEX `feature_UNIQUE` (`subscription_feature` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`config`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`config` (
  `id_config` INT NOT NULL,
  `description` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  `unlimited_likes` TINYINT NULL DEFAULT 0,
  `unlimited_filters` TINYINT NULL DEFAULT 0,
  `unlimited_reach` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id_config`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`subscription_config`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`subscription_config` (
  `id_subscription` INT NOT NULL,
  `id_config` INT NOT NULL,
  PRIMARY KEY (`id_subscription`, `id_config`),
  INDEX `fk_subscription_has_config_config1_idx` (`id_config` ASC) VISIBLE,
  INDEX `fk_subscription_has_config_subscription1_idx` (`id_subscription` ASC) VISIBLE,
  CONSTRAINT `fk_subscription_has_config_subscription1`
    FOREIGN KEY (`id_subscription`)
    REFERENCES `petmatch_dev`.`subscription` (`id_subscription`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscription_has_config_config1`
    FOREIGN KEY (`id_config`)
    REFERENCES `petmatch_dev`.`subscription_feature` (`id_subscription_feature`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`config`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`config` (
  `id_config` INT NOT NULL,
  `description` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  `unlimited_likes` TINYINT NULL DEFAULT 0,
  `unlimited_filters` TINYINT NULL DEFAULT 0,
  `unlimited_reach` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id_config`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`payer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`payer` (
  `id_payer` INT NOT NULL,
  `names` VARCHAR(100) NOT NULL,
  `description` VARCHAR(45) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  `document` VARCHAR(100) NULL,
  `address` VARCHAR(200) NULL,
  PRIMARY KEY (`id_payer`),
  UNIQUE INDEX `breed_UNIQUE` (`names` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`payment_provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`payment_provider` (
  `id_payment_provider` INT NOT NULL,
  `payment_provider` VARCHAR(100) NOT NULL,
  `description` VARCHAR(45) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_payment_provider`),
  UNIQUE INDEX `breed_UNIQUE` (`payment_provider` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`payment` (
  `id_payment` INT NOT NULL AUTO_INCREMENT,
  `token` VARCHAR(100) NOT NULL,
  `description` VARCHAR(45) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  `from_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `to_date` DATETIME NOT NULL,
  `payer_payment` INT NOT NULL,
  `amount` DOUBLE NOT NULL,
  `payment_provider_id_payment_provider` INT NOT NULL,
  PRIMARY KEY (`id_payment`),
  UNIQUE INDEX `breed_UNIQUE` (`token` ASC) VISIBLE,
  INDEX `fk_payment_payer1_idx` (`payer_payment` ASC) VISIBLE,
  INDEX `fk_payment_payment_provider1_idx` (`payment_provider_id_payment_provider` ASC) VISIBLE,
  CONSTRAINT `fk_payment_payer1`
    FOREIGN KEY (`payer_payment`)
    REFERENCES `petmatch_dev`.`payer` (`id_payer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_payment_provider1`
    FOREIGN KEY (`payment_provider_id_payment_provider`)
    REFERENCES `petmatch_dev`.`payment_provider` (`id_payment_provider`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`owner_copy1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`owner_copy1` (
  `id_owner` INT NOT NULL,
  `names` VARCHAR(200) NOT NULL,
  `last_names` VARCHAR(200) NULL,
  `phone` VARCHAR(20) NULL,
  `password` VARCHAR(200) NOT NULL,
  `email` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `birthdate` DATE NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `role_owner` INT NOT NULL,
  `subscription_owner` INT NOT NULL,
  PRIMARY KEY (`id_owner`),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_owner_role1_idx` (`role_owner` ASC) VISIBLE,
  INDEX `fk_owner_subscription1_idx` (`subscription_owner` ASC) VISIBLE,
  CONSTRAINT `fk_owner_role10`
    FOREIGN KEY (`role_owner`)
    REFERENCES `petmatch_dev`.`role` (`id_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_owner_subscription10`
    FOREIGN KEY (`subscription_owner`)
    REFERENCES `petmatch_dev`.`subscription` (`id_subscription`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`configuration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`configuration` (
  `id_configuration` INT NOT NULL AUTO_INCREMENT,
  `currency` VARCHAR(100) NOT NULL,
  `description` VARCHAR(45) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id_configuration`),
  UNIQUE INDEX `breed_UNIQUE` (`currency` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petmatch_dev`.`subscription_configuration_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petmatch_dev`.`subscription_configuration_history` (
  `id_subscription_configuration_history` INT NOT NULL,
  `description` VARCHAR(500) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  `is_active` TINYINT NULL DEFAULT 1,
  `end_at` TIMESTAMP NULL,
  `start_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `subscription_configuration_subscription_configuration_history` INT NOT NULL,
  PRIMARY KEY (`id_subscription_configuration_history`),
  INDEX `fk_subscription_configuration_history_subscription_configur_idx` (`subscription_configuration_subscription_configuration_history` ASC) VISIBLE,
  CONSTRAINT `fk_subscription_configuration_history_subscription_configurat1`
    FOREIGN KEY (`subscription_configuration_subscription_configuration_history`)
    REFERENCES `petmatch_dev`.`subscription_configuration` (`id_subscription_configuration`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
