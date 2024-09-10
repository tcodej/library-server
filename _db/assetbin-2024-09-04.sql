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

DROP TABLE IF EXISTS `assets`;
CREATE TABLE IF NOT EXISTS `assets` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT '',
  `part_number` varchar(50) DEFAULT '',
  `serial_number` varchar(50) DEFAULT '',
  `notes` varchar(1024) DEFAULT '',
  `location_id` tinyint(4) DEFAULT NULL,
  `category_id` tinyint(4) DEFAULT NULL,
  `subcategory_id` tinyint(4) DEFAULT NULL,
  `photo` varchar(30) DEFAULT NULL,
  `storage` tinyint(3) unsigned DEFAULT NULL,
  `date_created` timestamp NULL DEFAULT current_timestamp(),
  `date_modified` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `assets` (`id`, `name`, `part_number`, `serial_number`, `notes`, `location_id`, `category_id`, `subcategory_id`, `photo`, `storage`, `date_created`, `date_modified`) VALUES
	(1, 'Apple //e', 'A2S2064', '', 'My original computer.', 1, 1, 1, NULL, NULL, '2024-09-01 02:54:05', '2024-09-04 16:28:29'),
	(2, 'Apple //c monitor stand', 'A2M-4021', '', 'One of the rubber feet is missing, some scuffs in the paint on the rear', 1, 1, 1, NULL, NULL, '2024-09-01 03:03:11', '2024-09-04 05:40:59'),
	(3, 'Apple //e', 'A2S2064', '', 'Belonged to Harold N. Howard', 1, 1, 1, NULL, NULL, '2024-09-01 03:13:21', '2024-09-04 16:28:41'),
	(5, 'Macintosh LC III', 'M1254', '', '', 1, 1, 3, NULL, NULL, '2024-09-01 16:28:11', '2024-09-04 17:09:08'),
	(6, 'Macintosh Color Display', 'M1212', '', 'The video cord has been chewed on by mice but functions fine.', 1, 1, 24, NULL, NULL, '2024-09-01 16:28:24', '2024-09-04 17:10:17'),
	(7, 'Apple Internal 3.5" Hard Drive', '', '', '500MB SCSI, Quantum ProDrive', 1, 1, 3, NULL, NULL, '2024-09-01 16:28:37', '2024-09-04 17:04:12'),
	(8, 'iPhone 3G', 'A1241', '', 'White, 16GB, iOS 4.2.1. Home button needs extra pressure to work.', 1, 1, NULL, NULL, NULL, '2024-09-01 16:28:53', '2024-09-01 16:36:12'),
	(9, 'iPhone 3G booklet', '', '', 'Includes tool, stickers and a soft cloth-like thing', 1, 1, NULL, NULL, NULL, '2024-09-01 16:29:42', '2024-09-01 16:35:45'),
	(10, 'Soprano Ukulele', '', '', 'No brand name, totally generic and cheap. Belonged to my Mom\'s dad.', 1, 6, 18, NULL, NULL, '2024-09-01 16:33:40', '2024-09-04 17:09:25'),
	(11, 'Alesis 16 bit stereo drum machine', 'SR-16', '', 'Includes power adapter, manual and getting started booklet. 1990', 1, 6, 18, NULL, 0, '2024-09-01 16:33:53', '2024-09-04 17:00:10'),
	(12, 'Boss Dr. Rhythm drum machine', 'DR-550', '', 'In box with manual and pattern score.', 1, 6, 18, NULL, NULL, '2024-09-01 16:34:03', '2024-09-04 17:10:42'),
	(13, 'Atari 2600 "Light Sixer"', 'CX-2600', '', 'A 3/4" chunk of plastic is missing from the left-top side. Cosmetic only.', 1, 5, 15, NULL, NULL, '2024-09-01 16:34:26', '2024-09-04 17:04:24'),
	(14, 'Atari 2600', 'CX2600-A', '', '4 switch model with plastic tape covering lower case mold holes.', 1, 5, 15, NULL, NULL, '2024-09-01 16:34:38', '2024-09-04 17:04:19');

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `categories` (`id`, `name`) VALUES
	(1, 'Computer'),
	(2, 'Miscellaneous'),
	(3, 'Appliance'),
	(4, 'Audio/Visual'),
	(5, 'Gaming'),
	(6, 'Music Production');

DROP TABLE IF EXISTS `locations`;
CREATE TABLE IF NOT EXISTS `locations` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

INSERT INTO `locations` (`id`, `name`) VALUES
	(1, 'Basement'),
	(2, 'Garage'),
	(3, 'Office'),
	(4, 'Kitchen'),
	(5, 'Dining Room'),
	(6, 'Living Room');

DROP TABLE IF EXISTS `subcategories`;
CREATE TABLE IF NOT EXISTS `subcategories` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `subcategories` (`id`, `category_id`, `name`) VALUES
	(1, 1, 'Apple ]['),
	(2, 1, 'PC'),
	(3, 1, 'Macintosh'),
	(4, 1, 'iDevice'),
	(5, 1, 'Android'),
	(6, 1, 'Board'),
	(7, 2, 'Toy'),
	(8, 2, 'Gadget'),
	(9, 3, 'Kitchen'),
	(10, 3, 'Power Tool'),
	(11, 4, 'Component'),
	(12, 4, 'Speaker'),
	(13, 4, 'Camcorder'),
	(14, 4, 'Television'),
	(15, 5, 'Console'),
	(16, 5, 'Controller'),
	(17, 5, 'Cartridge'),
	(18, 6, 'Instrument'),
	(19, 6, 'Keyboard'),
	(20, 6, 'Synthesizer'),
	(21, 6, 'Effects'),
	(22, 6, 'Mixer'),
	(23, 6, 'Guitar'),
	(24, 1, 'Monitor');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
