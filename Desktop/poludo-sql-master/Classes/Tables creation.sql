CREATE  SCHEMA IF NOT EXISTS `school_simulation` ;
USE school_simulation;

CREATE TABLE `address` (
  `addressID` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(100) NOT NULL,
  `postalCode` varchar(20) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  PRIMARY KEY (`addressID`),
  UNIQUE KEY `address_UNIQUE` (`address`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8;

CREATE TABLE `student` (
  `studentID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `gender` varchar(45) NOT NULL COMMENT 'Considering that now you can accept more than 2 genders',
  `email` varchar(45) NOT NULL,
  `birthDate` date NOT NULL,
  `contactNumber` varchar(20) NOT NULL,
  `addressID` int(11) NOT NULL,
  PRIMARY KEY (`studentID`),
  KEY `addressFK_idx` (`addressID`),
  CONSTRAINT `addressFK` FOREIGN KEY (`addressID`) REFERENCES `address` (`addressID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COMMENT='new students table';

CREATE TABLE `instructor` (
  `instructorID` int(11) NOT NULL AUTO_INCREMENT,
  `fullName` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `contactNumber` varchar(20) NOT NULL,
  `addressID` int(11) NOT NULL,
  PRIMARY KEY (`instructorID`),
  KEY `addressFK_idx` (`addressID`),
  CONSTRAINT `addressINFK` FOREIGN KEY (`addressID`) REFERENCES `address` (`addressID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

CREATE TABLE `class` (
  `classID` varchar(6) NOT NULL,
  `totalHours` TIME NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`classID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `course` (
  `courseID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` mediumtext NOT NULL,
  PRIMARY KEY (`courseID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE `course_class` (
  `courseID` int(11) NOT NULL,
  `classID` varchar(6) NOT NULL,
  PRIMARY KEY (`courseID`,`classID`),
  KEY `classIDFK_idx` (`classID`),
  CONSTRAINT `classIDFK` FOREIGN KEY (`classID`) REFERENCES `class` (`classID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `courseIDFK` FOREIGN KEY (`courseID`) REFERENCES `course` (`courseID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `student_course` (
  `studentID` INT NOT NULL,
  `courseID` INT NOT NULL,
  PRIMARY KEY (`studentID`, `courseID`),
  INDEX `courseIDSCFK_idx` (`courseID` ASC),
  CONSTRAINT `studentIDSCFK`
    FOREIGN KEY (`studentID`)
    REFERENCES `student` (`studentID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `courseIDCSFK`
    FOREIGN KEY (`courseID`)
    REFERENCES `course` (`courseID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);

	
CREATE TABLE `instructor_class` (
  `instructorID` int(11) NOT NULL,
  `classID` varchar(6) NOT NULL,
  PRIMARY KEY (`instructorID`,`classID`),
  KEY `classIFK_idx` (`classID`),
  CONSTRAINT `classIFK` FOREIGN KEY (`classID`) REFERENCES `class` (`classID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `instructorCFK` FOREIGN KEY (`instructorID`) REFERENCES `instructor` (`instructorID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `schedule` (
  `classID` VARCHAR(6) NOT NULL,
  `startDay` INT NOT NULL,
  `startMonth` INT NOT NULL,
  `endDay` INT NOT NULL,
  `endMonth` INT NOT NULL,
  `year` INT NOT NULL,
  PRIMARY KEY (`classID`, `year`),
  CONSTRAINT `classSFK`
    FOREIGN KEY (`classID`)
    REFERENCES `class` (`classID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)ENGINE=InnoDB  DEFAULT CHARSET=utf8;

	CREATE TABLE `tuition` (
  `classID` VARCHAR(6) NOT NULL,
  `year` INT NOT NULL,
  `cost` DECIMAL(15,2) NOT NULL,
  PRIMARY KEY (`classID`, `year`),
  CONSTRAINT `classIDTFK`
    FOREIGN KEY (`classID`)
    REFERENCES `class` (`classID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)ENGINE=InnoDB  DEFAULT CHARSET=utf8;
