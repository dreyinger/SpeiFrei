-- MySQL dump 10.13  Distrib 5.6.21, for osx10.10 (x86_64)
--
-- Host: delphi3.dhbw-stuttgart.de    Database: SpeiFrei
-- ------------------------------------------------------
-- Server version	5.1.46-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ACTOR`
--

DROP TABLE IF EXISTS `ACTOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACTOR` (
  `PersID` int(11) NOT NULL AUTO_INCREMENT,
  `Firstname` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `Surname` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `PlaceOfBirth` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Birthdate` date DEFAULT NULL,
  `Gender` char(1) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`PersID`)
) ENGINE=MyISAM AUTO_INCREMENT=1007 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACTOR`
--

LOCK TABLES `ACTOR` WRITE;
/*!40000 ALTER TABLE `ACTOR` DISABLE KEYS */;
INSERT INTO `ACTOR` VALUES (1000,'Mark','Wahlberg','Boston','1971-05-06','m'),(1001,'Arnold','Schwarzenegger','Salzburg','1947-07-30','m'),(1002,'John','Depp','Owensboro','1963-06-09','m'),(1003,'Jennifer','Lawrence','Louisville','1990-08-15','f'),(1004,'Chloë','Moretz','Atlanta','1997-02-10','f'),(1005,'Thomas','Hanks','Concord','1956-07-09','m'),(1006,'Joshua','Hutcherson','Union','1992-10-12','m');
/*!40000 ALTER TABLE `ACTOR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACTSIN`
--

DROP TABLE IF EXISTS `ACTSIN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACTSIN` (
  `A_PersID` int(11) NOT NULL,
  `M_MovieID` int(11) NOT NULL,
  PRIMARY KEY (`A_PersID`,`M_MovieID`),
  KEY `m_acts` (`M_MovieID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACTSIN`
--

LOCK TABLES `ACTSIN` WRITE;
/*!40000 ALTER TABLE `ACTSIN` DISABLE KEYS */;
INSERT INTO `ACTSIN` VALUES (1002,1002),(1003,1006),(1004,1005),(1005,1001),(1005,1003),(1005,1004),(1006,1006);
/*!40000 ALTER TABLE `ACTSIN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMMENT`
--

DROP TABLE IF EXISTS `COMMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COMMENT` (
  `CommentID` int(11) NOT NULL AUTO_INCREMENT,
  `Text` text COLLATE utf8_unicode_ci NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Position` time DEFAULT NULL,
  `M_MovieID` int(11) NOT NULL,
  `U_Email` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`CommentID`),
  KEY `u_comments` (`U_Email`),
  KEY `m_comments` (`M_MovieID`)
) ENGINE=MyISAM AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMMENT`
--

LOCK TABLES `COMMENT` WRITE;
/*!40000 ALTER TABLE `COMMENT` DISABLE KEYS */;
/*!40000 ALTER TABLE `COMMENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DIRECTOR`
--

DROP TABLE IF EXISTS `DIRECTOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DIRECTOR` (
  `PersID` int(11) NOT NULL AUTO_INCREMENT,
  `Firstname` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `Surname` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `PlaceOfBirth` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Birthdate` date DEFAULT NULL,
  `Gender` char(1) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`PersID`)
) ENGINE=MyISAM AUTO_INCREMENT=1014 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DIRECTOR`
--

LOCK TABLES `DIRECTOR` WRITE;
/*!40000 ALTER TABLE `DIRECTOR` DISABLE KEYS */;
INSERT INTO `DIRECTOR` VALUES (1000,'Christopher','Nolan','London','1970-07-30','m'),(1001,'Michael','Bay','Los Angeles','1965-02-17','m'),(1002,'Francis','Lawrence','Vienna','1971-03-26','m'),(1003,'Gary','Ross','Los Angeles','1956-11-03','m'),(1007,'Ridley','Scott','South Shields','1937-11-30','m'),(1006,'Wesley','Anderson','Houston','1969-05-01','m'),(1008,'John','Wedge','Binghampton','1957-03-20','m'),(1009,'Tom','Tykwer','Wuppertal','1965-05-23','m'),(1010,'Gregor','Verbinski','Oak Ridge','1964-03-16','m'),(1011,'Ronald','Howard','Duncan','1954-03-01','m'),(1012,'Roland','Emmerich','Stuttgart','1955-11-10','m'),(1013,'Matthew','Vaughn','London','1971-03-07','m');
/*!40000 ALTER TABLE `DIRECTOR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MOVIE`
--

DROP TABLE IF EXISTS `MOVIE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MOVIE` (
  `MovieID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `ReleaseDate` date DEFAULT NULL,
  `Genre` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Mood` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Duration` int(11) NOT NULL,
  `AgeRating` int(11) NOT NULL,
  `D_PersID` int(11) NOT NULL,
  `StudioID` int(11) DEFAULT NULL,
  `AvgRating` int(11) DEFAULT NULL,
  `RatingCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`MovieID`),
  KEY `directs` (`D_PersID`)
) ENGINE=MyISAM AUTO_INCREMENT=1007 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MOVIE`
--

LOCK TABLES `MOVIE` WRITE;
/*!40000 ALTER TABLE `MOVIE` DISABLE KEYS */;
INSERT INTO `MOVIE` VALUES (1000,'Day After Tomorrow','2004-10-10','Thriller','Melancholic',118,12,1012,1000,NULL,NULL),(1001,'Cloud Atlas','2012-10-26','Thriller',NULL,172,12,1009,1000,NULL,NULL),(1002,'Pirates of the Carribean: The Curse of the Black Pearl','2003-09-02','Action',NULL,143,12,1010,NULL,NULL,NULL),(1003,'The Da Vinci Code','2006-05-18','Thriller',NULL,149,12,1011,NULL,NULL,NULL),(1004,'Angels and Demons','2009-05-13','Thriller',NULL,138,12,1011,NULL,NULL,NULL),(1005,'Kick Ass','2010-04-22','Action',NULL,117,16,1013,NULL,NULL,NULL),(1006,'The Hunger Games','2012-03-22','Sci-Fi',NULL,142,12,1003,NULL,NULL,NULL);
/*!40000 ALTER TABLE `MOVIE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STUDIO`
--

DROP TABLE IF EXISTS `STUDIO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `STUDIO` (
  `StudioID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `Headquarter` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`StudioID`)
) ENGINE=MyISAM AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STUDIO`
--

LOCK TABLES `STUDIO` WRITE;
/*!40000 ALTER TABLE `STUDIO` DISABLE KEYS */;
INSERT INTO `STUDIO` VALUES (1000,'Universal','Universal City'),(1001,'Paramount Pictures','Los Angeles'),(1002,'Legendary Pictures','Burbank'),(1003,'Lions Gate Entertainment','Santa Monica');
/*!40000 ALTER TABLE `STUDIO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER`
--

DROP TABLE IF EXISTS `USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER` (
  `Email` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `Firstname` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `Surname` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `RegistrationDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Birthdate` date DEFAULT NULL,
  `Gender` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Password` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Email`)
) ENGINE=MyISAM AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER`
--

LOCK TABLES `USER` WRITE;
/*!40000 ALTER TABLE `USER` DISABLE KEYS */;
INSERT INTO `USER` VALUES ('vitzthum_m@gmx.at','Michael','Vitzthum','2014-10-22 21:57:18',NULL,'m','');
/*!40000 ALTER TABLE `USER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WATCHLIST`
--

DROP TABLE IF EXISTS `WATCHLIST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WATCHLIST` (
  `U_Email` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `M_MovieID` int(11) NOT NULL,
  `Seen` tinyint(1) NOT NULL,
  PRIMARY KEY (`U_Email`,`M_MovieID`),
  KEY `m_watches` (`M_MovieID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WATCHLIST`
--

LOCK TABLES `WATCHLIST` WRITE;
/*!40000 ALTER TABLE `WATCHLIST` DISABLE KEYS */;
/*!40000 ALTER TABLE `WATCHLIST` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-10-29 18:29:10
