-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 08, 2025 at 01:06 PM
-- Server version: 9.1.0
-- PHP Version: 8.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stagging_inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL COMMENT '0=active, 1=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(5, 'Sweet', 1, '2025-03-13 03:23:24', '2025-04-16 21:56:31'),
(6, 'Meat', 1, '2025-03-13 03:23:41', '2025-04-16 21:56:59'),
(8, 'Fruits', 1, '2025-03-13 03:25:07', '2025-04-16 21:55:46'),
(9, 'Fish', 1, '2025-03-13 05:18:24', '2025-04-16 21:55:57'),
(11, 'Seeds', 1, '2025-04-21 21:17:00', '2025-04-21 21:17:00'),
(12, 'Oil', 1, '2025-04-21 21:17:29', '2025-04-21 21:17:29'),
(13, 'Spices', 1, '2025-04-21 21:48:59', '2025-04-21 21:48:59'),
(14, 'Household Essentials', 1, '2025-04-21 21:59:41', '2025-04-21 21:59:41'),
(15, 'resturant', 1, '2025-04-23 06:22:19', '2025-04-23 06:22:19'),
(16, 'Restureবে', 1, '2025-04-23 06:22:47', '2025-04-23 06:22:47'),
(17, 'Restuরেসটুরেস্ট', 1, '2025-04-30 01:01:06', '2025-04-30 01:01:06');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `company` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL COMMENT '0=active, 1=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `company`, `address`, `status`, `created_at`, `updated_at`) VALUES
(2, 'Milan', 'milan@gmail.com', '01736699819', 'ACI Limited', 'Mirpur\nBanani', 1, '2025-03-13 03:38:38', '2025-03-13 03:38:38'),
(4, 'test', 'abdulazizsajib@gmail.com', '01782521705', 'test', 'Merul Badda, Dhaka', 1, '2025-03-17 02:18:44', '2025-03-17 02:18:44');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_09_11_122523_create_personal_access_tokens_table', 1),
(5, '2024_09_11_122909_create_permission_tables', 1),
(6, '2024_10_21_113551_create_categories_table', 1),
(7, '2024_10_21_113612_create_sub_categories_table', 1),
(8, '2024_10_21_113635_create_suppliers_table', 1),
(9, '2024_10_21_114228_create_customers_table', 1),
(10, '2024_10_21_122628_create_products_table', 1),
(11, '2024_10_21_123349_create_sales_manage_table', 1),
(12, '2024_10_21_123404_create_sales_add_table', 1),
(13, '2024_10_21_123414_create_purchase_manage_table', 1),
(14, '2024_10_21_123424_create_purchase_add_table', 1),
(15, '2025_03_17_093045_create_product_pack_sizes_table', 2),
(16, '2025_03_17_093101_create_product_prices_table', 3),
(17, '2025_03_17_093112_create_product_images_table', 4),
(18, '2025_04_16_062825_create_purchases_table', 5),
(19, '2025_04_16_062831_create_purchase_products_table', 6),
(20, '2025_04_16_062838_create_purchase_bonus_products_table', 7);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 3);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'permissions', 'web', '2025-03-17 00:00:49', '2025-03-17 00:00:49'),
(3, 'roles', 'web', '2025-03-17 00:08:42', '2025-03-17 00:17:52');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'milan@gmail.com', 'b4154f7956aef52269025ebc69c0997b8ef4bc18f15ca25ef8009e3844802afd', '[\"*\"]', NULL, NULL, '2024-10-21 07:35:12', '2024-10-21 07:35:12'),
(2, 'App\\Models\\User', 1, 'milan@gmail.com', '4dfb80c9c1f89778a166f8d723e3e8eb71a31d39c8e29528c2ef21a772d0b1ce', '[\"*\"]', '2024-10-22 04:54:55', NULL, '2024-10-21 07:36:44', '2024-10-22 04:54:55'),
(3, 'App\\Models\\User', 1, 'milan@gmail.com', '48d6655e3037a16dca46f6e7fe889999920e076896e27af117d8edec94973a44', '[\"*\"]', NULL, NULL, '2024-10-22 01:57:11', '2024-10-22 01:57:11'),
(4, 'App\\Models\\User', 1, 'milan@gmail.com', '2a9eb5143fc4c670183deecf47d8c0f0dd0b792704b5f7e218506dd0575392d5', '[\"*\"]', NULL, NULL, '2024-10-22 01:58:31', '2024-10-22 01:58:31'),
(5, 'App\\Models\\User', 1, 'milan@gmail.com', '91b55abc3fd75578bad8fd5386be77204fcae6766d79959b76710c311599c87a', '[\"*\"]', NULL, NULL, '2024-10-22 02:04:33', '2024-10-22 02:04:33'),
(6, 'App\\Models\\User', 1, 'milan@gmail.com', '8dc7fb497e54dd9d35cfdcc9258a7a14d66162ae4ba363e6fd98cdf3def5937f', '[\"*\"]', NULL, NULL, '2024-10-22 02:06:01', '2024-10-22 02:06:01'),
(7, 'App\\Models\\User', 1, 'milan@gmail.com', '9784d7a70f2c122ab7202bf0804c8d3b779d3f2148d7c0b5ccb2d7e2ff40a7e7', '[\"*\"]', NULL, NULL, '2024-10-22 02:08:34', '2024-10-22 02:08:34'),
(8, 'App\\Models\\User', 1, 'milan@gmail.com', '9711ecdf1718baf53751d100bfa968c9f77fd1513783aa3a5b4a29fcaa7a99af', '[\"*\"]', NULL, NULL, '2024-10-22 02:09:05', '2024-10-22 02:09:05'),
(9, 'App\\Models\\User', 1, 'milan@gmail.com', 'acb7714d5d27a0506f50dc3c3a3a95e78fb392e3430f6c6f5576f0965edb94da', '[\"*\"]', NULL, NULL, '2024-10-22 02:10:28', '2024-10-22 02:10:28'),
(10, 'App\\Models\\User', 1, 'milan@gmail.com', 'f2677b68a3586aca9129edefab2a676438fe7a7840738af3399246a153b37723', '[\"*\"]', '2024-10-22 05:23:17', NULL, '2024-10-22 04:28:10', '2024-10-22 05:23:17'),
(11, 'App\\Models\\User', 1, 'milan@gmail.com', '94d6bcc44db5a4f1c0b7347c1b73d496d0ff2d9d48d7feb2e180dfdd3d57be21', '[\"*\"]', NULL, NULL, '2025-03-11 02:45:16', '2025-03-11 02:45:16'),
(12, 'App\\Models\\User', 1, 'milan@gmail.com', '78ffc12857af248b0c4c5140f084f141dd275f9f0aecd43c61e793c810cb0ab1', '[\"*\"]', '2025-03-11 23:59:46', NULL, '2025-03-11 23:59:45', '2025-03-11 23:59:46'),
(13, 'App\\Models\\User', 1, 'milan@gmail.com', 'c64062536614130753d231859cf652c34ba96f7e08096eefc6ea7b1dff86f1c8', '[\"*\"]', '2025-03-12 00:00:34', NULL, '2025-03-12 00:00:30', '2025-03-12 00:00:34'),
(14, 'App\\Models\\User', 1, 'milan@gmail.com', 'd7df6f9c9297d5edfc540d28e701953ecc977d158a2fe62ec041839420e05d4b', '[\"*\"]', '2025-03-12 00:02:25', NULL, '2025-03-12 00:02:21', '2025-03-12 00:02:25'),
(15, 'App\\Models\\User', 1, 'milan@gmail.com', '09b32d726bad8c4d9d525564221b9c40827f5286ae8fb9210d0bb6e40d9d4ce3', '[\"*\"]', '2025-03-12 01:52:59', NULL, '2025-03-12 00:02:25', '2025-03-12 01:52:59'),
(16, 'App\\Models\\User', 1, 'milan@gmail.com', '3f7efb9da0ca3a107393ae2fd451c261e7f45bc54a5a8fb6360bd500beb0cecf', '[\"*\"]', '2025-03-13 03:11:31', NULL, '2025-03-13 03:08:54', '2025-03-13 03:11:31'),
(17, 'App\\Models\\User', 1, 'milan@gmail.com', 'cc99887fea9195e216bdbf50823ae320c4dcef5efa528512b2f316f112b4f8eb', '[\"*\"]', '2025-03-13 03:13:44', NULL, '2025-03-13 03:11:42', '2025-03-13 03:13:44'),
(18, 'App\\Models\\User', 1, 'milan@gmail.com', 'ca7698aa454d4171ca080a2bd6dcdb459371679499165c916a8cb21ac82d2c74', '[\"*\"]', '2025-03-13 04:14:43', NULL, '2025-03-13 03:13:52', '2025-03-13 04:14:43'),
(19, 'App\\Models\\User', 1, 'milan@gmail.com', '9af26d9ad40cf050bcc317593114fde8ff9fd8913b1836288085e3c308252f46', '[\"*\"]', '2025-03-13 04:02:35', NULL, '2025-03-13 03:49:10', '2025-03-13 04:02:35'),
(20, 'App\\Models\\User', 1, 'milan@gmail.com', '0e21fc861ac10158f8036223f2a5af8918a50b6c3f0ae3a848f70679294c70e4', '[\"*\"]', '2025-03-13 04:07:09', NULL, '2025-03-13 04:07:07', '2025-03-13 04:07:09'),
(21, 'App\\Models\\User', 1, 'milan@gmail.com', '811acd12e0fb4a0a95af16cae7c1caf55807c77846f6c5f426b740a7a09fa608', '[\"*\"]', '2025-03-13 04:13:34', NULL, '2025-03-13 04:07:32', '2025-03-13 04:13:34'),
(22, 'App\\Models\\User', 1, 'milan@gmail.com', 'cd4d67a76f0f4b84428a4b8974f9336492afbae1a670d35f0a914b1dfaf69d4a', '[\"*\"]', '2025-03-13 04:28:35', NULL, '2025-03-13 04:14:07', '2025-03-13 04:28:35'),
(23, 'App\\Models\\User', 1, 'milan@gmail.com', 'c095e9c3faf170f9c31d95765c73490a150412592771d5589087e9dcc9ee894a', '[\"*\"]', '2025-03-13 04:16:19', NULL, '2025-03-13 04:16:16', '2025-03-13 04:16:19'),
(24, 'App\\Models\\User', 1, 'milan@gmail.com', '7f242fa3d9f7498551c70bd2ef5bc9d45b7347faef467226f56152fc1e6dd987', '[\"*\"]', '2025-03-13 04:18:46', NULL, '2025-03-13 04:18:45', '2025-03-13 04:18:46'),
(25, 'App\\Models\\User', 1, 'milan@gmail.com', 'b8168e94d8f3df2693135e71e5764fb9763bf93a770164884de9ae51decb3472', '[\"*\"]', '2025-03-13 04:26:16', NULL, '2025-03-13 04:26:13', '2025-03-13 04:26:16'),
(26, 'App\\Models\\User', 1, 'milan@gmail.com', '91a5dc6f62f5e32e9435fb68ee0701df99888446b8b0332c143a7b1efd034a4e', '[\"*\"]', '2025-03-13 04:33:40', NULL, '2025-03-13 04:28:36', '2025-03-13 04:33:40'),
(27, 'App\\Models\\User', 1, 'milan@gmail.com', 'f94ec5a693900672f566b81ffe95fbb964113811e958979f46ef6d852e6aa184', '[\"*\"]', '2025-03-13 04:43:33', NULL, '2025-03-13 04:43:22', '2025-03-13 04:43:33'),
(28, 'App\\Models\\User', 1, 'milan@gmail.com', '43a5157c20e4e44944e20548d7b90fb508cf04c7e4bfd22d9566dba9b9cd7b22', '[\"*\"]', NULL, NULL, '2025-03-13 04:53:03', '2025-03-13 04:53:03'),
(29, 'App\\Models\\User', 1, 'milan@gmail.com', 'addb52d17d9e332c63ae7c3a0375e3f3a012ab84bed7eaf69f01a953dd91a652', '[\"*\"]', NULL, NULL, '2025-03-13 04:53:08', '2025-03-13 04:53:08'),
(30, 'App\\Models\\User', 1, 'milan@gmail.com', '76fab273d66aa4e37260916d5a6f04b4bf7166e98c3ef51b092784c61d6d32a8', '[\"*\"]', NULL, NULL, '2025-03-13 04:53:11', '2025-03-13 04:53:11'),
(31, 'App\\Models\\User', 1, 'milan@gmail.com', 'bd475881f400313a751e5c2123c91b14507ffd437bba6edd8da86adde6643de8', '[\"*\"]', NULL, NULL, '2025-03-13 04:57:54', '2025-03-13 04:57:54'),
(32, 'App\\Models\\User', 1, 'milan@gmail.com', 'e7c03c085aff591cb3787bb7962041d2ac7931e5d17b1c9b124825bb46323893', '[\"*\"]', '2025-03-13 05:42:53', NULL, '2025-03-13 05:17:21', '2025-03-13 05:42:53'),
(33, 'App\\Models\\User', 1, 'milan@gmail.com', 'fcc711f71b8350e54ed321cd88a34b4d97d4d9e84f014ce7a5438e85c1eff9bd', '[\"*\"]', '2025-03-13 07:02:11', NULL, '2025-03-13 05:47:44', '2025-03-13 07:02:11'),
(34, 'App\\Models\\User', 1, 'milan@gmail.com', 'da557d6217afa2b4ab2b17bcb9334cc03ca6945966d3ac9e2541ae713584940b', '[\"*\"]', '2025-03-13 07:09:05', NULL, '2025-03-13 07:08:54', '2025-03-13 07:09:05'),
(35, 'App\\Models\\User', 1, 'milan@gmail.com', 'aaed52cf1fd979add5817f303e8fc1ab4b9c714ff9a1ae917dc9108a00556142', '[\"*\"]', '2025-03-16 00:40:28', NULL, '2025-03-16 00:35:03', '2025-03-16 00:40:28'),
(36, 'App\\Models\\User', 1, 'milan@gmail.com', '64b90b67aca4314a43cdd59d7f44808939bb559aa72a45a48a552246aeadfd67', '[\"*\"]', NULL, NULL, '2025-03-16 03:25:59', '2025-03-16 03:25:59'),
(37, 'App\\Models\\User', 1, 'milan@gmail.com', '6c897a03168ee2153c8cd1de6f67548f25d4b3c442fd55120657a69313d0e06c', '[\"*\"]', NULL, NULL, '2025-03-16 03:26:40', '2025-03-16 03:26:40'),
(38, 'App\\Models\\User', 1, 'milan@gmail.com', '342783ec4a847fb8df0c99ba9ec91009f5fa2943c6d703e5814c3b6208e40f03', '[\"*\"]', NULL, NULL, '2025-03-16 23:08:27', '2025-03-16 23:08:27'),
(39, 'App\\Models\\User', 1, 'milan@gmail.com', 'df1c0b193d28aafc1ae8e34a208607a58a2aa1439ba2019508f4968c4feea319', '[\"*\"]', NULL, NULL, '2025-03-16 23:08:38', '2025-03-16 23:08:38'),
(40, 'App\\Models\\User', 1, 'milan@gmail.com', '8111dfcb91bbb64f9cc5f9ea6d444319d13a1a00de9d0d2ee1f06fd237beb8ef', '[\"*\"]', NULL, NULL, '2025-03-16 23:10:11', '2025-03-16 23:10:11'),
(41, 'App\\Models\\User', 1, 'milan@gmail.com', '0b554b4120368f699e8f3d39c11cc5824dc2d0aa2aeb9c3db1447c0006c1b1a2', '[\"*\"]', '2025-03-16 23:21:13', NULL, '2025-03-16 23:17:59', '2025-03-16 23:21:13'),
(42, 'App\\Models\\User', 1, 'milan@gmail.com', '18c5e44ec4d88baf6b46196e5d6f43606a5c01833c923e8158138bb75c67706c', '[\"*\"]', '2025-03-16 23:37:15', NULL, '2025-03-16 23:35:31', '2025-03-16 23:37:15'),
(43, 'App\\Models\\User', 1, 'milan@gmail.com', 'e656af745155aaa22064d3ad5d01bf614659c1322445812f372ed3122b18bc85', '[\"*\"]', '2025-03-17 00:36:25', NULL, '2025-03-16 23:36:37', '2025-03-17 00:36:25'),
(44, 'App\\Models\\User', 2, 'test@test.com', '62d5270c4f00be5ed1325d73d1073c2897094aa6d8064d00fae79a8f12b46b9b', '[\"*\"]', NULL, NULL, '2025-03-16 23:46:14', '2025-03-16 23:46:14'),
(45, 'App\\Models\\User', 3, 'sajib@gmail.com', '698bd51af498b36bf5ee6c0f32bd7ab2b8863cd59159e2ba3d82bf8316f2f8f7', '[\"*\"]', NULL, NULL, '2025-03-16 23:51:07', '2025-03-16 23:51:07'),
(46, 'App\\Models\\User', 5, 'faysal@gmail.com', '09b4b9506a7d9e3472bb94bb1914be4a1edef0f5d329ca39992f586eb1f362c8', '[\"*\"]', '2025-03-16 23:56:52', NULL, '2025-03-16 23:56:24', '2025-03-16 23:56:52'),
(47, 'App\\Models\\User', 1, 'milan@gmail.com', 'fa205010594b7236715ea10419a6adfec6eaa2e12033a55db9cf42033409a348', '[\"*\"]', '2025-04-16 21:24:09', NULL, '2025-03-17 00:12:31', '2025-04-16 21:24:09'),
(48, 'App\\Models\\User', 1, 'milan@gmail.com', '85393d15a84dcbcd2e077bee185cd300d9508338e064958fb4d34c7da38ae661', '[\"*\"]', NULL, NULL, '2025-03-17 00:37:04', '2025-03-17 00:37:04'),
(49, 'App\\Models\\User', 1, 'milan@gmail.com', 'a6a58d248925906ef0e5709699141f192b9f6e274e1eedb69a63bbb7edb325f6', '[\"*\"]', NULL, NULL, '2025-03-17 00:40:10', '2025-03-17 00:40:10'),
(50, 'App\\Models\\User', 1, 'milan@gmail.com', '3463d6c55ce29d89fa6edb5682d7c419086f52b89749882992a61e042933fa68', '[\"*\"]', '2025-03-17 01:35:45', NULL, '2025-03-17 00:40:34', '2025-03-17 01:35:45'),
(51, 'App\\Models\\User', 1, 'milan@gmail.com', 'f62f15b0b78c5bdf606225770a99025aa8fcb165b2c790acf0495b2f6396a86e', '[\"*\"]', '2025-03-17 04:38:25', NULL, '2025-03-17 01:35:55', '2025-03-17 04:38:25'),
(52, 'App\\Models\\User', 1, 'milan@gmail.com', 'ba4acdc0fd875179fe1f479d4ac915de7cdade770852007d7f857ebfe8e93cdf', '[\"*\"]', '2025-03-17 05:12:06', NULL, '2025-03-17 05:06:59', '2025-03-17 05:12:06'),
(53, 'App\\Models\\User', 1, 'milan@gmail.com', '82c102101fca09ee2276402b0e359b42bebe8e9c7b97f8951b5166f92c6546b9', '[\"*\"]', '2025-03-18 00:49:53', NULL, '2025-03-17 05:13:18', '2025-03-18 00:49:53'),
(54, 'App\\Models\\User', 1, 'milan@gmail.com', '03ac7d47f4eba51ab20cf79442a64f3957f9badf63610dd2fc7f54cb32076d27', '[\"*\"]', '2025-03-17 20:45:19', NULL, '2025-03-17 20:45:19', '2025-03-17 20:45:19'),
(55, 'App\\Models\\User', 1, 'milan@gmail.com', '1de6ca22f48f3d51a9206a600db808b9f761a70dc6fa4cf8136df69f2c298beb', '[\"*\"]', '2025-03-18 01:00:39', NULL, '2025-03-17 20:46:11', '2025-03-18 01:00:39'),
(56, 'App\\Models\\User', 1, 'milan@gmail.com', '009c30454b8c86d398ae216bec95d641c439e8622f6882a593ba3f6ff93be5e2', '[\"*\"]', '2025-03-17 22:39:10', NULL, '2025-03-17 22:34:15', '2025-03-17 22:39:10'),
(57, 'App\\Models\\User', 1, 'milan@gmail.com', 'e8e616f7e0e6281c0c0ba81d0f13057c9c314fe4c4be306d991bcc212de4df69', '[\"*\"]', '2025-04-22 00:27:19', NULL, '2025-03-18 01:00:08', '2025-04-22 00:27:19'),
(58, 'App\\Models\\User', 1, 'milan@gmail.com', '29aafa01e4dd00837dc00d487a3c61600fd830225b371e74790f877aeb35fd82', '[\"*\"]', '2025-03-18 01:35:43', NULL, '2025-03-18 01:17:18', '2025-03-18 01:35:43'),
(59, 'App\\Models\\User', 1, 'milan@gmail.com', '3ec0fd34950f9b19abb25b5f5655313e68003d653950673b04aaea5766d65c60', '[\"*\"]', '2025-03-18 03:00:42', NULL, '2025-03-18 01:42:11', '2025-03-18 03:00:42'),
(60, 'App\\Models\\User', 1, 'milan@gmail.com', '357e0b5f8d15ecc26d715153b1145f3bc662d570cf0cd21aab945b495d11a461', '[\"*\"]', '2025-04-16 23:02:13', NULL, '2025-03-18 03:06:15', '2025-04-16 23:02:13'),
(61, 'App\\Models\\User', 1, 'milan@gmail.com', '3cdbcee54ffaad4269c9c2ca3d94007d5eceff24e94e833739242eacdfa56a8b', '[\"*\"]', '2025-03-18 03:30:48', NULL, '2025-03-18 03:07:21', '2025-03-18 03:30:48'),
(62, 'App\\Models\\User', 1, 'milan@gmail.com', 'd816d898baaa1e0c36c47ed808a711b8f71391af3061e0f7c32a8e428456f57b', '[\"*\"]', '2025-03-18 21:16:13', NULL, '2025-03-18 20:40:01', '2025-03-18 21:16:13'),
(63, 'App\\Models\\User', 1, 'milan@gmail.com', '0daf7b8cb8bcfed9949d00d802a8caa73946a11893ad5f8989275c9700c9887b', '[\"*\"]', NULL, NULL, '2025-03-18 20:45:20', '2025-03-18 20:45:20'),
(64, 'App\\Models\\User', 1, 'milan@gmail.com', '8467aec35170b54e27449087477e96d276f5609f6e2e9d5556218aececbfface', '[\"*\"]', '2025-03-19 00:19:20', NULL, '2025-03-18 21:24:47', '2025-03-19 00:19:20'),
(65, 'App\\Models\\User', 1, 'milan@gmail.com', 'b14a4cc84bb761ac72bfd5a6a9ae5aac55d937cd1ed02da58e70671e390ddba4', '[\"*\"]', '2025-03-19 01:25:36', NULL, '2025-03-19 00:38:21', '2025-03-19 01:25:36'),
(66, 'App\\Models\\User', 1, 'milan@gmail.com', '0449086ebd11fa53a73aa2f3ebf440660a46e031482e40c7b2ef2f3f8f2c6834', '[\"*\"]', NULL, NULL, '2025-04-15 22:51:17', '2025-04-15 22:51:17'),
(67, 'App\\Models\\User', 1, 'milan@gmail.com', '64a09d7c7bd7e500b584a9eb534c384e878ceaeaecc716e7b871ac23c1378689', '[\"*\"]', '2025-04-16 20:59:14', NULL, '2025-04-16 20:59:13', '2025-04-16 20:59:14'),
(68, 'App\\Models\\User', 1, 'milan@gmail.com', '81cfc49b806f6a6e995fce4c5589dd9c44d794a0ab7b541e84abec28a7abffdd', '[\"*\"]', '2025-04-16 21:00:07', NULL, '2025-04-16 20:59:54', '2025-04-16 21:00:07'),
(69, 'App\\Models\\User', 1, 'milan@gmail.com', '604bdbfbe893926f25b1968aa54f6e3900cbac7470f61587f003362ade7018f8', '[\"*\"]', NULL, NULL, '2025-04-16 21:04:13', '2025-04-16 21:04:13'),
(70, 'App\\Models\\User', 1, 'milan@gmail.com', '78d82b7a2b23b7e1ebe63d250b531ae89c218d9a8b654545eb492696d2cb3075', '[\"*\"]', '2025-04-16 21:48:22', NULL, '2025-04-16 21:04:17', '2025-04-16 21:48:22'),
(71, 'App\\Models\\User', 1, 'milan@gmail.com', '9158b418dc87febdbff1582f5f5d3e5a13189d0872d2c414ea439db7053a21d2', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:25', '2025-04-16 21:09:25'),
(72, 'App\\Models\\User', 1, 'milan@gmail.com', '3eacbe8abc1d266fe12924d2f5709856f511b07f08ed66e0b1698a56bf644102', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:29', '2025-04-16 21:09:29'),
(73, 'App\\Models\\User', 1, 'milan@gmail.com', '9850b6c9784b9d375641dbe1e7504c141f18c60e1b7127679173583e20694d78', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:31', '2025-04-16 21:09:31'),
(74, 'App\\Models\\User', 1, 'milan@gmail.com', 'b25e113201ebae3b4a69622be99f313a9dd456c55a409424e6d6c18056279ec6', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:32', '2025-04-16 21:09:32'),
(75, 'App\\Models\\User', 1, 'milan@gmail.com', 'ed6943ed2e87059e6dedb21750ddd0ec36a61b47182d28b97ad35a18d334fd7d', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:33', '2025-04-16 21:09:33'),
(76, 'App\\Models\\User', 1, 'milan@gmail.com', '50ac38d16b064159dda79ea57005e51b4229e3a6efc6d46ff11e65515aa4c03d', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:34', '2025-04-16 21:09:34'),
(77, 'App\\Models\\User', 1, 'milan@gmail.com', '2856644104cf71a34c88f01d4899ed5880bb3a13ac22f46ee22244bd316080cb', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:35', '2025-04-16 21:09:35'),
(78, 'App\\Models\\User', 1, 'milan@gmail.com', 'f95b78b0d292982f72f3f4cb1890c0fbdf582b9830420a38221cf7cf120d1ea9', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:36', '2025-04-16 21:09:36'),
(79, 'App\\Models\\User', 1, 'milan@gmail.com', '8730160e664fb82c6ded24c29ef845ac1a9e387ca83c981b7381c108c114242d', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:37', '2025-04-16 21:09:37'),
(80, 'App\\Models\\User', 1, 'milan@gmail.com', '259321e532faebac4fe1ff5867b9397e42f80f80a47cfb6eed5f53b2e12a8035', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:38', '2025-04-16 21:09:38'),
(81, 'App\\Models\\User', 1, 'milan@gmail.com', '89c6e60623a04e752cc05708b87ef604fa09fe0e03aa1d3010bb586cdf396100', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:40', '2025-04-16 21:09:40'),
(82, 'App\\Models\\User', 1, 'milan@gmail.com', '1b58a5bb0e8503b359d5d8c0708c3781c691fccdf62d2b0bce4d62d47030d4e9', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:41', '2025-04-16 21:09:41'),
(83, 'App\\Models\\User', 1, 'milan@gmail.com', '7ad31fd16a85f93ec152a1be47df4cd5712072f9d3762b2f9d71d9c5733cfd70', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:42', '2025-04-16 21:09:42'),
(84, 'App\\Models\\User', 1, 'milan@gmail.com', '5e52395f92e04fc9e08221464c7151b7e6e7af8045d7b8a3b163e7af293518a7', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:43', '2025-04-16 21:09:43'),
(85, 'App\\Models\\User', 1, 'milan@gmail.com', '95149d00b65107b9d20ff195009478595cd11805eabc93f265dec9d9bef241b4', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:45', '2025-04-16 21:09:45'),
(86, 'App\\Models\\User', 1, 'milan@gmail.com', '993931ec5c523739dcacc9cb913f0fcd2e05de9c8368ce7a4cdd81e4d8bb33c8', '[\"*\"]', NULL, NULL, '2025-04-16 21:09:46', '2025-04-16 21:09:46'),
(87, 'App\\Models\\User', 1, 'milan@gmail.com', 'e3b598af01352d5b843696dc9c46a79c028b65d8f370776df26221acd0426308', '[\"*\"]', '2025-04-21 02:27:01', NULL, '2025-04-16 21:24:19', '2025-04-21 02:27:01'),
(88, 'App\\Models\\User', 1, 'milan@gmail.com', 'd6a94171f2c7a425187175afca38d7f46ff71116b6208a9aa3606db0e44b8c4d', '[\"*\"]', '2025-04-22 06:12:33', NULL, '2025-04-16 21:49:17', '2025-04-22 06:12:33'),
(89, 'App\\Models\\User', 1, 'milan@gmail.com', '1ec6af914990f4dcc04bd2d750f3a95c79206e8362b4a64e67dd39ad5c8b6687', '[\"*\"]', '2025-04-17 02:41:24', NULL, '2025-04-17 01:06:06', '2025-04-17 02:41:24'),
(90, 'App\\Models\\User', 1, 'milan@gmail.com', '779115fdb31b3881ed16757858b5a90f9cb448ccc8b1bc320204b934b1fa445f', '[\"*\"]', '2025-04-20 00:10:43', NULL, '2025-04-19 20:50:00', '2025-04-20 00:10:43'),
(91, 'App\\Models\\User', 1, 'milan@gmail.com', '1507172b6b13770d2a3186c1fe34e4378cb5f66974557ca214235d03d02c5e1c', '[\"*\"]', NULL, NULL, '2025-04-19 22:52:30', '2025-04-19 22:52:30'),
(92, 'App\\Models\\User', 1, 'milan@gmail.com', 'dc4f8a705764958f8d20f8774be69f3b7b09c37763baa9f5e000eea3b99b5e3d', '[\"*\"]', '2025-04-20 03:48:05', NULL, '2025-04-20 00:57:36', '2025-04-20 03:48:05'),
(93, 'App\\Models\\User', 1, 'milan@gmail.com', 'f4817875941f46f07d90af617eaf4616decac003b5303af32e9c4cd80d945976', '[\"*\"]', '2025-04-20 04:58:52', NULL, '2025-04-20 04:49:23', '2025-04-20 04:58:52'),
(94, 'App\\Models\\User', 1, 'milan@gmail.com', 'aac215173655df4671ca0c499ef278dc9ae3a98d1fc51ff79fb06e8341840b96', '[\"*\"]', '2025-04-20 22:06:13', NULL, '2025-04-20 21:17:15', '2025-04-20 22:06:13'),
(95, 'App\\Models\\User', 1, 'milan@gmail.com', 'aede8879c4a84dedd60a74a650fdc14799eee48968011714deab26467bbbffab', '[\"*\"]', '2025-04-21 00:41:26', NULL, '2025-04-20 22:11:38', '2025-04-21 00:41:26'),
(96, 'App\\Models\\User', 1, 'milan@gmail.com', '8d91aa4b3594dc8098d41d998e28484ee1b48f65ebd38d710c7bebc2c35f52de', '[\"*\"]', '2025-04-21 02:12:21', NULL, '2025-04-21 01:00:36', '2025-04-21 02:12:21'),
(97, 'App\\Models\\User', 1, 'milan@gmail.com', 'a9ac49284b1f0dc3667ef468aa74d8f57b970ee4aec813b71c20e4e63cca99bc', '[\"*\"]', '2025-04-21 05:44:46', NULL, '2025-04-21 02:17:30', '2025-04-21 05:44:46'),
(98, 'App\\Models\\User', 1, 'milan@gmail.com', 'b199f8799207da3b7e434a76600bcbecc41dd5863814ccfa369e6f48746bf109', '[\"*\"]', '2025-04-21 03:30:39', NULL, '2025-04-21 03:28:51', '2025-04-21 03:30:39'),
(99, 'App\\Models\\User', 1, 'milan@gmail.com', '1ed6252a3eed0e41a0de771a98a76d18d89d198b5462a9628b2d6f646837e5ec', '[\"*\"]', NULL, NULL, '2025-04-21 20:39:03', '2025-04-21 20:39:03'),
(100, 'App\\Models\\User', 1, 'milan@gmail.com', 'de228233d564d2bc8cc60694d2b51f169183e5e7a3ca616036f54f6ea3ede333', '[\"*\"]', '2025-04-21 20:43:42', NULL, '2025-04-21 20:43:33', '2025-04-21 20:43:42'),
(101, 'App\\Models\\User', 1, 'milan@gmail.com', 'd3e4928c99e719034c7739d5efbe6d3c0c27aa7f9a08477ae22472392d1e3431', '[\"*\"]', '2025-04-21 21:21:06', NULL, '2025-04-21 21:06:58', '2025-04-21 21:21:06'),
(102, 'App\\Models\\User', 1, 'milan@gmail.com', 'ed1a6fe7c6dab21d0aef04a4ce610393fbf4c7d7f318b65b1ea2f69e9df66ec0', '[\"*\"]', '2025-04-22 01:39:20', NULL, '2025-04-21 21:10:50', '2025-04-22 01:39:20'),
(103, 'App\\Models\\User', 1, 'milan@gmail.com', '02b6a3d152fad22dc5ac240eb5449a843dfd13f97093fc74bc3545872163f52e', '[\"*\"]', '2025-04-22 06:50:45', NULL, '2025-04-21 21:21:45', '2025-04-22 06:50:45'),
(104, 'App\\Models\\User', 1, 'milan@gmail.com', '390fd7d87718b60c49390aab921d7163b788adc9024fb90dd7235f43e7627665', '[\"*\"]', '2025-04-21 22:36:24', NULL, '2025-04-21 22:28:57', '2025-04-21 22:36:24'),
(105, 'App\\Models\\User', 1, 'milan@gmail.com', '9b7ac18972e6c8585e1d41ad7aa0251908ab2b22ab55e38d1e97f7ef97305fb6', '[\"*\"]', '2025-04-22 05:34:15', NULL, '2025-04-22 05:32:35', '2025-04-22 05:34:15'),
(106, 'App\\Models\\User', 1, 'milan@gmail.com', '49770e39fd8fddd0e82ed289d94de9ae52cbd56c9d3aa5f823054cf61f87fc0b', '[\"*\"]', '2025-04-22 05:34:34', NULL, '2025-04-22 05:34:27', '2025-04-22 05:34:34'),
(107, 'App\\Models\\User', 1, 'milan@gmail.com', 'b7cf188da09a672ce11139a6d75842ca6e0109f9fddb819747cd6e04a059de63', '[\"*\"]', '2025-04-22 05:53:57', NULL, '2025-04-22 05:35:58', '2025-04-22 05:53:57'),
(108, 'App\\Models\\User', 1, 'milan@gmail.com', '610eb2b7a0c9001c42b7408ccbced11d15f80db7b9ab430674016ff35f85bfde', '[\"*\"]', NULL, NULL, '2025-04-22 06:02:38', '2025-04-22 06:02:38'),
(109, 'App\\Models\\User', 1, 'milan@gmail.com', 'c53b2d4f731ddd4b773e817eab4fbb97c48e3c8bb3fe47628b6953794604fefa', '[\"*\"]', '2025-04-22 06:44:47', NULL, '2025-04-22 06:03:04', '2025-04-22 06:44:47'),
(110, 'App\\Models\\User', 1, 'milan@gmail.com', '420904fdb2055eaca8ff725639d930e15968b26e7dcc4a24fa5189f7dc717153', '[\"*\"]', '2025-04-23 05:11:13', NULL, '2025-04-23 05:10:44', '2025-04-23 05:11:13'),
(111, 'App\\Models\\User', 1, 'milan@gmail.com', '00159abad94976cf09786c43545cf8a6938461f247645f8d3fbe5bdf9b6b78d0', '[\"*\"]', '2025-04-23 05:12:57', NULL, '2025-04-23 05:10:45', '2025-04-23 05:12:57'),
(112, 'App\\Models\\User', 1, 'milan@gmail.com', 'be700999b0861bf077f731220ee9adb1341c680c8e8e359b7844bed5f612c7e9', '[\"*\"]', '2025-04-23 07:02:47', NULL, '2025-04-23 06:00:41', '2025-04-23 07:02:47'),
(113, 'App\\Models\\User', 1, 'milan@gmail.com', 'e5e35b9c91c876881f43c7600f27414712c2e78bf30c646d1d889859d29d579a', '[\"*\"]', '2025-04-23 06:23:25', NULL, '2025-04-23 06:05:45', '2025-04-23 06:23:25'),
(114, 'App\\Models\\User', 1, 'milan@gmail.com', '6e3df4aca8790607e2e728800f56162f3f53a1006601d62e54e24c041499a7ec', '[\"*\"]', '2025-04-23 21:40:52', NULL, '2025-04-23 21:24:05', '2025-04-23 21:40:52'),
(115, 'App\\Models\\User', 1, 'milan@gmail.com', '19e89b4bb6eecf03b68cc8126a2b85a3bc65695e0bafc35f75807cbed65e9eca', '[\"*\"]', '2025-04-23 22:00:07', NULL, '2025-04-23 21:41:14', '2025-04-23 22:00:07'),
(116, 'App\\Models\\User', 1, 'milan@gmail.com', '05040e56edff5f768cb6606123bc3332f7c14904ba60cbaa5ffb99d79d4d0d7f', '[\"*\"]', '2025-04-23 21:50:19', NULL, '2025-04-23 21:50:10', '2025-04-23 21:50:19'),
(117, 'App\\Models\\User', 1, 'milan@gmail.com', '17db392c20feb13b23af4842da03943358a1e398aec8aed437c62200953ae1bb', '[\"*\"]', '2025-04-24 01:54:53', NULL, '2025-04-23 22:00:27', '2025-04-24 01:54:53'),
(118, 'App\\Models\\User', 1, 'milan@gmail.com', 'f3d17c72356456908fbca8d878dcf4109a6d9c01a0a06cdba6249c716d4dcbe4', '[\"*\"]', '2025-04-24 00:23:46', NULL, '2025-04-24 00:13:13', '2025-04-24 00:23:46'),
(119, 'App\\Models\\User', 1, 'milan@gmail.com', '19408f41b0c4f2bc3310932c95bd339c37cd766fe526b076aa270d4e2bc9952c', '[\"*\"]', '2025-04-24 03:19:38', NULL, '2025-04-24 02:36:20', '2025-04-24 03:19:38'),
(120, 'App\\Models\\User', 1, 'milan@gmail.com', 'bf1c6b0f555246c4cb98fd27e54f9155ae247fcecf33c20d096944ca483dda56', '[\"*\"]', '2025-04-24 03:44:07', NULL, '2025-04-24 03:43:53', '2025-04-24 03:44:07'),
(121, 'App\\Models\\User', 1, 'milan@gmail.com', '44340b3e52effa1269faba2379371e0a58b5244616499855350f6f0674eb1bcb', '[\"*\"]', '2025-04-24 04:48:58', NULL, '2025-04-24 04:48:53', '2025-04-24 04:48:58'),
(122, 'App\\Models\\User', 1, 'milan@gmail.com', '456bc4d357b1e310a2cfb59744c95dc9c408932d414a69ea626c8f6a13383ab2', '[\"*\"]', '2025-04-25 11:26:25', NULL, '2025-04-25 11:25:39', '2025-04-25 11:26:25'),
(123, 'App\\Models\\User', 1, 'milan@gmail.com', '8fd188dafc598b1a489c38090208d5208f3edb6d01f99bf996f3d7cd210cbf9c', '[\"*\"]', '2025-04-25 11:42:34', NULL, '2025-04-25 11:38:15', '2025-04-25 11:42:34'),
(124, 'App\\Models\\User', 1, 'milan@gmail.com', '709f9470547fd7d6e3c78d73f8bf9fdd6a94197981bbf69850ad5d61281aa1c1', '[\"*\"]', '2025-04-28 03:23:55', NULL, '2025-04-28 03:23:38', '2025-04-28 03:23:55'),
(125, 'App\\Models\\User', 1, 'milan@gmail.com', '81cd357322540c21e575f67f568936496bf7d0d8c0e57989f3df4ba657053339', '[\"*\"]', '2025-05-07 03:27:06', NULL, '2025-04-28 04:04:16', '2025-05-07 03:27:06'),
(126, 'App\\Models\\User', 1, 'milan@gmail.com', 'ec7ee69a6567521220078cc3ef31bae79e21d9121afcd53dbd730e59710c2543', '[\"*\"]', '2025-04-30 01:02:37', NULL, '2025-04-30 00:55:38', '2025-04-30 01:02:37'),
(127, 'App\\Models\\User', 1, 'milan@gmail.com', 'abedad6b5d94f961d9f3bc0731ff9ba6eb74488e0f106c5411364425d68bc517', '[\"*\"]', '2025-04-30 04:55:14', NULL, '2025-04-30 04:50:13', '2025-04-30 04:55:14'),
(128, 'App\\Models\\User', 1, 'milan@gmail.com', 'fb3d1cb60ca38f1a5ad96033fad111817a1936e9657294a8de9e117e0c7d4514', '[\"*\"]', NULL, NULL, '2025-04-30 04:56:20', '2025-04-30 04:56:20'),
(129, 'App\\Models\\User', 1, 'milan@gmail.com', 'e86283c858025a6a4067b01ac23f72ae437bb82f3b60a2d56eb7f23143691de4', '[\"*\"]', '2025-05-04 04:47:08', NULL, '2025-05-04 04:37:30', '2025-05-04 04:47:08'),
(130, 'App\\Models\\User', 1, 'milan@gmail.com', 'af5ef4726223e504538b700e455ab7e8eed652a5903e94b7f2a4ad2c36ec0f8d', '[\"*\"]', NULL, NULL, '2025-05-04 04:45:15', '2025-05-04 04:45:15'),
(131, 'App\\Models\\User', 1, 'milan@gmail.com', 'b88819adf51a2ab6618f607a105427c25f24add0b1bb3c279a94b736b93c521c', '[\"*\"]', '2025-05-04 05:23:08', NULL, '2025-05-04 04:47:31', '2025-05-04 05:23:08'),
(132, 'App\\Models\\User', 1, 'milan@gmail.com', '70d891a4a969ceed9d6aaf116309e8624616686e9b7c96a1abc27e36088610d6', '[\"*\"]', '2025-05-04 07:14:52', NULL, '2025-05-04 05:23:21', '2025-05-04 07:14:52'),
(133, 'App\\Models\\User', 1, 'milan@gmail.com', '4c0f059154f9ba1ec61fc7ecfc00a71380f5554898225e7fc2f95af99ca9be50', '[\"*\"]', '2025-05-04 07:09:43', NULL, '2025-05-04 07:03:25', '2025-05-04 07:09:43'),
(134, 'App\\Models\\User', 1, 'milan@gmail.com', '3e57e60c1bf9c498ee3786bdb5c1aefcc07af664301074f1820e1c109ccec188', '[\"*\"]', '2025-05-06 06:51:12', NULL, '2025-05-06 06:06:09', '2025-05-06 06:51:12'),
(135, 'App\\Models\\User', 1, 'milan@gmail.com', '16dc771f19396d58fefab5a293909c898444ac20491d01633a8003212312d3de', '[\"*\"]', '2025-05-06 06:55:07', NULL, '2025-05-06 06:54:42', '2025-05-06 06:55:07'),
(136, 'App\\Models\\User', 1, 'milan@gmail.com', '71701b65a22274b930adc7fce83296f6fe413c3b9f5727724812cad123ad8a53', '[\"*\"]', '2025-05-06 07:40:45', NULL, '2025-05-06 07:11:10', '2025-05-06 07:40:45'),
(137, 'App\\Models\\User', 1, 'milan@gmail.com', '6979d6a0f2394935c16c3100fc540356d3d8bdabe0f731399ba2cf0a0f3af4c6', '[\"*\"]', '2025-05-06 07:50:43', NULL, '2025-05-06 07:43:10', '2025-05-06 07:50:43'),
(138, 'App\\Models\\User', 1, 'milan@gmail.com', '8e87c265b253fbb5ae155d2c3a307f3e406a6caf4b67c3f8793033729af3b70a', '[\"*\"]', '2025-05-06 11:35:19', NULL, '2025-05-06 11:14:31', '2025-05-06 11:35:19'),
(139, 'App\\Models\\User', 1, 'milan@gmail.com', 'ec2d8b421d0465cbb68565c7f49a0d994cc4cfef2bd00c38dd40b8a9950b26e5', '[\"*\"]', '2025-05-07 05:54:14', NULL, '2025-05-06 20:44:42', '2025-05-07 05:54:14'),
(140, 'App\\Models\\User', 1, 'milan@gmail.com', 'bc9ded040bba5def8e43ecdfacd6ba3043ad1728915df771fee4e8835984d2dd', '[\"*\"]', '2025-05-06 21:32:46', NULL, '2025-05-06 21:10:33', '2025-05-06 21:32:46'),
(141, 'App\\Models\\User', 1, 'milan@gmail.com', '836f13e3238ed1e8d710940d78e878018d10362b5a26a9ab7039949d38445495', '[\"*\"]', NULL, NULL, '2025-05-06 21:46:35', '2025-05-06 21:46:35'),
(142, 'App\\Models\\User', 1, 'milan@gmail.com', '32d6a953cb40c8985817430432aef5c9e586c15cbe623d9d27db1e3d29bb6c72', '[\"*\"]', '2025-05-07 03:49:47', NULL, '2025-05-06 23:05:43', '2025-05-07 03:49:47'),
(143, 'App\\Models\\User', 1, 'milan@gmail.com', '54e4be86e94e2b93312ef3dbb2a9e6cc06234133d70d81f120d5822e60d4afeb', '[\"*\"]', '2025-05-07 03:38:41', NULL, '2025-05-07 03:25:46', '2025-05-07 03:38:41'),
(144, 'App\\Models\\User', 1, 'milan@gmail.com', '73e79525620a619d2f39de5f9b69560da602919ff5f452ef807926ea3942f8e1', '[\"*\"]', '2025-05-07 20:19:33', NULL, '2025-05-07 20:17:29', '2025-05-07 20:19:33'),
(145, 'App\\Models\\User', 1, 'milan@gmail.com', '08e49c958add0275652c5e97c649f1ea8e552d62eb2dcd3bb2738f8781e6262e', '[\"*\"]', '2025-05-08 05:01:44', NULL, '2025-05-07 21:56:33', '2025-05-08 05:01:44'),
(146, 'App\\Models\\User', 1, 'milan@gmail.com', '96fef2186264d4ff1c08f98e9d2ce1bc34ab2bf12f784ee525532202770294aa', '[\"*\"]', '2025-05-08 05:36:30', NULL, '2025-05-08 05:07:35', '2025-05-08 05:36:30'),
(147, 'App\\Models\\User', 1, 'milan@gmail.com', '3ea366cccfc1b981e5fd195a2a90dd63f349644f7ce38d6eb9a61c201991f136', '[\"*\"]', NULL, NULL, '2025-05-08 05:09:18', '2025-05-08 05:09:18'),
(148, 'App\\Models\\User', 1, 'milan@gmail.com', 'a4ba39cf1af172a0b8ceb98abfebb895d821db63c71c3088984cbd6592ab7afc', '[\"*\"]', NULL, NULL, '2025-05-08 05:10:22', '2025-05-08 05:10:22'),
(149, 'App\\Models\\User', 1, 'milan@gmail.com', '9221f8bba8fcd36748046389699318fd002c528a5fe565b5e487eee18af414fb', '[\"*\"]', NULL, NULL, '2025-05-08 05:10:26', '2025-05-08 05:10:26'),
(150, 'App\\Models\\User', 1, 'milan@gmail.com', '87f55daa7e57144f8ab5726ff1c70de80766228cd2779975b66ed237651a9f3b', '[\"*\"]', '2025-05-08 05:38:33', NULL, '2025-05-08 05:38:17', '2025-05-08 05:38:33'),
(151, 'App\\Models\\User', 1, 'milan@gmail.com', '13e24c84af21a887ad612e27fab13170072af6b0c247405b5ad17bd328b166d8', '[\"*\"]', '2025-05-08 07:05:50', NULL, '2025-05-08 06:56:01', '2025-05-08 07:05:50');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categories_id` bigint UNSIGNED DEFAULT NULL,
  `subcategories_id` bigint UNSIGNED DEFAULT NULL,
  `suppliers_id` bigint UNSIGNED DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `tags` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manufacturer_id` bigint DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `batch_no` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generic_id` int DEFAULT NULL,
  `is_ecommerce_item` int DEFAULT '0',
  `is_barcoded` int DEFAULT '0',
  `status` int DEFAULT '0' COMMENT '0=active, 1=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_categories_id_foreign` (`categories_id`),
  KEY `products_subcategories_id_foreign` (`subcategories_id`),
  KEY `products_suppliers_id_foreign` (`suppliers_id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `categories_id`, `subcategories_id`, `suppliers_id`, `product_id`, `tags`, `manufacturer_id`, `description`, `batch_no`, `generic_id`, `is_ecommerce_item`, `is_barcoded`, `status`, `created_at`, `updated_at`) VALUES
(69, 'চাল – Rice', 11, 21, 5, NULL, 'chal', 112233, 'chal', '112233', 123456, 1, 1, 0, '2025-04-21 21:33:01', '2025-04-21 21:33:55'),
(71, 'বাসমতি চাল – Basmati Rice', 11, 21, 5, NULL, 'বাসমতি চাল – Basmati Rice', 11, 'null', '1122', 11, 1, 1, 0, '2025-04-21 21:39:34', '2025-04-21 21:39:34'),
(72, 'মসুর ডাল – Red Lentil', 11, 21, 1, NULL, 'মসুর ডাল – Red Lentil', 112233, 'মসুর ডাল – Red Lentil', '112233', 112233, 1, 1, 0, '2025-04-21 21:41:26', '2025-04-21 21:41:26'),
(73, 'মুগ ডাল – Moong Dal', 11, 21, 1, NULL, 'মুগ ডাল – Moong Dal', 5566, 'মুগ ডাল – Moong Dal', '5566', 5566, 1, 1, 0, '2025-04-21 21:43:21', '2025-04-21 21:43:21'),
(74, 'চানা ডাল – Chana Dal', 11, 21, 2, NULL, 'Iusto elit enim cul', 28, 'চানা ডাল – Chana Dal', 'চানা ডাল – Chana Dal', 61, 0, 1, 0, '2025-04-21 21:44:25', '2025-04-21 21:44:25'),
(75, 'আটা – Wheat Flour', 11, 21, 4, NULL, 'আটা – Wheat Flour', 78, 'আটা – Wheat Flour', '11223', 44, 1, 1, 0, '2025-04-21 21:45:18', '2025-04-21 21:45:18'),
(76, 'ময়দা – Refined Flour', 11, 21, 4, NULL, 'ময়দা – Refined Flour', 14, 'Sit corrupti ipsam', '112', 93, 1, 1, 0, '2025-04-21 21:47:41', '2025-04-21 21:47:41'),
(77, 'হলুদ গুঁড়া – Turmeric Powder', 11, 22, 4, NULL, 'হলুদ গুঁড়া – Turmeric Powder', 20, 'হলুদ গুঁড়া – Turmeric Powder', '112', 94, 1, 1, 0, '2025-04-21 21:50:08', '2025-04-21 21:50:08'),
(78, 'মরিচ গুঁড়া – Chili Powder', 13, 22, 1, NULL, 'মরিচ গুঁড়া – Chili Powder', 52, 'মরিচ গুঁড়া – Chili Powder', '115588', 75, 1, 1, 0, '2025-04-21 21:51:04', '2025-04-21 21:51:04'),
(79, 'ধনে গুঁড়া – Coriander Powder', 13, 22, 1, NULL, 'Quae est dolor dolor', 36, 'ধনে গুঁড়া – Coriander Powder', '123', 15, 1, 1, 0, '2025-04-21 21:52:11', '2025-04-21 21:52:11'),
(80, 'জিরা – Cumin', 13, 22, 1, NULL, 'জিরা – Cumin', 25, 'Iusto nostrud animi', '123456', 35, 1, 1, 0, '2025-04-21 21:53:07', '2025-04-21 21:53:07'),
(82, 'সরিষা – Mustard Seed', 13, 22, 5, NULL, 'সরিষা – Mustard Seed', 92, 'সরিষা – Mustard Seed', '897', 32, 0, 1, 0, '2025-04-21 21:55:16', '2025-04-21 21:55:16'),
(83, 'সয়াবিন তেল – Soybean Oil', 12, 23, 2, NULL, 'সয়াবিন তেল – Soybean Oil', 14, 'Nisi molestias atque', '456', 26, 0, 1, 0, '2025-04-21 21:57:27', '2025-04-21 21:57:27'),
(84, 'সরিষার তেল – Mustard Oil', 12, 23, 1, NULL, 'সরিষার তেল – Mustard Oil', 34, 'সরিষার তেল – Mustard Oil', '456', 52, 0, 1, 0, '2025-04-21 21:58:34', '2025-04-21 21:58:34'),
(85, 'সাবান – Soap', 14, 24, 4, NULL, 'সাবান – Soap', 2, 'Molestiae incidunt', '123', 13, 1, 1, 0, '2025-04-21 22:00:51', '2025-04-21 22:00:51'),
(86, 'চিনি - Sugar', 5, 21, 6, NULL, 'Est impedit ex eum', 100, 'Porro est alias accu', 'Cum quasi eveniet v', 46, 0, 1, 0, '2025-04-22 05:45:31', '2025-04-22 05:45:31'),
(87, 'বেসন -Beson', 11, 21, 6, NULL, 'Qui quisquam quas sa', 84, 'Cupidatat omnis sint', 'Fugiat sed laudanti', 65, 1, 1, 0, '2025-04-22 05:48:22', '2025-04-22 05:48:22'),
(88, 'সোলা - Sola But', 11, 21, 6, NULL, 'Qui quisquam assumen', 66, 'Voluptas suscipit es', 'Aute non eos non om', 62, 0, 1, 0, '2025-04-22 05:49:58', '2025-04-22 05:49:58'),
(89, 'পাম তেল -pam oil', 12, 21, 6, NULL, 'Et recusandae Magni', 88, 'Cum ab laborum Odio', 'Et ut qui itaque qui', 25, 1, 1, 0, '2025-04-22 05:51:44', '2025-04-22 05:51:44'),
(90, 'পোলাও চাল - polao chal', 11, 21, 6, NULL, 'Culpa dolor fugiat', 8, 'Et nisi cupidatat ex', 'Qui sit iste ipsam s', 53, 0, 1, 0, '2025-04-22 05:53:13', '2025-04-22 05:53:13'),
(91, 'লবণ -Salt', 13, 21, 1, NULL, 'Sunt rerum nisi ven', 31, 'Culpa fugit ipsum', 'Eiusmod dignissimos', 55, 0, 1, 0, '2025-04-22 06:04:34', '2025-04-22 06:04:34'),
(102, 'বুটের ডাল - Booter Dal', 11, 21, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, '2025-05-06 07:18:15', '2025-05-06 07:18:15'),
(103, 'বুশরা মিনিকেট - Bushraminiket', 11, 21, 4, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, '2025-05-06 07:22:00', '2025-05-06 07:22:00'),
(111, 'Onion', 13, 22, 4, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, '2025-05-07 00:33:16', '2025-05-07 00:33:16');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
CREATE TABLE IF NOT EXISTS `product_images` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` bigint UNSIGNED DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `path`, `created_at`, `updated_at`) VALUES
(2, 43, 'storage/product_images/1742281978_Screenshot_4.png', '2025-03-18 01:12:58', '2025-03-18 01:12:58'),
(5, 44, 'storage/product_images/1742282009_Screenshot_4.png', '2025-03-18 01:13:29', '2025-03-18 01:13:29'),
(6, 44, 'storage/product_images/1742282009_Screenshot_7.png', '2025-03-18 01:13:29', '2025-03-18 01:13:29'),
(8, 45, 'storage/product_images/1742282267_photo-1533450718592-29d45635f0a9.avif', '2025-03-18 01:17:47', '2025-03-18 01:17:47'),
(11, 46, 'storage/product_images/1742282322_Screenshot_4.png', '2025-03-18 01:18:42', '2025-03-18 01:18:42'),
(12, 46, 'storage/product_images/1742282322_Screenshot_7.png', '2025-03-18 01:18:42', '2025-03-18 01:18:42'),
(15, 47, 'storage/product_images/1742282504_Screenshot_4.png', '2025-03-18 01:21:44', '2025-03-18 01:21:44'),
(16, 47, 'storage/product_images/1742282504_Screenshot_7.png', '2025-03-18 01:21:44', '2025-03-18 01:21:44'),
(19, 48, 'storage/product_images/1742288040_Screenshot_4.png', '2025-03-18 02:54:00', '2025-03-18 02:54:00'),
(20, 48, 'storage/product_images/1742288040_Screenshot_7.png', '2025-03-18 02:54:00', '2025-03-18 02:54:00'),
(22, 49, 'storage/product_images/1742288481_photo-1533450718592-29d45635f0a9.avif', '2025-03-18 03:01:21', '2025-03-18 03:01:21'),
(24, 50, 'storage/product_images/1742288542_Screenshot-2019-01-23-at-6.55.51-PM.webp', '2025-03-18 03:02:22', '2025-03-18 03:02:22'),
(26, 51, 'storage/product_images/1742288642_Screenshot-2019-01-23-at-6.55.51-PM.webp', '2025-03-18 03:04:02', '2025-03-18 03:04:02'),
(28, 59, 'storage/product_images/1742353677_Screenshot-2019-01-23-at-6.55.51-PM.webp', '2025-03-18 21:07:57', '2025-03-18 21:07:57'),
(30, 60, 'storage/product_images/1742353901_2025-02-16.png', '2025-03-18 21:11:41', '2025-03-18 21:11:41'),
(32, 61, 'storage/product_images/1742354007_photo-1533450718592-29d45635f0a9.avif', '2025-03-18 21:13:27', '2025-03-18 21:13:27'),
(34, 62, 'storage/product_images/1742354719_photo-1533450718592-29d45635f0a9.avif', '2025-03-18 21:25:19', '2025-03-18 21:25:19'),
(36, 63, 'storage/product_images/1742354758_Screenshot-2019-01-23-at-6.55.51-PM.webp', '2025-03-18 21:25:58', '2025-03-18 21:25:58'),
(38, 64, 'storage/product_images/1742354949_2025-02-16.png', '2025-03-18 21:29:09', '2025-03-18 21:29:09'),
(40, 65, 'storage/product_images/1742355051_Screenshot-2019-01-23-at-6.55.51-PM.webp', '2025-03-18 21:30:51', '2025-03-18 21:30:51'),
(42, 66, 'storage/product_images/1744862916_images.jpeg', '2025-04-16 22:08:36', '2025-04-16 22:08:36'),
(44, 67, 'storage/product_images/1744863266_rup chada.jpeg', '2025-04-16 22:14:26', '2025-04-16 22:14:26'),
(46, 68, 'storage/product_images/1744866550_lychee-fruits-Southeast-Asia.webp', '2025-04-16 23:09:10', '2025-04-16 23:09:10'),
(48, 69, 'storage/product_images/1745292782_rup chada.jpeg', '2025-04-21 21:33:02', '2025-04-21 21:33:02'),
(50, 70, 'storage/product_images/1745293013_chinigura-10.jpg', '2025-04-21 21:36:53', '2025-04-21 21:36:53'),
(52, 71, 'storage/product_images/1745293174_brunch_pg16_1611853874078_1611853881994_1673847005318_1673847005318.avif', '2025-04-21 21:39:34', '2025-04-21 21:39:34'),
(54, 72, 'storage/product_images/1745293286_red-masoor-dal-500x500.webp', '2025-04-21 21:41:26', '2025-04-21 21:41:26'),
(56, 73, 'storage/product_images/1745293401_60f9f789d9c5eeaec9135d01bae57fe2169134627120647_original.avif', '2025-04-21 21:43:21', '2025-04-21 21:43:21'),
(58, 74, 'storage/product_images/1745293465_chana-dal01.webp', '2025-04-21 21:44:25', '2025-04-21 21:44:25'),
(60, 75, 'storage/product_images/1745293518_wheat-flour_1024x460.webp', '2025-04-21 21:45:18', '2025-04-21 21:45:18'),
(62, 76, 'storage/product_images/1745293661_maida-7.webp', '2025-04-21 21:47:41', '2025-04-21 21:47:41'),
(64, 77, 'storage/product_images/1745293808_images.jpeg', '2025-04-21 21:50:08', '2025-04-21 21:50:08'),
(66, 78, 'storage/product_images/1745293864_মরিচের গুঁড়া Chili Powder.jpg', '2025-04-21 21:51:04', '2025-04-21 21:51:04'),
(68, 79, 'storage/product_images/1745293932_ধনে গুঁড়া – Coriander Powder.jpeg', '2025-04-21 21:52:12', '2025-04-21 21:52:12'),
(70, 80, 'storage/product_images/1745293987_জিরা – Cumin.jpg', '2025-04-21 21:53:07', '2025-04-21 21:53:07'),
(72, 81, 'storage/product_images/1745294047_গরম মসলা.jpg', '2025-04-21 21:54:07', '2025-04-21 21:54:07'),
(74, 82, 'storage/product_images/1745294116_সরিষা.jpg', '2025-04-21 21:55:16', '2025-04-21 21:55:16'),
(76, 83, 'storage/product_images/1745294247_aaaa.jpg', '2025-04-21 21:57:27', '2025-04-21 21:57:27'),
(78, 84, 'storage/product_images/1745294314_5-liter1.jpg', '2025-04-21 21:58:34', '2025-04-21 21:58:34'),
(80, 85, 'storage/product_images/1745294451_images.jpeg', '2025-04-21 22:00:51', '2025-04-21 22:00:51'),
(82, 86, 'storage/product_images/1745322332_1698499579941-sku-1177-0-500x500.webp', '2025-04-22 05:45:32', '2025-04-22 05:45:32'),
(84, 87, 'storage/product_images/1745322502_aci-pure-chickpea-flour-boot-beshon-500-gm.jpeg', '2025-04-22 05:48:22', '2025-04-22 05:48:22'),
(86, 88, 'storage/product_images/1745322598_1635761939.Pran Sola But.webp', '2025-04-22 05:49:58', '2025-04-22 05:49:58'),
(88, 89, 'storage/product_images/1745322704_AN405-palm-oil-fruit-732x549-Thumb-1-732x549.avif', '2025-04-22 05:51:44', '2025-04-22 05:51:44'),
(90, 90, 'storage/product_images/1745322793_60deee66ef825.edited.jpg', '2025-04-22 05:53:13', '2025-04-22 05:53:13'),
(92, 91, 'storage/product_images/1745323474_8941196220037.webp', '2025-04-22 06:04:34', '2025-04-22 06:04:34'),
(94, 94, 'storage/product_images/1745476819_lychee-fruits-Southeast-Asia.webp', '2025-04-24 00:40:19', '2025-04-24 00:40:19'),
(96, 98, 'storage/product_images/1746361838_ChatGPT Image Apr 29, 2025, 09_54_40 AM.png', '2025-05-04 06:30:38', '2025-05-04 06:30:38'),
(98, 99, 'storage/product_images/1746363198_lychee-fruits-Southeast-Asia.webp', '2025-05-04 06:53:18', '2025-05-04 06:53:18'),
(100, 102, 'storage/product_images/1746537496_Peeled-Garbanzo-খোসাছাড়া-বুটের-ডাল-500gm.jpeg', '2025-05-06 07:18:16', '2025-05-06 07:18:16'),
(102, 103, 'storage/product_images/1746537720_rice.jpeg', '2025-05-06 07:22:00', '2025-05-06 07:22:00'),
(104, 104, 'storage/product_images/1746586233_photo-1533450718592-29d45635f0a9.avif', '2025-05-06 20:50:33', '2025-05-06 20:50:33'),
(106, 105, 'storage/product_images/1746586882_photo-1533450718592-29d45635f0a9.avif', '2025-05-06 21:01:22', '2025-05-06 21:01:22'),
(108, 107, 'storage/product_images/1746588554_original-865765f0a40954dde0d33e3c9662bac1.webp', '2025-05-06 21:29:14', '2025-05-06 21:29:14'),
(110, 108, 'storage/product_images/1746590371_1698499579941-sku-1177-0-500x500.webp', '2025-05-06 21:59:31', '2025-05-06 21:59:31'),
(112, 109, 'storage/product_images/1746592020_1698499579941-sku-1177-0-500x500.webp', '2025-05-06 22:27:00', '2025-05-06 22:27:00'),
(114, 110, 'storage/product_images/1746596037_1698499579941-sku-1177-0-500x500.webp', '2025-05-06 23:33:57', '2025-05-06 23:33:57'),
(116, 111, 'storage/product_images/1746599596_images.jpeg', '2025-05-07 00:33:16', '2025-05-07 00:33:16'),
(118, 112, 'storage/product_images/1746676683_lychee-fruits-Southeast-Asia.webp', '2025-05-07 21:58:03', '2025-05-07 21:58:03'),
(120, 113, 'storage/product_images/1746678407_images.jpeg', '2025-05-07 22:26:47', '2025-05-07 22:26:47');

-- --------------------------------------------------------

--
-- Table structure for table `product_pack_sizes`
--

DROP TABLE IF EXISTS `product_pack_sizes`;
CREATE TABLE IF NOT EXISTS `product_pack_sizes` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `tp` decimal(10,2) DEFAULT NULL,
  `vat_percent` decimal(5,2) DEFAULT NULL,
  `vat` decimal(10,2) DEFAULT NULL,
  `selling_price` decimal(10,2) DEFAULT NULL,
  `default_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_pack_sizes`
--

INSERT INTO `product_pack_sizes` (`id`, `product_id`, `name`, `quantity`, `tp`, `vat_percent`, `vat`, `selling_price`, `default_unit`, `created_at`, `updated_at`) VALUES
(6, 30, '25 kg', 130, 37.00, 59.00, 76.00, 89.00, '1', '2025-03-17 22:45:55', '2025-05-07 03:44:55'),
(7, 31, '50kg', 95, 27.00, 21.00, 28.00, 37.00, '1', '2025-03-17 22:47:04', '2025-04-21 23:46:38'),
(8, 32, 'Qui sunt quam pariat', 58, 91.00, 81.00, 83.00, 38.00, '1', '2025-03-17 22:50:11', '2025-03-17 22:50:11'),
(9, 33, 'Cupiditate illo et s', 23, 15.00, 18.00, 19.00, 40.00, '1', '2025-03-17 22:51:34', '2025-03-17 22:51:34'),
(10, 34, 'Et dolores id id eli', 94, 2.00, 41.00, 85.00, 8.00, '1', '2025-03-17 22:53:30', '2025-03-17 22:53:30'),
(11, 35, 'Eu sapiente dignissi', 4, 66.00, 13.00, 27.00, 57.00, '1', '2025-03-17 23:04:18', '2025-03-17 23:04:18'),
(12, 36, 'Omnis debitis impedi', 74, 13.00, 57.00, 56.00, 21.00, '1', '2025-03-17 23:13:10', '2025-03-17 23:13:10'),
(13, 37, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-03-18 00:20:08', '2025-03-18 00:20:08'),
(14, 38, 'Aliquid quibusdam ea', 14, 3.00, 93.00, 77.00, 61.00, '1', '2025-03-18 00:38:03', '2025-03-18 00:38:03'),
(15, 39, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-03-18 01:01:44', '2025-03-18 01:01:44'),
(16, 40, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-03-18 01:04:22', '2025-03-18 01:04:22'),
(17, 41, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-03-18 01:05:56', '2025-03-18 01:05:56'),
(18, 42, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-03-18 01:06:03', '2025-03-18 01:06:03'),
(19, 43, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-03-18 01:12:58', '2025-03-18 01:12:58'),
(20, 44, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-03-18 01:13:29', '2025-03-18 01:13:29'),
(21, 45, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-03-18 01:17:47', '2025-03-18 01:17:47'),
(22, 46, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-03-18 01:18:42', '2025-03-18 01:18:42'),
(23, 47, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-03-18 01:21:44', '2025-03-18 01:21:44'),
(24, 49, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-03-18 03:01:21', '2025-03-18 03:01:21'),
(25, 50, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-03-18 03:02:22', '2025-03-18 03:06:31'),
(26, 51, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-03-18 03:04:02', '2025-03-18 03:04:02'),
(27, 52, 'Aut sit beatae quo', 70, 83.00, 77.00, 51.00, 13.00, '1', '2025-03-18 20:40:59', '2025-03-18 20:40:59'),
(28, 53, 'Voluptatum nihil ut', 52, 93.00, 21.00, 48.00, 2.00, '1', '2025-03-18 20:41:53', '2025-03-18 20:41:53'),
(29, 54, 'Recusandae Eos ani', 54, 71.00, 56.00, 66.00, 34.00, '1', '2025-03-18 20:46:12', '2025-03-18 20:46:12'),
(30, 55, 'Nulla nihil amet au', 74, 85.00, 2.00, 29.00, 70.00, '1', '2025-03-18 20:55:15', '2025-03-18 20:55:15'),
(31, 56, 'Voluptas rerum non v', 86, 53.00, 47.00, 93.00, 7.00, '1', '2025-03-18 20:57:04', '2025-03-18 20:57:04'),
(32, 57, 'Dolorem incididunt n', 95, 34.00, 72.00, 1.00, 10.00, '1', '2025-03-18 20:58:35', '2025-03-18 20:58:35'),
(33, 58, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-03-18 21:07:43', '2025-03-18 21:07:43'),
(34, 59, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-03-18 21:07:56', '2025-03-18 21:07:56'),
(35, 60, 'Nesciunt sed proide', 93, 64.00, 11.00, 63.00, 33.00, '1', '2025-03-18 21:11:41', '2025-03-18 21:11:41'),
(36, 61, 'Sed molestiae qui pr', 17, 49.00, 95.00, 41.00, 37.00, '1', '2025-03-18 21:13:27', '2025-03-18 21:13:27'),
(37, 62, 'Eveniet natus ea mo', 54, 88.00, 44.00, 60.00, 26.00, '1', '2025-03-18 21:25:19', '2025-03-18 21:25:19'),
(38, 63, 'Consequuntur harum i', 83, 2.00, 67.00, 37.00, 32.00, '1', '2025-03-18 21:25:58', '2025-03-18 21:25:58'),
(39, 64, 'Earum in nihil omnis', 46, 10.00, 93.00, 47.00, 50.00, '1', '2025-03-18 21:29:09', '2025-03-18 21:29:09'),
(40, 65, 'In omnis numquam ius', 13, 5.00, 43.00, 72.00, 20.00, '1', '2025-03-18 21:30:51', '2025-03-18 21:30:51'),
(41, 66, 'Gulab jamun', 100, 10.00, 10.00, 10.00, 450.00, '1', '2025-04-16 22:08:36', '2025-04-16 22:08:36'),
(42, 67, 'Rupchada', 200, 100.00, 10.00, 10.00, 500.00, '1', '2025-04-16 22:14:26', '2025-04-16 22:14:26'),
(43, 68, 'Lychee', 1000, 100.00, 10.00, 10.00, 250.00, '1', '2025-04-16 23:09:10', '2025-04-16 23:09:10'),
(44, 69, '50kg', 1000, 150.00, 0.00, 0.00, 200.00, '1', '2025-04-21 21:33:01', '2025-05-08 05:08:10'),
(45, 70, '12kg', 1000, 20.00, 20.00, 30.00, 55.00, '1', '2025-04-21 21:36:53', '2025-05-07 03:45:02'),
(46, 71, '25kg', 1000, 150.00, 0.00, 0.00, 200.00, '1', '2025-04-21 21:39:34', '2025-05-08 05:08:29'),
(47, 72, '25 KG', 8, 2450.00, 0.00, 20.00, 2500.00, '1', '2025-04-21 21:41:26', '2025-05-08 05:34:26'),
(48, 73, '20kg', 7798, 2500.00, 55.00, 1.00, 522.00, '1', '2025-04-21 21:43:21', '2025-05-08 05:01:28'),
(49, 74, '12kg', 11, 200.00, 32.00, 10.00, 19.00, '1', '2025-04-21 21:44:25', '2025-05-08 04:48:48'),
(50, 75, '1000gm', 21, 100.00, 0.00, 10.00, 120.00, '1', '2025-04-21 21:45:18', '2025-05-08 04:49:04'),
(51, 76, '50 KG', 8, 2450.00, 0.00, 20.00, 2500.00, '1', '2025-04-21 21:47:41', '2025-05-08 05:34:26'),
(52, 77, '250gm', 41, 79.00, 85.00, 98.00, 29.00, '1', '2025-04-21 21:50:08', '2025-05-07 03:45:05'),
(53, 78, '200gm', 58, 6000.00, 0.00, 0.00, 6500.00, '1', '2025-04-21 21:51:04', '2025-05-08 05:10:27'),
(54, 79, '200gm', 81, 61.00, 78.00, 51.00, 75.00, '1', '2025-04-21 21:52:11', '2025-05-07 22:08:09'),
(55, 80, '200gm', 5, 300.00, 0.00, 0.00, 400.00, '1', '2025-04-21 21:53:07', '2025-05-08 05:08:49'),
(56, 81, '250gm', 21, 89.00, 99.00, 35.00, 48.00, '1', '2025-04-21 21:54:07', '2025-04-22 05:25:28'),
(57, 82, '5Liter', 31, 53.00, 59.00, 60.00, 29.00, '1', '2025-04-21 21:55:16', '2025-04-22 05:28:55'),
(58, 83, '5Liter', 21, 4.00, 1.00, 69.00, 87.00, '1', '2025-04-21 21:57:27', '2025-05-07 03:45:02'),
(59, 84, '5Liter', 22, 41.00, 47.00, 26.00, 24.00, '1', '2025-04-21 21:58:34', '2025-05-07 03:45:05'),
(60, 85, '60gm', 24, 43.00, 14.00, 87.00, 70.00, '1', '2025-04-21 22:00:51', '2025-05-08 00:13:56'),
(61, 86, '50 KG', 15, 0.00, 0.00, 20.00, 5500.00, '1', '2025-04-22 05:45:31', '2025-05-08 07:02:14'),
(62, 87, '40 KG', 100, 0.00, 0.00, 0.00, 2800.00, '1', '2025-04-22 05:48:22', '2025-05-07 03:45:08'),
(63, 88, '25 KG', 100, 0.00, 0.00, 0.00, 2500.00, '1', '2025-04-22 05:49:58', '2025-05-07 03:45:08'),
(64, 89, '20 KG', 107, 3240.00, 0.00, 20.00, 3300.00, '1', '2025-04-22 05:51:44', '2025-05-08 05:34:26'),
(65, 90, '35 KG', 50, 0.00, 0.00, 0.00, 2780.00, '1', '2025-04-22 05:53:13', '2025-05-07 03:45:14'),
(66, 91, '1 Ps', 20, 150.00, 0.00, 0.00, 300.00, '1', '2025-04-22 06:04:34', '2025-05-08 05:09:49'),
(69, 94, 'Illum debitis ullam', 44, 17.00, 40.00, 299.20, 1047.20, '0', '2025-04-24 00:40:19', '2025-04-24 00:40:19'),
(70, 95, '50 kg', 50, 5450.00, 0.00, 0.00, 272500.00, '0', '2025-04-25 11:42:06', '2025-04-25 11:42:06'),
(71, 97, 'Pack Size 1', 10, 100.50, 5.00, 5.25, 110.75, '1', '2025-04-28 04:08:52', '2025-04-28 04:08:52'),
(72, 98, '500 ml', 5, 10.00, 5.00, 2.50, 52.50, '0', '2025-05-04 06:30:37', '2025-05-04 06:30:37'),
(73, 99, '100 pc', 100, 3.00, 2.00, 6.00, 306.00, '0', '2025-05-04 06:53:18', '2025-05-04 06:53:18'),
(74, 100, 'Maet 1KG', 10, 1000.00, 0.00, 0.00, 1300.00, '0', '2025-05-04 07:07:13', '2025-05-04 07:07:13'),
(76, 102, '25 KG', 8, 2600.00, 0.00, 20.00, 2800.00, '0', '2025-05-06 07:18:15', '2025-05-08 05:34:26'),
(77, 103, '25 KG', 8, 0.00, 0.00, 0.00, 2200.00, '0', '2025-05-06 07:22:00', '2025-05-08 07:05:50'),
(78, 104, '500 ml', 1, 500.00, 4.00, 20.00, 600.00, '0', '2025-05-06 20:50:32', '2025-05-06 20:50:32'),
(79, 105, '500 ML', 1, 0.00, 0.00, 0.00, 200.00, '0', '2025-05-06 21:01:22', '2025-05-06 21:01:22'),
(80, 106, '1', 50, NULL, NULL, 0.00, 500.00, '0', '2025-05-06 21:28:27', '2025-05-06 21:28:27'),
(81, 107, '2 KG', 50, NULL, NULL, 0.00, 500.00, '0', '2025-05-06 21:29:14', '2025-05-06 21:29:14'),
(82, 108, '50 KG', 2, 5350.00, NULL, 0.00, 10700.00, '0', '2025-05-06 21:59:31', '2025-05-06 21:59:31'),
(83, 109, '50 KG', 2, 10700.00, 0.00, 0.00, 21400.00, '0', '2025-05-06 22:27:00', '2025-05-06 22:27:00'),
(84, 110, NULL, 10, 20.00, 0.00, 0.00, 200.00, '0', '2025-05-06 23:33:57', '2025-05-06 23:33:57'),
(85, 111, '50 KG', 16, 50.00, 0.00, 10.00, 3000.00, '0', '2025-05-07 00:33:16', '2025-05-08 04:49:07'),
(86, 112, '20 KG', 1, 5000.00, 0.00, 0.00, 5500.00, '0', '2025-05-07 21:58:01', '2025-05-08 04:48:44'),
(87, 113, '25 KG', 1, 5000.00, 0.00, 0.00, 5500.00, '0', '2025-05-07 22:26:47', '2025-05-07 22:26:47');

-- --------------------------------------------------------

--
-- Table structure for table `product_prices`
--

DROP TABLE IF EXISTS `product_prices`;
CREATE TABLE IF NOT EXISTS `product_prices` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` bigint UNSIGNED DEFAULT NULL,
  `cost_price_without_tax` decimal(10,2) DEFAULT NULL,
  `selling_price` decimal(10,2) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `trade_price` decimal(10,2) DEFAULT NULL,
  `vat_percent` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vat` decimal(10,2) DEFAULT NULL,
  `wholesale` decimal(10,2) DEFAULT NULL,
  `wholesale_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disable_from_price_rules` tinyint(1) NOT NULL DEFAULT '0',
  `allow_price_override_regardless_of_permissions` tinyint(1) NOT NULL DEFAULT '0',
  `prices_include_tax` tinyint(1) NOT NULL DEFAULT '0',
  `only_allow_items_to_be_sold_in_whole_numbers` tinyint(1) NOT NULL DEFAULT '0',
  `change_cost_price_during_sale` tinyint(1) NOT NULL DEFAULT '0',
  `override_default_commission` tinyint(1) NOT NULL DEFAULT '0',
  `override_default_tax` tinyint(1) NOT NULL DEFAULT '0',
  `is_editable_in_sale` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_prices`
--

INSERT INTO `product_prices` (`id`, `product_id`, `cost_price_without_tax`, `selling_price`, `quantity`, `trade_price`, `vat_percent`, `vat`, `wholesale`, `wholesale_type`, `disable_from_price_rules`, `allow_price_override_regardless_of_permissions`, `prices_include_tax`, `only_allow_items_to_be_sold_in_whole_numbers`, `change_cost_price_during_sale`, `override_default_commission`, `override_default_tax`, `is_editable_in_sale`, `created_at`, `updated_at`) VALUES
(6, 30, 58.00, 25.00, NULL, 84.00, NULL, 64.00, 99.00, 'Minus sint duis nemo', 1, 1, 1, 1, 1, 1, 1, 1, '2025-03-17 22:45:55', '2025-03-17 22:45:55'),
(7, 31, 57.00, 90.00, NULL, 65.00, NULL, 12.00, 82.00, 'Deleniti nobis liber', 1, 1, 1, 1, 1, 1, 1, 1, '2025-03-17 22:47:04', '2025-03-17 22:47:04'),
(8, 32, 70.00, 60.00, NULL, 96.00, NULL, 89.00, 38.00, 'Odio ea molestias at', 1, 1, 1, 1, 1, 1, 1, 1, '2025-03-17 22:50:11', '2025-03-17 22:50:11'),
(9, 33, 55.00, 70.00, NULL, 62.00, NULL, 5.00, 71.00, 'In occaecat rem in u', 1, 1, 1, 1, 1, 1, 1, 1, '2025-03-17 22:51:34', '2025-03-17 22:51:34'),
(10, 34, 58.00, 90.00, NULL, 76.00, NULL, 47.00, 52.00, 'Est amet totam faci', 1, 1, 1, 1, 1, 1, 1, 1, '2025-03-17 22:53:30', '2025-03-17 22:53:30'),
(11, 35, 41.00, 94.00, NULL, 81.00, NULL, 91.00, 81.00, 'Quidem obcaecati nul', 1, 1, 1, 1, 1, 1, 1, 1, '2025-03-17 23:04:18', '2025-03-17 23:04:18'),
(12, 36, 1.00, 9.00, NULL, 12.00, NULL, 36.00, 31.00, 'Provident iusto dol', 1, 1, 1, 1, 1, 1, 1, 1, '2025-03-17 23:13:10', '2025-03-17 23:13:10'),
(13, 37, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 1, 0, 0, 0, 1, 1, '2025-03-18 00:20:08', '2025-03-18 00:20:08'),
(14, 38, 71.00, 64.00, NULL, 24.00, NULL, 97.00, 52.00, 'Expedita soluta id', 1, 1, 1, 1, 1, 1, 1, 1, '2025-03-18 00:38:03', '2025-03-18 00:38:03'),
(15, 39, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 01:01:44', '2025-03-18 01:01:44'),
(16, 40, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 01:04:22', '2025-03-18 01:04:22'),
(17, 41, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 01:05:56', '2025-03-18 01:05:56'),
(18, 42, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 01:06:03', '2025-03-18 01:06:03'),
(19, 43, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 01:12:58', '2025-03-18 01:12:58'),
(20, 44, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 01:13:29', '2025-03-18 01:13:29'),
(21, 45, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 01:17:47', '2025-03-18 01:17:47'),
(22, 46, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 01:18:42', '2025-03-18 01:18:42'),
(23, 47, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 01:21:44', '2025-03-18 01:21:44'),
(24, 48, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 02:54:00', '2025-03-18 02:54:00'),
(25, 49, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 03:01:21', '2025-03-18 03:01:21'),
(26, 50, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 03:02:22', '2025-03-18 03:06:31'),
(27, 51, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 03:04:02', '2025-03-18 03:04:02'),
(28, 52, 35.00, 44.00, NULL, 30.00, NULL, 37.00, 28.00, 'Id quisquam sed magn', 1, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 20:40:59', '2025-03-18 20:40:59'),
(29, 53, 96.00, 65.00, NULL, 47.00, NULL, 85.00, 76.00, 'Hic in commodi moles', 1, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 20:41:53', '2025-03-18 20:41:53'),
(30, 54, 25.00, 42.00, NULL, 70.00, NULL, 56.00, 86.00, 'Repellendus Magni e', 1, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 20:46:12', '2025-03-18 20:46:12'),
(31, 55, 91.00, 59.00, NULL, 41.00, NULL, 61.00, 58.00, 'Accusamus sit vitae', 1, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 20:55:15', '2025-03-18 20:55:15'),
(32, 56, 95.00, 99.00, NULL, 57.00, NULL, 81.00, 85.00, 'Delectus tempor dol', 1, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 20:57:04', '2025-03-18 20:57:04'),
(33, 57, 9.00, 29.00, NULL, 49.00, NULL, 17.00, 32.00, 'Dignissimos et volup', 1, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 20:58:35', '2025-03-18 20:58:35'),
(34, 58, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 21:07:43', '2025-03-18 21:07:43'),
(35, 59, 90.00, 120.00, NULL, 115.00, NULL, 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 21:07:56', '2025-03-18 21:07:56'),
(36, 60, 21.00, 9.00, NULL, 71.00, NULL, 71.00, 57.00, 'At ut incididunt seq', 1, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 21:11:41', '2025-03-18 21:11:41'),
(37, 61, 17.00, 80.00, NULL, 79.00, NULL, 71.00, 13.00, 'Cumque similique mol', 1, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 21:13:27', '2025-03-18 21:13:27'),
(38, 62, 21.00, 50.00, NULL, 97.00, NULL, 82.00, 25.00, 'Facilis quod non del', 1, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 21:25:19', '2025-03-18 21:25:19'),
(39, 63, 76.00, 84.00, NULL, 57.00, NULL, 77.00, 97.00, 'Incididunt commodi m', 1, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 21:25:58', '2025-03-18 21:25:58'),
(40, 64, 48.00, 1.00, NULL, 72.00, NULL, 49.00, 62.00, 'Officia quos fuga E', 1, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 21:29:09', '2025-03-18 21:29:09'),
(41, 65, 17.00, 58.00, NULL, 30.00, NULL, 92.00, 59.00, 'Omnis sint esse des', 1, 0, 0, 0, 0, 0, 0, 1, '2025-03-18 21:30:51', '2025-03-18 21:30:51'),
(42, 66, 200.00, 450.00, NULL, 200.00, NULL, 10.00, 500.00, 'nai', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-16 22:08:36', '2025-04-16 22:08:36'),
(43, 67, 200.00, 300.00, NULL, 100.00, NULL, 10.00, 20.00, 'jani na', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-16 22:14:26', '2025-04-16 22:14:26'),
(44, 68, 100.00, 250.00, NULL, 200.00, NULL, 10.00, 150.00, 'jani na', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-16 23:09:10', '2025-04-16 23:09:10'),
(45, 69, 35.00, 75.00, NULL, 30.00, NULL, 5.00, 30.00, 'Null', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:33:01', '2025-04-21 21:33:01'),
(46, 70, 55.00, 75.00, NULL, 30.00, NULL, 20.00, 11.00, 'null', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:36:53', '2025-04-21 21:36:53'),
(47, 71, 65.00, 75.00, NULL, 20.00, NULL, 20.00, 20.00, 'Null', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:39:34', '2025-04-21 21:39:34'),
(48, 72, 0.00, 2450.00, NULL, 0.00, NULL, 0.00, 0.00, 'Null', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:41:26', '2025-05-06 07:26:33'),
(49, 73, 55.00, 90.00, NULL, 30.00, NULL, 60.00, 55.00, '1', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:43:21', '2025-04-21 21:43:21'),
(50, 74, 36.00, 70.00, NULL, 70.00, NULL, 69.00, 56.00, '1', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:44:25', '2025-04-21 21:44:25'),
(51, 75, 90.00, 120.00, NULL, 120.00, NULL, 0.00, 110.00, '1', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:45:18', '2025-04-23 06:51:49'),
(52, 76, 0.00, 2450.00, NULL, 0.00, NULL, 0.00, 0.00, '1', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:47:41', '2025-05-06 07:25:02'),
(53, 77, 28.00, 95.00, NULL, 90.00, NULL, 72.00, 68.00, '1', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:50:08', '2025-04-21 21:50:08'),
(54, 78, 100.00, 87.00, NULL, 39.00, NULL, 26.00, 35.00, '1', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:51:04', '2025-04-21 21:51:04'),
(55, 79, 4.00, 87.00, NULL, 39.00, NULL, 17.00, 27.00, '1', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:52:11', '2025-04-21 21:52:11'),
(56, 80, 36.00, 31.00, NULL, 53.00, NULL, 69.00, 67.00, '1', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:53:07', '2025-04-21 21:53:07'),
(57, 81, 36.00, 19.00, NULL, 54.00, NULL, 63.00, 43.00, '1', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:54:07', '2025-04-21 21:54:07'),
(58, 82, 45.00, 6.00, NULL, 4.00, NULL, 61.00, 84.00, '1', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:55:16', '2025-04-21 21:55:16'),
(59, 83, 23.00, 65.00, NULL, 53.00, NULL, 83.00, 6.00, '1', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:57:27', '2025-04-21 21:57:27'),
(60, 84, 20.00, 1.00, NULL, 69.00, NULL, 16.00, 57.00, '1', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 21:58:34', '2025-04-21 21:58:34'),
(61, 85, 31.00, 79.00, NULL, 74.00, NULL, 23.00, 11.00, '1', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-21 22:00:51', '2025-04-21 22:00:51'),
(62, 86, 0.00, 5350.00, NULL, 0.00, NULL, 0.00, 0.00, '1', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-22 05:45:31', '2025-05-06 07:31:48'),
(63, 87, 0.00, 2800.00, NULL, 0.00, NULL, 0.00, 0.00, 'Aut deserunt quia ni', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-22 05:48:22', '2025-04-22 06:28:19'),
(64, 88, 0.00, 2500.00, NULL, 0.00, NULL, 0.00, 0.00, 'Qui voluptatum aut d', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-22 05:49:58', '2025-04-22 06:32:49'),
(65, 89, 0.00, 3240.00, NULL, 0.00, NULL, 0.00, 0.00, 'Impedit occaecat ip', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-22 05:51:44', '2025-05-06 07:29:05'),
(66, 90, 0.00, 2780.00, NULL, 0.00, NULL, 0.00, 0.00, 'Ea aut nisi commodi', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-22 05:53:13', '2025-04-22 06:33:34'),
(67, 91, 0.00, 150.00, NULL, 0.00, NULL, 0.00, 0.00, 'Voluptas commodi dol', 1, 0, 0, 0, 0, 0, 0, 1, '2025-04-22 06:04:34', '2025-04-22 06:34:38'),
(68, 94, 748.00, 20.00, NULL, 4.00, NULL, 9.00, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-04-24 00:40:19', '2025-04-24 00:40:19'),
(69, 95, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-04-25 11:42:06', '2025-04-25 11:42:06'),
(70, 97, 90.00, 120.00, 10, 115.00, '5', 10.00, 100.00, 'bulk', 0, 0, 0, 0, 0, 0, 0, 1, '2025-04-28 04:08:52', '2025-04-28 04:08:52'),
(71, 98, 2.00, 2.10, 1, 2.00, '5', 0.10, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-04 06:30:37', '2025-05-04 06:30:37'),
(72, 99, 0.03, 0.03, 1, 0.03, '2', 0.00, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-04 06:53:18', '2025-05-04 06:53:18'),
(73, 100, 100.00, 100.00, 1, 100.00, '0', 0.00, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-04 07:07:13', '2025-05-04 07:07:13'),
(74, 102, 0.00, 2600.00, NULL, 0.00, NULL, 0.00, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-06 07:18:15', '2025-05-06 07:33:27'),
(75, 103, 0.00, 2120.00, NULL, 0.00, NULL, 0.00, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-06 07:22:00', '2025-05-06 07:28:03'),
(76, 104, 500.00, 520.00, 1, 500.00, '4', 20.00, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-06 20:50:32', '2025-05-06 20:50:32'),
(77, 105, 0.00, 0.00, 1, 0.00, '0', 0.00, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-06 21:01:22', '2025-05-06 21:01:22'),
(78, 106, 0.00, 0.00, 1, 0.00, '0', 0.00, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-06 21:28:27', '2025-05-06 21:28:27'),
(79, 107, 0.00, 500.00, NULL, 0.00, NULL, 0.00, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-06 21:29:14', '2025-05-06 21:31:01'),
(80, 108, 2675.00, 2675.00, 1, 2675.00, '0', 0.00, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-06 21:59:31', '2025-05-06 21:59:31'),
(81, 109, 5350.00, 10700.00, 1, 5350.00, '0', 0.00, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-06 22:27:00', '2025-05-06 22:27:00'),
(82, 110, 20.00, 20.00, 1, 20.00, '0', 0.00, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-06 23:33:57', '2025-05-06 23:33:57'),
(83, 111, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-07 00:33:16', '2025-05-07 22:36:36'),
(84, 112, NULL, NULL, 1, NULL, NULL, NULL, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-07 21:58:01', '2025-05-07 21:58:01'),
(85, 113, NULL, NULL, 1, NULL, NULL, NULL, 0.00, NULL, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-07 22:26:47', '2025-05-07 22:26:47');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
CREATE TABLE IF NOT EXISTS `purchases` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `purchase_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_id` bigint UNSIGNED DEFAULT NULL,
  `getis_percent` decimal(10,2) DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `mrr_id` bigint UNSIGNED DEFAULT NULL,
  `sub_total` decimal(15,2) DEFAULT NULL,
  `total_trade_price` decimal(15,2) DEFAULT NULL,
  `total_vat` decimal(15,2) DEFAULT NULL,
  `total` decimal(15,2) DEFAULT NULL,
  `amount_due` decimal(15,2) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `paid_amount` decimal(15,2) DEFAULT NULL,
  `payment_method_id` bigint UNSIGNED DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `discount_entire_purchase` decimal(15,2) NOT NULL DEFAULT '0.00',
  `discount_all_percent` decimal(10,2) NOT NULL DEFAULT '0.00',
  `invoice_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `purchases_purchase_code_unique` (`purchase_code`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `purchase_code`, `supplier_id`, `getis_percent`, `amount`, `mrr_id`, `sub_total`, `total_trade_price`, `total_vat`, `total`, `amount_due`, `purchase_date`, `paid_amount`, `payment_method_id`, `note`, `branch_id`, `discount_entire_purchase`, `discount_all_percent`, `invoice_no`, `file`, `created_by`, `created_at`, `updated_at`) VALUES
(25, '2505087152', 6, NULL, NULL, NULL, 18330.00, 23560.00, 140.00, 18330.00, 0.00, '2025-05-08', 18330.00, NULL, NULL, NULL, 0.00, 5370.00, NULL, NULL, 1, '2025-05-08 04:57:00', '2025-05-08 05:34:26');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_bonus_products`
--

DROP TABLE IF EXISTS `purchase_bonus_products`;
CREATE TABLE IF NOT EXISTS `purchase_bonus_products` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `purchase_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pack_size_id` bigint UNSIGNED DEFAULT NULL,
  `tp` decimal(10,2) NOT NULL DEFAULT '0.00',
  `vat` decimal(10,2) DEFAULT NULL,
  `cost` decimal(15,2) DEFAULT NULL,
  `received_quantity` int NOT NULL DEFAULT '0',
  `quantity` int NOT NULL DEFAULT '0',
  `total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `size` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generic_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `cost_price_preview` decimal(15,2) DEFAULT NULL,
  `item_id` bigint UNSIGNED DEFAULT NULL,
  `batch_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_products`
--

DROP TABLE IF EXISTS `purchase_products`;
CREATE TABLE IF NOT EXISTS `purchase_products` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `purchase_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pack_size_id` bigint UNSIGNED DEFAULT NULL,
  `tp` decimal(10,2) DEFAULT NULL,
  `vat` decimal(10,2) DEFAULT NULL,
  `cost` decimal(15,2) DEFAULT NULL,
  `received_quantity` int NOT NULL DEFAULT '0',
  `quantity` int NOT NULL DEFAULT '0',
  `without_dis_total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `discount_percent` decimal(10,2) NOT NULL DEFAULT '0.00',
  `discount_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `getis_percent` decimal(10,2) NOT NULL DEFAULT '0.00',
  `getis_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `size` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generic_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `cost_price_preview` decimal(15,2) DEFAULT NULL,
  `item_id` bigint UNSIGNED DEFAULT NULL,
  `batch_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_products`
--

INSERT INTO `purchase_products` (`id`, `purchase_id`, `product_id`, `product_name`, `pack_size_id`, `tp`, `vat`, `cost`, `received_quantity`, `quantity`, `without_dis_total`, `discount_percent`, `discount_amount`, `getis_percent`, `getis_amount`, `total`, `size`, `generic_name`, `serial`, `stock`, `cost_price_preview`, `item_id`, `batch_no`, `expiry_date`, `created_at`, `updated_at`) VALUES
(42, 12, 111, 'Onion', 85, NULL, NULL, 2500.00, 1, 1, 2500.00, 0.00, 0.00, 0.00, 0.00, 2500.00, NULL, NULL, NULL, NULL, NULL, NULL, '2505076974', NULL, '2025-05-07 01:29:48', '2025-05-07 01:29:48'),
(43, 12, 75, 'আটা – Wheat Flour', 50, 120.00, 0.00, 90.00, 1, 1, 90.00, 0.00, 0.00, 0.00, 0.00, 90.00, NULL, NULL, NULL, NULL, NULL, NULL, '2505075237', NULL, '2025-05-07 01:29:48', '2025-05-07 01:29:48'),
(44, 12, 85, 'সাবান – Soap', 60, 74.00, 23.00, 43.00, 1, 1, 43.00, 0.00, 0.00, 0.00, 0.00, 43.00, NULL, NULL, NULL, NULL, NULL, NULL, '2505075250', NULL, '2025-05-07 01:29:48', '2025-05-07 01:29:48'),
(104, 25, 86, 'চিনি - Sugar', 61, 5350.00, 20.00, 5370.00, 2, 2, 10740.00, 50.00, 5370.00, 0.00, 0.00, 5370.00, '50 KG', NULL, NULL, NULL, NULL, NULL, '2505086301', NULL, '2025-05-08 05:34:26', '2025-05-08 05:34:26'),
(105, 25, 76, 'ময়দা – Refined Flour', 51, 2450.00, 20.00, 2470.00, 1, 1, 2470.00, 0.00, 0.00, 0.00, 0.00, 2470.00, '50 KG', NULL, NULL, NULL, NULL, NULL, '2505081771', NULL, '2025-05-08 05:34:26', '2025-05-08 05:34:26'),
(106, 25, 72, 'মসুর ডাল – Red Lentil', 47, 2450.00, 20.00, 2470.00, 1, 1, 2470.00, 0.00, 0.00, 0.00, 0.00, 2470.00, '25 KG', NULL, NULL, NULL, NULL, NULL, '2505082769', NULL, '2025-05-08 05:34:26', '2025-05-08 05:34:26'),
(107, 25, 102, 'বুটের ডাল - Booter Dal', 76, 2600.00, 20.00, 2620.00, 1, 1, 2620.00, 0.00, 0.00, 0.00, 0.00, 2620.00, '25 KG', NULL, NULL, NULL, NULL, NULL, '2505087849', NULL, '2025-05-08 05:34:26', '2025-05-08 05:34:26'),
(108, 25, 103, 'বুশরা মিনিকেট - Bushraminiket', 77, 2120.00, 20.00, 2140.00, 1, 1, 2140.00, 0.00, 0.00, 0.00, 0.00, 2140.00, '25 KG', NULL, NULL, NULL, NULL, NULL, '2505086047', NULL, '2025-05-08 05:34:26', '2025-05-08 05:34:26'),
(109, 25, 89, 'পাম তেল -pam oil', 64, 3240.00, 20.00, 3260.00, 1, 1, 3260.00, 0.00, 0.00, 0.00, 0.00, 3260.00, '20 KG', NULL, NULL, NULL, NULL, NULL, '2505088366', NULL, '2025-05-08 05:34:26', '2025-05-08 05:34:26');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'web', NULL, NULL),
(2, 'Super-Admin', 'web', '2025-03-17 00:01:18', '2025-03-17 00:01:18'),
(3, 'test', 'web', '2025-03-17 00:08:57', '2025-03-17 00:19:37'),
(4, 'sajib', 'web', '2025-03-17 01:08:39', '2025-03-17 01:08:39');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(3, 3),
(1, 4),
(3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `sales_add`
--

DROP TABLE IF EXISTS `sales_add`;
CREATE TABLE IF NOT EXISTS `sales_add` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `sales_manage_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL,
  `sales_price` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sales_add_sales_manage_id_foreign` (`sales_manage_id`),
  KEY `sales_add_product_id_foreign` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales_manage`
--

DROP TABLE IF EXISTS `sales_manage`;
CREATE TABLE IF NOT EXISTS `sales_manage` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `gross_amount` int NOT NULL,
  `discount` int NOT NULL,
  `net_amount` int NOT NULL,
  `paidamount` int NOT NULL,
  `dueamount` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sales_manage_customer_id_foreign` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('2IdEGExYMFJ0RRer1FukCIZulslsWNhp3r0UX6zv', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYTk2eHZ1Y0EwRDYzQ1pLVjFxV1VmaHBXazZhSnNEdzBBNUJ1aTVUOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746693151),
('4f36qqiI4xvTL6bEXyh8Bz6pkWYPN31lWKdVPY5F', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicWd4SVZ1ZDBrWVdWTUptUExkNVNaWDJwWDJaRHdzOFd2RHVReVIxMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746701693),
('6NU5QpihFD0rgPlliA4fw9XTZmiHb3PBBbCJTFMK', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibXUxNDRaakFxb0h1TVVTTmd0eEMwelVyR3hOV2VxRWZwVDdONGJRZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746694726),
('7fcVg1R7KnLifNsJJ2vmHR8akhOXkov0yjDYoWu4', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicmVJRE5xTU9lMkVVUVJTUW44UER1WEJuRGpZeWFqOXBvUXA4cjNJWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746695439),
('8k1gmjsES2QeJKlsdfSypqfM3GSbs6XPnPDbY1fr', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSDkzTDVzbG0xelFzSHUxMzBOb0VWbmhaYXpERk11anZ1ZEpHaTJNNCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746695472),
('8SkIcdn2HkQbN2UzN3CQT3Vvq6b9OIhBL8hwiRus', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYU9LUEhLRmI0Y0JBZzczTVlreU13MEpycDlma2dhQ2hCU09peDI5OSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746687552),
('aZftJ8Q6xwRy0MN8thKfx1lQanJYPDZ40SUwFIs7', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZGJENHNQSmlWYTd4RUFna1QzTDFxbEFyOHd4YXFuTnhkWkxwdDBkUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746693073),
('bRQAj8ufmug6bjXuTorIxU93c8RIRf9yRJQKnqq4', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTW9pNEpHd2ZaeE04dU1udUkzNTRVTjBHVmJhWVdsSFJjaHI5N2ZQQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746690908),
('c3YHgEiRMXB2LXBy1d3UKtgbvHygoWwCZUs4VBgH', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiczJKS1Rpang5WXQ5UEt1OXI1SjVmNTBBcFh0d2N2OHVSN3VkbWU5aiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746702593),
('cBty3rssuGhMy4kGuuf3B7JpLEyN0rs6TCUfruCn', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZDhEeklwNmY3N042UzRmcHdFRmdLQnJ1UFJGVVRUak9LcjBwVXJQSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746701517),
('cxZURnGD97hzKj3YleVMsQIHwmBIoBKKYibMYdM4', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibFUzWlRwS2hCS2FxMVBGVTI4WTViZkVZTXdhd2lxTHNmbmtuQmdvYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746678421),
('drjCH4WGd6eTGXoUet4WTQHcZM7CeaZ1ezj6UgK3', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicEtNd1VpQmVFQzhNOTZDZThkT0dWSTVSbnVUWjU4cFhIaW80aXVjdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746701575),
('EizMnpP8Rs0zFcmC39VizY1kClCRClVbgt1jc95i', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWmNzZWFkVTNCaXhQSWFlY1FlNGJvRXBKalRVaFQ3NDU0U3ZzTWFzVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746700878),
('emZIEoAWGTKmLbpBJpBdmguoDwkOUKgVydQTwykt', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUjFxMGtISUVJRk9XZXJta3B3YXJVTlBYZUgxdXVScXhZbE42aDQ4WiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746701013),
('fhZJ5URA6IpCHHyVaM3mmjMmAbXKYdlhLWzEuj6L', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiejlMVnU3c3VrZmsxMlJhUHNnVW1ZTUxrWTJ5Njg2Wk11eDVXUm1EaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746702497),
('GHXDAe6FTJAqYX9JvxGIJXfiZ0ccUPuQT6pcpEUv', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWVh4bnROM2tFMzVXelRKcG1xTG5IZTJta2o5OTF1bjBvYVFKdXF0biI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746698681),
('godgHkLyz6EosZRsZagC4ZVjQlhsJoMTX0SlOyQx', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY1NudXFzMUlRSVUxREFFSW4xTE5PVkxseFUxVHpEWk5vWlkyZElYSCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746691154),
('Gom7iqoS3oasLQsNPJ75FRaxcuBzeIIAp1tXWzMS', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMFg4NTV4bzlrVUMyQlhDNjFnQW01OG9oaFh2V3VNd3ZuaVRvYVRibiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746700617),
('HVXVla0tneoix9ZBx1prYqS0tlEPFyyzQaNgvGqz', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZU0yRG1BejA1QkF3bDFaWnlCUDZieURCVlZqRno1Q1NjdnlSZGJKTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746701667),
('ilpVcGBW7thitsBUXiyygpuMPUSEa7oxBZKUO2nD', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYXpGdzhOUXpkdmlPVHNybW44YU5RRDZWaFcwRkg2TnBROVlsQk1VcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746700845),
('iuV3cmALrxcLgOMcKt1xEOAGLo3VMFexVXL4M237', NULL, '192.168.102.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY0JjUGEwSU40a3E0RnB1UTJOU2NiS05LeHc5c1BKdGVQeWczMDIxTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746709529),
('JEv7sKm7VDVL0ussLk0AUb7Jnq6RsmKNncOzsOL1', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid3lOYWVUbVk3cnNnNHRXdW1BbmQwYkdrTzZmUHg1UkxJT2dEVFBYYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746693138),
('jKOCPrK3P3rV1SzkHtqCem9VekBWV0enTXhIXRzS', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUDF2Z2txSzN2QXNFRHpnaGgyWkNic0Zya0hFSUNpZTFlRXRobERNZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746693226),
('LbJH86v7wHWVrXaK6bRhvRoZXOiCiQtJxPFCjzdK', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQTdXcVlWb2pLM0RWMTBIbmVOd0VCZGozdXpNYWlMdWE4WVQ4cWxyZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746701627),
('lPSWYaEFTkwTUFYB6MMBaQsVnSzAEi7nBbS8uFKM', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidWxCUVdVVUVCcG1TMExmQ1RqcFd5VzViREh3ZmlHcG94amYxbHRqdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746694830),
('MGzbgqJR7BI5cY4a4jjTwIspqmh0jh43uuXZWt5M', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVHgwTFNxdDB1Z1RjdEZrcGp3QUo3NlM3MWNLRHB4OXB6VVF5NFBVbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746702580),
('nBMG1HK79tSL2osMA6iVBtV2IvOWZP2NrMCOoUtM', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVEFOckdyMG5ZYnJHNkthbllQNDJ4NVFMTlRzeGYybWVhblh5Q2ZPdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746678415),
('oflViy5ef9k0HhSDH44FexSqZ9Di6a1nQLTdQIo6', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibWtxUEpOSHVCdWkyV1JKb1NIUjJCM2xwZ3F6Zm5KUTlCTzdQbkdaUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746701549),
('ojAfmJodKGRihkxvAIdu5o00JiJR5VhKPm9jFm2K', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSVdPOVZZWDZsZTEzSDNhQXhQRjVuNHpWaGRDU01IbVFuMGxBSFRLbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746691175),
('P0aTDGG6XdEsk1HuNZNS19XQADvVxFTqzCntuQzF', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibVI1SmFHdFc4MXozb3Zoa21SNHZ3NlNlTHh5Z0lMUEE1dGRmTEhiWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746694699),
('Pp2kgDfb8m0w8KNINhMXHj2Mj6yo7yETMO4NFkPm', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOXVmVkxvMDB5WTJuTFlYTm9lbkNZeWFvZW5kclBBUEJCUXZFYjJwWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746702474),
('RHKPCFHsTR3g1OPYpddYReOT0oC1u2zlX7Ys3cSU', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieldFbWVkS3dhTkFiUWd1dkIzZEZhNEdHRVFXeUZIbldvMHd0UW9YWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746691284),
('rHzSbGEBUGPYxBREit8YUs4QpVmeVdXhDtvdSQD3', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTnJJa1JvejdxMDhqWnBMdWFOTElCZHhUR1pGa3E0N2ZGVXB3STZleSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746702613),
('Sg87RTN36wqKqraV0TF3RgSjhjG1qdQbEiLob5k2', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMjRsWTEzRWFSWTJHNG9sRlQ5UVRDajkzNnpvY1RYaVh6SFppejJHaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746678980),
('TqJdSAzDQyEQqrW49MI8HUR5bnGHCvPSmcYCm1aS', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV2xUV2JkNW9yWGptSVBVbGU5bDdmVjZYWndGa0QxSXk2dEpNN25WeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746687305),
('Vl4LnQ9x2STbEjL34SshWTaTMNtldClrxDHI2q3x', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMzRSUDlvWTNXakdjalNKZmZTVXdDWm9tM0Z4NG9oeUp1eVY4NU9IRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746702514),
('WcKbH1UXj5J95kRFCX5scw9pUaw0nsuT2Ii1kZf2', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWFJybUNMNWlqTThHQm10eHBveGZ5elNJb3JDaUpaWFRsUW8zVGhHUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746700754),
('yoatefUcVR64KHiyTuYsz5NBof9iM5suE6OSwu7a', NULL, '192.168.101.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicFRhUW9PNnIzMU82WU5sblVJdG9Mc1BaWXRWa1VlT1VYZWQwN0VrTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vd2EuYWNpYmQuY29tL3N0YWdnaW5nX2ludmVudG9yeSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746701604);

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

DROP TABLE IF EXISTS `sub_categories`;
CREATE TABLE IF NOT EXISTS `sub_categories` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `categories_id` bigint UNSIGNED NOT NULL,
  `status` int NOT NULL COMMENT '0=active, 1=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sub_categories_categories_id_foreign` (`categories_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `name`, `categories_id`, `status`, `created_at`, `updated_at`) VALUES
(21, 'Rice, Lentils, and Flour', 11, 1, '2025-04-21 21:30:38', '2025-04-21 21:30:38'),
(22, 'Masala Power', 13, 1, '2025-04-21 21:49:27', '2025-04-21 21:49:27'),
(23, 'Soybean, Mustard, Coconut', 12, 1, '2025-04-21 21:56:54', '2025-04-21 21:56:54'),
(24, 'Soap. Detergent, Tissue', 14, 1, '2025-04-21 22:00:05', '2025-04-21 22:00:05'),
(25, 'Rice', 16, 1, '2025-04-23 06:24:35', '2025-04-23 06:24:35'),
(26, 'Meat 1', 6, 1, '2025-04-24 00:14:54', '2025-04-24 00:14:54'),
(27, 'Meat 2', 6, 1, '2025-04-28 10:27:57', '2025-04-28 10:27:58'),
(28, 'Mudi Prodct', 17, 1, '2025-04-30 01:02:16', '2025-04-30 01:02:16');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE IF NOT EXISTS `suppliers` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `company` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL COMMENT '0=active, 1=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `email`, `phone`, `company`, `address`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Bismillah store', 'bismillah@gmail.com', '01736699819', 'Bismillah store', 'Dhaka tejgaon', 1, '2025-03-13 03:22:11', '2025-04-21 21:16:28'),
(2, 'Sajib store', 'sajib@gmail.com', '01735689896', 'Sajib store', 'Dhaka tejgaon', 1, '2025-03-13 05:21:48', '2025-04-21 21:16:40'),
(4, 'ACI Limited', 'aci@gmail.com', '01782521705', 'ACI Limited', 'Dhaka tejgaon', 1, '2025-03-18 22:40:49', '2025-04-21 21:16:07'),
(5, 'PRAN-RFL Group', 'rfl@gmail.com', '01782521705', 'PRAN-RFL Group', 'Dhaka tejgaon', 1, '2025-04-16 21:51:49', '2025-04-21 21:15:58'),
(6, 'Noor Jahan Traders', 'test@gmail.com', '01714340103', 'Noor Jahan Traders', 'Sh-76 , Ali Complex Tetul Tola Road, Uttor Badda Bazar, Badda, Dhaka - 1212', 1, '2025-04-22 05:41:18', '2025-04-22 05:41:18');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Milan Hossain', 'milan@gmail.com', NULL, '$2y$12$FPbphhjOpXQkPJlb46SvyOYu7XUWnay/jPcgk1X9xbKwme0ZyPgz.', NULL, '2024-10-21 07:35:12', '2024-10-21 07:35:12'),
(3, 'sajib', 'sajib@gmail.com', NULL, '$2y$12$Z8qiPjPZbfI0eZCf1eTlJ.LhG16YcYgB.3oGm2gjz6pgwOLv7cjqW', NULL, '2025-03-16 23:51:07', '2025-03-16 23:51:07');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_categories_id_foreign` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_subcategories_id_foreign` FOREIGN KEY (`subcategories_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_suppliers_id_foreign` FOREIGN KEY (`suppliers_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sales_add`
--
ALTER TABLE `sales_add`
  ADD CONSTRAINT `sales_add_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sales_add_sales_manage_id_foreign` FOREIGN KEY (`sales_manage_id`) REFERENCES `sales_manage` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sales_manage`
--
ALTER TABLE `sales_manage`
  ADD CONSTRAINT `sales_manage_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `sub_categories_categories_id_foreign` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
