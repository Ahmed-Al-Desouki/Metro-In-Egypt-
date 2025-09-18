-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Metro
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Metro` ;

-- -----------------------------------------------------
-- Schema Metro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Metro` DEFAULT CHARACTER SET utf8 ;
USE `Metro` ;

-- -----------------------------------------------------
-- Table `Metro`.`Person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Person` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Person` (
  `ssn` VARCHAR(50) NOT NULL,
  `Fname` VARCHAR(20) NULL,
  `Lname` VARCHAR(20) NULL,
  `Address` VARCHAR(40) NULL,
  `Sex` ENUM('M', 'F') NULL,
  `Bdate` DATE NULL,
  `phone` VARCHAR(45) NULL,
  PRIMARY KEY (`ssn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Manger`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Manger` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Manger` (
  `Pssn` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Pssn`),
  CONSTRAINT `fk_Manger_Person1`
    FOREIGN KEY (`Pssn`)
    REFERENCES `Metro`.`Person` (`ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Station`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Station` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Station` (
  `Name` VARCHAR(30) NOT NULL,
  `Location` VARCHAR(40) NOT NULL,
  `Mpssn` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Name`),
  INDEX `fk_Station_Manger1_idx` (`Mpssn` ASC),
  CONSTRAINT `fk_Station_Manger1`
    FOREIGN KEY (`Mpssn`)
    REFERENCES `Metro`.`Manger` (`Pssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Employee` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Employee` (
  `Pssn` VARCHAR(50) NOT NULL,
  `Sname` VARCHAR(30) NOT NULL,
  `salary` DOUBLE NOT NULL,
  `hours` DOUBLE NOT NULL,
  PRIMARY KEY (`Pssn`),
  INDEX `fk_Employee_Station1_idx` (`Sname` ASC),
  CONSTRAINT `fk_Employee_Person1`
    FOREIGN KEY (`Pssn`)
    REFERENCES `Metro`.`Person` (`ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Employee_Station1`
    FOREIGN KEY (`Sname`)
    REFERENCES `Metro`.`Station` (`Name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Access_Method`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Access_Method` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Access_Method` (
  `Code` VARCHAR(20) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `Price` INT NOT NULL,
  `Tflag` VARCHAR(10) NOT NULL,
  `Date` DATE NULL,
  `Cflag` VARCHAR(10) NOT NULL,
  `Type` VARCHAR(40) NULL,
  PRIMARY KEY (`Code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Passenger`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Passenger` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Passenger` (
  `Pssn` VARCHAR(50) NOT NULL,
  `code` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Pssn`),
  INDEX `fk_Passenger_Access-Method1_idx` (`code` ASC),
  CONSTRAINT `fk_Passenger_Person1`
    FOREIGN KEY (`Pssn`)
    REFERENCES `Metro`.`Person` (`ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Passenger_Access-Method1`
    FOREIGN KEY (`code`)
    REFERENCES `Metro`.`Access_Method` (`Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Dependent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Dependent` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Dependent` (
  `name` VARCHAR(20) NOT NULL,
  `Sex` ENUM('M', 'F') NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Bdate` DATE NOT NULL,
  `Pssn` VARCHAR(50) NULL,
  PRIMARY KEY (`name`, `Pssn`),
  INDEX `fk_Dependent_Employee1_idx` (`Pssn` ASC),
  CONSTRAINT `fk_Dependent_Employee1`
    FOREIGN KEY (`Pssn`)
    REFERENCES `Metro`.`Employee` (`Pssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Ticket_worker`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Ticket_worker` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Ticket_worker` (
  `Pssn` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Pssn`),
  CONSTRAINT `fk_Ticket-worker_Person`
    FOREIGN KEY (`Pssn`)
    REFERENCES `Metro`.`Person` (`ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Subscription_worker`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Subscription_worker` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Subscription_worker` (
  `Pssn` VARCHAR(50) NOT NULL,
  `SName` VARCHAR(30) NULL,
  PRIMARY KEY (`Pssn`),
  INDEX `fk_Subscription-worker_Station1_idx` (`SName` ASC),
  CONSTRAINT `fk_Subscription-worker_Person1`
    FOREIGN KEY (`Pssn`)
    REFERENCES `Metro`.`Person` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Subscription-worker_Station1`
    FOREIGN KEY (`SName`)
    REFERENCES `Metro`.`Station` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Line`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Line` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Line` (
  `Number` INT NOT NULL,
  `Color` VARCHAR(10) NOT NULL,
  `Responsible-company` VARCHAR(40) NOT NULL,
  `Num-of-Station` INT NOT NULL,
  PRIMARY KEY (`Number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Train`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Train` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Train` (
  `Code` VARCHAR(20) NOT NULL,
  `Energy` ENUM('FULL', 'MEDIUM', 'LOW') NOT NULL,
  `Start-time` TIME NOT NULL,
  `End-time` TIME NOT NULL,
  `LNumber` INT NULL,
  PRIMARY KEY (`Code`),
  INDEX `fk_Train_Line1_idx` (`LNumber` ASC),
  CONSTRAINT `fk_Train_Line1`
    FOREIGN KEY (`LNumber`)
    REFERENCES `Metro`.`Line` (`Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Safety_services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Safety_services` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Safety_services` (
  `SsNumber` INT NOT NULL,
  `Name` VARCHAR(20) NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SsNumber`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Accident`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Accident` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Accident` (
  `Num` INT NOT NULL,
  `Type` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`Num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`T_has`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`T_has` ;

CREATE TABLE IF NOT EXISTS `Metro`.`T_has` (
  `TCode` VARCHAR(20) NOT NULL,
  `Pssn` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`TCode`, `Pssn`),
  INDEX `fk_Access-Method_has_Ticket-worker_Ticket-worker1_idx` (`Pssn` ASC),
  INDEX `fk_Access-Method_has_Ticket-worker_Access-Method1_idx` (`TCode` ASC),
  CONSTRAINT `fk_Access-Method_has_Ticket-worker_Access-Method1`
    FOREIGN KEY (`TCode`)
    REFERENCES `Metro`.`Access_Method` (`Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Access-Method_has_Ticket-worker_Ticket-worker1`
    FOREIGN KEY (`Pssn`)
    REFERENCES `Metro`.`Ticket_worker` (`Pssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`C_has`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`C_has` ;

CREATE TABLE IF NOT EXISTS `Metro`.`C_has` (
  `Ccode` VARCHAR(20) NOT NULL,
  `pssn` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Ccode`, `pssn`),
  INDEX `fk_Access-Method_has_Subscription-worker_Subscription-worke_idx` (`pssn` ASC),
  INDEX `fk_Access-Method_has_Subscription-worker_Access-Method1_idx` (`Ccode` ASC),
  CONSTRAINT `fk_Access-Method_has_Subscription-worker_Access-Method1`
    FOREIGN KEY (`Ccode`)
    REFERENCES `Metro`.`Access_Method` (`Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Access-Method_has_Subscription-worker_Subscription-worker1`
    FOREIGN KEY (`pssn`)
    REFERENCES `Metro`.`Subscription_worker` (`Pssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Buy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Buy` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Buy` (
  `Tcode` VARCHAR(20) NULL,
  `Pssn` VARCHAR(50) NULL,
  `Type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Tcode`, `Pssn`),
  INDEX `fk_Passenger_has_Access-Method_Access-Method1_idx` (`Tcode` ASC),
  INDEX `fk_Passenger_has_Access-Method_Passenger1_idx` (`Pssn` ASC),
  CONSTRAINT `fk_Passenger_has_Access-Method_Passenger1`
    FOREIGN KEY (`Pssn`)
    REFERENCES `Metro`.`Passenger` (`Pssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Passenger_has_Access-Method_Access-Method1`
    FOREIGN KEY (`Tcode`)
    REFERENCES `Metro`.`Access_Method` (`Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Crosss`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Crosss` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Crosss` (
  `ACode` VARCHAR(20) NOT NULL,
  `SName` VARCHAR(30) NOT NULL,
  `End_station` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ACode`, `SName`),
  INDEX `fk_Access-Method_has_Station_Station1_idx` (`SName` ASC),
  INDEX `fk_Access-Method_has_Station_Access-Method1_idx` (`ACode` ASC),
  CONSTRAINT `fk_Access-Method_has_Station_Access-Method1`
    FOREIGN KEY (`ACode`)
    REFERENCES `Metro`.`Access_Method` (`Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Access-Method_has_Station_Station1`
    FOREIGN KEY (`SName`)
    REFERENCES `Metro`.`Station` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`L_has`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`L_has` ;

CREATE TABLE IF NOT EXISTS `Metro`.`L_has` (
  `SName` VARCHAR(30) NOT NULL,
  `LNumber` INT NOT NULL,
  PRIMARY KEY (`SName`, `LNumber`),
  INDEX `fk_Station_has_Line_Line1_idx` (`LNumber` ASC),
  INDEX `fk_Station_has_Line_Station1_idx` (`SName` ASC),
  CONSTRAINT `fk_Station_has_Line_Station1`
    FOREIGN KEY (`SName`)
    REFERENCES `Metro`.`Station` (`Name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Station_has_Line_Line1`
    FOREIGN KEY (`LNumber`)
    REFERENCES `Metro`.`Line` (`Number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`transform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`transform` ;

CREATE TABLE IF NOT EXISTS `Metro`.`transform` (
  `in_LNumber` INT NOT NULL,
  `out_LNumber` INT NOT NULL,
  `SName` VARCHAR(30) NULL,
  PRIMARY KEY (`in_LNumber`, `out_LNumber`, `SName`),
  INDEX `fk_Line_has_Line_Line2_idx` (`in_LNumber` ASC),
  INDEX `fk_Line_has_Line_Line1_idx` (`out_LNumber` ASC),
  INDEX `fk_Line_has_Line_Station1_idx` (`SName` ASC),
  CONSTRAINT `fk_Line_has_Line_Line1`
    FOREIGN KEY (`out_LNumber`)
    REFERENCES `Metro`.`Line` (`Number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Line_has_Line_Line2`
    FOREIGN KEY (`in_LNumber`)
    REFERENCES `Metro`.`Line` (`Number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Line_has_Line_Station1`
    FOREIGN KEY (`SName`)
    REFERENCES `Metro`.`Station` (`Name`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Tr_pass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Tr_pass` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Tr_pass` (
  `TrCode` VARCHAR(20) NOT NULL,
  `SName` VARCHAR(30) NULL,
  `time` TIME NOT NULL,
  PRIMARY KEY (`TrCode`, `SName`),
  INDEX `fk_Train_has_Station_Station1_idx` (`SName` ASC),
  INDEX `fk_Train_has_Station_Train1_idx` (`TrCode` ASC),
  CONSTRAINT `fk_Train_has_Station_Train1`
    FOREIGN KEY (`TrCode`)
    REFERENCES `Metro`.`Train` (`Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Train_has_Station_Station1`
    FOREIGN KEY (`SName`)
    REFERENCES `Metro`.`Station` (`Name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`supply`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`supply` ;

CREATE TABLE IF NOT EXISTS `Metro`.`supply` (
  `Safety_Number` INT NOT NULL,
  `TrCode` VARCHAR(20) NOT NULL,
  `Pssn` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Safety_Number`, `TrCode`, `Pssn`),
  INDEX `fk_Train_has_Safety-services_Safety-services1_idx` (`Safety_Number` ASC),
  INDEX `fk_Train_has_Safety-services_Train1_idx` (`TrCode` ASC),
  INDEX `fk_Train_has_Safety-services_Employee1_idx` (`Pssn` ASC),
  CONSTRAINT `fk_Train_has_Safety-services_Train1`
    FOREIGN KEY (`TrCode`)
    REFERENCES `Metro`.`Train` (`Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Train_has_Safety-services_Safety-services1`
    FOREIGN KEY (`Safety_Number`)
    REFERENCES `Metro`.`Safety_services` (`SsNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Train_has_Safety-services_Employee1`
    FOREIGN KEY (`Pssn`)
    REFERENCES `Metro`.`Employee` (`Pssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`occurs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`occurs` ;

CREATE TABLE IF NOT EXISTS `Metro`.`occurs` (
  `ANum` INT NULL,
  `TrCode` VARCHAR(20) NULL,
  `LNumber` INT NULL,
  `time` TIME NOT NULL,
  `location` VARCHAR(44) NOT NULL,
  PRIMARY KEY (`ANum`, `TrCode`, `LNumber`),
  INDEX `fk_Accident_has_Train_Train1_idx` (`TrCode` ASC),
  INDEX `fk_Accident_has_Train_Accident1_idx` (`ANum` ASC),
  INDEX `fk_Accident_has_Train_Line1_idx` (`LNumber` ASC),
  CONSTRAINT `fk_Accident_has_Train_Accident1`
    FOREIGN KEY (`ANum`)
    REFERENCES `Metro`.`Accident` (`Num`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Accident_has_Train_Train1`
    FOREIGN KEY (`TrCode`)
    REFERENCES `Metro`.`Train` (`Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Accident_has_Train_Line1`
    FOREIGN KEY (`LNumber`)
    REFERENCES `Metro`.`Line` (`Number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- ------------  -------------- ------------- 
INSERT INTO line
VALUES(1, 'blue', 44, 35),
(2, 'red', 21.6, 20),
(3, 'green', 41.2, 34);
-- -------------
INSERT INTO train
VALUES( '10642LG', 'low', '16:15:39', '22:11:37',1),
( '25635KQ', 'MEDIUM', '10:09:41', '08:39:41',3),
( '22394RR', 'MEDIUM', '10:25:15', '18:26:27',2),
( '16278MG', 'full', '10:24:42', '06:02:46',2),
( '27531JI', 'full', '20:45:44', '14:11:28',1),
( '19053KT', 'low', '17:36:24', '05:10:53',3);
-- -------------
INSERT INTO person
VALUES(9965412365, 'mohamed' , 'eldsoky' , 'el-mahdi' , 'M' , '1942-04-23' , '01512814'),
(2111137605, 'ibrahim' , 'eldsoky' , 'nour-el-deen' , 'M' , '1970-02-27' , '01128218'),
(3111143747, 'shahd' , 'ali' , 'al-bashir' , 'F' , '1948-07-22' , '0117634'),
(4111113930, 'Gharib' , 'mosa' , 'el-khalifa-el-maamoun' , 'M' , '1945-09-14' , '01129950'),
(5111123090, 'ashraf' , 'nader' , 'nour-el-deen' , 'M' , '2022-10-9' , '011387'),
(6111137166, 'ashraf' , 'rashad' , 'el-khalifa-el-maamoun' , 'M' , '1990-01-3' , '0117775'),
(7111125839, 'taher' , 'kmal' , 'nour-el-deen' , 'M' , '1993-02-11' , '01127710'),
(8111141088, 'ashraf' , 'mansor' , 'el-mahdi' , 'M' , '1953-02-02' , '01117895'),
(9111142622, 'ayaat' , 'ramy' , 'mahmoud-el-attar' , 'F' , '2009-01-22' , '0112564'),
(1011137605, 'Ghanem' , 'saber' , 'mahmoud-el-attar' , 'M' , '1994-10-14' , '01128669'),
(1111139227, 'mazen' , 'ibrahim' , 'al-bashir' , 'M' , '1966-05-04' , '011954'),
(1211136745, 'ashraf' , 'mohamed' , 'el-mahdi' , 'M' , '2002-03-24' , '01125734'),
(1311136061, 'ibrahim' , 'Ghanem' , 'mahmoud-el-attar' , 'M' , '1966-05-27' , '0113439'),
(1411116284, 'ahmad' , 'ibrahim' , 'nour-el-deen' , 'M' , '1977-12-23' , '01120942'),
(1511134012, 'rahma' , 'mohamed' , 'el-mahdi' , 'F' , '2007-07-11' , '01126339'),
(1611117300, 'mazen' , 'kareem' , 'el-khalifa-el-maamoun' , 'M' , '1983-09-18' , '01023464'),
(1711142801, 'rahma' , 'mazen' , 'mahmoud-el-attar' , 'F' , '1951-12-02' , '01121062'),
(1811131612, 'mohamed' , 'mazen' , 'el-khalifa-el-maamoun' , 'M' , '2007-12-16' , '01215058'),
(1911142470, 'Ghanem' , 'eldsoky' , 'nour-el-deen' , 'M' , '1979-11-15' , '01217726'),
(2011133463, 'yasiin' , 'said' , 'el-mahdi' , 'M' , '1983-12-16' , '01120636'),
(2145678945, 'ibrahim' , 'ashraf' , 'abdelraouf' , 'M' , '2004-12-16' , '01020636'),
(2245678978, 'mohamed' , 'ahmed' , 'el-mahdi' , 'M' , '2006-09-08' , '01093645'),
(2345698796, 'ahmad' , 'eldsoky' , 'mogawra40' , 'M' , '1907-03-30' , '0124485054'),
(2432178965, 'adel' , 'bola' , 'mogawra45' , 'M' , '1988-08-19' , '012554984'),
(2512365478, 'sama' , 'eldsoky' , 'mogawra40' , 'F' , '1906-09-10' , '01049464'),
(2665478925, 'lolo' , 'tarek' , 'alahram' , 'F' , '1907-07-9' , '01545125'),
(2765478925, 'ali' , 'mohamed' , 'alahram' , 'M' , '2007-07-1' , '01545125910'),
(2865478925, 'mostafa' , 'tarek' , 'alahram' , 'M' , '2004-09-9' , '01157126303'),
(2965478925, 'ayaat' , 'tarek' , 'alahram' , 'F' , '1953-10-9' , '01057126404');
-- -------------

INSERT INTO manger
VALUES(9965412365),
(2111137605),
(4111113930),
(5111123090),
(2145678945),
(2245678978),
(6111137166),
(2345698796);
-- -------------
INSERT INTO station
VALUES('al-shohadaa' , 'Giza' , 5111123090),
('nasser' , 'Giza' , 2111137605),
('sadat' , 'Qalyubia' , 4111113930),
('Attaba' , 'Qalyubia' , 6111137166),
('cairoUN' , 'cairo' , 9965412365),
('ghamra' , 'Giza' , 2145678945),
('kitkat' , 'cairo' , 2245678978),
('shubra' , 'Qalyubia' , 2345698796);

-- -------------
INSERT INTO employee
VALUES(9965412365, 'cairoUN',3397,8),
(2111137605, 'nasser',2505,9),
(3111143747, 'cairoUN',8132,15),
(4111113930, 'sadat',4587,24),
(5111123090, 'al-shohadaa',4576,3),
(6111137166, 'Attaba',8811.123,7),
(7111125839, 'cairoUN',8719.99,12),
(8111141088, 'cairoUN',5055,13),
(9111142622, 'sadat',2200,4),
(1011137605, 'cairoUN',1005,8),
(1111139227, 'cairoUN',6666,9),
(1511134012, 'sadat',7894,6),
(1911142470, 'cairoUN',6000,3),
(2145678945, 'ghamra',8000,18),
(2345698796, 'shubra',4569,8),
(2245678978, 'kitkat',10000,24),
(2432178965, 'cairoUN',879.99,1),
(2512365478, 'Attaba',6547.5,9),
(2665478925, 'sadat',3652.099,8),
(2765478925, 'nasser',1212,4),
(2865478925, 'shubra',1000.5,3),
(2965478925, 'kitkat',300,10);
-- -------------
INSERT INTO Tr_pass
VALUES('25635KQ' , 'nasser', '11:56:22'),
('16278MG' , 'Attaba', '1:28:15'),
('19053KT' , 'Attaba', '2:36:34'),
('22394RR' , 'sadat', '21:41:13');
-- -------------
INSERT INTO safety_services
VALUES(1, 'cameras' , 'surveillance'),
(2, 'fire extinguisher' , 'Put out the fire'),
(3, 'alarm' , 'Alert'),
(4, 'metal-Detective' , 'Check');
-- -------------

INSERT INTO  access_Method
VALUES(30925, 'ticket',10,'1', '2023-05-12' ,'0', null ),
(2819, 'card',33,'0', null ,'1', 'student' ),
(14728, 'card',55,0, null ,1, 'worker' ),
(26494, 'ticket',10,1, '2022-09-25' ,0, null ),
(24950, 'card',60,0, null ,1, 'older' ),
(6189, 'ticket',10,1, '2023-01-06' ,0, null ),
(31359, 'ticket',10,1, '2021-12-04' ,0, null ),
(22392, 'card',38,0, null ,1, 'older' ),
(20895, 'card',60,0, null ,1, 'adulte' ),
(21087, 'ticket',5,1, '2020-05-05' ,0, null );
-- -------------
INSERT INTO passenger
VALUES(1211136745, '30925'),
(1311136061, '2819'),
(1411116284, '14728'),
(1611117300, '26494'),
(1711142801, '24950'),
(1811131612, '6189'),
(2011133463, '31359');
-- -------------
INSERT INTO buy
VALUES('31359',1211136745, 'green' ),
('26494',1411116284, 'red' ),
('21087',1311136061, 'yellow' ),
('30925',2011133463, 'green' );
-- -------------
INSERT INTO Ticket_Worker
VALUES(7111125839),
(8111141088),
(3111143747),
(9111142622);
-- -------------
INSERT INTO Subscription_Worker
VALUES(1011137605, 'nasser' ),
(1111139227, 'nasser' ),
(1511134012, 'cairoUN' ),
(1911142470, 'sadat' );
-- -------------
INSERT INTO T_has
VALUES('30925',7111125839),
('26494',8111141088),
('6189',3111143747);
-- -------------
INSERT INTO C_has
VALUES('2819',1011137605),
('14728',1111139227),
('22392',1511134012);
-- -------------
INSERT INTO Dependent
VALUES('ayaat','F','el-khalifa-el-maamoun','1920-03-04',2111137605),
('ashraf','M','mahmoud-el-attar','1964-08-28',3111143747),
('nade','F','el-mahdi','1968-05-01',1911142470);
-- -------------
INSERT INTO L_has
VALUES('ghamra' ,1),
('kitkat' ,3),
('shubra' ,2);
-- -------------
INSERT INTO transform
VALUES(2 ,3,'nasser'),
(2 ,1,'al-shohadaa'),
(1 ,2,'sadat');
-- -------------
INSERT INTO crosss
VALUES('20895','cairoUN','shubra'),
('24950','al-shohadaa','nasser'),
('21087','shubra','sadat'),
('30925','attaba','sadat');
-- -------------
INSERT INTO Accident
VALUES(1,'collision'),
(2,'firefighting'),
(3,'passengers die');
-- -------------
INSERT INTO occurs
VALUES(1, '16278MG', 2, '22:2:32', 'station'),
(2, '27531JI', 3, '18:15:49', 'train'),
(3, '19053KT', 1, '13:59:41', 'station');
-- -------------
INSERT INTO supply
VALUES(1,'19053KT',2432178965),
(2,'27531JI',2512365478),
(3,'16278MG',2345698796);
-- ------------  -------------- ------------- 

