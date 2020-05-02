CREATE DATABASE `inventory` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;


CREATE TABLE `inventory`.`items` (
  `id` INT NOT NULL,
  `serial` VARCHAR(50) NULL,
  `name` VARCHAR(100) NULL,
  `description` MEDIUMTEXT NULL,
  `quantity` INT NULL,
  `dateadded` DATE NULL,
  `borrowable` TINYINT NULL,
  PRIMARY KEY (`id`));



CREATE TABLE `inventory`.`borrowed` (
  `item_id` INT NOT NULL,
  `control` INT NOT NULL,
  `borrow_date` DATETIME NULL,
  `return_date` DATETIME NULL,
  `borrower_id` INT NULL,
  `employee_sign` VARCHAR(50) NULL);
