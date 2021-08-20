-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: gigih_microblog
-- ------------------------------------------------------
-- Server version	8.0.25-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `hashtags`
--

DROP TABLE IF EXISTS `hashtags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hashtags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `name` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `hashtags_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hashtags`
--

LOCK TABLES `hashtags` WRITE;
/*!40000 ALTER TABLE `hashtags` DISABLE KEYS */;
INSERT INTO `hashtags` VALUES (1,5,'#gigih','2021-08-16 01:33:34'),(2,6,'#yabb','2021-08-16 01:33:34'),(3,7,'#yabb','2021-08-16 01:33:34'),(4,8,'#gigih','2021-08-11 01:33:34'),(5,9,'#gigih','2021-08-13 01:33:34'),(6,10,'#gigih','2021-08-13 01:33:34'),(7,11,'#gigih','2021-08-13 01:33:34'),(8,54,'#gigih','2021-08-17 01:04:55'),(9,54,'#bisa','2021-08-17 01:04:55'),(10,57,'#oi','2021-08-17 01:50:47'),(11,58,'#oi','2021-08-17 01:52:17'),(12,59,'#oi','2021-08-17 01:53:09'),(13,64,'#oi','2021-08-17 01:54:18'),(14,65,'#HeHeHe','2021-08-17 01:54:32'),(15,66,'#HeHeHe','2021-08-17 01:57:37'),(16,67,'#HeHeHe','2021-08-17 01:57:38'),(17,68,'#HeHeHe','2021-08-17 01:57:45'),(18,69,'#HeHeHe','2021-08-17 01:57:46'),(19,70,'#HeHeHe','2021-08-17 01:57:46'),(20,77,'#ABC','2021-08-17 01:58:42'),(21,78,'#ABC','2021-08-17 01:58:43'),(22,79,'#ABC','2021-08-17 01:58:44'),(23,80,'#ABC','2021-08-17 02:00:17'),(24,81,'#ABC','2021-08-17 02:00:23'),(25,82,'#ABC','2021-08-17 02:00:25'),(26,83,'#ABC','2021-08-17 02:00:27'),(27,84,'#ABC','2021-08-17 02:00:47'),(28,85,'#ABC','2021-08-17 02:00:49'),(29,86,'#ABC','2021-08-17 02:02:54'),(30,87,'#ABC','2021-08-17 02:02:57'),(31,88,'#ABC','2021-08-17 02:03:06'),(32,88,'#HEhehe','2021-08-17 02:03:06'),(33,88,'#Babi','2021-08-17 02:03:06'),(34,89,'#ABC','2021-08-17 02:04:48'),(35,89,'#HEhehe','2021-08-17 02:04:48'),(36,89,'#Babi','2021-08-17 02:04:48'),(37,90,'#ABC','2021-08-17 02:04:51'),(38,90,'#HEhehe','2021-08-17 02:04:51'),(39,90,'#Babi','2021-08-17 02:04:51'),(40,91,'#ABC','2021-08-17 03:23:43'),(41,91,'#HEhehe','2021-08-17 03:23:43'),(42,91,'#Babi','2021-08-17 03:23:43'),(43,92,'#ABC','2021-08-17 03:24:55'),(44,92,'#HEhehe','2021-08-17 03:24:55'),(45,92,'#Babi','2021-08-17 03:24:55'),(46,121,'#GIGIH','2021-08-20 00:56:59'),(47,122,'#Gigih','2021-08-20 00:57:25'),(48,123,'#Gigih','2021-08-20 00:57:45'),(49,123,'#Bisa','2021-08-20 00:57:45'),(50,123,'#Bisa','2021-08-20 00:57:45'),(51,123,'#BISA','2021-08-20 00:57:45'),(52,123,'#bisa','2021-08-20 00:57:45'),(53,124,'#Gigih','2021-08-20 01:31:09'),(54,124,'#Bisa','2021-08-20 01:31:09'),(55,124,'#Bisa','2021-08-20 01:31:09'),(56,124,'#BISA','2021-08-20 01:31:09'),(57,124,'#bisa','2021-08-20 01:31:09'),(58,125,'#Gigih','2021-08-20 01:31:24'),(59,125,'#Bisa','2021-08-20 01:31:24'),(60,125,'#Bisa','2021-08-20 01:31:24'),(61,125,'#BISA','2021-08-20 01:31:24'),(62,125,'#bisa','2021-08-20 01:31:24'),(63,126,'#Gigih','2021-08-20 01:53:21'),(64,126,'#Bisa','2021-08-20 01:53:21'),(65,126,'#Bisa','2021-08-20 01:53:21'),(66,126,'#BISA','2021-08-20 01:53:21'),(67,126,'#bisa','2021-08-20 01:53:21'),(68,129,'#Gigih','2021-08-20 02:42:08'),(69,129,'#Bisa','2021-08-20 02:42:08'),(70,129,'#Bisa','2021-08-20 02:42:08'),(71,129,'#BISA','2021-08-20 02:42:08'),(72,129,'#bisa','2021-08-20 02:42:08'),(73,130,'#Gigih','2021-08-20 02:42:29'),(74,130,'#Bisa','2021-08-20 02:42:29'),(75,130,'#Bisa','2021-08-20 02:42:29'),(76,130,'#BISA','2021-08-20 02:42:29'),(77,130,'#bisa','2021-08-20 02:42:29'),(78,131,'#Gigih','2021-08-20 02:47:43'),(79,131,'#Bisa','2021-08-20 02:47:43'),(80,131,'#Bisa','2021-08-20 02:47:43'),(81,131,'#BISA','2021-08-20 02:47:43'),(82,131,'#bisa','2021-08-20 02:47:43'),(83,136,'#gigih','2021-08-20 04:01:21'),(84,136,'#bisa','2021-08-20 04:01:21'),(85,137,'#gigih','2021-08-20 04:01:33'),(86,137,'#bisa','2021-08-20 04:01:33'),(87,138,'#gigih','2021-08-20 04:05:07'),(88,138,'#bisa','2021-08-20 04:05:07'),(89,139,'#gigih','2021-08-20 05:18:18'),(90,139,'#bisa','2021-08-20 05:18:18'),(91,140,'#gigih','2021-08-20 13:37:39'),(92,140,'#bisa','2021-08-20 13:37:39');
/*!40000 ALTER TABLE `hashtags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `parent_id` int DEFAULT NULL,
  `text_content` text NOT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,NULL,'Hello World!',NULL,'2021-08-16 01:33:34'),(2,2,1,'Hello Gas!',NULL,'2021-08-16 01:33:34'),(3,3,NULL,'Huft!',NULL,'2021-08-16 01:33:34'),(4,2,3,'kenapa kamu?',NULL,'2021-08-16 01:33:34'),(5,1,NULL,'Semangat! #gigih',NULL,'2021-08-16 01:33:34'),(6,1,NULL,'Go! #yabb',NULL,'2021-08-16 01:33:34'),(7,2,6,'GoGoGo! #yabb',NULL,'2021-08-16 01:33:34'),(8,2,NULL,'ayo boy!!! #gigih',NULL,'2021-08-11 01:33:34'),(9,3,NULL,'ayo gengs!!! #gigih',NULL,'2021-08-13 01:33:34'),(10,1,NULL,'KUY!!! #gigih',NULL,'2021-08-13 01:33:34'),(11,1,10,'oke bro #gigih',NULL,'2021-08-13 01:33:34'),(12,1,NULL,'coba coba',NULL,'2021-08-16 23:41:09'),(13,1,NULL,'coba coba',NULL,'2021-08-16 23:42:06'),(14,1,NULL,'coba coba',NULL,'2021-08-16 23:44:46'),(15,1,14,'coba coba',NULL,'2021-08-16 23:45:36'),(16,1,14,'coba coba',NULL,'2021-08-16 23:50:16'),(17,1,14,'coba coba',NULL,'2021-08-16 23:53:50'),(18,1,14,'coba coba',NULL,'2021-08-16 23:53:59'),(19,1,14,'coba coba',NULL,'2021-08-16 23:54:01'),(20,1,NULL,'coba coba',NULL,'2021-08-16 23:54:06'),(21,1,NULL,'coba coba',NULL,'2021-08-16 23:54:47'),(22,1,14,'coba coba',NULL,'2021-08-16 23:54:50'),(23,1,NULL,'coba coba',NULL,'2021-08-16 23:54:54'),(24,1,NULL,'coba coba',NULL,'2021-08-16 23:54:58'),(25,1,NULL,'coba coba',NULL,'2021-08-16 23:54:58'),(26,1,14,'coba coba',NULL,'2021-08-16 23:55:12'),(27,1,14,'coba coba',NULL,'2021-08-16 23:55:13'),(28,1,14,'coba coba',NULL,'2021-08-16 23:55:15'),(29,1,14,'coba coba',NULL,'2021-08-16 23:58:18'),(30,1,14,'coba coba',NULL,'2021-08-16 23:58:19'),(31,1,14,'coba coba',NULL,'2021-08-16 23:58:24'),(32,1,14,'coba coba',NULL,'2021-08-16 23:58:58'),(33,1,14,'coba coba','sdasdw','2021-08-16 23:59:48'),(34,1,14,'coba coba',NULL,'2021-08-16 23:59:53'),(35,1,NULL,'coba coba',NULL,'2021-08-16 23:59:57'),(36,1,NULL,'coba coba','sdasdw','2021-08-17 00:00:00'),(37,1,14,'coba coba',NULL,'2021-08-17 00:00:04'),(38,1,14,'coba coba',NULL,'2021-08-17 00:02:16'),(39,1,14,'coba coba',NULL,'2021-08-17 00:02:22'),(40,1,14,'coba coba','sdasdw','2021-08-17 00:02:34'),(41,1,14,'coba coba','sdasdw','2021-08-17 00:03:05'),(42,1,14,'coba coba','sdasdw','2021-08-17 00:03:06'),(43,1,14,'coba coba','sdasdw','2021-08-17 00:03:09'),(44,1,14,'coba coba','sdasdw','2021-08-17 00:03:10'),(45,1,14,'coba coba','sdasdw','2021-08-17 00:24:57'),(46,1,14,'coba coba #gigih','sdasdw','2021-08-17 00:25:12'),(47,1,14,'coba coba #gigih #bisa','sdasdw','2021-08-17 00:25:19'),(48,1,14,'coba coba #gigih #bisa','sdasdw','2021-08-17 00:57:09'),(49,1,14,'coba coba #gigih #bisa','sdasdw','2021-08-17 00:59:10'),(50,1,14,'coba coba #gigih #bisa','sdasdw','2021-08-17 01:00:02'),(51,1,14,'coba coba #gigih #bisa','sdasdw','2021-08-17 01:00:30'),(52,1,14,'coba coba #gigih #bisa','sdasdw','2021-08-17 01:03:55'),(53,1,14,'coba coba #gigih #bisa','sdasdw','2021-08-17 01:04:35'),(54,1,14,'coba coba #gigih #bisa','sdasdw','2021-08-17 01:04:55'),(55,2,5,'Gas Gimana gas?','sdasdw','2021-08-17 01:50:03'),(56,2,5,'Gas Gimana gas? #oi','sdasdw','2021-08-17 01:50:30'),(57,2,5,'Gas Gimana gas? #oi','sdasdw','2021-08-17 01:50:47'),(58,2,5,'Gas Gimana gas? #oi','sdasdw','2021-08-17 01:52:17'),(59,2,5,'Gas Gimana gas? #oi','sdasdw','2021-08-17 01:53:09'),(60,2,5,'Gas Gimana gas? #oi','sdasdw','2021-08-17 01:53:27'),(61,2,5,'Gas Gimana gas? #oi','sdasdw','2021-08-17 01:53:34'),(62,2,5,'Gas Gimana gas? #oi','sdasdw','2021-08-17 01:53:34'),(63,2,5,'Gas Gimana gas? #oi','sdasdw','2021-08-17 01:53:34'),(64,2,5,'Gas Gimana gas? #oi','sdasdw','2021-08-17 01:54:18'),(65,2,5,'HALOOOO!!! #HeHeHe','sdasdw','2021-08-17 01:54:32'),(66,2,5,'HALOOOO!!! #HeHeHe','sdasdw','2021-08-17 01:57:37'),(67,2,5,'HALOOOO!!! #HeHeHe','sdasdw','2021-08-17 01:57:38'),(68,2,5,'HALOOOO!!! #HeHeHe','sdasdw','2021-08-17 01:57:45'),(69,2,5,'HALOOOO!!! #HeHeHe','sdasdw','2021-08-17 01:57:46'),(70,2,5,'HALOOOO!!! #HeHeHe','sdasdw','2021-08-17 01:57:46'),(71,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 01:58:12'),(72,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 01:58:12'),(73,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 01:58:13'),(74,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 01:58:14'),(75,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 01:58:29'),(76,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 01:58:29'),(77,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 01:58:42'),(78,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 01:58:43'),(79,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 01:58:44'),(80,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 02:00:17'),(81,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 02:00:23'),(82,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 02:00:25'),(83,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 02:00:27'),(84,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 02:00:47'),(85,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 02:00:49'),(86,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 02:02:54'),(87,2,5,'HALOOOO!!! #ABC','sdasdw','2021-08-17 02:02:57'),(88,2,5,'HALOOOO!!! #ABC #HEhehe #Babi','sdasdw','2021-08-17 02:03:06'),(89,2,5,'HALOOOO!!! #ABC #HEhehe #Babi','sdasdw','2021-08-17 02:04:48'),(90,2,5,'HALOOOO!!! #ABC #HEhehe #Babi','sdasdw','2021-08-17 02:04:51'),(91,2,5,'HALOOOO!!! #ABC #HEhehe #Babi','sdasdw','2021-08-17 03:23:43'),(92,2,5,'HALOOOO!!! #ABC #HEhehe #Babi','sdasdw','2021-08-17 03:24:54'),(93,1,NULL,'Halooo','./public/sepatuhitam.jpg-202092-52250.jpg','2021-08-19 20:48:57'),(94,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 20:53:07'),(95,1,NULL,'Halooo!!!','files/sepatuhitam.jpg-202092-52250.jpg','2021-08-19 21:08:56'),(96,1,NULL,'Halooo!!!','files/sepatuhitam.jpg-202092-52250.jpg','2021-08-19 21:25:22'),(97,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 21:25:31'),(98,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 21:47:27'),(99,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 21:47:38'),(100,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 21:49:14'),(101,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 21:49:17'),(102,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 22:01:27'),(103,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 22:01:28'),(104,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 22:01:29'),(105,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 22:19:29'),(106,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 22:20:01'),(107,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 22:21:40'),(108,1,NULL,'Halooo!!!',NULL,'2021-08-19 22:21:53'),(109,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 22:21:57'),(110,1,NULL,'Halooo!!!',NULL,'2021-08-19 22:21:59'),(111,1,NULL,'Halooo!!!',NULL,'2021-08-19 22:22:34'),(112,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 22:22:36'),(113,1,NULL,'Halooo!!!',NULL,'2021-08-19 22:22:38'),(114,1,NULL,'Halooo!!!',NULL,'2021-08-19 22:23:49'),(115,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 22:23:52'),(116,1,NULL,'Halooo!!!','sepatuhitam.jpg-202092-52250.jpg','2021-08-19 22:24:07'),(117,1,NULL,'Halo bos!',NULL,'2021-08-20 00:44:10'),(118,1,1,'Halo bos!','Bagas.png','2021-08-20 00:44:37'),(119,1,1,'Halo bos!','Bagas.png','2021-08-20 00:46:51'),(120,1,1,'Halo bos!','Bagas.png','2021-08-20 00:56:51'),(121,1,1,'Halo bos! #GIGIH','Bagas.png','2021-08-20 00:56:59'),(122,2,121,'Halo Pak! #Gigih','Bagas.png','2021-08-20 00:57:25'),(123,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa','Bagas.png','2021-08-20 00:57:45'),(124,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa','Bagas.png','2021-08-20 01:31:09'),(125,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa','Bagas.png','2021-08-20 01:31:24'),(126,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa','Bagas.png','2021-08-20 01:53:21'),(127,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa','Bagas.png','2021-08-20 02:41:11'),(128,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa','Bagas.png','2021-08-20 02:41:51'),(129,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa','Bagas.png','2021-08-20 02:42:08'),(130,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa','Bagas.png','2021-08-20 02:42:29'),(131,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa','Bagas.png','2021-08-20 02:47:43'),(132,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa','Bagas.png','2021-08-20 03:32:29'),(133,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa','Bagas.png','2021-08-20 03:48:29'),(134,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa','Bagas.png','2021-08-20 03:49:04'),(135,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa','Bagas.png','2021-08-20 04:00:10'),(136,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa','Bagas.png','2021-08-20 04:01:21'),(137,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa #Gigih','Bagas.png','2021-08-20 04:01:33'),(138,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa #Gigih','Bagas.png','2021-08-20 04:05:07'),(139,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa #Gigih','Bagas.png','2021-08-20 05:18:18'),(140,2,121,'Halo Pak! #Gigih #Bisa #Bisa #BISA #bisa #Gigih','Bagas.png','2021-08-20 13:37:39');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `bio` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'bagasys','bagasys@gmail.com',NULL,'2021-08-16 01:33:34'),(2,'naufalrdj','naufalrdj@gmail.com',NULL,'2021-08-16 01:33:34'),(3,'larasij','larasij@gmail.com',NULL,'2021-08-16 01:33:34'),(4,'john','john@gmail.com','I am John, Hi!','2021-08-16 16:12:02'),(5,'johndoe','johndoe@gmail.com','Hai!','2021-08-17 23:10:16'),(7,'aaa','bbb@gmail.com','Hai!','2021-08-19 20:47:54'),(8,'babi123','babi123@gmail.com','','2021-08-20 00:13:37'),(10,'babi1234','babi1234@gmail.com','Haloo!!!','2021-08-20 00:14:00'),(11,'babi12345','babi12345@gmail.com','Haloo!!! HAI!!!!','2021-08-20 00:14:53'),(15,'babi12','babi12@gmail.com','Haloo!!! HAI!!!!','2021-08-20 05:06:50'),(16,'hahaaha','hahaaha@gmail.com','Haloo!!! HAI!!!!','2021-08-20 05:15:42'),(17,'asd','asd@gmail.com','Haloo!!! HAI!!!!','2021-08-20 05:17:36');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-21  1:47:42
