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
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `assets` (`id`, `name`, `part_number`, `serial_number`, `notes`, `location_id`, `category_id`, `subcategory_id`, `photo`, `storage`, `date_created`, `date_modified`) VALUES
	(1, 'Apple //e', 'A2S2064', '', 'My original computer. Currently broken.', 1, 1, 1, NULL, NULL, '2024-09-01 02:54:05', '2024-09-05 22:09:58'),
	(2, 'Apple //c monitor stand', 'A2M-4021', '', 'One of the rubber feet is missing, some scuffs in the paint on the rear', 1, 1, 27, NULL, NULL, '2024-09-01 03:03:11', '2024-09-05 22:29:14'),
	(3, 'Apple //e', 'A2S2064', '', 'Belonged to Harold N. Howard', 1, 1, 1, NULL, NULL, '2024-09-01 03:13:21', '2024-09-04 16:28:41'),
	(5, 'Macintosh LC III', 'M1254', '', '', 3, 1, 3, NULL, NULL, '2024-09-01 16:28:11', '2024-09-05 23:10:48'),
	(6, 'Macintosh Color Display', 'M1212', '', 'The video cord has been chewed on by mice but functions fine.', 1, 1, 24, NULL, NULL, '2024-09-01 16:28:24', '2024-09-04 17:10:17'),
	(7, 'Apple Internal 3.5" Hard Drive', '', '', '500MB SCSI, Quantum ProDrive', 1, 1, 3, NULL, NULL, '2024-09-01 16:28:37', '2024-09-04 17:04:12'),
	(8, 'iPhone 3G', 'A1241', '', 'White, 16GB, iOS 4.2.1. Home button needs extra pressure to work.', 1, 1, 4, NULL, NULL, '2024-09-01 16:28:53', '2024-09-04 19:13:46'),
	(9, 'iPhone 3G booklet', '', '', 'Includes tool, stickers and a soft cloth-like thing', 1, 1, 4, NULL, NULL, '2024-09-01 16:29:42', '2024-09-04 19:13:55'),
	(10, 'Soprano Ukulele', '', '', 'No brand name, totally generic and cheap. Belonged to my Mom\'s dad.', 1, 6, 18, NULL, NULL, '2024-09-01 16:33:40', '2024-09-04 17:09:25'),
	(11, 'Alesis 16 bit stereo drum machine', 'SR-16', '', 'Includes power adapter, manual and getting started booklet. 1990', 1, 6, 18, NULL, 0, '2024-09-01 16:33:53', '2024-09-04 17:00:10'),
	(12, 'Boss Dr. Rhythm drum machine', 'DR-550', '', 'In box with manual and pattern score.', 1, 6, 18, NULL, NULL, '2024-09-01 16:34:03', '2024-09-04 17:10:42'),
	(13, 'Atari 2600 "Light Sixer"', 'CX-2600', '', 'A 3/4" chunk of plastic is missing from the left-top side. Cosmetic only.', 1, 5, 15, NULL, NULL, '2024-09-01 16:34:26', '2024-09-04 17:04:24'),
	(14, 'Atari 2600', 'CX2600-A', '', '4 switch model with plastic tape covering lower case mold holes.', 1, 5, 15, NULL, NULL, '2024-09-01 16:34:38', '2024-09-04 17:04:19'),
	(15, 'Apple Mouse', 'M0100', '', 'Same part number as the Mouse II, but not labeled as such. Belonged to Harold N. Howard', 1, 1, 25, NULL, 1, '2024-09-04 19:22:15', '2024-09-04 19:22:35'),
	(16, 'Apple Mouse II', 'M0100', '', 'Repackaged Mac mouse for Apple II cards', 1, 1, 25, NULL, 1, '2024-09-04 19:25:34', '2024-09-04 19:25:34'),
	(17, 'Apple //c', 'A2S4100', '', '5 1/4" floppy drive, missing a rubber foot', 1, 1, 1, NULL, NULL, '2024-09-05 04:49:27', '2024-09-05 04:49:27'),
	(18, 'Power Supply //c', 'A2M4120', '', 'For the Apple //c', 1, 1, 1, NULL, NULL, '2024-09-05 04:50:19', '2024-09-05 22:30:02'),
	(19, 'Apple IIgs', 'A2S6000', '', 'ROM01', 1, 1, 1, NULL, NULL, '2024-09-05 04:50:37', '2024-09-05 04:50:37'),
	(20, 'Apple IIgs Memory Expansion', '670-0025-A', '', 'Fully populated at 1MB', 1, 1, 6, NULL, NULL, '2024-09-05 04:51:03', '2024-09-05 04:51:45'),
	(21, 'Super Serial Card II', '670-0020-C', '', 'For the Apple ][ family.', 1, 1, 6, NULL, NULL, '2024-09-05 04:51:34', '2024-09-05 22:30:23'),
	(25, 'Whirlpool Gas Oven', 'WFG505M0BS3', 'VEX3555621', '', 4, 3, 9, NULL, NULL, '2024-09-05 17:17:18', '2024-09-05 22:28:26'),
	(26, 'Apple IIgs Memory Expansion', '670-0025-A', '', 'Fully populated at 1MB (Do I really have two of these?)', 1, 1, 6, NULL, NULL, '2024-09-05 22:26:12', '2024-09-05 22:27:34'),
	(27, 'Memory chips', 'AS4C4256-80P', '', '256K x 4 DRAM, 20 chips, pulled from an old PC at The Bins', 1, 1, 6, NULL, 1, '2024-09-05 22:27:58', '2024-09-05 22:27:58'),
	(28, 'Apple II Monitor Stand', '', '', 'Is this a dupe of the //c monitor stand?', 1, 1, 27, NULL, NULL, '2024-09-05 23:03:28', '2024-09-05 23:03:28'),
	(29, 'AppleWorks', '', '', 'Software in box, with lots of extra documentation about the //c', 1, 1, 1, NULL, NULL, '2024-09-05 23:04:38', '2024-09-05 23:04:57'),
	(30, 'Apple //e 80 Col/64K memory expansion', '607-0103-E', '', 'From my original computer.', 1, 1, 6, NULL, NULL, '2024-09-05 23:05:40', '2024-09-05 23:05:40'),
	(31, 'Apple //e 80 Col/64K memory expansion', '607-0102', '', 'Harold\'s', 1, 1, 6, NULL, NULL, '2024-09-05 23:06:01', '2024-09-05 23:06:01'),
	(32, 'Disk ][ Interface Card', '650-X104-B', '', 'Harold\'s (what about the one in my orig computer?)', 1, 1, 6, NULL, NULL, '2024-09-05 23:06:51', '2024-09-05 23:06:51'),
	(33, 'Apple Disk ][ Drive', 'A2M0003', '', 'x2. Belonged to Harold N. Howard', 1, 1, 1, NULL, NULL, '2024-09-05 23:07:27', '2024-09-05 23:07:27'),
	(34, 'Apple Disk ][ Drive', 'A2M0003', '', 'x2. From my original computer.', 1, 1, 1, NULL, NULL, '2024-09-05 23:08:04', '2024-09-05 23:08:04'),
	(35, 'Apple Mouse Interface', '670-0030-C', '', 'Harold\'s', 1, 1, 6, NULL, NULL, '2024-09-05 23:08:33', '2024-09-05 23:08:33'),
	(36, 'Hayes Micromodem //e', '09 00012', '', 'Untested (no phone line). Harold\'s', 1, 1, 6, NULL, NULL, '2024-09-05 23:09:10', '2024-09-05 23:09:55'),
	(37, 'AppleColor Composite Monitor //e', 'A2M6021', '', 'Missing front panel cover', 1, 1, 24, NULL, NULL, '2024-09-05 23:09:46', '2024-09-05 23:09:46'),
	(38, 'Apple //e Platinum', 'A2S2128', '', '', 3, 1, 1, NULL, NULL, '2024-09-05 23:10:35', '2024-09-05 23:10:35'),
	(39, 'Apple //e 80 Col/64K memory expansion', '820-0067-D', '', 'From the //e Platinum', 3, 1, 6, NULL, NULL, '2024-09-05 23:11:58', '2024-09-05 23:11:58'),
	(40, 'TextPrint parallel card (?)', '1-810-9520', '', 'Can\'t find any info on this card.\nHas momentary switch attached inside with long wires. Triggers a \'print screen\' (?). Untested.', 1, 1, 6, NULL, 1, '2024-09-05 23:13:35', '2024-09-07 00:00:21'),
	(41, 'Atlantic Data Products parallel interface (?)', 'ADP-2PIC', '', 'No info found on this card. The cable attached looks like a parallel connector. Untested.', 1, 1, 6, NULL, NULL, '2024-09-07 00:01:29', '2024-09-07 00:01:29'),
	(42, 'Apple 5.25 Drive Controller', '655-0101-D', '', 'Later revision with connector cable soldered to board (for daisy-chaining drives, or the dual-drive)', 1, 1, 27, NULL, NULL, '2024-09-07 00:04:02', '2024-09-07 00:04:02'),
	(43, 'Apple Unidisk (5.25)', 'A9M0104', '', '', 1, 1, 1, NULL, NULL, '2024-09-07 00:07:23', '2024-09-07 00:07:23'),
	(44, 'Apple 3.5 Drive', 'A9M0106', '', 'x3. 800k, used with the 2gs', 1, 1, 1, NULL, NULL, '2024-09-07 00:17:00', '2024-09-07 00:17:00'),
	(45, 'Apple 5.25" Drive', 'A9M0107', '', 'Could use a cleaning. Might be possible to use with the //e card on a Mac LC', 1, 1, 1, NULL, NULL, '2024-09-07 00:18:45', '2024-09-07 00:18:45'),
	(46, 'Apple Duodisk (5.25 x2)', 'A9M0108', '', '', 1, 1, 1, NULL, NULL, '2024-09-07 00:20:43', '2024-09-07 00:20:43'),
	(47, 'Koala Pad', 'Model 002', '', 'This is the Commodore version, not Apple, but with a joystick converter it may work (see Champ analog adapter)', 1, 1, 1, NULL, NULL, '2024-09-07 00:22:11', '2024-09-07 00:22:11'),
	(48, 'Kraft joystick', 'KC-3', '', 'Has a Y-cable and a switch for use with an Apple or PC', 1, 1, 1, NULL, NULL, '2024-09-07 00:22:52', '2024-09-07 00:22:52'),
	(49, 'Champ Analog Adaptor', 'CA-343', '', 'Has an Atari style input, output connects to the game I/O port inside the Apple.', 1, 1, 1, NULL, NULL, '2024-09-07 00:23:54', '2024-09-07 00:23:54'),
	(50, 'Apple Monitor II', 'A2M2010', '', 'Green phosphor, 1983. My original monitor.', 1, 1, 24, NULL, NULL, '2024-09-07 00:25:08', '2024-09-07 00:25:08'),
	(51, 'Itoh Electronics, Inc. Dot-matrix printer', 'M-8510', '', 'Appears to work. The ribbon has long since dried up.', 3, 1, 1, NULL, NULL, '2024-09-07 00:25:32', '2024-09-07 00:26:04'),
	(52, 'Apple //e Owner\'s Manual', '030-0356-C', '', '', 1, 1, 1, NULL, NULL, '2024-09-07 00:35:32', '2024-09-07 00:35:32'),
	(53, 'Apple // DOS Programmer\'s Manual', '030-0536-A', '', '', 3, 1, 1, NULL, NULL, '2024-09-07 00:35:58', '2024-09-07 00:35:58'),
	(54, 'Apple // 80-Column Text Card Manual', '030-0408-A', '', '', 3, 1, 1, NULL, NULL, '2024-09-07 00:36:50', '2024-09-07 00:36:50'),
	(55, 'Apple II Disk II Installation Manual', '030-0415-A', '', '', 3, 1, 1, NULL, NULL, '2024-09-07 00:37:21', '2024-09-07 00:37:21'),
	(56, 'Apple // Monitor II User\'s Manual', '030-0598-A ', '', '', 3, 1, 1, NULL, NULL, '2024-09-07 00:37:48', '2024-09-07 00:37:48'),
	(57, 'Apple Pascal Software', '', '', 'Full box, contains multiple books, discs, paperwork', 3, 1, 1, NULL, NULL, '2024-09-07 00:38:39', '2024-09-07 00:38:46'),
	(58, 'Apple Ethernet LC Twisted-pair card', '820-0532-B', '', 'NuBus, Inside the LC III', 3, 1, 3, NULL, NULL, '2024-09-07 00:41:54', '2024-09-07 00:41:54'),
	(59, 'iMac CD install pack', '600-8981', '', '', 1, 1, 3, NULL, NULL, '2024-09-07 00:43:57', '2024-09-07 00:43:57'),
	(60, 'White MacBook install pack', '602-6081-B', '', '', 3, 1, 3, NULL, NULL, '2024-09-07 00:44:41', '2024-09-07 00:44:41'),
	(61, 'eMac install pack', '603-5708', '', '', 1, 1, 3, NULL, NULL, '2024-09-07 00:46:03', '2024-09-07 00:46:03'),
	(62, 'iMac user\'s guide', 'ZM034-1064-A', '', '', 1, 1, 3, NULL, NULL, '2024-09-07 00:46:28', '2024-09-07 00:46:28'),
	(63, 'Mac OS X Instant Up-To-Date pack', 'M8518LL/A', '', 'Missing CD', 1, 1, 3, NULL, NULL, '2024-09-07 00:46:50', '2024-09-07 00:46:50'),
	(64, 'Apple Mouse', 'MB112LL/B', '', 'USB, scroll ball. Original mighty mouse. Like new in box.', 1, 1, 25, NULL, NULL, '2024-09-07 00:52:32', '2024-09-07 20:21:20'),
	(65, 'SCSI 255 MB hard drive + enclosure', '655-0186 A 270S TB25S026 Rev 04-E S590A', '', 'Drive is Apple branded, Quantum ProDrive LPS. Enclosure is generic, no brand.', 1, 1, 3, NULL, NULL, '2024-09-07 20:21:14', '2024-09-07 20:21:14'),
	(66, 'Apple Enhanced Keyboard II', 'M3501', '', '', 1, 1, 3, NULL, NULL, '2024-09-07 20:22:07', '2024-09-07 20:22:07'),
	(67, 'AppleCD 300e Plus', 'M2918', '', '', 1, 1, 3, NULL, NULL, '2024-09-07 20:22:42', '2024-09-07 20:22:42'),
	(68, 'Apple Keyboard II', 'M0487', '', 'PPS sticker, anti-theft loop', 1, 1, 3, NULL, NULL, '2024-09-07 20:23:25', '2024-09-07 20:23:25'),
	(69, '1MB 30-pin memory module', 'GM71C4400AJ70', '', '2x Goldstar GM71C4400AJ70 1 MB 70 ns 30-pin SIMM parity RAM module', 1, 1, 3, NULL, NULL, '2024-09-07 20:35:26', '2024-09-07 20:35:26'),
	(70, '8MB 72-pin memory module', 'M514400C-70SJ', '', '', 1, 1, 3, NULL, NULL, '2024-09-07 20:36:50', '2024-09-07 20:36:50'),
	(71, 'SuperMac Video Spigot', '0007537-0001 Rev A', '', 'Requires PDS slot', 1, 1, 3, NULL, NULL, '2024-09-07 20:37:10', '2024-09-07 20:37:10'),
	(72, 'Apple IIe Card', '820-0444-A', '', 'Requires PDS slot', 1, 1, 3, NULL, NULL, '2024-09-07 20:39:32', '2024-09-07 20:39:32'),
	(73, 'Apple Desktop Bus Mouse', 'G5431', '', '2x', 1, 1, 3, NULL, NULL, '2024-09-07 20:39:52', '2024-09-07 20:39:52'),
	(74, 'Apple Desktop Bus Mouse II', 'M2706', '', '', 1, 1, 3, NULL, NULL, '2024-09-07 20:40:08', '2024-09-07 20:40:08'),
	(75, 'Apple 800K External Drive (3.5)', 'M0131', '', 'Disk gets stuck', 1, 1, 3, NULL, NULL, '2024-09-07 20:40:27', '2024-09-07 20:40:27'),
	(76, 'Macintosh Hard Disk 20, external', '825-1195-A', '', '', 1, 1, 3, NULL, NULL, '2024-09-07 20:40:58', '2024-09-07 20:40:58'),
	(77, 'Mac internal hard disk', 'Conner CP3008E', '', '80MB, 3.5", SCSI, Firmware 1992', 1, 1, 3, NULL, NULL, '2024-09-07 20:41:12', '2024-09-07 20:41:12'),
	(78, 'Mac internal hard disk', '940-40-9404', '', '40MB, 3.5", SCSI, Eprom 1990. Quantum ProDrive LPS', 1, 1, 3, NULL, NULL, '2024-09-07 20:41:28', '2024-09-07 20:41:28'),
	(79, 'Global Village TelePort Platinum modem', 'A812', '', 'Plugs into the Mac\'s round serial port.', 1, 1, 3, NULL, NULL, '2024-09-07 20:47:05', '2024-09-07 20:47:05'),
	(80, 'iPhone 3GS box, 32GB, Black', 'MC137LL/A', '', 'Includes booklets, stickers, tool. Nothing else. The phone is long gone.', 1, 1, 4, NULL, 1, '2024-09-07 20:47:57', '2024-09-07 20:47:57'),
	(81, 'iPhone 4 booklet', '607-6420', '', 'No box, no stickers.', 1, 1, 4, NULL, 1, '2024-09-07 20:48:13', '2024-09-07 20:49:15'),
	(82, 'iPhone SE box, 256 GB, Black, 2nd Gen', 'MXVP2LL/A', 'FFMCN2N7PMFG', 'Includes card inserts, stickers, tool, earpod case. Nothing else. This is my current phone.', NULL, 1, 4, NULL, NULL, '2024-09-07 20:48:26', '2024-09-07 20:53:35'),
	(83, 'iPhone 5 box, 32GB, Black', 'MD640LL/A', '', 'Includes booklet, stickers and earpods case. Nothing else. The phone is long gone.', 1, 1, 4, NULL, NULL, '2024-09-07 20:49:47', '2024-09-07 20:51:20'),
	(84, 'iPhone 5C box, 16GB', 'ME505LL/A', '', 'Includes paper inserts, simulated screen \'sticker\' and earpods case. Nothing else. The phone is long gone.', 1, 1, 4, NULL, NULL, '2024-09-07 20:50:06', '2024-09-07 20:51:30'),
	(85, 'iPhone SE box, 64GB, Space Gray, 1st Gen', 'MLM42LL/A', '', 'Includes booklet, stickers and earpods case. Nothing else. I have the phone, should put it back in the box.', 1, 1, 4, NULL, NULL, '2024-09-07 20:50:53', '2024-09-07 20:51:40'),
	(86, 'iPhone 6', 'A1549', '', 'Replacement screen broke the phone. It powers up but screen isn\'t working.', 1, 1, 4, NULL, 1, '2024-09-07 20:54:17', '2024-09-07 20:54:17'),
	(87, 'iPod Nano', 'A1199', '', '2nd generation, 8GB, black. Given this when working at Nike. Has the Rockbox firmware installed.', 1, 1, 4, NULL, 1, '2024-09-07 20:54:50', '2024-09-07 20:54:50'),
	(88, 'iPod Nano', 'A1320', '', '5th generation, 8GB, blue. Was Oliver\'s in middle school.', 1, 1, 4, NULL, NULL, '2024-09-07 20:55:24', '2024-09-07 20:55:24'),
	(89, 'iPad', 'A2602 / MK2K3LL/A', 'CW6VK4Y9FD', '9th Generation, 2021 model, $269.99', 1, 1, 4, NULL, NULL, '2024-09-07 20:55:51', '2024-09-07 20:55:51'),
	(90, 'Windows 98 install + Office 97', 'Dell P/N 09805C Rev: A00', '', 'CDs with win98 boot floppy. Includes manual and cert of authenticity', 1, 1, 2, NULL, NULL, '2024-09-08 00:49:36', '2024-09-08 00:49:36'),
	(91, 'Windows XP Professional install', '00045-137-868-043', '', 'CD plus booklet. Software key removed. Also with XP Home Edition booklet (no CD)', 1, 1, 2, NULL, NULL, '2024-09-08 00:50:03', '2024-09-08 00:50:03'),
	(92, 'Nexus 9 tablet', '99HZF003-00', '', 'From Google I/O 2015(?)', 1, 1, 5, NULL, 1, '2024-09-08 00:53:31', '2024-09-08 00:53:31'),
	(93, 'Google Chromebook Pixel', 'CB001 LTE', '', 'From Google I/O 2013(?). Power adapter was chewed on by mice but still works.', 1, 1, 5, NULL, 1, '2024-09-08 00:53:54', '2024-09-08 00:53:54'),
	(94, 'Lacie pocket USB floppy disk drive', '706018 MYFLOPPY3', '', 'Works', 1, 1, 2, NULL, 1, '2024-09-08 00:54:16', '2024-09-08 00:54:16'),
	(95, 'Biostar Microtech motherboard', 'MB-1433/50UIV-A', '', 'My original AMD 486 DV4-100 processor is installed. 1994.', 1, 1, 2, NULL, NULL, '2024-09-08 00:58:21', '2024-09-08 00:58:21'),
	(96, 'Media Vision Jazz Sound Card', 'JAZZ16', '', 'Seems to be many variations out there. Couldn\'t find an exact match.', 1, 1, 6, NULL, NULL, '2024-09-08 00:59:00', '2024-09-08 00:59:00'),
	(97, 'AMD K6 III', '', '', '1998. 333 AFR w/3DNow!', 1, 1, 2, NULL, NULL, '2024-09-08 00:59:25', '2024-09-08 00:59:25'),
	(98, 'AMD K6', '', '', '1997', 1, 1, 2, NULL, NULL, '2024-09-08 00:59:42', '2024-09-08 00:59:42'),
	(99, 'Turtle Beach soundcard', 'Tropez Plus Rev B', '', 'Has memory simms installed. Max is 12MB, not sure what is installed', 1, 1, 6, NULL, NULL, '2024-09-08 01:01:12', '2024-09-08 01:01:12'),
	(100, 'Pulse network card', 'H1012', '', '', 1, 1, 6, NULL, NULL, '2024-09-08 01:01:24', '2024-09-08 01:01:24'),
	(101, 'Diamond Multimedia VGA card', 'Stealth SE PCI', '', '1994', 1, 1, 6, NULL, NULL, '2024-09-08 01:01:40', '2024-09-08 01:01:40'),
	(102, 'Diamond Multimedia VGA card', 'Savage 4 SDRAM', '', '', 1, 1, 6, NULL, NULL, '2024-09-08 01:01:51', '2024-09-08 01:01:51'),
	(103, 'Memory sticks', '', '', 'Several varieties', 1, 1, 6, NULL, NULL, '2024-09-08 01:02:05', '2024-09-08 01:02:05'),
	(104, 'VGA multiplier', 'VM-118A', '', 'Used with the karaoke setup. 1 VGA input, 8 mirrored VGA outputs. Power adapter included.', 1, 1, 27, NULL, NULL, '2024-09-08 01:02:37', '2024-09-08 01:02:37'),
	(105, 'Scanner', '', '', 'The one on my desk.', 3, 1, 27, NULL, NULL, '2024-09-08 01:03:10', '2024-09-08 01:03:10'),
	(106, 'Zotac Z-Box', 'ZBOX-ID31DVD', 'G111516303271', 'P/N: 250FA163102ZT\nWas a media center PC originally. Now unused.', 3, 1, 2, NULL, NULL, '2024-09-08 01:04:51', '2024-09-08 01:08:36'),
	(107, 'Logitech Mouse', 'MX Anywhere 2S', '2337AP0227R9', 'USB corded mouse.', 1, 1, 25, NULL, NULL, '2024-09-08 01:05:27', '2024-09-08 01:08:32'),
	(108, 'Casio sampling keyboard', 'SK-1', '', 'My original. Keys are in bad shape, missing 2 black keys. Missing battery cover', 3, 6, 19, NULL, NULL, '2024-09-08 01:06:08', '2024-09-08 01:07:45'),
	(109, 'Casio sampling keyboard', 'SK-1', '', 'In good shape', 3, 6, 19, NULL, NULL, '2024-09-08 01:06:20', '2024-09-08 01:07:50'),
	(110, 'Casio sampling keyboard', 'SK-1', '', 'In decent shape, missing battery cover. Highest B key is broken.', 3, 6, 19, NULL, NULL, '2024-09-08 01:06:32', '2024-09-08 01:07:54'),
	(111, 'Casio Casiotone keyboard', 'MT-65', '', 'Missing some slider handles and a button cover. Works great', 3, 6, 19, NULL, NULL, '2024-09-08 01:06:48', '2024-09-08 01:07:58'),
	(112, 'Casio synthesizer', 'CZ-101', '', 'Unfortunately has gone haywire. Maybe needs to be recapped? - I recapped it and nothing changed', 3, 6, 20, NULL, NULL, '2024-09-08 01:07:00', '2024-09-08 01:08:03'),
	(113, 'Yamaha keyboard', 'PSR-22', '', 'In good condition, works great', 3, 6, 20, NULL, NULL, '2024-09-08 01:07:29', '2024-09-08 01:07:29'),
	(114, 'Roland synthesizer', 'D-20', '', 'My first legit keyboard. I seem to recall the disk drive started having issues - need to verify. VERIFIED. I suspect a bad belt.', 3, 6, 20, NULL, NULL, '2024-09-08 01:10:05', '2024-09-08 01:10:05'),
	(115, 'Artura mini keyboard controller', 'MKII', '', 'Sort of an impulse buy for programming in Abelton without needing to use the D-20', 3, 6, 19, NULL, NULL, '2024-09-08 01:10:30', '2024-09-08 01:10:30'),
	(116, 'Danelectro electric guitar', '59-DC', '', 'It\'s a Korean made reissue. I don\'t remember the purchase date, but I had it during The Promise breakers, so probably \'98 or \'99', 3, 6, 23, NULL, NULL, '2024-09-08 01:10:48', '2024-09-08 01:10:48'),
	(117, 'Behringer Pro-1', 'PRO-1', 'S1911000542DRK', 'Analog synthesizer. Bought new with $100 gift, $15.72 rewards, total $221 on 2021-03-21', 3, 6, 20, NULL, NULL, '2024-09-08 01:11:03', '2024-09-08 01:11:03'),
	(118, 'Behringer DeepMind 12', 'DEEPMIND12', 'S170511343AC5', 'Analog/digital synth. Bought new $799 on 2021-03-19', 3, 6, 20, NULL, NULL, '2024-09-08 01:11:18', '2024-09-08 01:11:18'),
	(119, 'Behringer VC340', 'VC340', 'S210400080CQP', 'String synth + vocoder. Bought new $499 - $173.15 rewards = $325.99 on 2021-10-16', 3, 6, 20, NULL, NULL, '2024-09-08 01:11:57', '2024-09-08 01:11:57'),
	(120, 'Yamaha reface', 'reface CS', '86792999418', 'Bought new $349.99 on 2023-09-28', 3, 6, 20, NULL, NULL, '2024-09-08 01:12:11', '2024-09-08 01:12:11'),
	(121, 'Behringer Solina String Ensemble', 'SOLINA', '010057D0718AAM', 'Bought new $299 on 2024-03-07', 3, 6, 20, NULL, NULL, '2024-09-08 01:12:31', '2024-09-08 01:12:31'),
	(122, 'Rockman guitar compressor', 'Model 100', '', 'Company started by Boston\'s guitar player. Rockman products are still sought after, but this unit less so.', 3, 6, 21, NULL, NULL, '2024-09-08 01:12:51', '2024-09-08 01:12:51'),
	(123, 'Kent analog rhythm system', 'K-2200', '', 'Real wood shell needs refinishing. Good candidate to circuit break.', 3, 6, 18, NULL, NULL, '2024-09-08 01:13:08', '2024-09-08 01:13:08'),
	(124, 'Digitech Digital Delay / Sampler', 'RDS 2001', '', 'Delay, flange, chorus, double, echo. I can\'t seem to get this to work in a way that is useful. Could it be broken?', 3, 6, 21, NULL, NULL, '2024-09-08 01:13:49', '2024-09-08 01:13:49'),
	(125, 'Digitech Guitar Multi-Effects pedal', 'RP-1', '', 'Sept. \'92. Rear headphone jack missing nut. Got this from Larry Brown and traded my effects rack. I so regret it.', 3, 6, 21, NULL, NULL, '2024-09-08 01:14:41', '2024-09-08 01:14:41'),
	(126, 'Behringer Feedback Destroyer Pro', 'FBQ2496', '', 'I never fully figured out how to use this. Got this for the karaoke setup.', 3, 6, 21, NULL, NULL, '2024-09-08 01:15:03', '2024-09-08 01:15:03'),
	(127, 'Boss Guitar Multi-Effectgs pedal', 'ME-50', '', 'Power adapter included. Used in the Poncherello days.', 3, 6, 21, NULL, NULL, '2024-09-08 01:15:38', '2024-09-08 01:15:38'),
	(128, 'Behringer Eurorack 8-input mixer', 'UB802', '', 'Needs testing, maybe cleaning', 3, 6, 22, NULL, NULL, '2024-09-08 01:15:52', '2024-09-08 01:15:52'),
	(129, 'Realistic Stereo Microphone Mixer', '32-1105', '', '4 channels', 1, 6, 22, NULL, NULL, '2024-09-08 01:16:18', '2024-09-08 01:16:18'),
	(130, 'Boss Foot Switch', 'FS-5U', '', 'In box, never used', 1, 6, 21, NULL, NULL, '2024-09-08 01:16:34', '2024-09-08 01:16:34'),
	(131, 'Korg digital tuner pedal', 'DT-10', '', 'Includes owner\'s manual', 1, 6, 21, NULL, NULL, '2024-09-08 01:16:47', '2024-09-08 01:16:47'),
	(132, 'Yamaha foot pedal', '', '', 'No identifying part number. Probably came as a sustain pedal with a keyboard. Bought at Goodwill', 1, 6, 21, NULL, NULL, '2024-09-08 01:16:59', '2024-09-08 01:16:59'),
	(133, 'Danelectro overdrive foot pedal', 'Pastrami', '', 'Used during The Promise Breakers days.', 1, 6, 21, NULL, NULL, '2024-09-08 01:17:22', '2024-09-08 01:17:22'),
	(134, 'Jim Dunlop Original Crybaby pedal', 'GCB-95', '', 'Something broke with the electronics and I haven\'t figured out how to fix it.', 1, 6, 21, NULL, NULL, '2024-09-08 01:17:36', '2024-09-08 01:17:36'),
	(135, 'Alesis mixer', 'Multimix 8 USB', '', 'Used for karaoke mixing. Includes power brick.', 1, 6, 22, NULL, NULL, '2024-09-08 01:17:56', '2024-09-08 01:17:56'),
	(136, 'Behringer mixer', 'Xenyx X2222 USB', '', 'No longer used. Replaced with Eurorack Pro 1u rack mixer.', 1, 6, 22, NULL, NULL, '2024-09-08 01:18:16', '2024-09-08 01:18:16'),
	(137, 'Behringer X-Touch', 'X-Touch', 'S210200573B1X', 'Impulse buy, hardly used. In box.', 1, 6, 22, NULL, NULL, '2024-09-08 01:19:04', '2024-09-08 01:19:04'),
	(138, 'Behringer rack mixer', 'Eurorack Pro RX1602', '', '1u rack mixer, attached to computer', 1, 6, 22, NULL, NULL, '2024-09-08 01:19:15', '2024-09-08 01:19:15'),
	(139, 'Zoom MultiStop effects pedal', 'MS-70CDR', '069353', 'Bought new $149.99 on 2023-09-28 - impulse buy, but it\'s pretty cool. Got it to use with the Behringer and Yamaha synths.', 1, 6, 22, NULL, NULL, '2024-09-08 01:20:13', '2024-09-08 01:20:13'),
	(140, 'Fostex Tape Sync Unit', 'TS-15', '', 'New old stock, never had a use for this as it\'s not MIDI.', 1, 6, NULL, NULL, NULL, '2024-09-08 01:20:41', '2024-09-08 01:20:41'),
	(141, 'Emagic MIDI interface', 'mt4', '', 'Can\'t find it! USB interface with 2 in and 4 out midi ports.', 1, 6, NULL, NULL, NULL, '2024-09-08 01:22:24', '2024-09-08 01:22:24'),
	(142, 'Matrix quartz guitar tuner', 'SR-1000', '', 'My original cheap tuner. Has an analog needle.', 1, 6, 21, NULL, NULL, '2024-09-08 01:22:50', '2024-09-08 01:22:50'),
	(143, 'Focusrite Scarlett i818', '', '', 'Attached to my computer.', 3, 6, 22, NULL, NULL, '2024-09-08 01:23:11', '2024-09-08 01:23:11'),
	(144, 'Behringer Eurorack power supply', 'CP1A', '', 'Bought when I blew the component in the PRO-1. Turned out to be unnecessary. $89 - rewards = $0', 3, 6, NULL, NULL, NULL, '2024-09-08 01:23:45', '2024-09-08 01:23:45'),
	(145, 'Sony headphones', 'MDR-V600', '', 'Foam has deteriorated, cable is starting to get sticky with age. Appears you can buy replacement foam', 3, 6, 28, NULL, NULL, '2024-09-08 01:25:39', '2024-09-08 01:25:57'),
	(146, 'Audio Technica Microphone', 'AT3035', '', 'Cardioid  capacitor, great for vocals. Includes zip pouch.', 3, 6, 30, NULL, NULL, '2024-09-08 01:27:14', '2024-09-08 01:28:40'),
	(147, 'Sennheiser Microphone', 'e835', '', 'Need to test... I seem to recall this is dead. Where did this mic come from? Includes zip pouch.', 3, 6, 30, NULL, NULL, '2024-09-08 01:27:28', '2024-09-08 01:28:45'),
	(148, 'Fender Microphone', 'P-51', '', 'Bought this on a whim and it\'s been a workhorse! Beat up because of karaoke. Includes zip pouch.', 3, 6, 30, NULL, NULL, '2024-09-08 01:27:48', '2024-09-08 01:28:55'),
	(149, 'Shure Microphone', 'SM58', '', 'Works great. Screen is beat up because of karaoke.', 3, 6, 30, NULL, NULL, '2024-09-08 01:28:03', '2024-09-08 01:29:10'),
	(150, 'Shure Microphone', 'SM57', '', 'x2. Both work great, sometimes used as backup karaoke or KJ mic. Both in the same zip pouch.', 3, 6, 30, NULL, NULL, '2024-09-08 01:28:27', '2024-09-08 01:29:04'),
	(151, 'Technics Amp', '', '', '', 3, 4, 11, NULL, NULL, '2024-09-08 02:27:06', '2024-09-08 02:27:06'),
	(152, 'Technics Amp with Surround', '', '', '', 3, 4, 11, NULL, NULL, '2024-09-08 02:27:11', '2024-09-08 02:27:11'),
	(153, 'Technics Dual Cassette', '', '', '', 3, 4, 11, NULL, NULL, '2024-09-08 02:27:16', '2024-09-08 02:27:16'),
	(154, 'Technics Turntable', 'SL-3300', '', '', 3, 4, 11, NULL, NULL, '2024-09-08 02:27:25', '2024-09-08 02:27:25'),
	(155, 'Niles speaker selector', 'HDL 6', '', 'Found at Goodwill', 3, 4, 11, NULL, NULL, '2024-09-08 02:27:42', '2024-09-08 02:27:42');

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `subcategories` (`id`, `category_id`, `name`) VALUES
	(1, 1, 'Apple ]['),
	(2, 1, 'PC'),
	(3, 1, 'Macintosh'),
	(4, 1, 'iDevice'),
	(5, 1, 'Android'),
	(6, 1, 'Card'),
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
	(24, 1, 'Monitor'),
	(25, 1, 'Mouse'),
	(26, 1, 'Keyboard'),
	(27, 1, 'Accessory'),
	(28, 6, 'Speakers'),
	(29, 6, 'Amplifier'),
	(30, 6, 'Microphone');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
