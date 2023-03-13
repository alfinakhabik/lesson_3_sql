-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(60) NOT NULL,
  `us_password` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC) VISIBLE,
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`profile` (
  `id_profile` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NULL,
  `surname` VARCHAR(120) NULL,
  `phone` INT NULL,
  `credit_card` INT NULL,
  `birthday` DATE NULL,
  `user_id_user` INT NOT NULL,
  PRIMARY KEY (`id_profile`, `user_id_user`),
  UNIQUE INDEX `id_profile_UNIQUE` (`id_profile` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  UNIQUE INDEX `credit_card_UNIQUE` (`credit_card` ASC) VISIBLE,
  INDEX `fk_profile_user1_idx` (`user_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_profile_user1`
    FOREIGN KEY (`user_id_user`)
    REFERENCES `mydb`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `id_cat` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NULL,
  PRIMARY KEY (`id_cat`),
  UNIQUE INDEX `id_cat_UNIQUE` (`id_cat` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`position` (
  `id_position` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NULL,
  PRIMARY KEY (`id_position`),
  UNIQUE INDEX `id_position_UNIQUE` (`id_position` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`teachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`teachers` (
  `id_teachers` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NULL,
  `surnme` VARCHAR(120) NULL,
  `birthday` DATE NULL,
  `position_id_position` INT NOT NULL,
  PRIMARY KEY (`id_teachers`, `position_id_position`),
  UNIQUE INDEX `id_teachers_UNIQUE` (`id_teachers` ASC) VISIBLE,
  INDEX `fk_teachers_position1_idx` (`position_id_position` ASC) VISIBLE,
  CONSTRAINT `fk_teachers_position1`
    FOREIGN KEY (`position_id_position`)
    REFERENCES `mydb`.`position` (`id_position`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`media`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`media` (
  `id_media` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NULL,
  `url` TEXT(120) NULL,
  `user_id_user` INT NOT NULL,
  `category_id_cat` INT NOT NULL,
  `teachers_id_teachers` INT NOT NULL,
  PRIMARY KEY (`id_media`, `user_id_user`, `category_id_cat`, `teachers_id_teachers`),
  UNIQUE INDEX `id_teachers_UNIQUE` (`id_media` ASC) VISIBLE,
  INDEX `fk_media_user_idx` (`user_id_user` ASC) VISIBLE,
  INDEX `fk_media_category1_idx` (`category_id_cat` ASC) VISIBLE,
  INDEX `fk_media_teachers1_idx` (`teachers_id_teachers` ASC) VISIBLE,
  CONSTRAINT `fk_media_user`
    FOREIGN KEY (`user_id_user`)
    REFERENCES `mydb`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_media_category1`
    FOREIGN KEY (`category_id_cat`)
    REFERENCES `mydb`.`category` (`id_cat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_media_teachers1`
    FOREIGN KEY (`teachers_id_teachers`)
    REFERENCES `mydb`.`teachers` (`id_teachers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`courses` (
  `id_courses` INT NOT NULL AUTO_INCREMENT,
  `price` FLOAT NULL,
  `name` VARCHAR(60) NULL,
  PRIMARY KEY (`id_courses`),
  UNIQUE INDEX `id_courses_UNIQUE` (`id_courses` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cours_teach`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cours_teach` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `teachers_id_teachers` INT NOT NULL,
  `courses_id_courses` INT NOT NULL,
  PRIMARY KEY (`id`, `teachers_id_teachers`, `courses_id_courses`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_cours_teach_teachers1_idx` (`teachers_id_teachers` ASC) VISIBLE,
  INDEX `fk_cours_teach_courses1_idx` (`courses_id_courses` ASC) VISIBLE,
  CONSTRAINT `fk_cours_teach_teachers1`
    FOREIGN KEY (`teachers_id_teachers`)
    REFERENCES `mydb`.`teachers` (`id_teachers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cours_teach_courses1`
    FOREIGN KEY (`courses_id_courses`)
    REFERENCES `mydb`.`courses` (`id_courses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`directions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`directions` (
  `id_directions` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NULL,
  `price` FLOAT NULL,
  `duration` INT NULL,
  `courses_id_courses` INT NOT NULL,
  PRIMARY KEY (`id_directions`, `courses_id_courses`),
  UNIQUE INDEX `id_directions_UNIQUE` (`id_directions` ASC) VISIBLE,
  INDEX `fk_directions_courses1_idx` (`courses_id_courses` ASC) VISIBLE,
  CONSTRAINT `fk_directions_courses1`
    FOREIGN KEY (`courses_id_courses`)
    REFERENCES `mydb`.`courses` (`id_courses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cours_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cours_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `courses_id_courses` INT NOT NULL,
  `user_id_user` INT NOT NULL,
  PRIMARY KEY (`id`, `courses_id_courses`, `user_id_user`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_cours_user_courses1_idx` (`courses_id_courses` ASC) VISIBLE,
  INDEX `fk_cours_user_user1_idx` (`user_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_cours_user_courses1`
    FOREIGN KEY (`courses_id_courses`)
    REFERENCES `mydb`.`courses` (`id_courses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cours_user_user1`
    FOREIGN KEY (`user_id_user`)
    REFERENCES `mydb`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
