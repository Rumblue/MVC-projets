-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema youssef_mvcprojets
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youssef_mvcprojets
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youssef_mvcprojets` DEFAULT CHARACTER SET utf8 ;
USE `youssef_mvcprojets` ;

-- -----------------------------------------------------
-- Table `youssef_mvcprojets`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youssef_mvcprojets`.`user` ;

CREATE TABLE IF NOT EXISTS `youssef_mvcprojets`.`user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'user => auteur',
  `username` VARCHAR(80) NOT NULL,
  `usermail` VARCHAR(200) NOT NULL,
  `userpwd` VARCHAR(255) NOT NULL,
  `userscreen` VARCHAR(400) NOT NULL,
  `useruniqid` VARCHAR(120) NULL COMMENT 'ident uniq',
  `actif` TINYINT UNSIGNED NULL COMMENT '0 => inactif \n1 => actif \n2 => banni ',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `usermail_UNIQUE` (`usermail` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youssef_mvcprojets`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youssef_mvcprojets`.`post` ;

CREATE TABLE IF NOT EXISTS `youssef_mvcprojets`.`post` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `content` TEXT NOT NULL,
  `datecreate` DATETIME NULL DEFAULT current_timestamp,
  `visible` TINYINT UNSIGNED NULL DEFAULT 0 COMMENT '0 => not visible\n1=> visible',
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) VISIBLE,
  INDEX `fk_article_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_article_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `youssef_mvcprojets`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youssef_mvcprojets`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youssef_mvcprojets`.`category` ;

CREATE TABLE IF NOT EXISTS `youssef_mvcprojets`.`category` (
  `id` INT NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `content` VARCHAR(800) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youssef_mvcprojets`.`post_has_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `youssef_mvcprojets`.`post_has_category` ;

CREATE TABLE IF NOT EXISTS `youssef_mvcprojets`.`post_has_category` (
  `post_id` INT UNSIGNED NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`post_id`, `category_id`),
  INDEX `fk_post_has_category_category1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_post_has_category_post1_idx` (`post_id` ASC) VISIBLE,
  CONSTRAINT `fk_post_has_category_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `youssef_mvcprojets`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_has_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `youssef_mvcprojets`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
