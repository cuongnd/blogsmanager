/*
MySQL Backup
Database: homestead
Backup Time: 2021-11-05 01:04:31
*/

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `failed_jobs`;
DROP TABLE IF EXISTS `jobs`;
DROP TABLE IF EXISTS `media`;
DROP TABLE IF EXISTS `migrations`;
DROP TABLE IF EXISTS `password_resets`;
DROP TABLE IF EXISTS `posts`;
DROP TABLE IF EXISTS `role_user`;
DROP TABLE IF EXISTS `roles`;
DROP TABLE IF EXISTS `users`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_reserved_at_index` (`queue`,`reserved_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `media` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  `collection_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `manipulations` json NOT NULL,
  `custom_properties` json NOT NULL,
  `responsive_images` json NOT NULL,
  `posted_at` datetime NOT NULL,
  `order_column` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conversions_disk` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `media_model_type_model_id_index` (`model_type`,`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `posted_at` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `thumbnail_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`),
  KEY `posts_author_id_foreign` (`author_id`),
  KEY `posts_title_index` (`title`),
  KEY `posts_thumbnail_id_foreign` (`thumbnail_id`),
  CONSTRAINT `posts_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `posts_thumbnail_id_foreign` FOREIGN KEY (`thumbnail_id`) REFERENCES `media` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `role_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_user_user_id_foreign` (`user_id`),
  KEY `role_user_role_id_foreign` (`role_id`),
  CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registered_at` datetime DEFAULT NULL,
  `api_token` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_provider_id_unique` (`provider_id`),
  UNIQUE KEY `users_api_token_unique` (`api_token`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
BEGIN;
LOCK TABLES `failed_jobs` WRITE;
DELETE FROM `failed_jobs`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `jobs` WRITE;
DELETE FROM `jobs`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `media` WRITE;
DELETE FROM `media`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `migrations` WRITE;
DELETE FROM `migrations`;
INSERT INTO `migrations` (`id`,`migration`,`batch`) VALUES (1, '2014_10_12_000000_create_users_table', 1),(2, '2014_10_12_100000_create_password_resets_table', 1),(3, '2016_12_19_080506_create_posts_table', 1),(4, '2016_12_19_201351_create_comments_table', 1),(5, '2016_12_30_125504_create_newsletter_subscriptions_table', 1),(6, '2016_12_30_171448_create_jobs_table', 1),(7, '2017_01_08_205244_add_provider_and_provider_id_to_users', 1),(8, '2017_01_09_191917_update_email_and_password_to_nullable_to_users', 1),(9, '2017_01_23_210625_create_roles_table', 1),(10, '2017_01_29_003732_add_registered_at_to_users_table', 1),(11, '2017_03_12_213124_create_media_table', 1),(12, '2017_03_19_102521_add_thumbnail_id_to_posts_table', 1),(13, '2017_03_25_194948_add_api_token_to_users_table', 1),(14, '2017_04_16_092512_add_slug_to_posts', 1),(15, '2017_11_14_001056_add_index_on_title_to_posts', 1),(16, '2017_11_15_003340_create_likes_table', 1),(17, '2018_03_22_214952_drop_media_table', 1),(18, '2018_03_22_215224_create_media_table_with_media_library', 1),(19, '2018_03_22_230046_create_media_libraries_table', 1),(20, '2018_08_08_100000_create_telescope_entries_table', 1),(21, '2018_09_05_220100_add_email_verified_at_to_users', 1),(22, '2019_09_09_000456_create_failed_jobs_table', 1),(23, '2020_10_06_231328_add_fields_to_media', 1);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `password_resets` WRITE;
DELETE FROM `password_resets`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `posts` WRITE;
DELETE FROM `posts`;
INSERT INTO `posts` (`id`,`author_id`,`title`,`slug`,`content`,`posted_at`,`created_at`,`updated_at`,`thumbnail_id`) VALUES (1, 1, 'sdfsdfds', 'hello-world', '<p>sdfdsfds</p>', '2021-11-04 14:27:00', '2021-11-04 14:27:59', '2021-11-04 19:00:37', NULL),(2, 1, 'sdfsdfsd', 'sdfsdfsd-839', '<p>sdfsdfsddsdfsfdsfds</p>', '2021-11-04 01:48:00', '2021-11-04 17:50:00', '2021-11-04 17:50:16', NULL),(3, 1, 'sdfdsfdssdfsdfds', 'sdfdsfdssdfsdfds-518', '<p>sdfsdfsdfdsfdssdfsd</p>', '2021-12-02 04:55:00', '2021-11-04 17:50:40', '2021-11-04 17:50:40', NULL),(4, 2, 'asdsadsa', 'asdsadsa-1500', '<p>asdsadasdas</p>', '2021-12-05 04:56:00', '2021-11-04 17:51:33', '2021-11-04 17:51:33', NULL),(5, 1, 'sdfsdf', 'sdfsdf-577', '<p>sdfsdfdsczxczxc</p>', '2021-12-03 05:41:00', '2021-11-04 18:36:58', '2021-11-04 18:36:58', NULL),(7, 2, 'asdasdsa', 'asdasdsa-899', '<p>asdasdsaasdas</p>', '2021-11-27 05:55:00', '2021-11-04 18:50:42', '2021-11-04 18:50:42', NULL);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `role_user` WRITE;
DELETE FROM `role_user`;
INSERT INTO `role_user` (`id`,`user_id`,`role_id`,`created_at`,`updated_at`) VALUES (1, 1, 2, '2021-11-04 14:27:59', '2021-11-04 14:27:59'),(2, 2, 1, '2021-11-04 14:34:47', '2021-11-04 14:34:47'),(5, 3, 1, '2021-11-04 17:56:51', '2021-11-04 17:56:51');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `roles` WRITE;
DELETE FROM `roles`;
INSERT INTO `roles` (`id`,`name`,`created_at`,`updated_at`) VALUES (1, 'editor', '2021-11-04 14:27:59', '2021-11-04 14:27:59'),(2, 'admin', '2021-11-04 14:27:59', '2021-11-04 14:27:59');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `users` WRITE;
DELETE FROM `users`;
INSERT INTO `users` (`id`,`name`,`email`,`password`,`remember_token`,`created_at`,`updated_at`,`provider`,`provider_id`,`registered_at`,`api_token`,`email_verified_at`) VALUES (1, 'cuong', 'cuongnd@gmail.com', '$2y$10$HnJUEsdKyoKiNbmWKImSse1VUXWDIN5f8bzIVXqguesn3osBCXzFe', 'R1Yke9oIWviVjWlu8U14ga6h1DqSjt32R2Fqs4FleCR883hHDJBGT26OR0O3', '2021-11-04 14:27:59', '2021-11-04 18:54:04', NULL, NULL, '2021-11-04 14:27:59', 'tkybnnflW170yXkyUwqYnIQ4jcMDBJuGGJhPgSJrs5prLA1WVNRiY6rHU0ca', '2021-11-04 14:27:59'),(2, 'cuong1', 'nguyen@gmail.com', '$2y$10$EqSLbRutBZaY9cwWu.oB/OfGAfJQAUxujM3e6tR7cPDuQzao/AICu', 'yp6mRC7RymoP63Ru4GYudKHWfri7Jo0NyVlqm0Z2ERu4aa7sr7jARB386uSr', '2021-11-04 14:33:12', '2021-11-04 18:52:59', NULL, NULL, '2021-11-04 14:33:12', 'pA5462AlFSpdq2K91IQTXH0kGW4XIO22IYTFQCszwsmG30ibAtAAPd6b880G', '2021-11-04 14:27:59'),(3, 'cuong2', 'cuong2@gmail.com', '$2y$10$0m1xqvGDuOoXuMzBFn8LxOftyjErMXw2HxBToGvUTjKBi6ObTOFwi', NULL, '2021-11-04 16:07:46', '2021-11-04 16:07:46', NULL, NULL, NULL, NULL, NULL);
UNLOCK TABLES;
COMMIT;
