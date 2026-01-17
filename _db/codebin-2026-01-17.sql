-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.11.13-MariaDB-0ubuntu0.24.04.1 - Ubuntu 24.04
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table codebin.messages
DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `slug` tinytext DEFAULT NULL,
  `message` tinytext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table codebin.messages: ~6 rows (approximately)
REPLACE INTO `messages` (`id`, `slug`, `message`) VALUES
	(1, 'hello-world', 'Hello! This is the first message!'),
	(2, 'awesome', 'You are awesome!'),
	(3, 'ultrabeam', 'May I please have an Ultra Beam, please? It’s my last one, I swear!'),
	(5, 'hi', 'Hello! How are you?'),
	(6, 'new-one', 'This is a new one'),
	(7, 'reggie-awesome', 'Reggie, you’re awesome!'),
	(8, 'testy', 'Testy');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
