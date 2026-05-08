# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.44)
# Database: taskbin
# Generation Time: 2026-05-08 21:27:42 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table lists
# ------------------------------------------------------------

DROP TABLE IF EXISTS `lists`;

CREATE TABLE `lists` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `data` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `lists` WRITE;
/*!40000 ALTER TABLE `lists` DISABLE KEYS */;

INSERT INTO `lists` (`id`, `data`)
VALUES
	(1,'{\n  \"id\": \"seed-1\",\n  \"title\": \"Groceries\",\n  \"items\": [\n    {\n      \"id\": \"c1\", \"text\": \"Produce\", \"done\": false, \"isCategory\": true, \"collapsed\": false,\n      \"children\": [\n        { \"id\": \"i1\", \"text\": \"Lemons\", \"done\": false },\n        { \"id\": \"i2\", \"text\": \"Spinach\", \"done\": true },\n        { \"id\": \"i3\", \"text\": \"Avocados\", \"done\": false }\n      ]\n    },\n    {\n      \"id\": \"c2\", \"text\": \"Bakery\", \"done\": false, \"isCategory\": true, \"collapsed\": false,\n      \"children\": [\n        { \"id\": \"i4\", \"text\": \"Sourdough bread\", \"done\": false },\n        { \"id\": \"i5\", \"text\": \"Croissants\", \"done\": false }\n      ]\n    },\n    { \"id\": \"i6\", \"text\": \"Olive oil\", \"done\": true },\n    { \"id\": \"i7\", \"text\": \"Greek yogurt\", \"done\": false }\n  ],\n  \"color\": \"cream\",\n  \"pinned\": true,\n  \"createdAt\": \"\"\n}');

/*!40000 ALTER TABLE `lists` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
