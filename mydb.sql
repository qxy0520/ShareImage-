/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : mydb

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 27/04/2020 17:19:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `article_id` int NOT NULL AUTO_INCREMENT,
  `article_title` varchar(45) NOT NULL,
  `user_user_id` int NOT NULL,
  `article_content` mediumtext NOT NULL,
  `article_s_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `article_good` int NOT NULL DEFAULT '0',
  `article_collect` int NOT NULL DEFAULT '0',
  `article_comment` int NOT NULL DEFAULT '0',
  `article_e_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `category_category_id` int NOT NULL,
  `article_pic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`article_id`),
  UNIQUE KEY `article_id_UNIQUE` (`article_id`),
  KEY `fk_article_user1_idx` (`user_user_id`),
  KEY `fk_article_category1_idx` (`category_category_id`),
  CONSTRAINT `fk_article_category1` FOREIGN KEY (`category_category_id`) REFERENCES `category` (`category_id`),
  CONSTRAINT `fk_article_user1` FOREIGN KEY (`user_user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for attention
-- ----------------------------
DROP TABLE IF EXISTS `attention`;
CREATE TABLE `attention` (
  `attention_id` int NOT NULL AUTO_INCREMENT,
  `user_user_id` int NOT NULL,
  `attention_u` int NOT NULL,
  `attention_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`attention_id`),
  UNIQUE KEY `attention_u_UNIQUE` (`attention_u`),
  UNIQUE KEY `attention_id_UNIQUE` (`attention_id`),
  KEY `fk_attention_user_idx` (`user_user_id`),
  CONSTRAINT `fk_attention_user` FOREIGN KEY (`user_user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) NOT NULL,
  `category_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_id_UNIQUE` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect` (
  `user_user_id` int NOT NULL,
  `article_article_id` int NOT NULL,
  PRIMARY KEY (`user_user_id`,`article_article_id`),
  KEY `aid` (`article_article_id`),
  CONSTRAINT `aid` FOREIGN KEY (`article_article_id`) REFERENCES `article` (`article_id`),
  CONSTRAINT `uid` FOREIGN KEY (`user_user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `user_user_id` int NOT NULL,
  `article_article_id` int NOT NULL,
  `comment_parent` int DEFAULT NULL,
  `comment_content` mediumtext NOT NULL,
  `comment_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  UNIQUE KEY `comment_id_UNIQUE` (`comment_id`),
  KEY `fk_comment_user1_idx` (`user_user_id`),
  KEY `fk_comment_article1_idx` (`article_article_id`),
  CONSTRAINT `fk_comment_article1` FOREIGN KEY (`article_article_id`) REFERENCES `article` (`article_id`),
  CONSTRAINT `fk_comment_user1` FOREIGN KEY (`user_user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for fans
-- ----------------------------
DROP TABLE IF EXISTS `fans`;
CREATE TABLE `fans` (
  `user_user_id` int NOT NULL,
  `fans_id` int NOT NULL,
  `fans_u` int NOT NULL,
  `fans_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`fans_id`),
  UNIQUE KEY `fans_id_UNIQUE` (`fans_id`),
  UNIQUE KEY `fans_u_UNIQUE` (`fans_u`),
  KEY `fk_fans_user1_idx` (`user_user_id`),
  CONSTRAINT `fk_fans_user1` FOREIGN KEY (`user_user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for picture
-- ----------------------------
DROP TABLE IF EXISTS `picture`;
CREATE TABLE `picture` (
  `picture_id` int NOT NULL AUTO_INCREMENT,
  `picture_url` varchar(100) NOT NULL,
  `article_article_id` int NOT NULL,
  PRIMARY KEY (`picture_id`),
  UNIQUE KEY `picture_id_UNIQUE` (`picture_id`),
  KEY `fk_picture_article1_idx` (`article_article_id`),
  CONSTRAINT `fk_picture_article1` FOREIGN KEY (`article_article_id`) REFERENCES `article` (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for thomb
-- ----------------------------
DROP TABLE IF EXISTS `thomb`;
CREATE TABLE `thomb` (
  `user_user_id` int NOT NULL,
  `article_article_id` int NOT NULL,
  PRIMARY KEY (`user_user_id`,`article_article_id`) USING BTREE,
  KEY `article_article_id` (`article_article_id`),
  CONSTRAINT `article_article_id` FOREIGN KEY (`article_article_id`) REFERENCES `article` (`article_id`),
  CONSTRAINT `user_user_id` FOREIGN KEY (`user_user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for token
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tokens` text,
  `time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) NOT NULL,
  `user_password` varchar(32) NOT NULL,
  `user_email` varchar(45) NOT NULL,
  `user_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_if_email` tinyint NOT NULL DEFAULT '0',
  `user_icon` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username_UNIQUE` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Procedure structure for p_del_count
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_del_count`;
delimiter ;;
CREATE PROCEDURE `mydb`.`p_del_count`(IN `date_inter` INT)
BEGIN  
delete from token where (TO_DAYS(NOW()) - TO_DAYS(FROM_UNIXTIME(unix_timestamp(time),'%Y%m%d'))) >=date_inter;  
END
;;
delimiter ;

-- ----------------------------
-- Event structure for autodel
-- ----------------------------
DROP EVENT IF EXISTS `autodel`;
delimiter ;;
CREATE EVENT `mydb`.`autodel`
ON SCHEDULE
EVERY '1' DAY STARTS '2020-04-07 00:00:00'
DO call p_del_count (20)
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
