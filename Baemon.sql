-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 15 2026 г., 15:13
-- Версия сервера: 5.7.39
-- Версия PHP: 8.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `Baemon`
--

-- --------------------------------------------------------

--
-- Структура таблицы `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_03_12_164838_create_personal_access_tokens_table', 1),
(5, '2026_03_12_203708_create_videos_table', 2),
(6, '2026_03_20_204058_add_background_fields_to_users_table', 3),
(7, '2026_03_20_211851_add_background_fields_to_users_table', 4),
(8, '2026_04_03_220206_create_roles_table', 5),
(9, '2026_04_03_220320_create_permissions_table', 5),
(10, '2026_04_03_220426_create_role_user_table', 5),
(11, '2026_04_03_220513_create_permission_role_table', 5),
(12, '2026_04_03_220555_add_is_blocked_to_users_table', 5),
(13, '2026_04_14_132605_create_news_table', 6),
(14, '2026_04_14_141758_create_news_photos_table', 6);

-- --------------------------------------------------------

--
-- Структура таблицы `news`
--

CREATE TABLE `news` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `news_date` date NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'general',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `news`
--

INSERT INTO `news` (`id`, `title`, `slug`, `description`, `user_id`, `news_date`, `category`, `created_at`, `updated_at`) VALUES
(1, 'BABYMONSTER are returning with new mini album-Choom', 'babymonster-new-mini-album-choom', 'Hello, this is YG ENTERTAINMENT.\r\n\r\nWe would like to announce the release of BABYMONSTER 3rd MINI ALBUM [춤 (CHOOM)], Delivering the moment when music and dance bring everyone together as one.\r\n\r\nStarting from Monday, March 30th, you can pre-order the album at various online and offline music stores. Please see below for more details.\r\n\r\n◆ BABYMONSTER 3rd MINI ALBUM [춤 (CHOOM)] Crimson / Metallic / Prism Ver. ◆\r\n▶️ Release Date : 2026. 05. 04 (Mon) 18:00 KST\r\n▶️ Pre-order Date : 2026. 03. 30 (Mon) 11:00 ~ 2026. 05. 03 (Sun) 23:59 KST\r\n▶️ Price : 18,600KRW (VAT included)\r\n* Album contents may change during the production process.\r\n* BABYMONSTER 3rd MINI ALBUM [춤 (CHOOM)] Plush Keyring Ver. are made of paper certified by FSC and printed with biodegradable soy ink.\r\n\r\n▶ PRE-ORDER : https://babymonster.lnk.to/CHOOM_preorder\r\n* For detailed information regarding album pre-orders, please contact each store directly.\r\n\r\nWe kindly ask for your continued support and interest.\r\nThank you.', 3, '2026-04-14', 'album', '2026-04-14 11:51:04', '2026-04-14 12:22:16'),
(2, '2026-27 BABYMONSTER WORLD TOUR [춤 (CHOOM)] IN SEOUL ANNOUNCEMENT', '2026-27-babymonster-world-tour-choom-announcement', 'accompanying person.\r\n▶ On show day, ticket collection requires verification of wheelchair use, a welfare card. Failure to present the required documents will result in restrictions on ticket collection, including for accompanying persons. Tickets cannot be collected by or transferred to others.\r\n\r\n[IMPORTANT INFORMATION]\r\n▶ If you delete your NOL ticket account before the concert date and cannot verify your booking information, entry may be restricted.\r\n▶ To prevent illegal trading or transfers, entrance will be restricted if your ID does not match the name on the reservation. Please bring valid identification.\r\n▶ Ticket transfers, purchases by proxy, forgeries, or any unauthorized actions outside the officially designated ticket retailers are strictly prohibited.\r\n▶ Abnormal or fraudulent activities (e.g., using automated programs, purchasing tickets for resale, etc.) will result in immediate ticket cancellation or restriction without prior notice.\r\n▶ Tickets purchased through individual transfers or illegal proxy services may result in legal penalties. The purchasing party assumes full responsibility for any resulting issues. Event organizers and ticket retailers will not be liable for damages caused by failing to follow these guidelines. Please ensure proper ticketing to avoid any inconveniences.\r\n▶ Further details and updates may be announced separately. Please stay tuned for updates.\r\n\r\n[CONCERT ORGANIZERS]\r\n■ Presented by: YG ENTERTAINMENT\r\n■ Inquiries: NOL Ticket Customer Service Center (1544-1555)\r\n\r\nThank you.', 3, '2026-04-14', 'announcement', '2026-04-14 14:27:56', '2026-04-14 14:27:56'),
(3, '[춤 (CHOOM)] VISUAL PHOTOS', 'choom-visual-photos', '2026.05.04. 6PM KST\r\n\r\nPre-Order Now.\r\n\r\nhttps://babymonster.Ink.to/CHOOM_preorder\r\n\r\nPre-Save Now.\r\n\r\nbio.to/ygbabymonster-choom\r\n\r\n#BABYMONSTER #베이비몬스터 #3rdMINIALBUM#CHOOM#AHYEON#아현#YG', 3, '2026-04-15', 'general', '2026-04-14 14:34:05', '2026-04-14 14:34:05');

-- --------------------------------------------------------

--
-- Структура таблицы `news_photos`
--

CREATE TABLE `news_photos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `news_id` bigint(20) UNSIGNED NOT NULL,
  `photo_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `news_photos`
--

INSERT INTO `news_photos` (`id`, `news_id`, `photo_path`, `order`, `created_at`, `updated_at`) VALUES
(1, 1, 'news-photos/GMWhKRRfvhYt4tmakC4cp4zHewIf85mUxnWizKU4.jpg', 0, '2026-04-14 11:51:06', '2026-04-14 11:51:06'),
(2, 1, 'news-photos/3OhLVQPIFDwMS1tQRqS2V8TbT2Lri4SuVJ8iGS5j.jpg', 1, '2026-04-14 11:51:06', '2026-04-14 11:51:06'),
(3, 1, 'news-photos/OlEC9maVUVMx5DHrocmxclqRolTklFTHqk1GbpyT.jpg', 2, '2026-04-14 11:51:06', '2026-04-14 11:51:06'),
(4, 1, 'news-photos/jwKAwJ6FrHu1Y8dT6092bbKTSLoH9WT6ibIPJiZw.jpg', 3, '2026-04-14 11:51:06', '2026-04-14 11:51:06'),
(5, 1, 'news-photos/5ps3vvgKkm1fqAxti6mCtGuCy1PblBK1oxCHk8Zo.jpg', 4, '2026-04-14 11:51:06', '2026-04-14 11:51:06'),
(6, 1, 'news-photos/3LgzUb1bOD4cYWMz1ysm6yqV3OHFKY0d6hKBJCcL.jpg', 5, '2026-04-14 11:51:06', '2026-04-14 11:51:06'),
(7, 1, 'news-photos/dEM0uJxjBvgfB9Ckx9BDJ7vNtBGZfgcbyvvE6xTh.jpg', 6, '2026-04-14 11:51:06', '2026-04-14 11:51:06'),
(8, 1, 'news-photos/KcYxA7p61RYFGDQ3GYvXBrIjTscgTHsU7QxG3w8X.jpg', 7, '2026-04-14 11:51:06', '2026-04-14 11:51:06'),
(9, 1, 'news-photos/gF2HFdiLOtDAkg6NtawPEiLzmzO7Hs0oIfyVwYmZ.jpg', 8, '2026-04-14 11:51:06', '2026-04-14 11:51:06'),
(10, 1, 'news-photos/3xWyna6QYuN8Erw4YoAmRZfSgZQlMJievznlh1ld.jpg', 9, '2026-04-14 11:51:06', '2026-04-14 11:51:06'),
(11, 1, 'news-photos/mhtYyW1OdZV8T26i1kb5Kpg6ZL2GHK1HDHmhpQxe.jpg', 10, '2026-04-14 11:51:06', '2026-04-14 11:51:06'),
(12, 1, 'news-photos/JqwB7GRXDrAxnVE4WPXONBLAzUj2CNcN1QIahrBp.jpg', 11, '2026-04-14 11:51:06', '2026-04-14 11:51:06'),
(13, 2, 'news-photos/EdP6rEysaOhKc039CN3626FsGPvV70exWfi9KSAa.jpg', 0, '2026-04-14 14:27:57', '2026-04-14 14:27:57'),
(14, 3, 'news-photos/FrrlS43MNhD1zKGlWvx7Ag8YbfwAyad0Dx99L1ON.jpg', 0, '2026-04-14 14:34:05', '2026-04-14 14:34:05'),
(15, 3, 'news-photos/08MEAMca2C8agHcm50xsCM1KkhnkizpYUHX85fFn.jpg', 1, '2026-04-14 14:34:05', '2026-04-14 14:34:05'),
(16, 3, 'news-photos/bH20b8nk1tZ3OrQWfLhYUPDxoebckl7u5NHS60Ab.jpg', 2, '2026-04-14 14:34:05', '2026-04-14 14:34:05'),
(17, 3, 'news-photos/rlo2Kv7WaISMKpwMhhv3F6I6ZrgFq7yQWzSkXJ4h.jpg', 3, '2026-04-14 14:34:06', '2026-04-14 14:34:06'),
(18, 3, 'news-photos/Xud95BBCGYp3ezAklWQIrpg15UelhqbHX3ikb2B3.jpg', 4, '2026-04-14 14:34:06', '2026-04-14 14:34:06'),
(19, 3, 'news-photos/43h2agYtpW8tOoFRBz8ilsdOILkVTPvwCJOvxKOg.jpg', 5, '2026-04-14 14:34:06', '2026-04-14 14:34:06');

-- --------------------------------------------------------

--
-- Структура таблицы `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `description`, `group`, `created_at`, `updated_at`) VALUES
(1, 'view_users', 'View Users', NULL, 'users', '2026-04-03 20:16:57', '2026-04-03 20:16:57'),
(2, 'block_users', 'Block/Unblock Users', NULL, 'users', '2026-04-03 20:16:57', '2026-04-03 20:16:57'),
(3, 'manage_roles', 'Manage Roles', NULL, 'users', '2026-04-03 20:16:57', '2026-04-03 20:16:57'),
(4, 'manage_permissions', 'Manage Permissions', NULL, 'users', '2026-04-03 20:16:57', '2026-04-03 20:16:57'),
(5, 'assign_roles', 'Assign Roles to Users', NULL, 'users', '2026-04-03 20:16:57', '2026-04-03 20:16:57'),
(6, 'edit_videos', 'Edit Videos', NULL, 'videos', '2026-04-03 20:16:57', '2026-04-03 20:16:57'),
(7, 'delete_videos', 'Delete Videos', NULL, 'videos', '2026-04-03 20:16:57', '2026-04-03 20:16:57'),
(8, 'upload_videos', 'Upload Videos', NULL, 'videos', '2026-04-03 20:16:57', '2026-04-03 20:16:57'),
(9, 'edit_profile', 'Edit Profile', NULL, 'profile', '2026-04-03 20:16:57', '2026-04-03 20:16:57'),
(10, 'Add News', 'Add News', NULL, NULL, '2026-04-14 11:45:43', '2026-04-14 11:45:43');

-- --------------------------------------------------------

--
-- Структура таблицы `permission_role`
--

CREATE TABLE `permission_role` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `permission_role`
--

INSERT INTO `permission_role` (`id`, `permission_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 2, 1, NULL, NULL),
(3, 3, 1, NULL, NULL),
(4, 4, 1, NULL, NULL),
(5, 5, 1, NULL, NULL),
(6, 6, 1, NULL, NULL),
(7, 7, 1, NULL, NULL),
(8, 8, 1, NULL, NULL),
(9, 9, 1, NULL, NULL),
(10, 6, 2, NULL, NULL),
(11, 7, 2, NULL, NULL),
(12, 8, 2, NULL, NULL),
(13, 9, 2, NULL, NULL),
(14, 9, 3, NULL, NULL),
(15, 8, 3, NULL, NULL),
(18, 6, 5, '2026-04-08 17:45:11', '2026-04-08 17:45:11'),
(19, 10, 2, '2026-04-14 11:45:52', '2026-04-14 11:45:52'),
(21, 10, 1, '2026-04-14 13:02:31', '2026-04-14 13:02:31');

-- --------------------------------------------------------

--
-- Структура таблицы `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'superadmin', 'Super Administrator', 'Has full access to everything including user management', '2026-04-03 20:16:57', '2026-04-03 20:16:57'),
(2, 'admin', 'Administrator', 'Has all access except user management', '2026-04-03 20:16:57', '2026-04-03 20:16:57'),
(3, 'user', 'Regular User', 'Basic user access', '2026-04-03 20:16:57', '2026-04-03 20:16:57'),
(5, 'editor', 'Editor', NULL, '2026-04-08 17:45:05', '2026-04-08 17:45:05');

-- --------------------------------------------------------

--
-- Структура таблицы `role_user`
--

CREATE TABLE `role_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `role_user`
--

INSERT INTO `role_user` (`id`, `role_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 3, NULL, NULL),
(2, 2, 1, '2026-04-07 15:31:36', '2026-04-07 15:31:36'),
(6, 3, 2, '2026-04-14 13:18:49', '2026-04-14 13:18:49'),
(8, 3, 4, '2026-04-14 14:10:36', '2026-04-14 14:10:36'),
(9, 3, 5, '2026-04-14 14:57:04', '2026-04-14 14:57:04');

-- --------------------------------------------------------

--
-- Структура таблицы `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('2i2EepZ0XjS6Q0nL572TzMU8cHL3gm01zYzFMLZf', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRm55NUF2dlJrNWV1bXVIc2JkRGNDRUpRaEpaNklGdDZQS0VVMlNOZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy8yMDI2LTI3LWJhYnltb25zdGVyLXdvcmxkLXRvdXItY2hvb20tYW5ub3VuY2VtZW50Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1776187705),
('2jDQzAVbpd8HBf98syiafUBkEhV5w2Kzqb2QRbCH', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidjNWWnozekEwZU92WEtWdkNUQWxSYm9vNU0yR1Z6NnI4cExYdFdYMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy9jaG9vbS12aXN1YWwtcGhvdG9zIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1776188283),
('3XbTQsyu3Fes023NU1uQzXzMTzaanVNrWMtQO4HG', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV3JMYUhuU3ZMbkY0YktDdzYwVmRSWVNIbmhHS3FMd0tXUUxnbEVWaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy9jaG9vbS12aXN1YWwtcGhvdG9zIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1776253731),
('97zfrkvLl9fDuAZbZeYSv7sHME59XNTTgABsaiYq', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV0gzaWlGYmhmdjJhZXZJemplekRicWdXb1ZEeXJxbDVMMlNFMzNwbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy9jaG9vbS12aXN1YWwtcGhvdG9zIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1776253732),
('Bba0oS0b19eHBXQdduHfHB8Wq7geu2xhHl5bh5k7', 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiamFtcDRiTGlyOWtUQjJhZm92VklFYjRwUFhuUUFtNDJSVDZBV3VCeiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MztzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJFVSLnY0UlFCdUkzc2pMcVRhZFBTaGVtdVk2cllkMU9yRkZ4cFRIRk1XZGNQMFNMakFSNGRpIjt9', 1776253919),
('c2qLGdw1Dw4ycaFb41AEBJCp3KpOKE2plc2rsY8l', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaTRNUXViQWlJdVYzWmVLUVBjcU1DZ3lrWDRxdUU0SEY3aXJZQ0pIRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy9jaG9vbS12aXN1YWwtcGhvdG9zIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1776188081),
('CBK1yJ9PbsP8unsdXZ1JRRgey7i6AfgfJNVKBRIB', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNmNLQmFFMHFPYzRwTDUwb2hVMzQxTGQ3YjlTZlVUeDRsYnhrUFJDbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1776253062),
('enqLVi0F6Vb5j0T8hFRcBDHLl5lM7BHGp9PEQDkJ', 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMmxXYXRodmdxRFBTNnhWd1JDM1YzOHdGSG9NNlpYbmJwV1FZTVlWZCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MztzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJFVSLnY0UlFCdUkzc2pMcVRhZFBTaGVtdVk2cllkMU9yRkZ4cFRIRk1XZGNQMFNMakFSNGRpIjt9', 1776191866),
('ErVifJ0AJLqXzR5vkIluzrTqWNVxmb0srb53lvEd', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM1lCQktER0xKaGdlM0x2NHROc0kzYm9mdE5IUVB5UklCMUxzWVAzUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy9iYWJ5bW9uc3Rlci1uZXctbWluaS1hbGJ1bS1jaG9vbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1776186775),
('FV0nRggdOdlJhGQrCewGLlvsWqn9JoXiCSIJkwTS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNmtqVG9yWVlqazRjOENsZXcwVms4UDl6ZTFkQ0hKMndkS09ycXpqbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy9jaG9vbS12aXN1YWwtcGhvdG9zIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1776189539),
('gIWxUnvYk6dlKtX6zD1FvFXjR2NnfF7cAKdpGNfj', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMnFLTmhlTUx1a1ZuNlNMV1E1UzQ5TUVHTElmNXRDTlQxTVlHNGJCSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy9iYWJ5bW9uc3Rlci1uZXctbWluaS1hbGJ1bS1jaG9vbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1776186774),
('J7LhkteTWfdhSLIDSPy0hzA6LpDX0qA2clvQ5UlZ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS3dZQlZGaHZmOUl3cHRvVGdHSmhoNDk5T1d0NUdhdDBGMjBxaFlKbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy8yMDI2LTI3LWJhYnltb25zdGVyLXdvcmxkLXRvdXItY2hvb20tYW5ub3VuY2VtZW50Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1776187704),
('jeVkLJHGdRTPViRriv6q0Yiq2j9Z4cMtezA69MZh', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicHNFQ1IxRE40a0N2SFJrTWRWRlpST3N4Wnk1WWt3TnRHTE5QU3FhbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy9iYWJ5bW9uc3Rlci1uZXctbWluaS1hbGJ1bS1jaG9vbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1776186502),
('l3tprY9o9kXcw0zqw1jUNatVRtkaup3H7LN8OUSQ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZjR3VkgxMmJUckl0alhHa3F2UGhPemI3SVYyQjNsMjRmdW5TelJ1RyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy9iYWJ5bW9uc3Rlci1uZXctbWluaS1hbGJ1bS1jaG9vbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1776186597),
('o1Wl7FOCxNq9SliW3iibP1KFnFWgg6VZiSbOgAP2', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR0xaWFUzZkRSQmRjUzRPUHNtQlBVaXN0R21xM212MTdWb3JXbUhaOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy9iYWJ5bW9uc3Rlci1uZXctbWluaS1hbGJ1bS1jaG9vbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1776186503),
('PRaB7MdHDV2oZDem2dm9fmLTxa1m66aNuXGxL7wy', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUTRPSGdCUEJzOTVreEM2SklkRnhRdjdpMExHczlTc2NOcjFCMnBqWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy9jaG9vbS12aXN1YWwtcGhvdG9zIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1776188082),
('uDFbTaymUeG5ZIeUhUWc8lmWzkYggbuLDFvXRArZ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidlU1OG52NEpoV3ZCWXQyd0pIbDB2amltc2p3UHF6V3FEUHB1SFRiViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy9jaG9vbS12aXN1YWwtcGhvdG9zIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1776189540),
('xDZw9TqrZ1y6JQlzF6SoEjqEND4J8F10Sr9IcVV0', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM3lITFVXQkQ3QlFqNXR3MDVScFhBRTJPRkh6NUJneFhwejVpdFhodSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy9jaG9vbS12aXN1YWwtcGhvdG9zIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1776188283),
('z5dByBqK3rJTpJacvZ7fXQcT4f7GzKJXkxPvGsbk', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU1NieFpBd3FUWTBPNmdHcTV4VzVSVExSM1BmSjFLQkRzcHh2aXFsZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvbmV3cy9iYWJ5bW9uc3Rlci1uZXctbWluaS1hbGJ1bS1jaG9vbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1776186596);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'prefer_not_to_say',
  `bio` text COLLATE utf8mb4_unicode_ci,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_blocked` tinyint(1) NOT NULL DEFAULT '0',
  `blocked_at` timestamp NULL DEFAULT NULL,
  `blocked_by` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `gender`, `bio`, `avatar`, `background_url`, `is_private`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `is_blocked`, `blocked_at`, `blocked_by`) VALUES
(1, 'aaa', 'aaa@mail.ru', 'prefer_not_to_say', NULL, 'avatars/KzrpnthSZTGUCyqytNJfyS6yn2S7ee5K2pUco5q6.jpg', NULL, 0, NULL, '$2y$12$nPqFV.yjRqyqrdRNUXH1HuF8opyoY4LWE7A5h2qiEaSe9UbWr.1N6', NULL, '2026-03-12 15:48:39', '2026-04-07 16:46:24', 0, NULL, NULL),
(2, 'bbb', 'bbb@mail.ru', 'male', NULL, 'avatars/aFz2jawMbisQKzmfudT7UiBdVPT2e87hCQWypzNk.jpg', NULL, 0, NULL, '$2y$12$9pKHzd9Awr5LYyM/NwV.1.ukD0rr3RTsdv/hQbNrqriv.XCaAJ1S2', NULL, '2026-03-13 08:36:03', '2026-03-13 08:50:47', 0, NULL, NULL),
(3, 'Super Admin', 'superadmin@example.com', 'prefer_not_to_say', NULL, 'avatars/1776191860_choomAsa.jpg', '/uploads/bm/ot6.jpg', 0, '2026-04-03 20:17:11', '$2y$12$UR.v4RQBuI3sjLqTadPShemuY6rYd1OrFFxpTHFMWdcP0SLjAR4di', NULL, '2026-04-03 20:17:11', '2026-04-14 15:37:40', 0, NULL, NULL),
(4, 'ccc', 'ccc@mail.ru', 'male', NULL, NULL, NULL, 0, NULL, '$2y$12$IMDmwxHUca/fCbtfNm9AUuKk0E5bPK9.w4/eZpaEymmtUiMwkmCtS', NULL, '2026-04-08 17:34:01', '2026-04-08 17:34:01', 0, NULL, NULL),
(5, 'mmm', 'mm@gmai.com', 'female', NULL, NULL, '/uploads/bm/ot6.jpg', 0, NULL, '$2y$12$EWt8QR/1Kcg0nvFv5sEfbu.twZmZw47jRFZo76xrEcVWJStsUyL7m', NULL, '2026-04-14 14:57:03', '2026-04-14 15:01:04', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `videos`
--

CREATE TABLE `videos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `video_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `views` int(11) NOT NULL DEFAULT '0',
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `videos`
--

INSERT INTO `videos` (`id`, `title`, `description`, `video_path`, `thumbnail_path`, `duration`, `views`, `user_id`, `created_at`, `updated_at`) VALUES
(6, 'BABYMONSTER - \'DREAM\' (PRE-DEBUT SONG)', '#YG_NEW_GROUP #YG #BABYMONSTER\r\n#BABYMONSTER #베이비몬스터 #DREAM #PRE_DEBUT_SONG #RELEASE #20230514_0AM #YG_NEW_GROUP #YG\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @officialbabymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/In1bIM7H2LRAODOv3efOmn50BoroCPSz5t2yl5sA.mp4', 'thumbnails/grOTEzhgoHCtSqkoiuFFJIwTxN9VRwBaadJZB4xs.jpg', 136, 9, 2, '2026-03-13 12:39:46', '2026-03-13 12:45:54'),
(7, 'BABYMONSTER - \'BATTER UP\' M/V', '#BABYMONSTER #YG #베이비몬스터\r\nBATTER UP\r\n\r\nI’m on a mission\r\nDon’t need permission\r\nNo matter what I’m gonna make my own decisions\r\n\r\nI’m talking you\r\nYou want it too\r\n예쁘고 착한 내가 어떻게 변할지 monster\r\n\r\nRemember Me\r\nSting like a bee\r\n굶주린 사자 같은 personality\r\n\r\n네 맘 빼고 다른 것은 원하지 않아\r\nI would never do you wrong\r\nYou’ll regret it when I’m gone\r\n\r\nYou\r\n좀 더 강하게\r\n더 빠르게\r\n날려 버릴게\r\n\r\nYou\r\nGot a lot to say\r\nWhat a big mistake\r\n\r\nBatter Batter Batter Up\r\nBatter Up Batter Up Batter Up\r\nBatter Batter Batter Up\r\nBatter Up Batter Up Batter Up\r\nBatter Batter Batter Up\r\n\r\nYeah\r\nHit it 난 달려\r\nNever can stop\r\nRappin 시작\r\n네 귀에 shot\r\n비명은 함성이 될 거야 loud\r\n서프라이즈\r\nYo 몬스터의 등장\r\n내가 가는 길이 기리 빛이 나리 way\r\n어깨 펴고 난 Going going gone (gone)\r\n바통 받고 준비 완료\r\n후다닥 Run Run Run Run\r\n\r\n누가 날 막아 난 더 세게 밟아 너네가 좀 알아서 비켜\r\n순진한 척 나는 그딴 거 안 해 날 원해? but look in the mirror\r\n지치지 않아 계속 volume up, light em up\r\n무대 위를 태워 싹 다 치워버려 homerun\r\nLike a Boss Baby Imma Boss Baby\r\n모두 다 찢어 Iike brrra\r\n\r\nRemember Me\r\nSting like a bee\r\n무대를 갖고 노는 우린 MVP\r\n\r\n네 맘 빼고 다른 것은 원하지 않아\r\nI would never do you wrong\r\nYou’ll regret it when I’m gone\r\n\r\nYou \r\n좀 더 강하게\r\n더 빠르게\r\n날려 버릴게\r\n\r\nYou\r\nGot a lot to say\r\nWhat a big mistake\r\n\r\nBatter Batter Batter Up\r\nBatter Up Batter Up Batter Up\r\nBatter Batter Batter Up\r\nBatter Up Batter Up Batter Up\r\nBatter Batter Batter Up\r\n\r\nSo listen up, everybody\r\n소릴 높여 Move on\r\nWe are the Monsters of the world\r\nBatter up 지금 당장\r\n뛰어보자 어디든\r\nLet me show you who we are\r\n(Batter up up up up)\r\n\r\nEverybody\r\n소릴 높여 Move on\r\nWe are the Monsters of the world\r\nBatter up 지금 당장\r\n뛰어보자 어디든\r\nLet me show you who we are\r\n(Batter Batter Batter up)\r\n\r\n#BABYMONSTER #베이비몬스터 #DigitalSingle #BATTER_UP #MV #OUTNOW #YG\r\n\r\nAvailable @ https://BABYMONSTER.lnk.to/BATTERUP\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144', 'videos/euGyOPISSvFcs4tNsJvoTQH8pBuc8oSCMKyys7JQ.mp4', 'thumbnails/fPg05pPAplQWnqSTVcohRqsNxJifWfQ1UUTU5WpL.jpg', 755, 3, 2, '2026-03-13 12:49:15', '2026-03-13 14:10:03'),
(8, 'BABYMONSTER - \'BATTER UP\' DANCE PERFORMANCE (DEBUT SPECIAL)', '#BABYMONSTER #YG #베이비몬스터\r\n#BABYMONSTER #베이비몬스터 #DigitalSingle #BATTER_UP #DANCE_PERFORMANCE #DEBUT_SPECIAL #YG\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/4cl6ciqicY5sIlj1aAw0AWbgbd3NJTLCuDZpG5ra.mp4', 'thumbnails/m3YS9qcCRG0V8fNya4gj3GLWkYlqSAw9WBnywShG.jpg', 131, 1, 1, '2026-03-13 19:26:48', '2026-03-13 19:27:17'),
(9, 'BABYMONSTER - \'BATTER UP\' DANCE PRACTICE VIDEO', '#BABYMONSTER #YG #DancePractice\r\n#BABYMONSTER #베이비몬스터 #DigitalSingle #BATTER_UP #DancePractice #YG\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/NjZdUBTZ0uwq2xvDFvSQ6NdQGWJhBATSIAT4X4LM.mp4', 'thumbnails/itChCiDP8ORNPzvnR0h51brNdW8D8rKIitaOegj3.jpg', 136, 0, 1, '2026-03-13 19:30:49', '2026-03-13 19:30:49'),
(10, 'BABYMONSTER - \'Stuck In The Middle\' M/V', '#StuckInTheMiddle #YG #PreReleaseSingle\nStuck In The Middle\n\nAll this time we’ve been together\nAnd I still don’t know how you feel\nSometimes I wish you’d just\nTalk to me\n \nMaybe it’s make believe\nMaybe it can be true\nI try to tell myself\nI’m not in love with you\nI thought that I knew everything\nI guess I don’t know anything, yeah\nI get emotional \nAnd hypothetical\nWondering if there are all kinds of things\nI’m not supposed to know\nI try my best to let it go\nBaby then you bring me back\nBring me back\n \nYou lift my feet off of the ground\nKeep me spinning around and around\nI don’t ever wanna come down\nFrom your arms\n \nYou tell me that you need me\nThen you walk away\nKeep promising forever\nWith the words you say\nIt’s true\nDon’t know what I’m supposed to do\n \nI’m stuck in the middle with you you you\nWith you you\nOh boy you got me really confused\nDon’t know what I’m supposed to do\nI’m stuck in the middle with you\n \nYou were the spark\nLight in the dark\nGave you my everything\nPulling me in\nPushing me out\nPulling me back again\nDon’t know if your mind is made up\nBut I know that nobody wanna be stuck\nYou are the one that I want\nAll I can promise you now is my love\n \nYou say you want me \nYou say you care\nWhen we’re together \nAre you even there\nAnd you\nGave me the keys (to your heart)\nYeah you \nMade me believe (from the start)\nNow all that I know is \nI got all this love I won’t take back\n \nMy love\nMy love\nMy love\nMy love\n \nYou lift my feet off of the ground\nKeep me spinning around and around\nI don’t ever wanna come down\nFrom your arms\n \nYou tell me that you need me\nThen you walk away\nKeep promising forever\nWith the words you say\nIt’s true\nDon’t know what I’m supposed to do\nI’m stuck in the middle with you you you\nWith you you\nOh boy you got me really confused\nDon’t know what I’m supposed to do\nI’m stuck in the middle with you\n \nI’ve tried and I’ve tried to be good to myself\nGood for my health\nIs it selfish\nIf I’m constantly turning to you\nTo you\nIf you knew what I’m feeling right now\nYou’d comfort my heart\n \nYou tell me that you need me\nThen you walk away\nKeep promising forever\nWith the words you say\nIt’s true\nDon’t know what I’m supposed to do\n \nI’m stuck in the middle with you you you\nWith you you\nOh boy you got me really confused\nDon’t know what I’m supposed to do\nI’m stuck in the middle with you\n\n#BABYMONSTER #베이비몬스터 #PreReleaseSingle #StuckInTheMiddle #MV #OUTNOW #YG\n\nAvailable @ https://BABYMONSTER.lnk.to/StuckInThe...\n\nMore about BABYMONSTER @\nOfficial YouTube    / @babymonster  \nOfficial Instagram   / babymonster_ygofficial  \nOfficial Facebook   / babymonster.ygofficial  \nOfficial Twitter   / ygbabymonster_  \nOfficial TikTok   / babymonster_yg_tiktok  \nOfficial Weibo https://weibo.com/u/7811488144\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/Stuck in the middle.mp4', 'thumbnails/thumb_68f38e3be36736.59647665.webp', 124, 5, 1, '2026-03-14 09:37:41', '2026-03-14 09:55:54'),
(11, 'BABYMONSTER - ‘SHEESH’ M/V', '#BABYMONS7ER #YG #BABYMONSTER\nBABYMONSTER — SHEESH\n\nDa la lun dun\nDa la lun dun\nDa la lun dun\n\nBABY I’mma MONSTER\n\nMano a mano\nI see you in slow mo’\nYou know you’re in trouble\nOoh hoo hoo hoo\n\n발버둥 쳐봐\n어차피 손바닥\n위에서 못 나가\nYou know that\n\n눈을 뜬 순간\n피어나\nAll eyes on me\n불을 질러라\n\nDo or die\nOn my life\nYeah you ain’t seen nothing yet\n\nGot them all going\nSheesh Sheesh\nSheesh Sheesh Sheesh yeah\n\nB.A.B.Y.M.O.N\nSheesh Sheesh\nSheesh Sheesh Sheesh yeah\nGot them all going\n\nYo hold on 쉿\n걍 들이부어라 네 달팽이관에\n이건 네 귀에 줄 축복\n음악에 맞춰 걍 춤 춰\n\n히비리 합 합 boom boom pow\n분위기 타올라 너네들 눈 돌아\n띵하니 적잖이 충격일 거야\n\nCrown this queen\n홈런은 쳤고 내 다음은 위\n어중이떠중이 중간 아님\n날 보고 닫혔던 입들 say\nSheesh Sheesh Sheesh\n\nYou know what it is\nI be running this\nPull up in a ghost\nPeek a peek a boo hoo\nVroom vroom\n너네 심장에 박동이 pump pump pop\nPedal to the metal\nClick clack click\nPut’em up to the sky\nHigh high high high\n\n눈을 뜬 순간\n피어나\nAll eyes on me\n불을 질러라\n\nDo or die\nOn my life\nYeah you ain’t seen nothing yet\n\nGot them all going\nSheesh Sheesh\nSheesh Sheesh Sheesh yeah\n\nB.A.B.Y.M.O.N\nSheesh Sheesh\nSheesh Sheesh Sheesh yeah\nGot them all going\n\n마음껏 웃어봐\n이젠 내 차례니까\n\n천천히 불태워 네가 잠든 사이\n\nTime’s up\n올라가 올라가 더\n\n꼭대기 꼭대기로\n하늘 위 하늘 위로\n\nFly away\n온 세상을 뒤집어\nCome on let’s ride\n\nBABY I’mma MONSTER\n\nB A B Y M O N\nTell a friend tell a friend tell a friend\nB A B Y M O N\nTell a friend tell a friend tell a friend\n\nLet\'s go\nJump jump and let it go\nWatch out we on a roll\nRum pump pump pump it up then\n\nJump jump and let it go\nWatch out we on a roll\nRum pump pump pump it up then\n\n#BABYMONSTER #베이비몬스터 #1stMINIALBUM #BABYMONS7ER #SHEESH #MV #OUTNOW #YG\n\nAvailable @ https://BABYMONSTER.lnk.to/BABYMONS7ER \n\nMore about BABYMONSTER @\nOfficial YouTube    / @babymonster  \nOfficial Instagram   / babymonster_ygofficial  \nOfficial Facebook   / babymonster.ygofficial  \nOfficial Twitter   / ygbabymonster_  \nOfficial TikTok   / babymonster_yg_tiktok  \nOfficial Weibo https://weibo.com/u/7811488144\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/bcUgk8VUJXkQrRxLbQwY2b50kblZYNQmfFJykzeG.mp4', 'thumbnails/JYqOlxlcyslnAnVT57dOl8n6uhe6bunDIhe4bT7q.jpg', 196, 1, 1, '2026-03-14 09:54:00', '2026-03-14 09:54:55'),
(12, 'BABYMONSTER - ‘SHEESH’ PERFORMANCE VIDEO', '#BABYMONS7ER #PerformanceVideo #YG\n#BABYMONSTER #베이비몬스터 #1stMINIALBUM #BABYMONS7ER #Title #SHEESH #PerformanceVideo #YG\n\nMore about BABYMONSTER @\nOfficial YouTube    / @babymonster  \nOfficial Instagram   / babymonster_ygofficial  \nOfficial Facebook   / babymonster.ygofficial  \nOfficial Twitter   / ygbabymonster_  \nOfficial TikTok   / babymonster_yg_tiktok  \nOfficial Weibo https://weibo.com/u/7811488144\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/nHkYJdqz9N46UFTbwmHx7kzVBhfRQJXkedqNaHWK.mp4', 'thumbnails/3Q8uqtiRRaFzuz9RitX1fGc0B86EVlsjHC8IGcbc.jpg', 120, 0, 1, '2026-03-14 09:58:45', '2026-03-14 09:58:45'),
(13, 'BABYMONSTER - \'LIKE THAT\' EXCLUSIVE PERFORMANCE VIDEO', '#PerformanceVideo #LIKE_THAT #YG\r\nBABYMONSTER — LIKE THAT\r\n\r\nI see that look upon your face\r\nSomething my mind cannot erase\r\nIf we keep staring\r\nThen I might have to\r\n\r\nMight have to start to walk your way\r\nI wanna hear what you would say \r\nYou got high standards\r\nAnd I do too\r\n\r\nCause all those girls\r\n(They don’t)\r\nKnow what you need\r\n(They don’t)\r\nBut I know I know\r\nThe way the way\r\nTo make to make sure you never leave\r\n\r\nIf I come close baby would you like that\r\nIf I give some would you give it right back\r\nIf I show you that I know where it’s at\r\nBaby would you like that\r\nBaby would you like that\r\n\r\nSay you want love boy I know what that means\r\nMake you feel way better than in your dreams\r\nIf I show you that I know where it’s at\r\nBaby would you like that\r\nBaby would you like that\r\n\r\nYo it’s like that like that\r\nHow you run it right back\r\nknow you on the right track\r\nQueen ace blackjack\r\nI be thinking way too much\r\nI need to let it go\r\nYou be running through my mind\r\nAnd I’mma let it show\r\n\r\nCause ain’t nobody stepping up to me\r\nAnd saying nothing when I calling you \r\nBe running eye to eye we never fronting yeah\r\nWe zoning bet we stunting on and on and on and\r\nTo the top baby boy we be rolling\r\n\r\nCause all those girls\r\n(They don’t)\r\nKnow what you need\r\n(They don’t)\r\nBut I know I know\r\nThe way the way\r\nTo make to make sure you never leave\r\n\r\nIf I come close baby would you like that\r\nIf I give some would you give it right back\r\nIf I show you that I know where it’s at\r\nBaby would you like that\r\nBaby would you like that\r\n\r\nSay you want love boy I know what that means\r\nMake you feel way better than in your dreams\r\nIf I show you that I know where it’s at\r\nBaby would you like that\r\nBaby would you like that\r\n\r\nI want you\r\nIn my arms\r\nIn my arms\r\nMy arms\r\nThat’s where you need to be\r\n\r\nIn my arms\r\nIn my arms\r\nMy arms\r\nThat’s where you need to be\r\n\r\nAh ah ah ah\r\nBut I know I know\r\nThe way the way\r\nTo make to make sure you never leave\r\n\r\nIf I come close baby would you like that\r\nIf I give some would you give it right back\r\nIf I show you that I know where it’s at\r\nBaby would you like that\r\nBaby would you like that\r\n\r\nSay you want love boy I know what that means\r\nMake you feel way better than in your dreams\r\nIf I show you that I know where it’s at\r\nBaby would you like that\r\nBaby would you like that\r\n\r\nIf I come close baby would you like that\r\nIf I give some would you give it right back\r\nIf I show you that I know where it’s at\r\nBaby would you like that\r\nBaby would you like that\r\n\r\nSay you want love boy I know what that means\r\nMake you feel way better than in your dreams\r\nIf I show you that I know where it’s at\r\nBaby would you like that\r\nBaby would you like that\r\n\r\n#BABYMONSTER #베이비몬스터 #LIKE_THAT #EXCLUSIVE #PerformanceVideo #YG\r\n\r\nMore about BABYMONSTER @ https://BABYMONSTER.lnk.to/BABYMONS7ER \r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232..', 'videos/BlqY502npcvgj00RJL4NuYJVGn3Ibo1ToQVz7MGy.mp4', 'thumbnails/GcoFuzXNA2jFnVvGhyjH4OFpxPCFQZIUUU0zhvhL.jpg', 100, 0, 1, '2026-03-14 10:40:38', '2026-03-14 10:40:38'),
(14, 'BABYMONSTER - ‘LIKE THAT’ DANCE PERFORMANCE VIDEO', '#LIKE_THAT #YG #BABYMONSTER\r\n#BABYMONSTER #베이비몬스터 #LIKE_THAT #DancePerformance #YG\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/u5sTHxzY9Zp2NXBZwnakxrjlmjnmhpdPUzmX4XbG.mp4', 'thumbnails/h9HxlxHTexi3HcSEIEQAgkkSg57ZNhao4TPeO2p0.jpg', 120, 0, 1, '2026-03-14 10:43:30', '2026-03-14 10:43:30'),
(15, 'BABYMONSTER - ‘MONSTERS (Intro)’', '#BABYMONS7ER #YG #BABYMONSTER\r\nMONSTERS (INTRO)\r\n\r\nThere’s a new kind of monster\r\nGo on and tell your friends\r\nPromise you that we’ll haunt ya\r\nAgain and again and again\r\n\r\nGonna be getting stronger\r\nWith every step we take\r\nNot waiting any longer\r\nBetter get out of our way\r\n\r\nWe are the MONSTERS\r\nGet ready here we come\r\nThe BABY MONSTERS\r\nOutnumber you 7 to 1\r\nWe’re BABYMONSTER\r\n\r\n#BABYMONSTER #베이비몬스터 #1stMINIALBUM #BABYMONS7ER #MONSTERS #Official_Audio #YG\r\n\r\nAvailable @ https://BABYMONSTER.lnk.to/BABYMONS7ER \r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/7EY27Cbk5cXMSy7RfwwvPj3fGeN2bGqiGeg0u7o9.mp4', 'thumbnails/FEtmpyWnACKrqR7P9CixewzeKYJC83rudFBen21g.jpg', 229, 0, 1, '2026-03-14 10:45:09', '2026-03-14 10:45:09'),
(16, 'BABYMONSTER - \'FOREVER\' M/V', '#BABYMONSTER #YG #베이비몬스터\r\nFOREVER\r\n\r\nAlright ok ok ok ok\r\nAlright ok\r\nBABYMONSTER\r\n\r\nI got no worries on my mind\r\n난 멈추지 않아\r\nSo you can say goodbye\r\n\r\nI’ll fulfill my fantasy\r\nAnd you can watch and see\r\n박수나 쳐보지\r\n\r\n눈부셔\r\nThey say she looking flawless\r\nI know\r\n타고났지 Like this\r\n\r\nShe’s unlike unlike anybody\r\n여기저기 다 난리 난리\r\n가나다라마바 싸가지\r\nGotta gotta go so c’est la vie\r\n\r\nI’m dancing in the moonlight\r\nOoh ooh ooh ooh ooh ooh\r\nOoh ooh ooh ooh ay\r\n\r\nCan’t stop this feeling tonight\r\nWhat you waiting for\r\n\r\nBaby it was all a dream\r\nYou thought I was yours\r\n멋대로 착각하지는 마\r\n\r\nIt’s bitter it’s sweet\r\n저 하늘 높이\r\nI’m spreading my wings\r\nLike I’mma live\r\n\r\nForever\r\nLike I’mma live forever\r\nForever\r\nLike I’mma like I’mma\r\n\r\nForever\r\nLike I’m gonna live\r\nLike I’m gonna live forever\r\n\r\nOK you know what it is\r\n\r\nI’m that nice 뭘 것 같아 너와 내 차이\r\nPull up on me pay the price\r\nPut a milli on a rock my type\r\nNever seen it in your life\r\n\r\n예뻐 그러니까 바빠 아니 나빠 온 세상 울리는 Bad girl\r\nB (B) A (A) B (B) Y (Y) M (M) O (O) N\r\nGet money\r\n\r\nBout it bout it 발끝까지 까지\r\n리듬 타지 타지 기분 짜릿짜릿\r\nEverybody get down\r\nRoll up on ‘em with the motor running\r\nI’mma give you something\r\nBet you put the money in the bag\r\n\r\nI’m dancing in the moonlight\r\nOoh ooh ooh ooh ooh ooh\r\nOoh ooh ooh ooh ay\r\n\r\nCan’t stop this feeling tonight\r\nWhat you waiting for\r\n\r\nBaby it was all a dream\r\nYou thought I was yours\r\n멋대로 착각하지는 마\r\n\r\nIt’s bitter it’s sweet\r\n저 하늘 높이\r\nI’m spreading my wings\r\nLike I’mma live\r\n\r\nForever\r\nLike I’mma live forever\r\nForever\r\nLike I’mma like I’mma\r\n\r\nForever\r\nLike I’m gonna live\r\nLike I’m gonna live forever\r\n\r\nI can see the bright horizon\r\n세상이란 벽을 넘어서\r\nNo nothing can stop me now\r\n\r\nWe forever forever\r\nForever ever ever\r\n\r\nOoh ooh\r\nBaby it was all a dream\r\nYou thought I was yours\r\n멋대로 착각하지는 마\r\n\r\nIt’s bitter it’s sweet\r\n저 하늘 높이\r\nI’m spreading my wings\r\nLike I’mma live\r\n\r\nForever (Forever ever ever)\r\nForever (We forever forever forever ever ever)\r\nForever\r\n\r\nLike I’m gonna live\r\nLike I’m gonna live forever\r\n\r\n#BABYMONSTER #베이비몬스터 #DigitalSingle #FOREVER #MV #OUTNOW #YG\r\n\r\nAvailable @ https://BABYMONSTER.lnk.to/_FOREVER\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/RHu8UZTqDJADEzXgcQtqQd1noDLwqwFGLu7uYFk1.mp4', 'thumbnails/1lx0moNAC3Wv0Lp6dW9Wo7qy6g9JtQjqmIsZwdAP.jpg', 151, 0, 1, '2026-03-14 10:49:21', '2026-03-14 10:49:21'),
(17, 'BABYMONSTER - ‘FOREVER’ PERFORMANCE VIDEO', '#YG #BABYMONSTER #베이비몬스터\r\n#BABYMONSTER #베이비몬스터 #FOREVER #DancePerformance #YG\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/Qs6DrjTOhpRVrHUOGBknd8XS3cRstNxzU0YwTHka.mp4', 'thumbnails/1znNLf2x1w31twUam1Oj8uMOnxPjTluWOPxAHNkP.jpg', 1287, 0, 1, '2026-03-14 11:11:12', '2026-03-14 11:11:12'),
(18, 'BABYMONSTER - \'DRIP\' M/V', '#BABYMONSTER #DRIP #YG\r\nDRIP\r\n\r\nWhen I dress I don’t think so much\r\nI could be the GOAT\r\nI don’t need too much\r\nI’mma set a goal\r\nI’mma eat that lunch\r\nBaby so cold get that ice cream truck\r\n\r\n찌릿찌릿 끼리끼리 놀아볼까\r\nKitty kitty yeah we gonna run this town\r\nHittin’ me up cause I got what they like\r\nBaby got no chance better hit that dance\r\n\r\nMmm, na-na-na\r\nI’ll be there 고민하지 마\r\nUh, na-na-na\r\nI’ll be there 망설이지 마\r\n\r\nBut you don’t know ’bout me\r\nYeah yeah, you gon’ know ’bout me boy\r\n아름다운 별들이 빛나는 밤이야\r\n\r\nMmmh, what you say\r\n끝없는 가치\r\nYou know it’s all me\r\n\r\nGot that\r\nOoh, what you say\r\nAre you ready?\r\nSet, turn on the lights\r\n\r\nBaby got passion, ambition\r\n난 보란 듯이\r\nLook at that\r\n온몸으로 느끼는 내 몸짓\r\n\r\nBaby got\r\nDrip, drip, drip, drip, drip, drip, drip\r\nBaby got\r\nDrip, drip, drip, drip, drip, drip, drip\r\n\r\nLet ’em out\r\nMonster, monster, monster came to conquer\r\nBaby, holla wassup\r\nWe the best, the rest confess, we blessed\r\n판을 180도 바꿔\r\n\r\nY to the G, no copy, no Knock off\r\nBet on my life this pitch I’m gon’ walk-off\r\nMONSTIEZ 꽉 잡아 Hold tight\r\n끝까지 밟아\r\nYou know we gon’ ride\r\n\r\nMmm, na-na-na\r\nI’ll be there 고민하지 마\r\nUh, na-na-na\r\nI’ll be there 망설이지 마\r\n\r\nBut you don’t know ’bout me\r\nYeah yeah, you gon’ know ‘bout me boy\r\n아름다운 별들이 빛나는 밤이야\r\n\r\nMmmh, what you say\r\n끝없는 가치\r\nYou know it’s all me\r\n\r\nGot that\r\nOoh, what you say\r\nAre you ready?\r\nSet, turn on the lights\r\n\r\nBaby got passion, ambition\r\n난 보란 듯이\r\nLook at that\r\n온몸으로 느끼는 내 몸짓\r\n\r\nBaby got\r\nDrip, drip, drip, drip, drip, drip, drip\r\nBaby got\r\nDrip, drip, drip, drip, drip, drip, drip\r\n\r\n가끔 쓰러진대도\r\nI’mma shine as bright as diamonds\r\nSay my name\r\n다시 일어나\r\nNow watch me do it all again\r\n\r\nBaby got drip, drip, drip\r\nBaby got, baby got, baby got\r\nDrip, drip, drip\r\nYou know we got got that drip\r\n\r\nBaby got drip, drip, drip\r\nBaby got, baby got, baby got\r\nDrip, drip, drip\r\nGot that drip yeah\r\n\r\n#BABYMONSTER #베이비몬스터 #1stFULLALBUM #DRIP #MV #OUTNOW #YG\r\n\r\nAvailable @ https://BABYMONSTER.lnk.to/DRIP\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/aTGDEdBlkUbL4DS9g7G97lY173MNRgQf7BQtj8la.mp4', 'thumbnails/8ixIDpCC5me1633prf0PsBsTDokBqB8jkFUgQSoR.jpg', 138, 0, 1, '2026-03-14 11:13:53', '2026-03-14 11:13:53'),
(19, 'BABYMONSTER - ‘DRIP’ SPECIAL DANCE PERFORMANCE VIDEO', '#PerformanceVideo #YG #DRIP\r\n#BABYMONSTER #베이비몬스터 #1stFULLALBUM #DRIP #SPECIAL #PerformanceVideo #YG\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232..', 'videos/c2n3Jbofkw9F6fpOvpwcxSiFmzrnlk1sZrgaGXqQ.mp4', 'thumbnails/yNXaPG6M75CaxqEZou5KT8GUWR5XZoeDDjdTgOWR.jpg', 150, 0, 1, '2026-03-14 11:17:48', '2026-03-14 11:17:48'),
(20, 'BABYMONSTER - ‘DRIP’ DANCE PERFORMANCE VIDEO', '#PerformanceVideo #YG #DRIP\r\n#BABYMONSTER #베이비몬스터 #1stFULLALBUM #DRIP #SPECIAL #PerformanceVideo #YG\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232..', 'videos/d8mFPIikKwhWBiWCoRlwhWFzg9QCRKai78rKWqo3.mp4', 'thumbnails/LAwKgjjw0B9oa4muDQfGoA7WzmZOJi808vdP0QlG.jpg', 94, 0, 1, '2026-03-14 11:19:50', '2026-03-14 11:19:50'),
(21, 'BABYMONSTER - \'CLICK CLACK\' M/V', '#CLIKCLAK #BABYMONSTER #DRIP\r\nCLIK CLAK\r\n\r\nHuh\r\nHey hey hey hey\r\n\r\nCLIK CLAK heels tap\r\nWalkin’ with my hips back\r\nMoney CLIK CLAK\r\nCLIK CLAK CLIK CLAK CLIK CLAK\r\n\r\nSpending money charge charge charge\r\nWho be livin’ large large large\r\nWalking like a boss boss boss\r\nWe make ’em talk talk talk talk\r\n\r\nI need a van to hold all my bags\r\nAlways the first and never the last\r\nHere with my girls we step on the scene\r\nWe do it big you know what I mean\r\nIf I say which one looks better\r\nYou say both (both) both (both)\r\nI’m bad from any angle\r\nHit that pose (pose) pose (pose)\r\n\r\nMatching tennis bracelets\r\nBaby blue water vacations\r\nI’ll admit that I’m so vicious\r\nNo I ain’t the one to play with\r\nEverybody wanna know oh oh\r\nBitty burning up the show oh oh\r\nEenie meenie miney moe\r\nCatch ’em by the toe\r\nYou ain’t even no\r\nI’ma let it go\r\n\r\nCLIK CLAK heels tap\r\nWalkin’ with my hips back\r\nMoney CLIK CLAK\r\nCLIK CLAK CLIK CLAK CLIK CLAK\r\n\r\nSpending money charge charge charge\r\nWho be livin’ large large large\r\nWalking like a boss boss boss\r\nWe make ’em talk talk talk talk\r\n\r\nCLIK CLAK heels tap\r\nWalkin’ with my hips back\r\nMoney CLIK CLAK\r\nCLIK CLAK CLIK CLAK CLIK\r\n\r\nWalking like a boss boss boss\r\nWe make ’em talk talk talk talk\r\n\r\nGet back whip that they mad\r\nClap clap bring that ASAP\r\nIf they all up in their feelings that’s too bad\r\nI be laughing to the bank in my Maybach\r\nLeft hand kiss that big rock\r\nTunnel vision twenty twenty top notch\r\nSpent a milly on some fits I’m so hot\r\nPut some ice on my wrist that’s water\r\n\r\nI’m on it on it got it flaunt it\r\nGot your world in my pocket\r\nZero hundred like Ferrari\r\nHit the gas\r\nWho gon’ stop me\r\nYou love when BABYMONSTER hits\r\nCartier stacked up on my wrist\r\nFlip my hair and blow a kiss\r\nNot a dentist but I’m flossin’ sis\r\n\r\nCLIK CLAK heels tap\r\nCLIK CLAK heels tap\r\nCLIK CLAK heels tap\r\nMmmmm\r\n\r\nCLIK CLIK CLAK heels tap\r\nCLIK CLAK heels tap\r\nCLIK CLAK heels tap\r\nMmmmm\r\n\r\nCLIK CLIK CLAK heels tap\r\nWalkin’ with my hips back\r\nMoney CLIK CLAK CLIK CLAK CLIK CLAK\r\n\r\nCLIK CLIK CLAK heels tap\r\nWalkin’ with my hips back\r\nMoney CLIK CLAK CLIK CLAK\r\n\r\nAin’t looking back\r\nLet’s take the lead\r\nGo head ladies\r\nGo head ladies\r\n\r\nAin’t looking back\r\nLet’s take the lead\r\nGo head ladies\r\nGo head ladies\r\nHere we go\r\n\r\n#BABYMONSTER #베이비몬스터 #1stFULLALBUM #DRIP #CLIKCLAK #MV #OUTNOW #YG\r\n\r\nPre-Save/Pre-Add Now. @ https://ygbabymonster-drip.com/\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/BwZ0L576TGtGvoYy04pCjXsf8J42h8gwryTyjjZS.mp4', 'thumbnails/WklUMSnQGgiDTGwDDutoDaB0txAni1mf6ghq6fPs.jpg', 337, 0, 1, '2026-03-14 11:22:21', '2026-03-14 11:22:21'),
(22, 'BABYMONSTER - ‘CLICK CLACK’ SPECIAL PERFORMANCE VIDEO', '#CLIKCLAK #PerformanceVideo #YG\r\n#BABYMONSTER #베이비몬스터 #1stFULLALBUM #DRIP #CLIKCLAK #SPECIAL #PerformanceVideo #YG\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/rZKWSNIakLYVAMal5FyJ74OrfEDT3holeDsMiWob.mp4', 'thumbnails/yuRzDpFfRhE4XNsqxuI5huzOcqptrRu1uE2lSLVs.jpg', 108, 0, 1, '2026-03-14 11:25:01', '2026-03-14 11:25:01'),
(23, 'BABYMONSTER - ‘CLICK CLACK’ PERFORMANCE VIDEO', '#CLIKCLAK #PerformanceVideo #YG\r\n#BABYMONSTER #베이비몬스터 #1stFULLALBUM #DRIP #CLIKCLAK #SPECIAL #PerformanceVideo #YG\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/Mw03Ml0OzMjaKPwrQPoX2BRnBPvasT317eaOggC7.mp4', 'thumbnails/cBvXyQBvaqTh1rKpiMeqHQMTWibKlVIXxcMScSOB.jpg', 100, 0, 1, '2026-03-14 11:26:51', '2026-03-14 11:26:51'),
(24, 'BABYMONSTER - ‘Love,Maybe\'', '#BABYMONSTER #DRIP #YG\r\nLove, Maybe\r\n\r\nFalling for the first time\r\nI got feelings that I can’t fight\r\nLord, please have mercy on me\r\n\r\nPush play then I rewind\r\nThinking ’bout you every day and night\r\nBoy, what’chu doing to me?\r\n\r\nCause ooh\r\nSomething different ’bout the way you make me feel like\r\nSomething different ’bout the way you make me feel like\r\n\r\nI don’t know why\r\nCan’t control it\r\nTakes hold of me\r\nIs this for real\r\n\r\nThis must be love, baby\r\nCause I’ve never felt quite this way\r\nI think this is love, baby\r\nGet weak when you callin’ my name\r\n\r\nThis must be love, love, love\r\nI think this is love, maybe?\r\nCause I don’t know what else to blame\r\n\r\nI’ve been going out of my mind\r\nGot that goosebumps, butterflies\r\nI don’t even wanna play the game\r\nCause you read me everytime\r\n\r\nI’ve been guarded\r\nBut I think you picked the lock\r\nPicking petals saying love me, love me not\r\n\r\nGotta keep my cool\r\nWhat’chu make me do\r\nL.O.V.E got me fallin’\r\nI’m so into you\r\n\r\nI’ve been really trying to be cautious with my heart\r\nBut I can’t deny it, how you got me caught up\r\nAnd the feelings don’t lie\r\nSomething ’bout you really making me feel, feel, feel\r\n\r\nThis must be love, love, baby\r\nCause I’ve never felt quite this way\r\nI think this is love, baby\r\nGet weak when you callin’ my name\r\n\r\nThis must be love, love, love\r\nI think this is love, maybe?\r\nCause I don’t know what else to blame\r\n \r\nAfraid to lose myself when I’m with you\r\nThere’s nothing else I’d rather do\r\nBoy you really made a mess of me\r\nThis that real love\r\nThis that real, it’s that real\r\nI give up\r\nJust take my heart\r\n \r\nThis must be love, love, love\r\nI think this is love, maybe?\r\nCause I don’t know what else to blame\r\n\r\n#BABYMONSTER #베이비몬스터 #1stFULLALBUM #DRIP #LoveMaybe #Official_Audio #YG\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/yfHzb3gNqYsrFq2AmZLZRE0h8vaecAtbS34HRhEi.mp4', 'thumbnails/cJGKed1o7pb7mNs5Y7mu4wKmWnEucSkefthkK4yL.jpg', 195, 0, 1, '2026-03-14 11:39:05', '2026-03-14 11:39:05'),
(25, 'BABYMONSTER - ‘WOKE UP IN TOKYO\'', '#WokeUpInTokyo #BABYMONSTER #DRIP\r\nWoke Up In Tokyo (RUKA & ASA)\r\n\r\n(I woke up in Tokyo, Tokyo, Tokyo)\r\n(Everybody rock and roll, lost in Tokyo)\r\n\r\nShhh listen\r\nABCDEFG\r\nWhat you know ain’t what we see\r\n\r\nDing-dong, ding-dong\r\nI swear I’m seeing King Kong\r\nHead bouncing like a ping pong\r\nWe poppin’ out it’s on\r\n\r\nDing-dong, ding-dong\r\nI swear I’m seeing King Kong\r\n“Ohayogozaimasu”\r\nAre you ready for this?\r\n \r\nいち に eeee\r\nLook at meeeee\r\nKi ki keeeey\r\nMy name is Ruka Kawaii です\r\n\r\nI think I might be dreaming\r\nLooking for a fun time\r\n皆さんようこそ\r\nここ BABYMON WORLD\r\n\r\nいち に eeee\r\nLook at meeeee\r\nKi ki keeeey\r\nMy name is Asa Enami です\r\n\r\n(I woke up in Tokyo, Tokyo, Tokyo)\r\n(I woke up in Tokyo, I’m like oh oh oh)\r\nI woke up in Tokyo, Tokyo, Tokyo\r\nI woke up in Tokyo, this be loco-co\r\n\r\nありがとう rock and roll, rock and roll, rock and roll\r\nEverybody rock and roll, lost in Tokyo\r\n\r\nI woke up, in Tokyo\r\nI woke up, in Tokyo\r\n\r\nYum yum yum, we gon’ run and gun\r\nCome and get you some\r\nGet ’em one by one\r\n\r\nPew pew\r\nWe pulling up\r\nBoohoo\r\nThe level up\r\nGoku\r\n\r\nKamehameha\r\nKamehameha\r\nKamehameha\r\n\r\nYakiniku in pajamas\r\nYamaguchi go bananas\r\nNo you don’t want no drama\r\nCross fingers 領域展開\r\n\r\n(I woke up in Tokyo, Tokyo, Tokyo)\r\n(I woke up in Tokyo, I’m like oh oh oh)\r\nI woke up in Tokyo, Tokyo, Tokyo\r\nI woke up in Tokyo, this be loco-co\r\n\r\nありがとう rock and roll, rock and roll, rock and roll\r\nEverybody rock and roll, lost in Tokyo\r\n\r\nI woke up, in Tokyo\r\nI woke up, in Tokyo\r\nI woke up, in Tokyo\r\nI woke up, in Tokyo\r\n\r\n#BABYMONSTER #베이비몬스터 #1stFULLALBUM #DRIP #WokeUpInTokyo #Official_Audio #YG\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/RDWS2sG5OITSCocoktMBuJbr2w47Nk3ja9T764Vd.mp4', 'thumbnails/3LZ7zS233ZGrJVla2YWkvXM6i4jbWCNfs6kwfrVS.jpg', 108, 0, 1, '2026-03-14 11:41:44', '2026-03-14 11:41:44'),
(26, 'BABYMONSTER - \'Really Like You\' M/V', '#ReallyLikeYou #BABYMONSTER #DRIP\r\nReally Like You\r\n\r\n말하고 싶어\r\nTo say I love you\r\nBut boy, I like you\r\nReally really like you\r\n\r\nHey, what you doin’?\r\n기다리잖아 Call back, uh\r\n온도 Check 했잖아 나 꽁했어\r\n추워 나 감기고 싶어\r\nHurry up 이불 가져와 덮어줘\r\n\r\nI wanna touch you\r\nBut you’re in the laptop\r\n날 보러 와\r\n커피처럼 Take out\r\n딩디기딩 Like a 리기딩딩\r\n너랑 같이 빙빙 놀고 싶어 Errtime \r\n\r\n내 맘이 간질간질해 I’m sick\r\nAlways you and me like a symphony\r\nWe come together\r\n\r\n너의 넘치는 매력\r\nYou make a bad day better yeah you\r\nYou make a good day better too\r\n\r\n눈을 뜨는 아침부터\r\n달이 지는 새벽까지\r\n네 생각에 행복해\r\n아마 모를걸 \r\n\r\n말하고 싶어\r\nTo say I love you\r\nBut boy, I like you\r\nReally really like you\r\n\r\nAnd in this moonlight\r\nWe’re reaching new highs\r\nBut boy, I like you\r\nReally really like you\r\n\r\nL.O.V.E, L.O.V.E\r\n흐트러진 퍼즐같이\r\n입안에 담고 있는 말\r\n이제는 말하고 싶어\r\n\r\nTonight 이제 그만 고민하고\r\nYeah boy, I’d like 날 거부하지 마 so\r\n\r\n눈을 뜨는 아침부터\r\n달이 지는 새벽까지\r\n네 생각에 행복해\r\n아마 모를걸\r\n\r\n말하고 싶어\r\nTo say I love you\r\nBut boy, I like you\r\nReally really like you\r\n\r\nAnd in this moonlight\r\nWe’re reaching new highs\r\nBut boy, I like you\r\nReally really like you\r\n\r\n오 널 처음 본 순간부터\r\n자꾸 내 꿈에 나와\r\n눈 뜨면 아쉬워\r\n\r\nNo need to rush\r\n좀 더 다가갈게 난 Little\r\nI’m waiting on you too\r\nEvery day gets better\r\nSo glad that I found you\r\n\r\n말하고 싶어\r\nTo say I love you\r\nBut boy, I like you\r\nReally really like you\r\n\r\nAnd in this moonlight\r\nWe’re reaching new highs\r\nBut boy, I like you\r\nReally really like you\r\n\r\nOkay okay 내가 졌으니까\r\n오늘 너의 맘을 허락해\r\nOkay okay 별이 떴으니까\r\n손잡고 눈을 감을게 \r\n\r\nOkay okay 말을 섞으니까\r\n말풍선이 가득해\r\nBut boy, I like you\r\nReally really like you\r\n\r\n#BABYMONSTER #베이비몬스터 #1stFULLALBUM #DRIP #ReallyLikeYou #MV #OUTNOW #YG\r\n\r\nAvailable @ https://BABYMONSTER.lnk.to/DRIP\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/IpLRbKYrsEGgNqOItN7laB2RCyweJCRMubembTWV.mp4', 'thumbnails/jrHC3X42XyWk5uxd7ooXo5JxI8aSemoV2bTihiiE.jpg', 68, 0, 1, '2026-03-14 11:45:14', '2026-03-14 11:45:14'),
(27, 'BABYMONSTER - \'Love In My Heart\' M/V', '#LoveInMyHeart #DRIP #YG\r\nLove In My Heart\r\n\r\n어떤 말도 들리질 않아\r\n내 심장 소리뿐\r\n서둘러 날 고쳐보지만\r\nI can’t live without you\r\n\r\n내 맘은 불길처럼\r\n걷잡을 수가 없어\r\n이런 나를 내버려둬\r\n\r\n이 밤을 가로질러\r\n너에게 가고 있어\r\n늘 그래왔던 것처럼\r\n\r\n알잖아 너와 나\r\n애써 외면하지 마\r\nWe will be beautiful\r\nAnd we’ll stay together for all time\r\n \r\n이제 더 이상 참고 싶지 않아\r\nGive you all of the love in my heart\r\n이제 온 세상이 다 내 것 같아\r\nGive you all of the love in my heart\r\n\r\nGive you\r\nAy ay ay ay ay ay ay ay\r\nGive you all of the love in my heart\r\n\r\nGive you\r\nAy ay ay ay ay ay ay ay\r\nGive you all of the love in my heart\r\n\r\nThinking ’bout you every day and night\r\n우리 마음은 마치 Stars align\r\n춤을 추게 해 매일매일\r\nGet lost in the twilight\r\nYou belong with me forever\r\nLet’s go whenever\r\n\r\nDon’t you know I’m down bad\r\nOh babe 너 땜에 꼬여\r\nCan’t control my mind\r\n보여줘 If your love’s true\r\nShout it out, I’m so into you\r\n\r\n알잖아 너와 나\r\n애써 외면하지 마\r\nWe will be beautiful\r\nAnd we’ll stay together for all time\r\n\r\n이제 더 이상 참고 싶지 않아\r\nGive you all of the love in my heart\r\n이제 온 세상이 다 내 것 같아\r\nGive you all of the love in my heart\r\n\r\nGive you\r\nAy ay ay ay ay ay ay ay\r\nGive you all of the love in my heart\r\n\r\nGive you\r\nAy ay ay ay ay ay ay ay\r\nGive you all of the love in my heart\r\n\r\nYou and I\r\n밤하늘 아래 등을 맞대고 앉아\r\nYou have my back and I’m glad for that\r\n별빛처럼 아름다워\r\n\r\n이제 더 이상 참고 싶지 않아\r\nGive you all of the love in my heart\r\n이제 온 세상이 다 내 것 같아\r\nGive you all of the love in my heart\r\n\r\nGive you\r\nAy ay ay ay ay ay ay ay\r\nGive you all of the love in my heart\r\n\r\nGive you\r\nAy ay ay ay ay ay ay ay\r\nGive you all of the love in my heart\r\n\r\n#BABYMONSTER #베이비몬스터 #1stFULLALBUM #DRIP #LoveInMyHeart #MV #OUTNOW #YG\r\n\r\nAvailable @ https://BABYMONSTER.lnk.to/DRIP\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/Lt2voICizIWHmf445qbvnwMx7zOlRDz7xHvdSjZH.mp4', 'thumbnails/IqHSVzfgwlge7NNXOESMdgtUbw7F2l0VICV0NX7U.jpg', 268, 0, 1, '2026-03-14 12:44:20', '2026-03-14 12:44:20'),
(28, 'BABYMONSTER - \'BILLIONAIRE\' EXCLUSIVE PERFORMANCE VIDEO', '#PerformanceVideo #YG #DRIP\r\nBILLIONAIRE\r\n \r\nBABY I’mma MONSTER\r\n\r\nI’ve never felt like this before\r\nThey stop when I walk through the door\r\nSomething click it’s a state of mind\r\nType of rich can’t be quantified\r\nAnd it ain’t my fault if you not trying to match my mood\r\nSorry but that’s on you\r\n\r\nBaby I don’t mean to brag\r\nYou know I’m not talking cash\r\nGot a thing that’s only mine\r\n\r\nAnd I watch your eyes go green\r\nI can feel your jealousy\r\nUp here in the sky sky\r\n\r\nOh look at me, I woke up\r\nFeeling like a BILLIONAIRE, woah\r\nWorld is mine, yeah life is so unfair\r\nMoney don’t compare\r\nI got something rare\r\nFeeling like a BILLIONAIRE\r\n\r\nI got rules here to break\r\nSay it with my chest and in your face\r\nHear the boom in the bass\r\nPump it up, back it up, turn in up\r\nR.U.K.A\r\n\r\nACE-SA be the name, so cut the deck\r\nDeal it out\r\nAbove the money power and respect\r\nArigato\r\nWho dat? who dat? who dat?\r\nGot the flame\r\nBet it on me, double up your life\r\n\r\nBaby I don’t mean to brag\r\nYou know I’m not talking cash\r\nGot a thing that’s only mine\r\n\r\nAnd I watch your eyes go green\r\nI can feel your jealousy\r\nUp here in the sky sky\r\n\r\nOh look at me, I woke up\r\nFeeling like a BILLIONAIRE, woah\r\nWorld is mine, yeah life is so unfair\r\nMoney don’t compare\r\nI got something rare\r\nFeeling like a BILLIONAIRE\r\n\r\nBILLIONAIRE\r\nBuh buh buh buh BILLIONAIRE\r\nBABYMONSTER got me feeling like a BILLIONAIRE\r\n\r\nBILLIONAIRE\r\nBuh buh buh buh BILLIONAIRE\r\nBABYMONSTER got me feeling like a BILLIONAIRE\r\n\r\nOh look at me, I woke up\r\nFeeling like a BILLIONAIRE, woah\r\nWorld is mine, yeah life is so unfair\r\nMoney don’t compare\r\nI got something rare\r\nFeeling like a BILLIONAIRE\r\n\r\n#BABYMONSTER #베이비몬스터 #1stFULLALBUM #DRIP #BILLIONAIRE #EXCLUSIVE #PerformanceVideo #YG\r\n\r\nAvailable @ https://BABYMONSTER.lnk.to/DRIP\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/v6KEiUKapgW0EGeV4OLEkinMPFRGEl36kl81IyyI.mp4', 'thumbnails/FnxvAjargEatjxbU36CJ75l3Vh2Giz2WD3PjXQ9X.jpg', 388, 1, 1, '2026-03-14 12:49:50', '2026-03-14 12:50:10'),
(29, 'BABYMONSTER - ‘BILLIONAIRE’ PERFORMANCE VIDEO', '#PerformanceVideo #YG #DRIP\r\n#BABYMONSTER #베이비몬스터 #1stFULLALBUM #DRIP #BILLIONAIRE #PerformanceVideo #YG\r\n\r\nMore about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/ybXds78KuTQmT7qqvQ9qtDnNbb6RJchnB2LuoSYx.mp4', 'thumbnails/HWIvvAbSXZVjFnJ0lC5Jq5PSXGJerbqK7dVp5lpE.jpg', 77, 0, 1, '2026-03-14 12:52:56', '2026-03-14 12:52:56'),
(30, 'BABYMONSTER - ‘Ghost’', 'More about BABYMONSTER @\r\nOfficial YouTube    / @babymonster  \r\nOfficial Instagram   / babymonster_ygofficial  \r\nOfficial Facebook   / babymonster.ygofficial  \r\nOfficial Twitter   / ygbabymonster_  \r\nOfficial TikTok   / babymonster_yg_tiktok  \r\nOfficial Weibo https://weibo.com/u/7811488144\r\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/7KK761MQnRwNS3wXgLI2i3qOXyDFkYYzUyuN0zHu.mp4', 'thumbnails/7m9rNoJyU0i4SFlVgtIuRwprtMF7z92V3dc16Yus.jpg', 60, 0, 1, '2026-03-14 13:01:09', '2026-03-14 13:01:09'),
(31, 'BABYMONSTER - ‘Hot Sauce’ M/V', ' #BABYMONSTER #YG #HOTSAUCE\nHOT SAUCE\n\nFire go higher\nWherever we are\nBABYMONSTER girls got that woo woo ah\n \nHot sauce\nHot sauce\nEverybody want some but can’t handle what I brought ’em\nI’m like hot sauce\nHot sauce\nEverybody want some but can’t handle what I brought ’em\n \nI don’t think you’re ready\nFeeling deadly tonight\nB.A.B.Y.M.O.N about to blow your mind\nWe about to leave you breathless\nCall the doctors, paramedics\nCause the stage on fire\nI’m not talking pyrotechnics\n \nGot that chilli pepper, jalapeno\nToo addictive red hot cheetos\nWay we move hit like wasabi\nBABYMONSTER bring the party\n \nStep to the beat\nCame ready to eat\nYou know we bring the flavor\nTurn up the heat\nThey calling us beasts\nCall it monster behaviour\n \nHot sauce\nHot sauce\nEverybody want some but can’t handle what I brought ’em\nI’m like hot sauce\nHot sauce\nEverybody want some but can’t handle what I brought ’em\n \nI’m that little bit of everything, whole lot of energy\nHundred miles an hour you won’t never get ahead of me\nThink you need a lemonade\nThink you need a remedy\nAsk me how I do it\nIt’s a secret recipe\n \nBet you never ever felt a fire like this\nCarolina reaper kinda vibe like this\nSprinkle of pepper I’m stirring the pot\nGet what I get cause I got what I got\n \nWe’ll do this all night baby, we don’t get tired\nThe kinda energy that never expire\nRed yellow green\nKnow you know what I mean yeah\n’Bout to set it on fire\n \nHot sauce\nHot sauce\nEverybody want some but can’t handle what I brought ’em\nI’m like hot sauce\nHot sauce\nEverybody want some but can’t handle what I brought ’em\n \nFire go higher\nWherever we are\nBABYMONSTER girls got that woo woo ah\nFire go higher\nWherever we are\nBABYMONSTER girls got that woo woo\n \nHot sauce\nToo hot hot\nHot sauce\nYeah BABYMONSTER got that\nHot sauce\nToo hot hot\nHot sauce\nYeah BABYMONSTER got that\n\n#BABYMONSTER #베이비몬스터 #DigitalSingle #HOTSAUCE #MV #OUTNOW #YG \n\nAvailable @ https://BABYMONSTER.lnk.to/HOTSAUCE\n\nMore about BABYMONSTER @\nOfficial YouTube    / @babymonster  \nOfficial Instagram   / babymonster_ygofficial  \nOfficial Facebook   / babymonster.ygofficial  \nOfficial Twitter   / ygbabymonster_  \nOfficial TikTok   / babymonster_yg_tiktok  \nOfficial Weibo https://weibo.com/u/7811488144\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/CjoEho9lj6xpFNu4jD7XpPZlYqtcAl9TJD4PZd4D.mp4', 'thumbnails/IgHXhot54JuuaZElHoV564GwROCB2Uuy1aeGH9DY.jpg', 92, 0, 1, '2026-03-14 13:02:43', '2026-03-14 13:02:43'),
(32, 'BABYMONSTER - ‘Hot Sauce’ PERFORMANCE VIDEO (M/V White Horizon Ver.)', '#PerformanceVideo #YG #BABYMONSTER\n#BABYMONSTER #베이비몬스터 #DigitalSingle #HOTSAUCE #PerformanceVideo #YG\n\nMore about BABYMONSTER @\nOfficial YouTube    / @babymonster  \nOfficial Instagram   / babymonster_ygofficial  \nOfficial Facebook   / babymonster.ygofficial  \nOfficial Twitter   / ygbabymonster_  \nOfficial TikTok   / babymonster_yg_tiktok  \nOfficial Weibo https://weibo.com/u/7811488144\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/JLmMPQH3ch9qg434m2wrQipmcRMGQIdWcuxT0R48.mp4', 'thumbnails/c4l13IcC591K17vsblYdOwF9svkn23bhsUZfkOQf.jpg', 99, 0, 1, '2026-03-14 13:05:32', '2026-03-14 13:05:32'),
(33, 'BABYMONSTER - ‘Hot Sauce’ PERFORMANCE VIDEO', '#PerformanceVideo #YG #BABYMONSTER\n#BABYMONSTER #베이비몬스터 #DigitalSingle #HOTSAUCE #PerformanceVideo #YG\n\nMore about BABYMONSTER @\nOfficial YouTube    / @babymonster  \nOfficial Instagram   / babymonster_ygofficial  \nOfficial Facebook   / babymonster.ygofficial  \nOfficial Twitter   / ygbabymonster_  \nOfficial TikTok   / babymonster_yg_tiktok  \nOfficial Weibo https://weibo.com/u/7811488144\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/kyYJ1tMeBRSXymU6rnGhCCYScYDdUS3MpzPgHayr.mp4', 'thumbnails/rzzEpPNbt6q4ckDCFZPQjbI5QMgcFKhj82YO0IWq.jpg', 94, 0, 1, '2026-03-14 13:07:29', '2026-03-14 13:07:29'),
(34, 'BABYMONSTER - \'WILD\'', '#2ndMINIALBUM #YG #BABYMONSTER\nWILD\n\nLook in the mirror\nChecking my face\n사람은 쉽게 안 변해\nDon’t need a hero\nGet outta my way\n마음 가는 대로\nBorn to be brave\n\nBut it took a long long time\nTo realise\nThat I\n별빛처럼 찬란한\n꽃이 피게 할 거야\n\nJust a little bit different\n정답이 뭔데?\nNo no 정해진 건 없는데\nTypical, logical\n전부 똑같애\nI’m gonna do what I wanna do\n\nDance all night\nUntil I feel alive\nI think I’m ready\nI think I’m ready to\nBe myself\nNot like everybody else\nThat’s not my style\nI’d rather rather rather be wild\n\nI keep it wild, I keep it free, I got that dangerous in me\nHit the rodeo, that superstar, that one and only\nGlowing, shining like a diamond\nTrust me, you can’t beat this\nBABY I’mma MONSTER\nLeave ’em in the dust then I blow them a kiss\n\nBut it took a long long time\nTo realise\nThat I\n별빛처럼 찬란한\n꽃이 피게 할 거야\n\nJust a little bit different\n정답이 뭔데?\nNo no 정해진 건 없는데\nTypical, logical\n전부 똑같애\nI’m gonna do what I wanna do\n\nDance all night\nUntil I feel alive\nI think I’m ready\nI think I’m ready to\nBe myself\nNot like everybody else\nThat’s not my style\nI’d rather rather rather be wild\n\nOut in the dark\nOut on my own\n내 안의 길을 따라서\n언젠간 만나게 될\n내 꿈속에서\n\nI’m gonna dance all night\nUntil I feel alive\nI think I’m ready\nI think I’m ready to\nBe myself\nNot like everybody else\nThat’s not my style\nI’d rather rather rather be wild\n\nYa ya ya ya ya ya ya ya ya ya\nI’d rather rather rather be wild\nYa ya ya ya ya ya ya ya ya ya\nI’d rather rather rather be wild\n\n#BABYMONSTER #베이비몬스터 #2ndMINIALBUM #WILD #Official_Audio #YG\n\nAvailable @ https://BABYMONSTER.lnk.to/WE_GO_UP\n\nMore about BABYMONSTER @\nOfficial YouTube    / @babymonster  \nOfficial Instagram   / babymonster_ygofficial  \nOfficial Facebook   / babymonster.ygofficial  \nOfficial Twitter   / ygbabymonster_  \nOfficial TikTok   / babymonster_yg_tiktok  \nOfficial Weibo https://weibo.com/u/7811488144\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/tXCrhuWP83p0WYYK74LUR8vk5Hl3r5uPsHU9bvah.mp4', 'thumbnails/Z5uMAxzcp5EszenvVQjiF8HguGUvkJVgApqZiIfd.jpg', 14, 0, 1, '2026-03-14 13:09:37', '2026-03-14 13:09:37');
INSERT INTO `videos` (`id`, `title`, `description`, `video_path`, `thumbnail_path`, `duration`, `views`, `user_id`, `created_at`, `updated_at`) VALUES
(35, 'BABYMONSTER - \'SUPA DUPA LUV\'', ' #SUPADUPALUV #2ndMINIALBUM #YG\nSUPA DUPA LUV\n\nSupa dupa luv\n\nNo, I ain’t never felt a feeling like this\nNever had a feeling this big\nIf I ever saw a sky full of shooting stars\nThen I’d be spending every single wish on you\n\nNothing that I wouldn’t do\nHow’d you go and make a monster shy? It’s true\nSo different from the usual\nThat every kinda beautiful\nMy heart’s running outta room\n \nWhoa whoa whoa whoa\nGotta slow down, gotta cool down from you\nWhoa whoa whoa whoa\nI’m so all in, fireballing, I cannot lie\n\nBecause of you, I’m flying high\nBecause of you, I’m waking up in the sky\nHand on my heart till death do us part\nThe sweetest dynamite\n\nBoom boom boom\nI’m ’bout to explode\nHow can I feel more than this? I don’t know\nWe got that supa dupa luv luv luv\nSupa dupa luv luv\n\nBoom boom boom\nMy heart is too loud\nHow can it get better than it is right now?\nWe got that supa dupa luv luv luv\nSupa dupa luv luv luv\n\nThis love is so gigantic, so galactic, massive, so enormous\nJust like magic, I’ve been seeing stars and hearing orchestras\nLike that zero gravity\nYou and me beyond infinity\nGot me so up in the air like RUKA!\nHeart like a rocket, you’re taking me there\n\nHouston, yeah we got a problem cause I lost control of emotion\nNo hands on the wheel\nNeeding more oxygen\nYou a phenomenon\nI could go on and on ’bout how I feel\n\nCan’t stop, won’t stop, I don’t need a pit stop\nBeating like a boombox, no one got what you got\nHitting me like a bazooka\nOnly want love if it’s supa dupa\n\nBecause of you, I’m flying high\nBecause of you, I’m waking up in the sky\nHand on my heart till death do us part\nThe sweetest dynamite\n\nBoom boom boom\nI’m ’bout to explode\nHow can I feel more than this? I don’t know\nWe got that supa dupa luv luv luv\nSupa dupa luv luv\n\nBoom boom boom\nMy heart is too loud\nHow can it get better than it is right now?\nWe got that supa dupa luv luv luv\nSupa dupa luv luv luv\n\n#BABYMONSTER #베이비몬스터 #2ndMINIALBUM #SUPADUPALUV #Official_Audio #YG\n\nAvailable @ https://BABYMONSTER.lnk.to/WE_GO_UP\n\nMore about BABYMONSTER @\nOfficial YouTube    / @babymonster  \nOfficial Instagram   / babymonster_ygofficial  \nOfficial Facebook   / babymonster.ygofficial  \nOfficial Twitter   / ygbabymonster_  \nOfficial TikTok   / babymonster_yg_tiktok  \nOfficial Weibo https://weibo.com/u/7811488144\nOfficial bilibili https://space.bilibili.com/3493127232...\n', 'videos/ESWrqBM0wBCVldRxI8xOUgtQY8sjNUBRyAIEuX0r.mp4', 'thumbnails/5KRDPovb5gql2uZZcIxgXsjUrThbcTeSEECd1qGZ.jpg', 352, 0, 1, '2026-03-14 13:12:06', '2026-03-14 13:12:06'),
(36, 'BABYMONSTER - \'PSYCHO\'', ' #PSYCHO #2ndMINIALBUM #YG\nPSYCHO\n\nBABYMON\nHashtag\n\nMove\nYou don’t want no problems in that\nMood\n너는 너무 말이 많아\nWoo\n빈 수레가 요란할 뿐\nBoo hashtag\nHoo hashtag\n\nYeah yeah yeah\n난 치타처럼 달려 나가\nYeah yeah yeah\n독수리처럼 날아올라\n\n알 수 없는 끝\n향해 달려가자 꿈\nEverybody give me room\n누가 뭐래도 I’mma do\n\nNa na na na na na na na na\nYou don’t know about me\nYou don’t know about me\nNa na na na na na na na na\nEvery rose has a thorn\n\n우린 모두 Psycho\n누구나 똑같아 너나 나나\n서로 다른 Psycho\n모두 다 비정상 너나 나나\n조금 다른 Psycho\n\nS-s psycho s-s-s-s psycho\n웃는 얼굴 뒤엔 Just a little psycho\nS-s psycho s-s-s-s psycho\n세상처럼 돌고 도는 우린 Psycho\n\nTick tack toe\nPlaying games\nI’mma kick that door\nSay my name like Ruk ruk ruk\nEverybody wanna be it\nShoulda woulda coulda did it\nWon’t admit like\n\nOh I wish you would\nWho misunderstood\nYou ain’t got a clue\nFeeling like a villain chilling\nEverything I’m thrilling killing\nGet in where you fit in\nYou a psycho too\n\nNa na na na na na na na na\nYou don’t know about me\nYou don’t know about me\nNa na na na na na na na na\nEvery rose has a thorn\n\n우린 모두 Psycho\n누구나 똑같아 너나 나나\n서로 다른 Psycho\n모두 다 비정상 너나 나나\n조금 다른 Psycho\n\nS-s psycho s-s-s-s psycho\n웃는 얼굴 뒤엔 Just a little psycho\nS-s psycho s-s-s-s psycho\n세상처럼 돌고 도는 우린 Psycho\n\nCan you see it\n강가에 비친\n두 개의 달은 너와 나\n오늘이 우리 마지막 밤인 것처럼\n미쳐가 보자\n\nThis is for everybody\nYou’re not just anybody\nShout out and tell somebody\nWe are the psychos\n\nThis is for everybody\nYou’re not just anybody\nShout out and tell somebody\nWe are the psychos\n\nNa na na na na na na na\nNa na na na na na na na\nNa na na na na na na na\nNa na na na na na na\nWe are the psychos\n\n#BABYMONSTER #베이비몬스터 #2ndMINIALBUM #PSYCHO #Official_Audio #YG\n\nAvailable @ https://BABYMONSTER.lnk.to/WE_GO_UP\n\nMore about BABYMONSTER @\nOfficial YouTube    / @babymonster  \nOfficial Instagram   / babymonster_ygofficial  \nOfficial Facebook   / babymonster.ygofficial  \nOfficial Twitter   / ygbabymonster_  \nOfficial TikTok   / babymonster_yg_tiktok  \nOfficial Weibo https://weibo.com/u/7811488144\nOfficial bilibili https://space.bilibili.com/3493127232...\n', 'videos/9cVYiM7BUCXkHrhCCzeW49OnfVMTk8yj7zmly8L3.mp4', 'thumbnails/ck7yWCJBgjzkmqcWhPLoEPmde3kjPmuJ7bBopOZd.jpg', 399, 0, 1, '2026-03-14 13:27:59', '2026-03-14 13:27:59'),
(37, 'BABYMONSTER - \'WE GO UP\' M/V', '#2ndMINIALBUM #YG #WEGOUP\nWE GO UP\n\nYeah\nThis ain’t a game and you know we don’t play\n\nYou ain’t never seen the typa show we boutta show ya\nYou ain’t never heard this typa flow we crashing on ya\nTidal wave, tidal wave, it’s about to go\nYou will never dominate, domino when I see you fall\n\nKnow I pop better get back\nHand in my pocket\nWatch the rocket blow\n우리 걱정은 딱히 넣어둬 빨리\nLook at me on a roll\nLet bygones be bygones\nI ain’t never had no problems\nThat high road we gon’ walk over\nCause icons be icons\n\nWhatchu gon’\nWhatchu gon’\nWhatchu gon’ do\nLookin’ good\nLookin’ fly\nLookin’ brand new\n\nUnbelievable\n어림없거든\n어이없거든 (You love it love it)\nWhen we pull up, know it’s all on site\nB.A.B.Y.M.O.N we up, up, up\n\nWe go up like whoa\n우린 Killas killas\nWe go up like whoa\n우린 Villains villains\nUp high for me baby\nHigh for me baby oh\nUp like whoa can you feel us feel us\n\nWe go up like whoa\n우린 Killas killas\nWe go up like whoa\n우린 Villains villains\nUp high for me baby\nHigh for me baby oh\nThis is how we do it\nWe go whoa oh oh oh\n\nCopy copy copy copy, till the error pop up\nCopy copy, wanna be me but you’re never gonna\nThey all eatin’ my leftovers\nI left over what’s left over\nLike ring ring, come and get closer\nWe take over, that’s game over\n\nNobody do it like this\nNobody nobody do it like this\nYou’re never catching me slip\nI switch it on with a flick of the wrist\nLet bygones be bygones\nI ain’t never had no problems\nThat high road we gon’ walk over\nCause icons be icons\n\nWhatchu gon’\nWhatchu gon’\nWhatchu gon’ do\nLookin’ good\nLookin’ fly\nLookin’ brand new\n\nUnbelievable\n어림없거든\n어이없거든 (You love it love it)\nWhen we pull up, know it’s all on site\nB.A.B.Y.M.O.N we up, up, up\n\nWe go up like whoa\n우린 Killas killas\nWe go up like whoa\n우린 Villains villains\nUp high for me baby\nHigh for me baby oh\nUp like whoa can you feel us feel us\n\nWe go up like whoa\n우린 Killas killas\nWe go up like whoa\n우린 Villains villains\nUp high for me baby\nHigh for me baby oh\nThis is how we do it\nWe go whoa oh oh oh\n\n우린 보란듯이\nYeah we run it up, run it up\n불을 지필 거야\nBurn it up, burn it up\n세상 꼭대기에\nSay my name, say my name\n우린 판을 바꿀 Game changer uh uh\n\nDefinition dangerous, dangerous\nClock is ticking, ticking\nBuckle up, buckle up\nBet you never met a monster like me\nI’ll never stop, don’t forget we gon’ make history\n\nWe go up like whoa\n우린 Killas killas\nWe go up like whoa\n우린 Villains villains\nUp high for me baby\nHigh for me baby oh\nB.A.B.Y.M.O.N\n\nWe go up like whoa\n우린 Killas killas\nWe go up like whoa\n우린 Villains villains\nUp high for me baby\nHigh for me baby oh\nThis is how we do it\nWe go whoa oh oh oh\n\nWe go up\n\n#BABYMONSTER #베이비몬스터 #2ndMINIALBUM #WEGOUP #MV #OUTNOW #YG\n\nAvailable @ https://BABYMONSTER.lnk.to/WE_GO_UP\n\nMore about BABYMONSTER @\nOfficial YouTube    / @babymonster  \nOfficial Instagram   / babymonster_ygofficial  \nOfficial Facebook   / babymonster.ygofficial  \nOfficial Twitter   / ygbabymonster_  \nOfficial TikTok   / babymonster_yg_tiktok  \nOfficial Weibo https://weibo.com/u/7811488144\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/1776190427_69de83dbe231f.mp4', 'thumbnails/Q0xJRDudNVRQO7rLQZ45A32Cpu7iFKY6Nt30MFll.jpg', 82, 8, 1, '2026-03-14 13:29:22', '2026-04-14 15:14:28'),
(38, 'BABYMONSTER - ‘WE GO UP’ EXCLUSIVE DANCE PERFORMANCE VIDEO', '#PerformanceVideo #2ndMINIALBUM #YG\n#BABYMONSTER #베이비몬스터 #2ndMINIALBUM #WEGOUP #EXCLUSIVE #PerformanceVideo #YG\n\nMore about BABYMONSTER @\nOfficial YouTube    / @babymonster  \nOfficial Instagram   / babymonster_ygofficial  \nOfficial Facebook   / babymonster.ygofficial  \nOfficial Twitter   / ygbabymonster_  \nOfficial TikTok   / babymonster_yg_tiktok  \nOfficial Weibo https://weibo.com/u/7811488144\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/BABYMONSTER -  WE GO UP  EXCLUSIVE PERFORMANCE VIDEO.mp4', 'thumbnails/v5hF0RXJWM7p7Dsura7w3GBlQtgHKb5ktGDQgsGY.jpg', 124, 11, 1, '2026-03-14 14:01:19', '2026-04-14 15:01:26'),
(39, 'BABYMONSTER - ‘PSYCHO’ M/V', ' #PSYCHO #2ndMINIALBUM #YG\nPSYCHO\n\nBABYMON\nHashtag\n \nMove\nYou don’t want no problems in that\nMood\n너는 너무 말이 많아\nWoo\n빈 수레가 요란할 뿐\nBoo hashtag\nHoo hashtag\n \nYeah yeah yeah\n난 치타처럼 달려 나가\nYeah yeah yeah\n독수리처럼 날아올라\n \n알 수 없는 끝\n향해 달려가자 꿈\nEverybody give me room\n누가 뭐래도 I’mma do\n \nNa na na na na na na na na\nYou don’t know about me\nYou don’t know about me\nNa na na na na na na na na\nEvery rose has a thorn\n \n우린 모두 Psycho\n누구나 똑같아 너나 나나\n서로 다른 Psycho\n모두 다 비정상 너나 나나\n조금 다른 Psycho\n \nS-s psycho s-s-s-s psycho\n웃는 얼굴 뒤엔 Just a little psycho\nS-s psycho s-s-s-s psycho\n세상처럼 돌고 도는 우린 Psycho\n \nTick tack toe\nPlaying games\nI’mma kick that door\nSay my name like Ruk ruk ruk\nEverybody wanna be it\nShoulda woulda coulda did it\nWon’t admit like\n \nOh I wish you would\nWho misunderstood\nYou ain’t got a clue\nFeeling like a villain chilling\nEverything I’m thrilling killing\nGet in where you fit in\nYou a psycho too\n \nNa na na na na na na na na\nYou don’t know about me\nYou don’t know about me\nNa na na na na na na na na\nEvery rose has a thorn\n \n우린 모두 Psycho\n누구나 똑같아 너나 나나\n서로 다른 Psycho\n모두 다 비정상 너나 나나\n조금 다른 Psycho\n \nS-s psycho s-s-s-s psycho\n웃는 얼굴 뒤엔 Just a little psycho\nS-s psycho s-s-s-s psycho\n세상처럼 돌고 도는 우린 Psycho\n \nCan you see it\n강가에 비친\n두 개의 달은 너와 나\n오늘이 우리 마지막 밤인 것처럼\n미쳐가 보자\n \nThis is for everybody\nYou’re not just anybody\nShout out and tell somebody\nWe are the psychos\n \nThis is for everybody\nYou’re not just anybody\nShout out and tell somebody\nWe are the psychos\n \nNa na na na na na na na\nNa na na na na na na na\nNa na na na na na na na\nNa na na na na na na\nWe are the psychos\n\nAvailable @ https://BABYMONSTER.lnk.to/WE_GO_UP\n\n#BABYMONSTER #베이비몬스터 #2ndMINIALBUM #WEGOUP #PSYCHO #MV #OUTNOW #YG\n\nMore about BABYMONSTER @\nOfficial YouTube    / @babymonster  \nOfficial Instagram   / babymonster_ygofficial  \nOfficial Facebook   / babymonster.ygofficial  \nOfficial Twitter   / ygbabymonster_  \nOfficial TikTok   / babymonster_yg_tiktok  \nOfficial Weibo https://weibo.com/u/7811488144\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/xsFF6PH4gE13W3ef71wWWC4pvGDV2ns4zZg6DIzA.mp4', 'thumbnails/yTVPomoZtKyJKF0WKGlGeishNQwvhnd4FL6AnF4P.jpg', 813, 2, 1, '2026-03-14 14:06:25', '2026-04-14 15:17:55'),
(40, 'BABYMONSTER - \'PSYCHO\' PERFORMANCE VIDEO', '#PSYCHO #PerformanceVideo #2ndMINIALBUM\n#BABYMONSTER #베이비몬스터 #2ndMINIALBUM #WEGOUP #PSYCHO #PerformanceVideo #YG  \n\nMore about BABYMONSTER @\nOfficial YouTube    / @babymonster  \nOfficial Instagram   / babymonster_ygofficial  \nOfficial Facebook   / babymonster.ygofficial  \nOfficial Twitter   / ygbabymonster_  \nOfficial TikTok   / babymonster_yg_tiktok  \nOfficial Weibo https://weibo.com/u/7811488144\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/mYLCqx6r9Q4ceoaP025GtqNrhIy7324LMP4rzCqa.mp4', 'thumbnails/H9BRDz68NsNotcXi8V0SPQaHRKtwsEa0zlglB8OU.jpg', 4, 4, 1, '2026-03-14 14:10:54', '2026-04-08 17:10:01'),
(41, 'BABYMONSTER - ‘SUPA DUPA LUV’ M/V', '#SUPADUPALUV #2ndMINIALBUM #YG\nSUPA DUPA LUV \n\nSupa dupa luv\n\nNo, I ain’t never felt a feeling like this\nNever had a feeling this big\nIf I ever saw a sky full of shooting stars\nThen I’d be spending every single wish on you\n\nNothing that I wouldn’t do\nHow’d you go and make a monster shy? It’s true\nSo different from the usual\nThat every kinda beautiful\nMy heart’s running outta room\n \nWhoa whoa whoa whoa\nGotta slow down, gotta cool down from you\nWhoa whoa whoa whoa\nI’m so all in, fireballing, I cannot lie\n\nBecause of you, I’m flying high\nBecause of you, I’m waking up in the sky\nHand on my heart till death do us part\nThe sweetest dynamite\n\nBoom boom boom\nI’m ’bout to explode\nHow can I feel more than this? I don’t know\nWe got that supa dupa luv luv luv\nSupa dupa luv luv\n\nBoom boom boom\nMy heart is too loud\nHow can it get better than it is right now?\nWe got that supa dupa luv luv luv\nSupa dupa luv luv luv\n\nThis love is so gigantic, so galactic, massive, so enormous\nJust like magic, I’ve been seeing stars and hearing orchestras\nLike that zero gravity\nYou and me beyond infinity\nGot me so up in the air like RUKA!\nHeart like a rocket, you’re taking me there\n\nHouston, yeah we got a problem cause I lost control of emotion\nNo hands on the wheel\nNeeding more oxygen\nYou a phenomenon\nI could go on and on ’bout how I feel\n\nCan’t stop, won’t stop, I don’t need a pit stop\nBeating like a boombox, no one got what you got\nHitting me like a bazooka\nOnly want love if it’s supa dupa\n\nBecause of you, I’m flying high\nBecause of you, I’m waking up in the sky\nHand on my heart till death do us part\nThe sweetest dynamite\n\nBoom boom boom\nI’m ’bout to explode\nHow can I feel more than this? I don’t know\nWe got that supa dupa luv luv luv\nSupa dupa luv luv\n\nBoom boom boom\nMy heart is too loud\nHow can it get better than it is right now?\nWe got that supa dupa luv luv luv\nSupa dupa luv luv luv\n\nAvailable @ https://BABYMONSTER.lnk.to/WE_GO_UP\n\n#BABYMONSTER #베이비몬스터 #2ndMINIALBUM #WEGOUP #SUPADUPALUV #MV #OUTNOW #YG\n\nMore about BABYMONSTER @\nOfficial YouTube    / @babymonster  \nOfficial Instagram   / babymonster_ygofficial  \nOfficial Facebook   / babymonster.ygofficial  \nOfficial Twitter   / ygbabymonster_  \nOfficial TikTok   / babymonster_yg_tiktok  \nOfficial Weibo https://weibo.com/u/7811488144\nOfficial bilibili https://space.bilibili.com/3493127232...', 'videos/1775677414_69d6afe66148a.mp4', 'thumbnails/vBuKtc60I8sB6aGB0cGNYLDsBdsQ9GrmV7eUV4XA.jpg', 352, 12, 1, '2026-03-14 14:12:09', '2026-04-15 08:48:01');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Индексы таблицы `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Индексы таблицы `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Индексы таблицы `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Индексы таблицы `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `news_slug_unique` (`slug`),
  ADD KEY `news_user_id_foreign` (`user_id`);

--
-- Индексы таблицы `news_photos`
--
ALTER TABLE `news_photos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_photos_news_id_foreign` (`news_id`);

--
-- Индексы таблицы `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Индексы таблицы `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_unique` (`name`);

--
-- Индексы таблицы `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permission_role_permission_id_role_id_unique` (`permission_id`,`role_id`),
  ADD KEY `permission_role_role_id_foreign` (`role_id`);

--
-- Индексы таблицы `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Индексы таблицы `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Индексы таблицы `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_user_role_id_user_id_unique` (`role_id`,`user_id`),
  ADD KEY `role_user_user_id_foreign` (`user_id`);

--
-- Индексы таблицы `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_blocked_by_foreign` (`blocked_by`);

--
-- Индексы таблицы `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `videos_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT для таблицы `news`
--
ALTER TABLE `news`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `news_photos`
--
ALTER TABLE `news_photos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT для таблицы `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `permission_role`
--
ALTER TABLE `permission_role`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `role_user`
--
ALTER TABLE `role_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `videos`
--
ALTER TABLE `videos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `news_photos`
--
ALTER TABLE `news_photos`
  ADD CONSTRAINT `news_photos_news_id_foreign` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_blocked_by_foreign` FOREIGN KEY (`blocked_by`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `videos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
