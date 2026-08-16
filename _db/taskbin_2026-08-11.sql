-- --------------------------------------------------------
-- Host:                         192.168.1.136
-- Server version:               8.0.46-0ubuntu0.24.04.3 - (Ubuntu)
-- Server OS:                    Linux
-- HeidiSQL Version:             12.17.0.7270
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
CREATE DATABASE IF NOT EXISTS `taskbin` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `taskbin`;

-- Dumping structure for table taskbin.lists
DROP TABLE IF EXISTS `lists`;
CREATE TABLE IF NOT EXISTS `lists` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `data` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table taskbin.lists: ~2 rows (approximately)
INSERT INTO `lists` (`id`, `data`) VALUES
	(6, '{"id":6,"title":"Groceries","items":[{"id":"z7abd2e6","text":"Produce","done":false,"isCategory":true,"collapsed":true,"children":[{"id":"wxdarszj","text":"Strawberries","done":false},{"id":"9vowx2aw","text":"Blueberries","done":false},{"id":"t80tqinn","text":"Mushrooms","done":false},{"id":"g3c9zu3i","text":"Green onions","done":false},{"id":"oem95vbz","text":"Lettuce","done":false},{"id":"bodkti62","text":"Oranges","done":false},{"id":"ywnlba9f","text":"Bananas","done":false},{"id":"vfr3szx1","text":"Potatoes","done":false},{"id":"0xcaccih","text":"Celery","done":false},{"id":"qi42yl9g","text":"Bell peppers","done":false},{"id":"rtdlabk1","text":"Carrots","done":false},{"id":"i6gpy8zs","text":"Spinach","done":false},{"id":"0o0790kz","text":"Broccoli","done":false},{"id":"1g3tul4z","text":"Avocado","done":false},{"id":"tug0xp13","text":"Basil","done":false},{"id":"7plk09w5","text":"Cucumber","done":false},{"id":"buf6f7bg","text":"Tomatoes","done":false},{"id":"agwxjhn4","text":"Cabbage","done":false},{"id":"e6tj5gyl","text":"Lemons","done":false},{"id":"3dzexzsw","text":"Garlic","done":false},{"id":"3dv0k6t0","text":"Cilantro","done":false},{"id":"2cgwdkz7","text":"Limes","done":false},{"id":"21897am4","text":"Onions","done":false},{"id":"gn5ehrxz","text":"Sage","done":false},{"id":"l0qhl2er","text":"Thyme","done":false},{"id":"lyynbnl4","text":"Rosemary","done":false},{"id":"sx8fwf6r","text":"Leeks","done":false},{"id":"y6rw7nvl","text":"Jarlic","done":false},{"id":"o48hnuvv","text":"Chives","done":false},{"id":"gkp4pqaj","text":"Lime juice","done":false},{"id":"88mjbrhy","text":"Ginger","done":false},{"id":"8irzs5ya","text":"Bean sprouts","done":false},{"id":"s46xt5gr","text":"Mint leaves","done":false},{"id":"7bt6oj1x","text":"Fennel","done":false}]},{"id":"f3bah6cv","text":"Dry Goods","done":false,"isCategory":true,"collapsed":false,"children":[{"id":"pzjymqim","text":"Jasmine rice","done":false},{"id":"pbxqcmvq","text":"Cornbread mix","done":false},{"id":"hkkemsfd","text":"Sugar","done":false},{"id":"0nrt1le2","text":"Buns","done":false},{"id":"iai2x2ip","text":"Tortillas","done":false},{"id":"ni4g0ava","text":"Oatmeal","done":false},{"id":"tloxme4r","text":"Panko bread crumbs","done":false},{"id":"9fzr39rr","text":"Brownie mix","done":false},{"id":"lp5qh0r4","text":"White cornmeal","done":false},{"id":"nxa8bky2","text":"Granola bars","done":false},{"id":"8mrkny0n","text":"Basamati rice","done":false},{"id":"d72lv7th","text":"Instant yeast","done":false},{"id":"65zxq5le","text":"Popcorn","done":false},{"id":"vqnmnynx","text":"Breath mints","done":false},{"id":"ukh6ucrx","text":"Baking soda","done":false},{"id":"5glpdo5f","text":"Corn starch","done":false},{"id":"0qjpibjl","text":"Bread","done":false},{"id":"vh4n6f1v","text":"Boxed meals","done":false},{"id":"bz2s1g9x","text":"Snacks","done":false},{"id":"62rwqn6s","text":"Cereal","done":false},{"id":"89b1i5a9","text":"Saltines","done":false},{"id":"t5yh17l2","text":"Bagels","done":false},{"id":"cjrvxr5x","text":"Chips","done":false},{"id":"xqi7iq7b","text":"English muffins","done":false},{"id":"vu3oen29","text":"Tortilla chips","done":false},{"id":"z4gr3pjn","text":"Elbowmacaroni","done":false},{"id":"kwigbreh","text":"Coffee","done":false},{"id":"lev3k92a","text":"Baking Powder","done":false}]},{"id":"6au1hzwi","text":"Beverages","done":false,"isCategory":true,"collapsed":false,"children":[]},{"id":"avdj1tpn","text":"Meats","done":false,"isCategory":true,"collapsed":false,"children":[]},{"id":"m2c563xc","text":"Refrigerated Items","done":false,"isCategory":true,"collapsed":true,"children":[{"id":"ubfy4flc","text":"Guacamole","done":false}]},{"id":"p8b6ysdq","text":"Frozen","done":false,"isCategory":true,"collapsed":false,"children":[]},{"id":"wt0foshk","text":"Condiments","done":false,"isCategory":true,"collapsed":false,"children":[{"id":"ei97jq7s","text":"Peanut butter","done":false}]},{"id":"nc9eoje4","text":"Spices/Oil","done":false,"isCategory":true,"collapsed":false,"children":[]},{"id":"3d6mtwm2","text":"Canned","done":false,"isCategory":true,"collapsed":false,"children":[]},{"id":"98cnxksl","text":"Household","done":false,"isCategory":true,"collapsed":false,"children":[]},{"id":"2sa5kzj8","text":"Personal","done":false,"isCategory":true,"collapsed":false,"children":[]},{"id":"y47f0g9f","text":"Pet Supplies","done":false,"isCategory":true,"collapsed":false,"children":[]},{"id":"09f9e51c","text":"Liquor Store","done":false,"isCategory":true,"collapsed":false,"children":[]},{"id":"jhdzmvtx","text":"Asian Market","done":false,"isCategory":true,"collapsed":false,"children":[]},{"id":"qookc37d","text":"Bakery/Deli","done":false,"isCategory":true,"collapsed":true,"children":[{"id":"8wnfkhxj","text":"Bread","done":false},{"id":"l7pov3qo","text":"Sliced meat","done":false},{"id":"p3jqlqbd","text":"Sliced cheese","done":false}]}],"color":"Chalk","pinned":false,"createdAt":1786494925071}'),
	(7, '{"id":7,"title":"App todo","items":[{"id":"7h69r44j","text":"Give field focus when clicking category button","done":false},{"id":"la383i8z","text":"Title case on save?","done":false},{"id":"uousdr78","text":"Sticky category titles","done":false},{"id":"ssrwar7b","text":"Auto-complete using completed items","done":false},{"id":"8owgok7e","text":"Move item to category?","done":false},{"id":"25nqc50e","text":"Trigger add item when hitting enter on a list item without changing","done":false},{"id":"ane7siy1","text":"Fix line-height wrapping in item list","done":false}],"color":"cream","pinned":false,"createdAt":1786495357523}');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
