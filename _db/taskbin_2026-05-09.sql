-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.11.13-MariaDB-0ubuntu0.24.04.1 - Ubuntu 24.04
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             12.16.0.7229
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table taskbin.lists
DROP TABLE IF EXISTS `lists`;
CREATE TABLE IF NOT EXISTS `lists` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table taskbin.lists: ~2 rows (approximately)
INSERT INTO `lists` (`id`, `data`) VALUES
	(1, '{"id":1,"title":"Groceries","items":[{"id":"c1","text":"Produce","done":false,"isCategory":true,"collapsed":false,"children":[{"id":"i1","text":"Lemons","done":false},{"id":"i2","text":"Spinach","done":true},{"id":"i3","text":"Avocados","done":false}]},{"id":"c2","text":"Bakery","done":false,"isCategory":true,"collapsed":false,"children":[{"id":"i4","text":"Sourdough bread","done":false},{"id":"i5","text":"Croissants","done":false}]},{"id":"i6","text":"Olive oil","done":true},{"id":"i7","text":"Greek yogurt","done":false}],"color":"cream","pinned":true,"createdAt":""}'),
	(2, '{"id":2,"title":"Farmers Market","items":[{"id":"i8","text":"Heirloom tomatoes","done":false},{"id":"i9","text":"Fresh basil","done":false},{"id":"i10","text":"Goat cheese","done":false}],"color":"sage","pinned":false,"createdAt":""}');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
