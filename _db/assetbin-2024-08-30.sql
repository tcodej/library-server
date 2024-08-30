/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `assetbin` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `assetbin`;

CREATE TABLE IF NOT EXISTS `assets` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT '',
  `part_number` varchar(50) DEFAULT '',
  `serial_number` varchar(50) DEFAULT '',
  `notes` varchar(1024) DEFAULT '',
  `location_id` tinyint(4) DEFAULT NULL,
  `category_id` tinyint(4) DEFAULT NULL,
  `photo` varchar(30) DEFAULT NULL,
  `date_created` timestamp NULL DEFAULT current_timestamp(),
  `date_modified` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

REPLACE INTO `assets` (`id`, `name`, `part_number`, `serial_number`, `notes`, `location_id`, `category_id`, `photo`, `date_created`, `date_modified`) VALUES
	(1, 'Insignia Television', 'NS-32D20SNA14', '', '32" LCD, Basement TV edit', 1, 2, '1_1724897103531.jpg', NULL, '2024-08-29 02:05:03'),
	(2, 'Dell Monitor', 'SE2717H', '', '27" LCD 1080p, Primary PC monitor', 1, 1, NULL, NULL, '2024-08-14 18:41:55'),
	(3, 'Dell Inspiron 3668', '00325-80791-64028-AAOEM', '87516F56-4357-4494-80EF-D785894EB14C', '2017, Mini Tower PC, Primary PC', 1, 1, '3_1725045198552.jpg', NULL, '2024-08-30 19:13:19'),
	(7, 'test', 'test', 'test', 'test', 1, 1, '7_1724736423136.jpg', '2024-08-15 16:42:01', '2024-08-27 05:27:03'),
	(9, 'Atari 2600', 'new', 'new', 'new', 1, 5, '9_1725045105236.jpg', '2024-08-27 00:29:38', '2024-08-30 19:11:45'),
	(11, 'test', 'test', 'test', 'test', 6, 5, '11_1724736503544.jpg', '2024-08-27 00:31:17', '2024-08-27 05:28:23');

CREATE TABLE IF NOT EXISTS `categories` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

REPLACE INTO `categories` (`id`, `name`) VALUES
	(1, 'Computer'),
	(2, 'Electronic'),
	(3, 'Appliance'),
	(4, 'Music/Audio'),
	(5, 'Gaming');

CREATE TABLE IF NOT EXISTS `locations` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

REPLACE INTO `locations` (`id`, `name`) VALUES
	(1, 'Basement'),
	(2, 'Garage'),
	(3, 'Office'),
	(4, 'Kitchen'),
	(5, 'Dining Room'),
	(6, 'Living Room');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
