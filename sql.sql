CREATE DATABASE IF NOT EXISTS `hub`;
USE `hub`;

CREATE TABLE IF NOT EXISTS `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_ambulance', 'EMS', 1),
	('society_mehanicar', 'Mehanicar', 1),
	('society_mehanicar2', 'Mehanicar2', 1),
	('society_police', 'Police', 1);

CREATE TABLE IF NOT EXISTS `addon_account_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(46) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  KEY `index_addon_account_data_account_name` (`account_name`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `bought_houses` (
  `houseid` int(50) NOT NULL,
  PRIMARY KEY (`houseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `communityservice` (
  `identifier` varchar(100) NOT NULL,
  `actions_remaining` int(10) NOT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `dark-org` (
  `org` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `poeni` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `dark-org-vozila` (
  `org` longtext DEFAULT NULL,
  `vehprops` longtext DEFAULT NULL,
  `tablice` longtext DEFAULT NULL,
  `izvadjen` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `dark-racuni` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razlog` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cena` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=527 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_ambulance', 'EMS', 1),
	('society_automafija', 'Auto Mafija', 1),
	('society_ballas', 'Ballas', 1),
	('society_camorra', 'Camorra', 1),
	('society_favela', 'Favela', 1),
	('society_gsf', 'Gsf', 1),
	('society_juzniv', 'Juzni Vetar', 1),
	('society_lazarevacki', 'Lazarevacki', 1),
	('society_lcn', 'Lcn', 1),
	('society_ludisrbi', 'Ludi Srbi', 1),
	('society_mehanicar', 'Mehanicar', 1),
	('society_mehanicar2', 'Mehanicar2', 1),
	('society_peaky', 'Peaky', 1),
	('society_police', 'Police', 1),
	('society_stikla', 'Stikla', 1),
	('society_vagos', 'Vagos', 1),
	('society_yakuza', 'Yakuza', 1),
	('society_zemunski', 'Zemunski', 1),
	('user_ears', 'Ears', 0),
	('user_glasses', 'Glasses', 0),
	('user_helmet', 'Helmet', 0),
	('user_mask', 'Mask', 0);

CREATE TABLE IF NOT EXISTS `datastore_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `owner` varchar(46) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  KEY `index_datastore_data_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9740 DEFAULT CHARSET=utf8mb4;

INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
	(194, 'society_ambulance', NULL, '\'{}\''),
	(195, 'society_automafija', NULL, '\'{}\''),
	(196, 'society_ballas', NULL, '\'{}\''),
	(197, 'society_camorra', NULL, '\'{}\''),
	(198, 'society_favela', NULL, '\'{}\''),
	(199, 'society_gsf', NULL, '\'{}\''),
	(200, 'society_juzniv', NULL, '\'{}\''),
	(201, 'society_lazarevacki', NULL, '\'{}\''),
	(202, 'society_lcn', NULL, '\'{}\''),
	(203, 'society_ludisrbi', NULL, '\'{}\''),
	(204, 'society_peaky', NULL, '\'{}\''),
	(205, 'society_stikla', NULL, '\'{}\''),
	(206, 'society_vagos', NULL, '\'{}\''),
	(207, 'society_yakuza', NULL, '\'{}\''),
	(208, 'society_zemunski', NULL, '\'{}\'');

CREATE TABLE IF NOT EXISTS `evidence_storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `gksphone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `gksphone_bank_transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `identifier` longtext DEFAULT NULL,
  `price` longtext NOT NULL,
  `name` longtext NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7845 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `gksphone_blockednumber` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` longtext NOT NULL,
  `hex` longtext NOT NULL,
  `number` longtext NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `gksphone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` longtext NOT NULL COMMENT 'Num tel proprio',
  `num` longtext NOT NULL COMMENT 'Num refÃ©rence du contact',
  `incoming` int(11) NOT NULL COMMENT 'DÃ©fini si on est Ã  l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7255 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `gksphone_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hex` longtext NOT NULL,
  `image` longtext NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=346 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `gksphone_gps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hex` longtext NOT NULL,
  `nott` longtext DEFAULT NULL,
  `gps` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `gksphone_group_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupid` int(11) NOT NULL,
  `owner` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `ownerphone` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `groupname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `messages` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `contacts` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `groupid` (`groupid`) USING BTREE,
  CONSTRAINT `FK_phonegroupmessage` FOREIGN KEY (`groupid`) REFERENCES `gksphone_messages_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `gksphone_insto_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forename` longtext COLLATE utf8mb4_bin NOT NULL,
  `surname` longtext COLLATE utf8mb4_bin NOT NULL,
  `username` varchar(250) CHARACTER SET utf8 NOT NULL,
  `password` longtext COLLATE utf8mb4_bin NOT NULL,
  `avatar_url` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `takip` longtext COLLATE utf8mb4_bin DEFAULT '[]',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `gksphone_insto_instas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `filters` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_gksphone_insto_instas_gksphone_insto_accounts` (`authorId`),
  CONSTRAINT `FK_gksphone_insto_instas_gksphone_insto_accounts` FOREIGN KEY (`authorId`) REFERENCES `gksphone_insto_accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `gksphone_insto_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `inapId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_gksphone_insto_likes_gksphone_insto_accounts` (`authorId`),
  KEY `FK_gksphone_insto_likes_gksphone_insto_instas` (`inapId`),
  CONSTRAINT `FK_gksphone_insto_likes_gksphone_insto_accounts` FOREIGN KEY (`authorId`) REFERENCES `gksphone_insto_accounts` (`id`),
  CONSTRAINT `FK_gksphone_insto_likes_gksphone_insto_instas` FOREIGN KEY (`inapId`) REFERENCES `gksphone_insto_instas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `gksphone_insto_story` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stories` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `isRead` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_gksphone_insto_story_gksphone_insto_accounts` (`authorId`) USING BTREE,
  CONSTRAINT `FK_gksphone_insto_story_gksphone_insto_accounts` FOREIGN KEY (`authorId`) REFERENCES `gksphone_insto_accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `gksphone_job_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext NOT NULL,
  `number` varchar(50) NOT NULL,
  `message` longtext NOT NULL,
  `photo` longtext DEFAULT NULL,
  `gps` varchar(255) NOT NULL,
  `owner` int(11) NOT NULL DEFAULT 0,
  `jobm` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `gksphone_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL DEFAULT '0',
  `sender` varchar(255) NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '0',
  `image` text NOT NULL,
  `message` text NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `gksphone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(50) NOT NULL,
  `receiver` varchar(50) NOT NULL,
  `message` longtext NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6092 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `gksphone_messages_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` longtext NOT NULL,
  `ownerphone` varchar(50) NOT NULL,
  `groupname` varchar(255) NOT NULL,
  `gimage` longtext NOT NULL,
  `contacts` longtext NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `gksphone_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hex` longtext DEFAULT NULL,
  `haber` longtext DEFAULT NULL,
  `baslik` longtext DEFAULT NULL,
  `resim` longtext DEFAULT NULL,
  `video` longtext DEFAULT NULL,
  `zaman` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `gksphone_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` longtext NOT NULL,
  `crypto` longtext NOT NULL DEFAULT '{}',
  `phone_number` varchar(50) DEFAULT NULL,
  `avatar_url` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2429 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `gksphone_twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `profilavatar` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `gksphone_twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_gksphone_twitter_likes_gksphone_twitter_accounts` (`authorId`),
  KEY `FK_gksphone_twitter_likes_gksphone_twitter_tweets` (`tweetId`),
  CONSTRAINT `FK_gksphone_twitter_likes_gksphone_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `gksphone_twitter_accounts` (`id`),
  CONSTRAINT `FK_gksphone_twitter_likes_gksphone_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `gksphone_twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `gksphone_twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_gksphone_twitter_tweets_gksphone_twitter_accounts` (`authorId`),
  CONSTRAINT `FK_gksphone_twitter_tweets_gksphone_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `gksphone_twitter_accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=657 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `gksphone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` longtext CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(30) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` longtext CHARACTER SET utf8mb4 DEFAULT '-1',
  `avatar` longtext NOT NULL DEFAULT 'https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=520 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `gksphone_vehicle_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` longtext NOT NULL,
  `ownerphone` varchar(255) NOT NULL,
  `plate` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `image` longtext NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `gksphone_yellow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstname` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `hub_teritorije` (
  `id` int(11) DEFAULT NULL,
  `teritorija` varchar(60) NOT NULL,
  `pripada` varchar(50) DEFAULT NULL,
  `time` int(10) NOT NULL,
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `hub_teritorije` (`id`, `teritorija`, `pripada`, `time`) VALUES
	(1, 'T1', 'niko', 1286),
	(2, 'T2', 'niko', 1285),
	(3, 'T3', 'niko', 2211),
	(3, 'T4', 'niko', 498);
	
CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `jobs` (`name`, `label`) VALUES
	('automafija', 'Automafija'),
	('autoplac', 'Autoplac'),
	('bahama', 'Bahama '),
	('ballas', 'Ballas'),
	('bonnano', 'Bonnano'),
	('camorra', 'Camorra'),
	('cigani', 'Cigani'),
	('cleanbois', 'Cleanbois'),
	('cosanostra', 'Cosa Nostra'),
	('crips', 'Crips'),
	('delije', 'Delije'),
	('deltaforce', 'Delta Force'),
	('elchapo', 'El Chapo'),
	('favela', 'Amigos dos Amigos'),
	('garda', 'Nacionalna garda'),
	('grobari', 'Grobari'),
	('gsf', 'Grove Street Family'),
	('hellangels', 'Hell Angels'),
	('italijani', 'Italijanska Mafija'),
	('josamsedamgang', '187 Gang'),
	('kavacki', 'Kavacki'),
	('komiti', 'Komiti'),
	('ludisrbi', 'Ludi Srbi'),
	('mcdonalds', 'McDonalds'),
	('narcos', 'Narcos'),
	('pinkpanter', 'Pink Panter'),
	('pmehanicar', 'Plava Mehanicarska'),
	('police', 'PU'),
	('ruska', 'Ruska Mafija'),
	('scarface', 'Scarface'),
	('sheriff', 'Sheriff'),
	('sud', 'Sud'),
	('unemployed', 'Nezaposlen'),
	('vlada', 'Vlada'),
	('vwgroup', 'Volkswagen Group'),
	('yakuza', 'Yakuza'),
	('zemunski', 'Bolivija'),
	('zmehanicar', 'Zuta Mehanicarska');

CREATE TABLE IF NOT EXISTS `job_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=262 DEFAULT CHARSET=utf8mb4;

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(1, 'unemployed', 0, 'unemployed', 'Nezaposlen', 100, '{}', '{}'),
	(2, 'police', 0, 'pocetnik', 'Pripravnik', 20, '{}', '{}'),
	(3, 'police', 1, 'officer1', 'Mladji Vodnik', 20, '{}', '{}'),
	(4, 'police', 2, 'officer2', 'Stariji Vodnik', 40, '{}', '{}'),
	(5, 'police', 3, 'officer3', 'Vodnik Prve Klase', 60, '{}', '{}'),
	(6, 'police', 4, 'detective', 'Narednik', 80, '{}', '{}'),
	(26, 'favela', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(27, 'favela', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(28, 'favela', 2, 'zamenik', 'Zamenik Sefa', 0, '{}', '{}'),
	(29, 'favela', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(30, 'sud', 0, 'novi', 'Obezbedjenje', 50, '{}', '{}'),
	(31, 'sud', 1, 'radnik', 'Advokat', 100, '{}', '{}'),
	(32, 'sud', 2, 'tuzilac', 'Tuzilac', 100, '{}', '{}'),
	(33, 'sud', 3, 'sudija', 'Sudija', 150, '{}', '{}'),
	(34, 'sud', 4, 'boss', 'Vrhovni sudija', 300, '{}', '{}'),
	(97, 'mcdonalds', 0, 'radnik', 'Kasir', 0, '{}', '{}'),
	(98, 'mcdonalds', 1, 'kuvar', 'Kuvar', 0, '{}', '{}'),
	(99, 'mcdonalds', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(100, 'mcdonalds', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(105, 'delije', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(106, 'delije', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(107, 'delije', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(108, 'delije', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(109, 'grobari', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(110, 'grobari', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(111, 'grobari', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(112, 'grobari', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(113, 'kavacki', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(114, 'kavacki', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(115, 'kavacki', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(116, 'kavacki', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(117, 'bonnano', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(118, 'bonnano', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(119, 'bonnano', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(120, 'bonnano', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(121, 'hellangels', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(122, 'hellangels', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(123, 'hellangels', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(124, 'hellangels', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(125, 'yakuza', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(126, 'yakuza', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(127, 'yakuza', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(128, 'yakuza', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(129, 'zemunski', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(130, 'zemunski', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(131, 'zemunski', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(132, 'zemunski', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(133, 'elchapo', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(134, 'elchapo', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(135, 'elchapo', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(136, 'elchapo', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(137, 'crips', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(138, 'crips', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(139, 'crips', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(140, 'crips', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(142, 'automafija', 0, 'novi', 'Sef', 0, '{}', '{}'),
	(143, 'automafija', 1, 'radnik', 'Sef', 0, '{}', '{}'),
	(144, 'automafija', 2, 'zamenik', 'Sef', 0, '{}', '{}'),
	(145, 'automafija', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(146, 'cosanostra', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(147, 'cosanostra', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(148, 'cosanostra', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(149, 'cosanostra', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(150, 'italijani', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(151, 'italijani', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(152, 'italijani', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(153, 'italijani', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(154, 'ruska', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(155, 'ruska', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(156, 'ruska', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(157, 'ruska', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(158, 'komiti', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(159, 'komiti', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(160, 'komiti', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(161, 'komiti', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(162, 'scarface', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(163, 'scarface', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(164, 'scarface', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(165, 'scarface', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(166, 'ballas', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(167, 'ballas', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(168, 'ballas', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(169, 'ballas', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(170, 'gsf', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(171, 'gsf', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(172, 'gsf', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(173, 'gsf', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(174, 'ludisrbi', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(175, 'ludisrbi', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(176, 'ludisrbi', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(177, 'ludisrbi', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(178, 'pinkpanter', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(179, 'pinkpanter', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(180, 'pinkpanter', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(181, 'pinkpanter', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(182, 'camorra', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(183, 'camorra', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(184, 'camorra', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(185, 'camorra', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(186, 'bahama', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(187, 'bahama', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(188, 'bahama', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(189, 'bahama', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(190, 'cleanbois', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(191, 'cleanbois', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(192, 'cleanbois', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(193, 'cleanbois', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(198, 'police', 5, 'sdetective', 'Stariji Narednik', 100, '{}', '{}'),
	(199, 'police', 6, 'ldetective', 'Porucnik', 120, '{}', '{}'),
	(200, 'police', 7, 'sergeant', 'Kapetan', 140, '{}', '{}'),
	(201, 'police', 8, 'sfc', 'Komandir', 160, '{}', '{}'),
	(202, 'police', 9, 'lieutenant', 'Major', 180, '{}', '{}'),
	(203, 'police', 10, 'zamenik', 'Nacelnik', 200, '{}', '{}'),
	(206, 'police', 13, 'boss', 'Chief of Police', 300, '{}', '{}'),
	(207, 'autoplac', 0, 'novi', 'Obezbedjenje', 0, '{}', '{}'),
	(208, 'autoplac', 1, 'radnik', 'Prodavac', 0, '{}', '{}'),
	(209, 'autoplac', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(210, 'autoplac', 3, 'boss', 'Vlasnik', 0, '{}', '{}'),
	(211, 'josamsedamgang', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(212, 'josamsedamgang', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(213, 'josamsedamgang', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(214, 'josamsedamgang', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(215, 'vlada', 0, 'novi', 'Obezbedjenje', 50, '{}', '{}'),
	(216, 'vlada', 1, 'radnik', 'Sekretar', 50, '{}', '{}'),
	(217, 'vlada', 2, 'parlament', 'Parlament', 50, '{}', '{}'),
	(218, 'vlada', 3, 'kabinet', 'Kabinet', 50, '{}', '{}'),
	(219, 'vlada', 4, 'premijer', 'Premijer', 100, '{}', '{}'),
	(220, 'vlada', 5, 'boss', 'Predsednik', 150, '{}', '{}'),
	(221, 'vwgroup', 0, 'novi', 'Pocetnik', 0, '{}', '{}'),
	(222, 'vwgroup', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(223, 'vwgroup', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(224, 'vwgroup', 3, 'boss', 'Menadzer', 0, '{}', '{}'),
	(225, 'sheriff', 0, 'kadet', 'Kadet', 20, '{}', '{}'),
	(226, 'sheriff', 1, 'radnik', 'Oficir', 40, '{}', '{}'),
	(227, 'sheriff', 2, 'ranger', 'Kapetan', 60, '{}', '{}'),
	(228, 'sheriff', 3, 'zamenik', 'Zamenik nacelnika', 80, '{}', '{}'),
	(229, 'sheriff', 4, 'boss', 'Nacelnik', 100, '{}', '{}'),
	(230, 'deltaforce', 0, 'kadet', 'Kadet', 20, '{}', '{}'),
	(231, 'deltaforce', 1, 'radnik', 'Operater', 40, '{}', '{}'),
	(232, 'deltaforce', 2, 'vodja', 'Vodja Jedinice', 60, '{}', '{}'),
	(233, 'deltaforce', 3, 'zamenik', 'Zamenik nacelnika', 80, '{}', '{}'),
	(234, 'deltaforce', 4, 'boss', 'Nacelnik', 100, '{}', '{}'),
	(235, 'pmehanicar', 0, 'novi', 'Segrt', 0, '{}', '{}'),
	(236, 'pmehanicar', 1, 'radnik', 'Mehanicar', 0, '{}', '{}'),
	(237, 'pmehanicar', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(238, 'pmehanicar', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(239, 'zmehanicar', 0, 'novi', 'Segrt', 0, '{}', '{}'),
	(240, 'zmehanicar', 1, 'radnik', 'Mehanicar', 0, '{}', '{}'),
	(241, 'zmehanicar', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(242, 'zmehanicar', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(243, 'garda', 0, 'private', 'Private', 20, '{}', '{}'),
	(244, 'garda', 1, 'pfc', 'Private First Class', 40, '{}', '{}'),
	(245, 'garda', 2, 'corporal', 'Corporal', 60, '{}', '{}'),
	(246, 'garda', 3, 'sergeant', 'Sergeant', 80, '{}', '{}'),
	(247, 'garda', 4, 'staffsergeant', 'Staff Sergeant', 100, '{}', '{}'),
	(248, 'garda', 5, 'sfc', 'Sergeant First Class', 120, '{}', '{}'),
	(249, 'garda', 6, 'csm', 'Command Sergeant Major', 140, '{}', '{}'),
	(250, 'garda', 7, 'lieutenant', 'Lieutenant', 160, '{}', '{}'),
	(251, 'garda', 8, 'captain', 'Captain', 180, '{}', '{}'),
	(252, 'garda', 9, 'commander', 'Commander', 200, '{}', '{}'),
	(253, 'garda', 10, 'general', 'General', 220, '{}', '{}'),
	(254, 'narcos', 0, 'novi', 'Novi', 0, '{}', '{}'),
	(255, 'narcos', 1, 'radnik', 'Radnik', 0, '{}', '{}'),
	(256, 'narcos', 2, 'zamenik', 'Zamenik', 0, '{}', '{}'),
	(257, 'narcos', 3, 'boss', 'Sef', 0, '{}', '{}'),
	(258, 'cigani', 0, 'novi', 'Kikistar', 0, '{}', '{}'),
	(259, 'cigani', 1, 'radnik', 'Rasema', 0, '{}', '{}'),
	(260, 'cigani', 2, 'zamenik', 'Mudja', 0, '{}', '{}'),
	(261, 'cigani', 3, 'boss', 'Gedzo', 0, '{}', '{}');

CREATE TABLE IF NOT EXISTS `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('dmv', 'Driving Permit'),
	('drive', 'Drivers License'),
	('drive_bike', 'Motorcycle License'),
	('drive_truck', 'Commercial Drivers License'),
	('weed_processing', 'Weed Processing License');

CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(46) DEFAULT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicleid` longtext DEFAULT NULL,
  `state` int(4) DEFAULT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `stored` tinyint(4) NOT NULL DEFAULT 0,
  `trunk` longtext DEFAULT NULL,
  `glovebox` longtext DEFAULT NULL,
  `carseller` int(11) DEFAULT 0,
  `owner_type` int(11) DEFAULT 0,
  `lasthouse` int(11) DEFAULT 0,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `ox_doorlock` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `ox_doorlock` (`id`, `name`, `data`) VALUES
	(6, 'Sud#1', '{"doors":[{"model":110411286,"coords":{"x":238.87290954589845,"y":-414.0606384277344,"z":48.21968841552734},"heading":160},{"model":110411286,"coords":{"x":236.42897033691407,"y":-413.1647033691406,"z":48.21968841552734},"heading":340}],"state":1,"maxDistance":2.5,"coords":{"x":237.65093994140626,"y":-413.6126708984375,"z":48.21968841552734},"groups":{"sud":0}}'),
	(7, 'Sud#2', '{"doors":[{"model":110411286,"coords":{"x":233.9647674560547,"y":-412.24560546875,"z":48.21915054321289},"heading":160},{"model":110411286,"coords":{"x":231.52212524414063,"y":-411.3538818359375,"z":48.21915054321289},"heading":340}],"state":1,"maxDistance":2,"coords":{"x":232.74343872070313,"y":-411.79974365234377,"z":48.21915054321289},"groups":{"sud":0}}'),
	(13, 'Sud#3', '{"coords":{"x":228.79795837402345,"y":-421.81201171875,"z":48.22354888916015},"groups":{"sud":0},"doors":[{"coords":{"x":227.5769805908203,"y":-421.3661804199219,"z":48.22354888916015},"heading":340,"model":110411286},{"coords":{"x":230.01893615722657,"y":-422.2578125,"z":48.22354888916015},"heading":160,"model":110411286}],"maxDistance":2.5,"state":1}'),
	(14, 'Sud#4', '{"coords":{"x":234.34658813476563,"y":-423.826416015625,"z":48.22354888916015},"groups":{"sud":0},"doors":[{"coords":{"x":235.5675811767578,"y":-424.2722473144531,"z":48.22354888916015},"heading":160,"model":110411286},{"coords":{"x":233.1256103515625,"y":-423.380615234375,"z":48.22354888916015},"heading":340,"model":110411286}],"maxDistance":2.5,"state":1}'),
	(15, 'Sud#5', '{"coords":{"x":227.84719848632813,"y":-433.2611083984375,"z":48.2181510925293},"groups":{"sud":0},"doors":[{"coords":{"x":226.62782287597657,"y":-432.81146240234377,"z":48.2181510925293},"heading":340,"model":110411286},{"coords":{"x":229.06655883789063,"y":-433.7107849121094,"z":48.2181510925293},"heading":160,"model":110411286}],"maxDistance":2.5,"state":1}'),
	(18, 'Policjia#3', '{"coords":{"x":442.635009765625,"y":-994.3003540039063,"z":30.81251716613769},"state":1,"maxDistance":2.5,"heading":360,"groups":{"police":0},"model":-1543859032}'),
	(22, 'Policija#7', '{"coords":{"x":462.0155334472656,"y":-985.111083984375,"z":30.81599998474121},"state":1,"maxDistance":2.5,"heading":0,"groups":{"police":0},"model":165994623}'),
	(24, 'Policija#9', '{"coords":{"x":480.92913818359377,"y":-999.4942626953125,"z":30.81681823730468},"state":1,"maxDistance":2.5,"doors":[{"heading":0,"coords":{"x":479.6352233886719,"y":-999.4918212890625,"z":30.81683349609375},"model":165994623},{"heading":180,"coords":{"x":482.22308349609377,"y":-999.4966430664063,"z":30.81680488586425},"model":165994623}],"groups":{"police":4}}'),
	(27, 'Policija#12', '{"maxDistance":2.5,"state":1,"heading":180,"coords":{"x":460.84661865234377,"y":-984.669677734375,"z":34.34045028686523},"groups":{"police":0},"model":-1988553564}'),
	(28, 'Policija#13', '{"maxDistance":2.5,"state":1,"heading":180,"coords":{"x":454.9188537597656,"y":-984.669677734375,"z":34.34045028686523},"groups":{"police":0},"model":-884718443}'),
	(29, 'Policija#14', '{"maxDistance":2.5,"state":1,"heading":180,"coords":{"x":448.9914855957031,"y":-984.669677734375,"z":34.34045028686523},"groups":{"police":0},"model":-884718443}'),
	(30, 'Policija#15', '{"maxDistance":2.5,"state":1,"heading":0,"coords":{"x":450.2895202636719,"y":-989.1444091796875,"z":34.33730697631836},"groups":{"police":0},"model":-1988553564}'),
	(31, 'Policija#16', '{"maxDistance":2.5,"state":1,"heading":0,"coords":{"x":456.2223815917969,"y":-989.1444091796875,"z":34.33730697631836},"groups":{"police":0},"model":-1988553564}'),
	(32, 'Policija#17', '{"maxDistance":2.5,"state":1,"heading":0,"coords":{"x":462.1453857421875,"y":-989.1444091796875,"z":34.33730697631836},"groups":{"police":0},"model":-1988553564}'),
	(33, 'Policija#18', '{"maxDistance":2.5,"state":1,"heading":90,"coords":{"x":441.35687255859377,"y":-991.0828857421875,"z":34.3153190612793},"groups":{"police":0},"model":165994623}'),
	(34, 'Policija#19', '{"maxDistance":2.5,"state":1,"heading":90,"coords":{"x":441.35687255859377,"y":-995.2598876953125,"z":34.31415176391601},"groups":{"police":0},"model":-1543859032}'),
	(35, 'Policija#20', '{"maxDistance":2.5,"state":1,"heading":0,"coords":{"x":439.8937683105469,"y":-984.8536376953125,"z":34.31629180908203},"groups":{"police":0},"model":165994623}'),
	(36, 'Policija#21', '{"maxDistance":2.5,"state":1,"heading":0,"coords":{"x":435.7878723144531,"y":-984.8536376953125,"z":34.32023620605469},"groups":{"police":0},"model":-1543859032}'),
	(37, 'Policija#22', '{"maxDistance":2.5,"state":1,"heading":270,"coords":{"x":476.64959716796877,"y":-995.7869262695313,"z":34.34543991088867},"groups":{"police":0},"model":165994623}'),
	(38, 'Policija#23', '{"maxDistance":2.5,"state":1,"heading":180,"coords":{"x":482.2164306640625,"y":-1007.7431030273438,"z":34.34423828125},"groups":{"police":0},"model":165994623}'),
	(39, 'Policija#24', '{"maxDistance":2.5,"state":1,"heading":270,"coords":{"x":464.2744445800781,"y":-983.3741455078125,"z":43.83561706542969},"groups":{"police":0},"model":-340230128}'),
	(42, 'Policija#27', '{"maxDistance":2.5,"state":1,"heading":180,"coords":{"x":487.5503845214844,"y":-997.3180541992188,"z":25.85587882995605},"groups":{"police":0},"model":-1543859032}'),
	(43, 'Policija#28', '{"maxDistance":2.5,"state":1,"doors":[{"heading":0,"model":-2023754432,"coords":{"x":467.3533020019531,"y":-1014.5518188476563,"z":26.53733253479004}},{"heading":180,"model":-2023754432,"coords":{"x":469.9525146484375,"y":-1014.5518188476563,"z":26.53733253479004}}],"coords":{"x":468.65289306640627,"y":-1014.5518188476563,"z":26.53733253479004},"groups":{"police":0}}'),
	(46, 'Policjia#30', '{"maxDistance":10,"auto":true,"heading":0,"coords":{"x":452.3016662597656,"y":-1001.130126953125,"z":26.64808654785156},"groups":{"police":0},"model":1356380196,"state":1}'),
	(47, 'Policija#31', '{"maxDistance":10,"auto":true,"heading":0,"coords":{"x":447.4820861816406,"y":-1001.130126953125,"z":26.64808654785156},"groups":{"police":0},"model":1356380196,"state":1}'),
	(49, 'Policija#33', '{"maxDistance":10,"auto":true,"heading":0,"coords":{"x":431.4081726074219,"y":-1001.2523803710938,"z":26.64180564880371},"groups":{"police":0},"model":1356380196,"state":1}'),
	(50, 'Policija#34', '{"maxDistance":8,"auto":true,"heading":270,"coords":{"x":459.60675048828127,"y":-1019.6934814453125,"z":29.10957336425781},"groups":{"police":0},"model":-190780785,"state":1}'),
	(51, 'Policija#35', '{"maxDistance":8,"auto":true,"heading":270,"coords":{"x":459.5504150390625,"y":-1014.6458129882813,"z":29.10957336425781},"groups":{"police":0},"model":-190780785,"state":1}'),
	(52, 'Policija#36', '{"maxDistance":10,"auto":true,"heading":90,"coords":{"x":488.894775390625,"y":-1017.2122802734375,"z":27.14934539794922},"groups":{"police":0},"model":-1603817716,"state":1}'),
	(53, 'Policija#37', '{"maxDistance":10,"auto":true,"heading":270,"coords":{"x":411.0243225097656,"y":-1025.05712890625,"z":28.33852577209472},"groups":{"police":0},"model":725274945,"state":1}'),
	(54, 'Bolnica#1', '{"maxDistance":2.5,"model":854291622,"heading":250,"state":1,"coords":{"x":313.257080078125,"y":-596.0704345703125,"z":43.43391036987305},"groups":{"ambulance":0}}'),
	(55, 'Bolnica#2', '{"maxDistance":2.5,"model":854291622,"heading":160,"state":1,"coords":{"x":309.13372802734377,"y":-597.75146484375,"z":43.43391036987305},"groups":{"ambulance":0}}'),
	(56, 'Bolnica#3', '{"auto":true,"maxDistance":10,"model":-820650556,"heading":160,"state":1,"coords":{"x":337.2776794433594,"y":-564.4320068359375,"z":29.77529144287109},"groups":{"ambulance":0}}'),
	(57, 'Bolnica#5', '{"auto":true,"maxDistance":10,"model":-820650556,"heading":160,"state":1,"coords":{"x":330.1349182128906,"y":-561.8331298828125,"z":29.77529144287109},"groups":{"ambulance":0}}'),
	(58, 'Zatvor#1', '{"heading":90,"groups":{"sud":0,"police":0},"model":741314661,"coords":{"x":1844.9984130859376,"y":2604.8125,"z":44.63977813720703},"maxDistance":10,"state":1,"auto":true}'),
	(59, 'Zatvor#2', '{"heading":90,"groups":{"sud":0,"police":0},"model":741314661,"coords":{"x":1818.5428466796876,"y":2604.8125,"z":44.61100387573242},"maxDistance":10,"state":1,"auto":true}'),
	(60, 'Zatvor#3', '{"heading":180,"groups":{"sud":0,"police":0},"model":-1156020871,"coords":{"x":1796.9241943359376,"y":2596.565185546875,"z":46.3873062133789},"maxDistance":2.5,"state":1}'),
	(61, 'Zatvor#4', '{"heading":180,"groups":{"sud":0,"police":0},"model":-1156020871,"coords":{"x":1798.090087890625,"y":2591.687255859375,"z":46.41783905029297},"maxDistance":2.5,"state":1}'),
	(62, 'Zatvor#5', '{"heading":91,"groups":{"sud":0,"police":0},"model":1373390714,"coords":{"x":1791.7679443359376,"y":2551.460205078125,"z":45.75591278076172},"maxDistance":2.5,"state":1}'),
	(63, 'Zatvor#6', '{"heading":271,"groups":{"sud":0,"police":0},"model":1373390714,"coords":{"x":1775.994873046875,"y":2552.56494140625,"z":45.75591278076172},"maxDistance":2.5,"state":1}'),
	(64, 'Zatvor#7', '{"heading":211,"groups":{"sud":0,"police":0},"model":-340230128,"coords":{"x":1766.2613525390626,"y":2529.414794921875,"z":46.0760612487793},"maxDistance":2.5,"state":1}'),
	(65, 'Zatvor#8', '{"heading":211,"groups":{"sud":0,"police":0},"model":-340230128,"coords":{"x":1786.498046875,"y":2490.246337890625,"z":46.04889297485351},"maxDistance":2.5,"state":1}'),
	(66, 'Zatvor#9', '{"heading":31,"groups":{"sud":0,"police":0},"model":-340230128,"coords":{"x":1789.2169189453126,"y":2483.04248046875,"z":46.02537536621094},"maxDistance":2.5,"state":1}'),
	(67, 'Zatvor#10', '{"heading":31,"groups":{"sud":0,"police":0},"model":-340230128,"coords":{"x":1752.1328125,"y":2461.693359375,"z":46.01279067993164},"maxDistance":2.5,"state":1}'),
	(68, 'Zatvor#11', '{"heading":211,"groups":{"sud":0,"police":0},"model":-340230128,"coords":{"x":1749.810302734375,"y":2468.07470703125,"z":46.02368927001953},"maxDistance":2.5,"state":1}'),
	(69, 'Cleanbois kapija', '{"coords":{"x":-1800.3653564453126,"y":473.03912353515627,"z":133.95870971679688},"maxDistance":10,"groups":{"cleanbois":0,"sud":4},"doors":[{"model":546378757,"coords":{"x":-1799.039306640625,"y":470.6358642578125,"z":133.95050048828126},"heading":119},{"model":-1249591818,"coords":{"x":-1801.69140625,"y":475.4423828125,"z":133.9669189453125},"heading":119}],"state":1}'),
	(70, 'Cleanbois ulazna', '{"groups":{"cleanbois":0},"heading":119,"maxDistance":2.5,"coords":{"x":-1798.2308349609376,"y":468.82476806640627,"z":133.77560424804688},"state":1,"model":724862427}'),
	(71, 'Cleanbois kuca', '{"coords":{"x":-1804.943359375,"y":436.050537109375,"z":128.85438537597657},"maxDistance":2.5,"heading":0,"groups":{"cleanbois":0,"sud":4},"model":-1527723153,"state":1}'),
	(72, 'Cleanbois kuca#2', '{"coords":{"x":-1804.1136474609376,"y":429.08197021484377,"z":128.9164276123047},"maxDistance":2.5,"heading":180,"groups":{"cleanbois":0},"model":-1527723153,"state":1}'),
	(73, 'Cleanbois kuca#3', '{"coords":{"x":-1785.94482421875,"y":410.5105285644531,"z":113.90229034423828},"maxDistance":2.5,"heading":269,"groups":{"cleanbois":0},"model":-1568354151,"state":1}'),
	(74, 'Cleanbois kuca#5', '{"coords":{"x":-1804.413818359375,"y":402.15960693359377,"z":113.604248046875},"maxDistance":2.5,"heading":40,"groups":{"cleanbois":0},"model":-1568354151,"state":1}'),
	(76, 'Kapija cleanbois neka', '{"groups":{"sud":4,"cleanbois":0},"doors":[{"heading":23,"model":546378757,"coords":{"x":-1867.5201416015626,"y":349.26708984375,"z":89.79802703857422}},{"heading":23,"model":-1249591818,"coords":{"x":-1862.4840087890626,"y":351.4420166015625,"z":89.79802703857422}}],"coords":{"x":-1865.0020751953126,"y":350.35455322265627,"z":89.79802703857422},"maxDistance":10,"state":1}'),
	(129, 'favela1', '{"maxDistance":2,"heading":341,"groups":{"favela":0},"model":-1083130717,"coords":{"x":-34.84075927734375,"y":2871.641357421875,"z":59.73322677612305},"state":1}'),
	(130, 'favela celija1', '{"maxDistance":2,"heading":160,"groups":{"favela":0},"model":631614199,"coords":{"x":-37.50177001953125,"y":2882.806396484375,"z":51.6569709777832},"state":1}'),
	(131, 'favela celija 2', '{"maxDistance":2,"heading":340,"groups":{"favela":0},"model":631614199,"coords":{"x":-38.59494018554687,"y":2883.2041015625,"z":51.6569709777832},"state":1}'),
	(132, 'pd zadnja double', '{"doors":[{"coords":{"x":441.5993957519531,"y":-998.6812744140625,"z":30.79962348937988},"model":1388858739,"heading":180},{"coords":{"x":443.83966064453127,"y":-998.6812744140625,"z":30.79962348937988},"model":-165604314,"heading":180}],"maxDistance":2,"groups":{"police":0},"coords":{"x":442.71954345703127,"y":-998.6812744140625,"z":30.79962348937988},"state":1}'),
	(133, 'policija double 2', '{"doors":[{"coords":{"x":441.2427062988281,"y":-998.6812744140625,"z":30.79962348937988},"model":-165604314,"heading":180},{"coords":{"x":439.0085754394531,"y":-998.6812744140625,"z":30.79962348937988},"model":1388858739,"heading":180}],"maxDistance":2,"groups":{"police":0},"coords":{"x":440.1256408691406,"y":-998.6812744140625,"z":30.79962348937988},"state":1}'),
	(134, 'pd glavni', '{"groups":{"police":0},"maxDistance":2,"coords":{"x":434.7110900878906,"y":-981.9447021484375,"z":30.8007755279541},"state":0,"doors":[{"coords":{"x":434.7120056152344,"y":-983.0621948242188,"z":30.8007755279541},"model":1388858739,"heading":270},{"coords":{"x":434.7101745605469,"y":-980.8272705078125,"z":30.8007755279541},"model":-165604314,"heading":270}]}'),
	(135, 'policija salter', '{"heading":180,"groups":{"police":0},"maxDistance":2,"coords":{"x":441.7664489746094,"y":-994.2772216796875,"z":30.81871032714843},"state":1,"model":165994623}'),
	(136, 'policija nacelnik room', '{"heading":180,"groups":{"police":13},"maxDistance":2,"coords":{"x":472.2572326660156,"y":-999.5148315429688,"z":30.81649017333984},"state":1,"model":165994623}'),
	(137, 'policija garaza', '{"heading":90,"groups":{"police":0},"maxDistance":2,"coords":{"x":464.8759460449219,"y":-989.3229370117188,"z":25.8602180480957},"state":1,"model":165994623}'),
	(138, 'policija ormaric', '{"heading":180,"groups":{"police":0},"maxDistance":2,"coords":{"x":472.9867248535156,"y":-983.1987915039063,"z":25.85740852355957},"state":1,"model":-1543859032}'),
	(139, 'policija teretana', '{"heading":270,"groups":{"police":0},"maxDistance":2,"coords":{"x":478.484375,"y":-984.6744995117188,"z":25.85711860656738},"state":1,"model":165994623}'),
	(140, 'policija garaza 2', '{"heading":180,"groups":{"police":0},"maxDistance":2,"coords":{"x":468.177978515625,"y":-991.856689453125,"z":25.8560791015625},"state":1,"model":165994623}'),
	(141, 'policija vrata 2', '{"heading":180,"groups":{"police":0},"maxDistance":2,"coords":{"x":468.17724609375,"y":-991.8417358398438,"z":30.8217716217041},"state":1,"model":165994623}'),
	(142, 'policija vrata 3', '{"heading":180,"groups":{"police":0},"maxDistance":2,"coords":{"x":468.17840576171877,"y":-991.794189453125,"z":34.34156799316406},"state":1,"model":165994623}'),
	(143, 'policija kurac', '{"heading":270,"groups":{"police":0},"maxDistance":2,"coords":{"x":445.3455505371094,"y":-986.3033447265625,"z":34.31795120239258},"state":1,"model":165994623}'),
	(145, 'c1', '{"coords":{"x":-1099.2127685546876,"y":4948.58203125,"z":217.48606872558595},"maxDistance":2,"groups":{"cigani":0},"state":1,"doors":[{"coords":{"x":-1098.708984375,"y":4949.92138671875,"z":217.48355102539063},"heading":69,"model":1336183707},{"coords":{"x":-1099.716552734375,"y":4947.2431640625,"z":217.48858642578126},"heading":69,"model":184353357}]}'),
	(146, 'c4', '{"coords":{"x":-1101.9669189453126,"y":4941.037109375,"z":217.5135955810547},"maxDistance":2,"groups":{"cigani":0},"state":1,"heading":249,"model":96237516}'),
	(147, 'c3', '{"coords":{"x":-1111.0234375,"y":4938.0068359375,"z":217.5160369873047},"maxDistance":2,"groups":{"cigani":0},"state":1,"heading":160,"model":96237516}'),
	(148, 'c4', '{"coords":{"x":-1124.2659912109376,"y":4891.63916015625,"z":217.52142333984376},"maxDistance":2,"groups":{"cigani":0},"state":1,"heading":315,"model":96237516}'),
	(149, 'cigan vrata', '{"coords":{"x":-1149.0367431640626,"y":4905.87939453125,"z":219.98019409179688},"maxDistance":2,"groups":{"cigani":0},"state":1,"heading":305,"model":96237516}');

CREATE TABLE IF NOT EXISTS `ox_inventory` (
  `owner` varchar(46) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `data` longtext DEFAULT NULL,
  `lastupdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `owner` (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `playerhousing` (
  `id` int(32) NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `rented` tinyint(1) DEFAULT NULL,
  `price` int(32) DEFAULT NULL,
  `wardrobe` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `society_moneywash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `society` varchar(60) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sprays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` float(8,4) NOT NULL,
  `y` float(8,4) NOT NULL,
  `z` float(8,4) NOT NULL,
  `rx` float(8,4) NOT NULL,
  `ry` float(8,4) NOT NULL,
  `rz` float(8,4) NOT NULL,
  `scale` float(8,4) NOT NULL,
  `text` varchar(32) NOT NULL,
  `font` varchar(32) NOT NULL,
  `color` int(3) NOT NULL,
  `interior` int(3) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=992 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tgiann_mdt_arananlar` (
  `citizenid` varchar(50) DEFAULT NULL,
  `sebep` longtext DEFAULT NULL,
  `baslangic` varchar(255) DEFAULT NULL,
  `bitis` varchar(255) DEFAULT NULL,
  `isim` varchar(255) DEFAULT NULL,
  `img` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tgiann_mdt_cezalar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `aciklama` longtext DEFAULT NULL,
  `ceza` varchar(255) DEFAULT NULL,
  `polis` mediumtext DEFAULT NULL,
  `zanli` mediumtext DEFAULT NULL,
  `cezalar` longtext DEFAULT NULL,
  `olayid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1662 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tgiann_mdt_olaylar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aciklama` longtext DEFAULT NULL,
  `polis` mediumtext DEFAULT NULL,
  `zanli` mediumtext DEFAULT NULL,
  `zaman` varchar(50) DEFAULT current_timestamp(),
  `esyalar` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1211 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(46) NOT NULL,
  `accounts` longtext DEFAULT NULL,
  `group` varchar(50) DEFAULT 'user',
  `inventory` longtext DEFAULT NULL,
  `status` longtext DEFAULT NULL,
  `job` varchar(20) DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `loadout` longtext DEFAULT NULL,
  `position` varchar(255) DEFAULT '{"x":-1037.02,"y":-2736.44,"z":20.17,"heading":328.88}',
  `firstname` varchar(16) DEFAULT NULL,
  `lastname` varchar(16) DEFAULT NULL,
  `dateofbirth` varchar(10) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `disabled` tinyint(1) NOT NULL DEFAULT 0,
  `vip` tinyint(4) DEFAULT 0,
  `cardnumber` longtext DEFAULT '**** **** ****',
  `cvd` longtext DEFAULT '***',
  `pin` longtext DEFAULT '****',
  `last_house` int(11) DEFAULT 0,
  `house` longtext NOT NULL DEFAULT '{"owns":false,"furniture":[],"houseId":0}',
  `bought_furniture` longtext NOT NULL DEFAULT '{}',
  `aranma` mediumtext DEFAULT '[]',
  `photo` mediumtext DEFAULT NULL,
  `jail` int(11) NOT NULL DEFAULT 0,
  `odkoga` longtext NOT NULL,
  `donator` longtext NOT NULL DEFAULT 'Nista',
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2517 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `user_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) NOT NULL,
  `owner` varchar(46) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=413775 DEFAULT CHARSET=utf8mb4;