-- --------------------------------------------------------
-- Host:                         148.251.138.115
-- Server Version:               5.6.20-log - MySQL Community Server (GPL)
-- Server Betriebssystem:        Win64
-- HeidiSQL Version:             8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Exportiere Datenbank Struktur für arma3life
CREATE DATABASE IF NOT EXISTS `arma3life` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `arma3life`;


-- Exportiere Struktur von Prozedur arma3life.deleteOldMessages
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteOldMessages`()
BEGIN
	DELETE FROM `messages` WHERE `active` = 0;
END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
