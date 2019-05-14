/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.34 : Database - mextv3
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `classes` */

DROP TABLE IF EXISTS `classes`;

CREATE TABLE `classes` (
  `ItemID` int(11) unsigned NOT NULL,
  `Category` char(2) NOT NULL,
  `Description` text NOT NULL,
  `ManaRegenerationMethods` text NOT NULL,
  `StatsDescription` text NOT NULL,
  PRIMARY KEY (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `enhancements` */

DROP TABLE IF EXISTS `enhancements`;

CREATE TABLE `enhancements` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `PatternID` int(11) unsigned NOT NULL DEFAULT '1',
  `Rarity` tinyint(3) unsigned NOT NULL,
  `DPS` smallint(4) unsigned NOT NULL,
  `Level` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2057 DEFAULT CHARSET=utf8;

/*Table structure for table `enhancements_patterns` */

DROP TABLE IF EXISTS `enhancements_patterns`;

CREATE TABLE `enhancements_patterns` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `Desc` varchar(4) NOT NULL,
  `Wisdom` tinyint(2) unsigned NOT NULL,
  `Strength` tinyint(2) unsigned NOT NULL,
  `Luck` tinyint(2) unsigned NOT NULL,
  `Dexterity` tinyint(2) unsigned NOT NULL,
  `Endurance` tinyint(2) unsigned NOT NULL,
  `Intelligence` tinyint(2) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Table structure for table `factions` */

DROP TABLE IF EXISTS `factions`;

CREATE TABLE `factions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Table structure for table `guilds` */

DROP TABLE IF EXISTS `guilds`;

CREATE TABLE `guilds` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `MessageOfTheDay` varchar(512) NOT NULL,
  `MaxMembers` tinyint(3) unsigned NOT NULL DEFAULT '15',
  `HallSize` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `LastUpdated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2071 DEFAULT CHARSET=utf8;

/*Table structure for table `guilds_halls` */

DROP TABLE IF EXISTS `guilds_halls`;

CREATE TABLE `guilds_halls` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `GuildID` int(11) unsigned NOT NULL,
  `Linkage` varchar(64) NOT NULL,
  `Cell` varchar(16) NOT NULL,
  `X` double(7,2) NOT NULL DEFAULT '0.00',
  `Y` double(7,2) NOT NULL DEFAULT '0.00',
  `Interior` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_guildhalls_guildid` (`GuildID`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

/*Table structure for table `guilds_halls_buildings` */

DROP TABLE IF EXISTS `guilds_halls_buildings`;

CREATE TABLE `guilds_halls_buildings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `HallID` int(11) unsigned NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  `Slot` tinyint(2) NOT NULL DEFAULT '1',
  `Size` tinyint(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_hallbuidling_hallid` (`HallID`),
  KEY `fk_hallbuilding_itemid` (`ItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Table structure for table `guilds_halls_connections` */

DROP TABLE IF EXISTS `guilds_halls_connections`;

CREATE TABLE `guilds_halls_connections` (
  `HallID` int(11) unsigned NOT NULL,
  `Pad` varchar(16) NOT NULL,
  `Cell` varchar(16) NOT NULL,
  `PadPosition` varchar(16) NOT NULL,
  KEY `fk_guildhallcon_hallid` (`HallID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `guilds_inventory` */

DROP TABLE IF EXISTS `guilds_inventory`;

CREATE TABLE `guilds_inventory` (
  `GuildID` int(11) unsigned NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  `UserID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`GuildID`,`ItemID`,`UserID`),
  KEY `fk_guildinv_itemid` (`ItemID`),
  KEY `fk_guildinv_userid` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `hairs` */

DROP TABLE IF EXISTS `hairs`;

CREATE TABLE `hairs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Gender` char(1) NOT NULL,
  `Name` varchar(16) NOT NULL,
  `File` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8;

/*Table structure for table `hairs_shops` */

DROP TABLE IF EXISTS `hairs_shops`;

CREATE TABLE `hairs_shops` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

/*Table structure for table `hairs_shops_items` */

DROP TABLE IF EXISTS `hairs_shops_items`;

CREATE TABLE `hairs_shops_items` (
  `Gender` char(1) NOT NULL DEFAULT 'M',
  `ShopID` int(11) unsigned NOT NULL,
  `HairID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`Gender`,`ShopID`,`HairID`),
  KEY `fk_hairshopitems_hairid` (`HairID`),
  KEY `fk_hairshopitems_shopid` (`ShopID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `items` */

DROP TABLE IF EXISTS `items`;

CREATE TABLE `items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(60) NOT NULL,
  `Description` text NOT NULL,
  `Type` varchar(16) NOT NULL,
  `Element` varchar(16) NOT NULL DEFAULT 'None',
  `File` varchar(64) NOT NULL,
  `Link` varchar(64) NOT NULL,
  `Icon` varchar(16) NOT NULL,
  `Equipment` varchar(6) NOT NULL,
  `Level` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `DPS` smallint(6) unsigned NOT NULL DEFAULT '100',
  `Range` smallint(6) unsigned NOT NULL DEFAULT '100',
  `Rarity` tinyint(3) unsigned NOT NULL DEFAULT '10',
  `Cost` int(11) unsigned NOT NULL DEFAULT '0',
  `Quantity` smallint(4) unsigned NOT NULL DEFAULT '1',
  `Stack` smallint(4) unsigned NOT NULL DEFAULT '1',
  `Coins` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Temporary` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Upgrade` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Staff` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `EnhID` int(11) unsigned NOT NULL DEFAULT '0',
  `FactionID` int(11) unsigned NOT NULL DEFAULT '1',
  `ReqReputation` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `ReqClassID` int(11) unsigned NOT NULL DEFAULT '0',
  `ReqClassPoints` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `ReqQuests` varchar(64) NOT NULL DEFAULT '',
  `QuestStringIndex` tinyint(3) NOT NULL DEFAULT '-1',
  `QuestStringValue` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Meta` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_items_enhid` (`EnhID`),
  KEY `fk_items_factionid` (`FactionID`),
  KEY `fk_items_reqclassid` (`ReqClassID`)
) ENGINE=InnoDB AUTO_INCREMENT=2008633 DEFAULT CHARSET=utf8;

/*Table structure for table `items_requirements` */

DROP TABLE IF EXISTS `items_requirements`;

CREATE TABLE `items_requirements` (
  `ItemID` int(11) unsigned NOT NULL,
  `ReqItemID` int(11) unsigned NOT NULL,
  `Quantity` smallint(6) unsigned NOT NULL,
  PRIMARY KEY (`ItemID`,`ReqItemID`),
  KEY `fk_itemrequirement_reqitemid` (`ReqItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `maps` */

DROP TABLE IF EXISTS `maps`;

CREATE TABLE `maps` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `File` varchar(128) NOT NULL,
  `MaxPlayers` tinyint(3) unsigned NOT NULL DEFAULT '6',
  `ReqLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Upgrade` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Staff` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `PvP` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8;

/*Table structure for table `maps_cells` */

DROP TABLE IF EXISTS `maps_cells`;

CREATE TABLE `maps_cells` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `MapID` int(11) unsigned NOT NULL,
  `Frame` varchar(16) NOT NULL,
  `Pad` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_MAPID` (`MapID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

/*Table structure for table `maps_items` */

DROP TABLE IF EXISTS `maps_items`;

CREATE TABLE `maps_items` (
  `MapID` int(11) unsigned NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`MapID`,`ItemID`),
  KEY `fk_mapitem_itemid` (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `maps_monsters` */

DROP TABLE IF EXISTS `maps_monsters`;

CREATE TABLE `maps_monsters` (
  `MapID` int(11) unsigned NOT NULL,
  `MonsterID` int(11) unsigned NOT NULL,
  `MonMapID` int(11) unsigned NOT NULL,
  `Frame` varchar(16) NOT NULL,
  PRIMARY KEY (`MapID`,`MonsterID`,`MonMapID`,`Frame`),
  KEY `fk_mapmonsters_monid` (`MonsterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `monsters` */

DROP TABLE IF EXISTS `monsters`;

CREATE TABLE `monsters` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(16) NOT NULL,
  `Race` varchar(16) NOT NULL,
  `File` varchar(128) NOT NULL,
  `Linkage` varchar(32) NOT NULL,
  `Element` varchar(8) NOT NULL,
  `Level` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `Health` int(11) unsigned NOT NULL DEFAULT '1000',
  `Mana` int(11) unsigned NOT NULL DEFAULT '100',
  `Gold` int(11) unsigned NOT NULL DEFAULT '100',
  `Experience` int(11) unsigned NOT NULL DEFAULT '100',
  `Reputation` int(11) unsigned NOT NULL DEFAULT '100',
  `DPS` int(11) unsigned NOT NULL DEFAULT '100',
  `TeamID` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9008 DEFAULT CHARSET=utf8;

/*Table structure for table `monsters_drops` */

DROP TABLE IF EXISTS `monsters_drops`;

CREATE TABLE `monsters_drops` (
  `MonsterID` int(11) unsigned NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  `Chance` decimal(7,2) unsigned NOT NULL DEFAULT '1.00',
  `Quantity` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`MonsterID`,`ItemID`),
  KEY `fk_mondrops_itemid` (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `quests` */

DROP TABLE IF EXISTS `quests`;

CREATE TABLE `quests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `FactionID` int(11) unsigned NOT NULL DEFAULT '1',
  `ReqReputation` int(11) unsigned NOT NULL DEFAULT '0',
  `ReqClassID` int(11) unsigned NOT NULL DEFAULT '0',
  `ReqClassPoints` int(11) unsigned NOT NULL DEFAULT '0',
  `Name` varchar(64) NOT NULL,
  `Description` text NOT NULL,
  `EndText` text NOT NULL,
  `Experience` int(11) unsigned NOT NULL DEFAULT '0',
  `Gold` int(11) unsigned NOT NULL DEFAULT '0',
  `Reputation` int(11) unsigned NOT NULL DEFAULT '0',
  `ClassPoints` int(11) unsigned NOT NULL DEFAULT '0',
  `RewardType` char(1) NOT NULL DEFAULT 'S',
  `Level` tinyint(3) NOT NULL DEFAULT '1',
  `Upgrade` tinyint(1) NOT NULL DEFAULT '0',
  `Once` tinyint(1) NOT NULL DEFAULT '0',
  `Slot` int(11) NOT NULL DEFAULT '-1',
  `Value` int(11) unsigned NOT NULL DEFAULT '0',
  `Field` char(3) NOT NULL DEFAULT '',
  `Index` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `fk_quests_factionid` (`FactionID`),
  KEY `fk_quests_classid` (`ReqClassID`)
) ENGINE=InnoDB AUTO_INCREMENT=110002 DEFAULT CHARSET=utf8;

/*Table structure for table `quests_locations` */

DROP TABLE IF EXISTS `quests_locations`;

CREATE TABLE `quests_locations` (
  `QuestID` int(11) NOT NULL,
  `MapID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`QuestID`,`MapID`),
  KEY `fk_quesloc_mapid` (`MapID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `quests_requirements` */

DROP TABLE IF EXISTS `quests_requirements`;

CREATE TABLE `quests_requirements` (
  `QuestID` int(11) NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  `Quantity` int(11) DEFAULT '1',
  PRIMARY KEY (`QuestID`,`ItemID`),
  KEY `fk_questreq_itemid` (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `quests_rewards` */

DROP TABLE IF EXISTS `quests_rewards`;

CREATE TABLE `quests_rewards` (
  `QuestID` int(11) NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  `Quantity` int(11) unsigned NOT NULL DEFAULT '1',
  KEY `fk_questrewards_questid` (`QuestID`),
  KEY `fk_questrewards_itemid` (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `servers` */

DROP TABLE IF EXISTS `servers`;

CREATE TABLE `servers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL DEFAULT 'Server',
  `IP` char(15) NOT NULL DEFAULT '0.0.0.0',
  `Online` tinyint(1) NOT NULL DEFAULT '0',
  `Upgrade` tinyint(1) NOT NULL DEFAULT '0',
  `Chat` tinyint(1) NOT NULL DEFAULT '2',
  `Count` mediumint(4) NOT NULL DEFAULT '0',
  `Max` mediumint(4) NOT NULL DEFAULT '500',
  `MOTD` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Table structure for table `settings_login` */

DROP TABLE IF EXISTS `settings_login`;

CREATE TABLE `settings_login` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `value` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `settings_rates` */

DROP TABLE IF EXISTS `settings_rates`;

CREATE TABLE `settings_rates` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `value` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `shops` */

DROP TABLE IF EXISTS `shops`;

CREATE TABLE `shops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `House` tinyint(1) NOT NULL DEFAULT '0',
  `Upgrade` tinyint(1) NOT NULL DEFAULT '0',
  `Staff` tinyint(1) NOT NULL DEFAULT '0',
  `Limited` tinyint(1) NOT NULL DEFAULT '0',
  `Field` varchar(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32768 DEFAULT CHARSET=utf8;

/*Table structure for table `shops_items` */

DROP TABLE IF EXISTS `shops_items`;

CREATE TABLE `shops_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ShopID` int(11) NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  `QuantityRemain` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_shopitems_shopid` (`ShopID`),
  KEY `fk_shopitems_itemid` (`ItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=6649 DEFAULT CHARSET=utf8;

/*Table structure for table `shops_locations` */

DROP TABLE IF EXISTS `shops_locations`;

CREATE TABLE `shops_locations` (
  `ShopID` int(11) NOT NULL,
  `MapID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`ShopID`,`MapID`),
  KEY `fk_shoploc_mapid` (`MapID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `skills` */

DROP TABLE IF EXISTS `skills`;

CREATE TABLE `skills` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ItemID` int(11) unsigned NOT NULL,
  `AuraID` int(11) unsigned NOT NULL,
  `Name` varchar(32) NOT NULL,
  `Animation` varchar(64) NOT NULL,
  `Description` text NOT NULL,
  `Damage` decimal(7,2) NOT NULL DEFAULT '1.00',
  `Mana` smallint(3) NOT NULL,
  `Icon` varchar(32) NOT NULL,
  `Range` smallint(3) unsigned NOT NULL DEFAULT '808',
  `Dsrc` varchar(16) NOT NULL,
  `Reference` char(2) NOT NULL,
  `Target` char(1) NOT NULL,
  `Effects` char(1) NOT NULL,
  `Type` varchar(7) NOT NULL,
  `Strl` varchar(32) NOT NULL,
  `Cooldown` int(11) unsigned NOT NULL,
  `HitTargets` tinyint(2) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_skills_auraid` (`AuraID`),
  KEY `fk_skills_classid` (`ItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=1436 DEFAULT CHARSET=utf8;

/*Table structure for table `skills_auras` */

DROP TABLE IF EXISTS `skills_auras`;

CREATE TABLE `skills_auras` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `Duration` tinyint(2) NOT NULL DEFAULT '6',
  `Category` varchar(8) NOT NULL,
  `DamageIncrease` decimal(7,2) NOT NULL DEFAULT '0.00',
  `DamageTakenDecrease` decimal(7,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

/*Table structure for table `skills_auras_effects` */

DROP TABLE IF EXISTS `skills_auras_effects`;

CREATE TABLE `skills_auras_effects` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `AuraID` int(11) unsigned NOT NULL,
  `Stat` char(3) NOT NULL,
  `Value` decimal(7,2) NOT NULL DEFAULT '0.00',
  `Type` char(1) NOT NULL DEFAULT '+',
  PRIMARY KEY (`id`),
  KEY `fk_auraeffects_auraid` (`AuraID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `Hash` char(17) NOT NULL,
  `HairID` int(11) unsigned NOT NULL,
  `Access` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `ActivationFlag` tinyint(1) unsigned NOT NULL DEFAULT '5',
  `PermamuteFlag` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Country` char(2) NOT NULL DEFAULT 'xx',
  `Age` tinyint(2) unsigned NOT NULL,
  `Gender` char(1) NOT NULL,
  `Email` varchar(64) NOT NULL,
  `Level` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Gold` int(11) unsigned NOT NULL DEFAULT '0',
  `Coins` int(11) unsigned NOT NULL DEFAULT '0',
  `Exp` int(11) unsigned NOT NULL DEFAULT '0',
  `ColorHair` char(6) NOT NULL DEFAULT '000000',
  `ColorSkin` char(6) NOT NULL DEFAULT '000000',
  `ColorEye` char(6) NOT NULL DEFAULT '000000',
  `ColorBase` char(6) NOT NULL DEFAULT '000000',
  `ColorTrim` char(6) NOT NULL DEFAULT '000000',
  `ColorAccessory` char(6) NOT NULL DEFAULT '000000',
  `SlotsBag` smallint(5) unsigned NOT NULL DEFAULT '40',
  `SlotsBank` smallint(5) unsigned NOT NULL DEFAULT '0',
  `SlotsHouse` smallint(5) unsigned NOT NULL DEFAULT '20',
  `DateCreated` datetime NOT NULL,
  `LastLogin` datetime NOT NULL,
  `CpBoostExpire` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `RepBoostExpire` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `GoldBoostExpire` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `ExpBoostExpire` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `UpgradeExpire` datetime NOT NULL,
  `UpgradeDays` smallint(3) NOT NULL DEFAULT '0',
  `Upgraded` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Achievement` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Settings` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Quests` char(100) NOT NULL DEFAULT '0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
  `Quests2` char(100) NOT NULL DEFAULT '0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
  `DailyQuests0` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DailyQuests1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DailyQuests2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `MonthlyQuests0` smallint(5) unsigned NOT NULL DEFAULT '0',
  `LastArea` varchar(64) NOT NULL DEFAULT 'faroff-1|Enter|Spawn',
  `CurrentServer` varchar(16) NOT NULL DEFAULT 'Offline',
  `HouseInfo` text NOT NULL,
  `KillCount` int(10) unsigned NOT NULL DEFAULT '0',
  `DeathCount` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_users_hairid` (`HairID`)
) ENGINE=InnoDB AUTO_INCREMENT=275878 DEFAULT CHARSET=utf8;

/*Table structure for table `users_factions` */

DROP TABLE IF EXISTS `users_factions`;

CREATE TABLE `users_factions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int(11) unsigned NOT NULL,
  `FactionID` int(11) unsigned NOT NULL,
  `Reputation` mediumint(6) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UserID` (`UserID`,`FactionID`),
  KEY `fk_userfactions_factionid` (`FactionID`)
) ENGINE=InnoDB AUTO_INCREMENT=673818 DEFAULT CHARSET=utf8;

/*Table structure for table `users_friends` */

DROP TABLE IF EXISTS `users_friends`;

CREATE TABLE `users_friends` (
  `UserID` int(11) unsigned NOT NULL,
  `FriendID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`UserID`,`FriendID`),
  KEY `fk_friends_friendid` (`FriendID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `users_guilds` */

DROP TABLE IF EXISTS `users_guilds`;

CREATE TABLE `users_guilds` (
  `GuildID` int(11) unsigned NOT NULL,
  `UserID` int(11) unsigned NOT NULL,
  `Rank` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`GuildID`,`UserID`),
  KEY `fk_userguilds_userid` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `users_items` */

DROP TABLE IF EXISTS `users_items`;

CREATE TABLE `users_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int(11) unsigned NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  `EnhID` int(11) unsigned NOT NULL,
  `Equipped` tinyint(1) unsigned NOT NULL,
  `Quantity` mediumint(6) unsigned NOT NULL,
  `Bank` tinyint(1) unsigned NOT NULL,
  `DatePurchased` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid_itemid` (`ItemID`,`UserID`),
  KEY `fk_useritems_enhid` (`EnhID`),
  KEY `fk_useritems_userid` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=5143724 DEFAULT CHARSET=utf8;

/*Table structure for table `users_logs` */

DROP TABLE IF EXISTS `users_logs`;

CREATE TABLE `users_logs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int(11) unsigned NOT NULL,
  `Violation` varchar(64) NOT NULL,
  `Details` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_userlogs_userid` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/* Trigger structure for table `guilds` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
