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


-- Dumping database structure for taskbin
CREATE DATABASE IF NOT EXISTS `taskbin` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `taskbin`;

-- Dumping structure for table taskbin.lists
DROP TABLE IF EXISTS `lists`;
CREATE TABLE IF NOT EXISTS `lists` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table taskbin.lists: ~3 rows (approximately)
INSERT INTO `lists` (`id`, `data`) VALUES
	(19, '{"id":19,"title":"Groceries","items":[{"id":"3n4bk7x0","text":"Beverages","done":false,"isCategory":true,"collapsed":false,"children":[{"id":"emvk8uhj","text":"Beer","done":false},{"id":"2n63my5f","text":"Carbonated water","done":true},{"id":"kkg23xgj","text":"Gatorade powder","done":false},{"id":"v7hpy0uk","text":"Grapefruit juice","done":true},{"id":"s80you31","text":"Orange juice","done":true},{"id":"9wz6qyh0","text":"White wine","done":true}]},{"id":"imqkstvv","text":"Dry Goods","done":true,"isCategory":true,"collapsed":false,"children":[{"id":"7i4hhud9","text":"Bagels","done":true},{"id":"1r8mujgi","text":"Baking powder","done":true},{"id":"dtqxzyur","text":"Baking soda","done":true},{"id":"r9chq3oi","text":"Basamati rice","done":true},{"id":"b1ne8wuk","text":"Boxed meals","done":true},{"id":"h3n9paph","text":"Bread","done":true},{"id":"78lwbv8k","text":"Breath mints","done":true},{"id":"3d8cth28","text":"Brownie mix","done":true},{"id":"pcjkackk","text":"Buns","done":true},{"id":"bm659wns","text":"Cereal","done":true},{"id":"d0aa3kni","text":"Chips","done":true},{"id":"4ghpp89d","text":"Chocolate","done":true},{"id":"dycr5zfm","text":"Coffee","done":true},{"id":"o0pglf2g","text":"Corn starch","done":true},{"id":"79ksimfe","text":"Cornbread mix","done":true},{"id":"n6mc254t","text":"Elbo macaroni","done":true},{"id":"7rdimbv7","text":"English muffins","done":true},{"id":"8q2dkup2","text":"Granola","done":true},{"id":"xd5xek38","text":"Granola bars","done":true},{"id":"s0sts47u","text":"Granulated sugar","done":true},{"id":"f138sxbm","text":"Instant yeast","done":true},{"id":"0r6mztdf","text":"Oatmeal","done":true},{"id":"i3c79y3y","text":"Panko bread crumbs","done":true},{"id":"x1frkt49","text":"Pasta sauce","done":true},{"id":"ozd4d5lt","text":"Peanut butter","done":true},{"id":"j49tp28d","text":"Popcorn","done":true},{"id":"s8h3atqi","text":"Rice","done":true},{"id":"6v3a45ij","text":"Saltines","done":true},{"id":"vwmkeyhj","text":"Snacks","done":true},{"id":"3aydgc70","text":"Sugar","done":true},{"id":"ptmqph63","text":"Tortilla chips","done":true},{"id":"035fyj6n","text":"Tortillas","done":true},{"id":"no3ogrdy","text":"White cornmeal","done":true}]},{"id":"t6xlb0wv","text":"Produce","done":true,"isCategory":true,"collapsed":false,"children":[{"id":"dh4dcc00","text":"Asian cucumber","done":true},{"id":"t1u62p1x","text":"Avocado","done":true},{"id":"1rz6q2kp","text":"Avocado","done":true},{"id":"yys01ykk","text":"Baby greens","done":true},{"id":"8c7kdrby","text":"Bananas","done":true},{"id":"b8sxlj9a","text":"Basil","done":true},{"id":"u762rc32","text":"Bean sprouts","done":true},{"id":"42rae954","text":"Bell petters","done":true},{"id":"q3wnblca","text":"Blueberries","done":true},{"id":"thth9nxg","text":"Broccoli","done":true},{"id":"6vop0mxh","text":"Cabbage","done":true},{"id":"zxtpd5qd","text":"Carrots","done":true},{"id":"sla55d9r","text":"Celery","done":true},{"id":"7va4zoz3","text":"Chives","done":true},{"id":"8hkiihn7","text":"Cilantro","done":true},{"id":"k8zfaoxd","text":"Cucumber","done":true},{"id":"np5nmdmo","text":"Dill weed","done":true},{"id":"nsx1xnrt","text":"Fennel","done":true},{"id":"ic9vqrgk","text":"Garlic","done":true},{"id":"qbbv1kom","text":"Ginger","done":true},{"id":"67wghg0y","text":"Green onions","done":true},{"id":"dbtjyzn6","text":"Jarlic","done":true},{"id":"yyuu3c1q","text":"Leeks","done":true},{"id":"2ctdipuo","text":"Lemons","done":true},{"id":"gq2mtlb4","text":"Lettuce","done":true},{"id":"fp4z8cee","text":"Limes","done":true},{"id":"glioc3fi","text":"Mint leaves","done":true},{"id":"m1nvxpwl","text":"Onions","done":true},{"id":"bmk7o4fy","text":"Oranges","done":true},{"id":"7mwfkqog","text":"Potatoes","done":true},{"id":"2ylotzpk","text":"Rosemary","done":true},{"id":"q21uzwk6","text":"Sage","done":true},{"id":"nra8h7sx","text":"Spinach","done":true},{"id":"f0z9cfpm","text":"Sprouts","done":true},{"id":"a9trfde9","text":"Strawberries","done":true},{"id":"c33hvfot","text":"Thyme","done":true},{"id":"q9lgevwz","text":"Tomatoes","done":true}]}],"color":"butter","pinned":false,"createdAt":1778454111011}'),
	(25, '{"id":25,"title":"Test collapsed","items":[{"id":"acb47ikb","text":"Category 1","done":false,"isCategory":true,"collapsed":false,"children":[{"id":"v5j2plza","text":"Four","done":false},{"id":"n77huhpr","text":"One","done":false},{"id":"bjqju7z7","text":"Three","done":false},{"id":"ggqw0wor","text":"Two","done":false}]},{"id":"oprra54o","text":"Category 2","done":false,"isCategory":true,"collapsed":false,"children":[{"id":"4s0ua9hg","text":"Eight","done":false},{"id":"wrchz3a9","text":"Eleven","done":false},{"id":"wzy5ajj5","text":"Nine","done":false},{"id":"7e8g8j52","text":"Seven","done":false}]}],"color":"cream","pinned":false,"createdAt":1778688530599}'),
	(26, '{"id":26,"title":"Another test","items":[{"id":"35opqbx3","text":"1","done":true},{"id":"vi440fhv","text":"10","done":false},{"id":"tibhe668","text":"11","done":false},{"id":"aqmmygk7","text":"12","done":false},{"id":"x11u5p2o","text":"134","done":true},{"id":"ij5iaxgt","text":"14","done":false},{"id":"silkes61","text":"2","done":true},{"id":"wg9djl4h","text":"3","done":true},{"id":"ish9t6ws","text":"4","done":false},{"id":"ucqcn6cc","text":"5","done":false},{"id":"12vs6jpd","text":"6","done":false},{"id":"1131g96t","text":"7","done":false},{"id":"h37ozuab","text":"8","done":false},{"id":"23kgxu3g","text":"9","done":false}],"color":"cream","pinned":false,"createdAt":1778688739403}');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
