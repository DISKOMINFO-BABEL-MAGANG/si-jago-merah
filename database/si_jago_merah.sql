-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 09, 2026 at 07:10 AM
-- Server version: 8.4.3
-- PHP Version: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `si_jago_merah`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detail_evakuasi`
--

CREATE TABLE `detail_evakuasi` (
  `kejadian_id` bigint UNSIGNED NOT NULL,
  `objek_evakuasi` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detail_kebakaran`
--

CREATE TABLE `detail_kebakaran` (
  `kejadian_id` bigint UNSIGNED NOT NULL,
  `objek_terbakar` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exports`
--

CREATE TABLE `exports` (
  `id` bigint UNSIGNED NOT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `file_disk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exporter` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `processed_rows` int UNSIGNED NOT NULL DEFAULT '0',
  `total_rows` int UNSIGNED NOT NULL,
  `successful_rows` int UNSIGNED NOT NULL DEFAULT '0',
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_import_rows`
--

CREATE TABLE `failed_import_rows` (
  `id` bigint UNSIGNED NOT NULL,
  `data` json NOT NULL,
  `import_id` bigint UNSIGNED NOT NULL,
  `validation_error` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `failed_jobs`
--

INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(1, '3ebc7652-6b09-479f-a3a1-6e6483e47fc8', 'database', 'default', '{\"uuid\":\"3ebc7652-6b09-479f-a3a1-6e6483e47fc8\",\"displayName\":\"Filament\\\\Notifications\\\\DatabaseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"deleteWhenMissingModels\":false,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:1;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:43:\\\"Filament\\\\Notifications\\\\DatabaseNotification\\\":2:{s:4:\\\"data\\\";a:11:{s:7:\\\"actions\\\";a:1:{i:0;a:23:{s:4:\\\"name\\\";s:21:\\\"downloadFailedRowsCsv\\\";s:18:\\\"alpineClickHandler\\\";N;s:5:\\\"color\\\";s:6:\\\"danger\\\";s:5:\\\"event\\\";N;s:9:\\\"eventData\\\";a:0:{}s:17:\\\"dispatchDirection\\\";b:0;s:19:\\\"dispatchToComponent\\\";N;s:15:\\\"extraAttributes\\\";a:0:{}s:4:\\\"icon\\\";N;s:12:\\\"iconPosition\\\";E:42:\\\"Filament\\\\Support\\\\Enums\\\\IconPosition:Before\\\";s:8:\\\"iconSize\\\";N;s:10:\\\"isOutlined\\\";b:0;s:10:\\\"isDisabled\\\";b:0;s:5:\\\"label\\\";s:42:\\\"Download information about the failed rows\\\";s:11:\\\"shouldClose\\\";b:0;s:16:\\\"shouldMarkAsRead\\\";b:1;s:18:\\\"shouldMarkAsUnread\\\";b:0;s:21:\\\"shouldOpenUrlInNewTab\\\";b:1;s:15:\\\"shouldPostToUrl\\\";b:0;s:4:\\\"size\\\";E:33:\\\"Filament\\\\Support\\\\Enums\\\\Size:Small\\\";s:7:\\\"tooltip\\\";N;s:3:\\\"url\\\";s:129:\\\"\\/filament\\/imports\\/1\\/failed-rows\\/download?authGuard=web&signature=3aab77c73dea03ef997603cf947dd8040261375814c4b83141735c030c5b6e7c\\\";s:4:\\\"view\\\";s:25:\\\"filament::components.link\\\";}}s:4:\\\"body\\\";s:82:\\\"Import hotspot SIPONGI selesai. 0 data berhasil diimport. 216 data gagal diimport.\\\";s:5:\\\"color\\\";N;s:8:\\\"duration\\\";s:10:\\\"persistent\\\";s:4:\\\"icon\\\";s:19:\\\"heroicon-o-x-circle\\\";s:9:\\\"iconColor\\\";s:6:\\\"danger\\\";s:6:\\\"status\\\";s:6:\\\"danger\\\";s:5:\\\"title\\\";s:16:\\\"Import completed\\\";s:4:\\\"view\\\";N;s:8:\\\"viewData\\\";a:0:{}s:6:\\\"format\\\";s:8:\\\"filament\\\";}s:2:\\\"id\\\";s:36:\\\"ac68a8ea-cf99-4f4b-8892-31ba23ad1a1a\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}}\",\"batchId\":null},\"createdAt\":1788765148,\"delay\":null}', 'PDOException: SQLSTATE[42S02]: Base table or view not found: 1146 Table \'si_jago_merah.notifications\' doesn\'t exist in C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php:47\nStack trace:\n#0 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php(47): PDO->prepare(\'insert into `no...\')\n#1 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php(846): Illuminate\\Database\\MySqlConnection->Illuminate\\Database\\{closure}(\'insert into `no...\', Array)\n#2 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php(813): Illuminate\\Database\\Connection->runQueryCallback(\'insert into `no...\', Array, Object(Closure))\n#3 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php(42): Illuminate\\Database\\Connection->run(\'insert into `no...\', Array, Object(Closure))\n#4 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Query\\Builder.php(4164): Illuminate\\Database\\MySqlConnection->insert(\'insert into `no...\', Array)\n#5 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Builder.php(2281): Illuminate\\Database\\Query\\Builder->insert(Array)\n#6 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1612): Illuminate\\Database\\Eloquent\\Builder->__call(\'insert\', Array)\n#7 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1405): Illuminate\\Database\\Eloquent\\Model->performInsert(Object(Illuminate\\Database\\Eloquent\\Builder))\n#8 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany.php(393): Illuminate\\Database\\Eloquent\\Model->save()\n#9 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\helpers.php(393): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->Illuminate\\Database\\Eloquent\\Relations\\{closure}(Object(Illuminate\\Notifications\\DatabaseNotification))\n#10 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany.php(390): tap(Object(Illuminate\\Notifications\\DatabaseNotification), Object(Closure))\n#11 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Channels\\DatabaseChannel.php(19): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->create(Array)\n#12 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(165): Illuminate\\Notifications\\Channels\\DatabaseChannel->send(Object(App\\Models\\User), Object(Filament\\Notifications\\DatabaseNotification))\n#13 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(120): Illuminate\\Notifications\\NotificationSender->sendToNotifiable(Object(App\\Models\\User), \'ec1d45d1-26c2-4...\', Object(Filament\\Notifications\\DatabaseNotification), \'database\')\n#14 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\Traits\\Localizable.php(21): Illuminate\\Notifications\\NotificationSender->Illuminate\\Notifications\\{closure}()\n#15 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(115): Illuminate\\Notifications\\NotificationSender->withLocale(NULL, Object(Closure))\n#16 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\ChannelManager.php(61): Illuminate\\Notifications\\NotificationSender->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Filament\\Notifications\\DatabaseNotification), Array)\n#17 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\SendQueuedNotifications.php(130): Illuminate\\Notifications\\ChannelManager->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Filament\\Notifications\\DatabaseNotification), Array)\n#18 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle(Object(Illuminate\\Notifications\\ChannelManager))\n#19 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#20 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#21 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#22 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(800): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#23 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(136): Illuminate\\Container\\Container->call(Array)\n#24 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#25 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#26 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(140): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#27 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(155): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Notifications\\SendQueuedNotifications), false)\n#28 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#29 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#30 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(148): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#31 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(86): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#32 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#33 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(559): Illuminate\\Queue\\Jobs\\Job->fire()\n#34 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(505): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#35 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(257): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#36 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#37 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#38 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#39 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#40 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#41 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#42 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(800): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#43 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(292): Illuminate\\Container\\Container->call(Array)\n#44 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#45 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(261): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#46 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(1117): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#47 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#48 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#49 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#50 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1242): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#51 C:\\laragon\\www\\si-jago-merah\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#52 {main}\n\nNext Illuminate\\Database\\QueryException: SQLSTATE[42S02]: Base table or view not found: 1146 Table \'si_jago_merah.notifications\' doesn\'t exist (Connection: mysql, Host: 127.0.0.1, Port: 3306, Database: si_jago_merah, SQL: insert into `notifications` (`id`, `type`, `data`, `read_at`, `notifiable_id`, `notifiable_type`, `updated_at`, `created_at`) values (ac68a8ea-cf99-4f4b-8892-31ba23ad1a1a, Filament\\Notifications\\DatabaseNotification, {\"actions\":[{\"name\":\"downloadFailedRowsCsv\",\"alpineClickHandler\":null,\"color\":\"danger\",\"event\":null,\"eventData\":[],\"dispatchDirection\":false,\"dispatchToComponent\":null,\"extraAttributes\":[],\"icon\":null,\"iconPosition\":\"before\",\"iconSize\":null,\"isOutlined\":false,\"isDisabled\":false,\"label\":\"Download information about the failed rows\",\"shouldClose\":false,\"shouldMarkAsRead\":true,\"shouldMarkAsUnread\":false,\"shouldOpenUrlInNewTab\":true,\"shouldPostToUrl\":false,\"size\":\"sm\",\"tooltip\":null,\"url\":\"\\/filament\\/imports\\/1\\/failed-rows\\/download?authGuard=web&signature=3aab77c73dea03ef997603cf947dd8040261375814c4b83141735c030c5b6e7c\",\"view\":\"filament::components.link\"}],\"body\":\"Import hotspot SIPONGI selesai. 0 data berhasil diimport. 216 data gagal diimport.\",\"color\":null,\"duration\":\"persistent\",\"icon\":\"heroicon-o-x-circle\",\"iconColor\":\"danger\",\"status\":\"danger\",\"title\":\"Import completed\",\"view\":null,\"viewData\":[],\"format\":\"filament\"}, ?, 1, App\\Models\\User, 2026-09-07 07:12:28, 2026-09-07 07:12:28)) in C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php:857\nStack trace:\n#0 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php(813): Illuminate\\Database\\Connection->runQueryCallback(\'insert into `no...\', Array, Object(Closure))\n#1 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php(42): Illuminate\\Database\\Connection->run(\'insert into `no...\', Array, Object(Closure))\n#2 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Query\\Builder.php(4164): Illuminate\\Database\\MySqlConnection->insert(\'insert into `no...\', Array)\n#3 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Builder.php(2281): Illuminate\\Database\\Query\\Builder->insert(Array)\n#4 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1612): Illuminate\\Database\\Eloquent\\Builder->__call(\'insert\', Array)\n#5 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1405): Illuminate\\Database\\Eloquent\\Model->performInsert(Object(Illuminate\\Database\\Eloquent\\Builder))\n#6 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany.php(393): Illuminate\\Database\\Eloquent\\Model->save()\n#7 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\helpers.php(393): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->Illuminate\\Database\\Eloquent\\Relations\\{closure}(Object(Illuminate\\Notifications\\DatabaseNotification))\n#8 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany.php(390): tap(Object(Illuminate\\Notifications\\DatabaseNotification), Object(Closure))\n#9 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Channels\\DatabaseChannel.php(19): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->create(Array)\n#10 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(165): Illuminate\\Notifications\\Channels\\DatabaseChannel->send(Object(App\\Models\\User), Object(Filament\\Notifications\\DatabaseNotification))\n#11 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(120): Illuminate\\Notifications\\NotificationSender->sendToNotifiable(Object(App\\Models\\User), \'ec1d45d1-26c2-4...\', Object(Filament\\Notifications\\DatabaseNotification), \'database\')\n#12 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\Traits\\Localizable.php(21): Illuminate\\Notifications\\NotificationSender->Illuminate\\Notifications\\{closure}()\n#13 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(115): Illuminate\\Notifications\\NotificationSender->withLocale(NULL, Object(Closure))\n#14 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\ChannelManager.php(61): Illuminate\\Notifications\\NotificationSender->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Filament\\Notifications\\DatabaseNotification), Array)\n#15 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\SendQueuedNotifications.php(130): Illuminate\\Notifications\\ChannelManager->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Filament\\Notifications\\DatabaseNotification), Array)\n#16 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle(Object(Illuminate\\Notifications\\ChannelManager))\n#17 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#18 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#19 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#20 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(800): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#21 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(136): Illuminate\\Container\\Container->call(Array)\n#22 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#23 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#24 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(140): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#25 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(155): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Notifications\\SendQueuedNotifications), false)\n#26 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#27 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#28 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(148): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#29 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(86): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#30 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#31 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(559): Illuminate\\Queue\\Jobs\\Job->fire()\n#32 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(505): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#33 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(257): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#34 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#35 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#36 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#37 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#38 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#39 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#40 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(800): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#41 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(292): Illuminate\\Container\\Container->call(Array)\n#42 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#43 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(261): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#44 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(1117): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#45 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#46 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#47 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#48 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1242): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#49 C:\\laragon\\www\\si-jago-merah\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#50 {main}', '2026-09-07 00:12:28');
INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(2, '371b6582-aed8-4329-a75f-e582e2a7d720', 'database', 'default', '{\"uuid\":\"371b6582-aed8-4329-a75f-e582e2a7d720\",\"displayName\":\"Filament\\\\Notifications\\\\DatabaseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"deleteWhenMissingModels\":false,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:1;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:43:\\\"Filament\\\\Notifications\\\\DatabaseNotification\\\":2:{s:4:\\\"data\\\";a:11:{s:7:\\\"actions\\\";a:1:{i:0;a:23:{s:4:\\\"name\\\";s:21:\\\"downloadFailedRowsCsv\\\";s:18:\\\"alpineClickHandler\\\";N;s:5:\\\"color\\\";s:6:\\\"danger\\\";s:5:\\\"event\\\";N;s:9:\\\"eventData\\\";a:0:{}s:17:\\\"dispatchDirection\\\";b:0;s:19:\\\"dispatchToComponent\\\";N;s:15:\\\"extraAttributes\\\";a:0:{}s:4:\\\"icon\\\";N;s:12:\\\"iconPosition\\\";E:42:\\\"Filament\\\\Support\\\\Enums\\\\IconPosition:Before\\\";s:8:\\\"iconSize\\\";N;s:10:\\\"isOutlined\\\";b:0;s:10:\\\"isDisabled\\\";b:0;s:5:\\\"label\\\";s:42:\\\"Download information about the failed rows\\\";s:11:\\\"shouldClose\\\";b:0;s:16:\\\"shouldMarkAsRead\\\";b:1;s:18:\\\"shouldMarkAsUnread\\\";b:0;s:21:\\\"shouldOpenUrlInNewTab\\\";b:1;s:15:\\\"shouldPostToUrl\\\";b:0;s:4:\\\"size\\\";E:33:\\\"Filament\\\\Support\\\\Enums\\\\Size:Small\\\";s:7:\\\"tooltip\\\";N;s:3:\\\"url\\\";s:129:\\\"\\/filament\\/imports\\/2\\/failed-rows\\/download?authGuard=web&signature=248466607293dc58321b73f4c1d5d3b7750ac1013ae0fddc166f13629a7b9090\\\";s:4:\\\"view\\\";s:25:\\\"filament::components.link\\\";}}s:4:\\\"body\\\";s:82:\\\"Import hotspot SIPONGI selesai. 0 data berhasil diimport. 216 data gagal diimport.\\\";s:5:\\\"color\\\";N;s:8:\\\"duration\\\";s:10:\\\"persistent\\\";s:4:\\\"icon\\\";s:19:\\\"heroicon-o-x-circle\\\";s:9:\\\"iconColor\\\";s:6:\\\"danger\\\";s:6:\\\"status\\\";s:6:\\\"danger\\\";s:5:\\\"title\\\";s:16:\\\"Import completed\\\";s:4:\\\"view\\\";N;s:8:\\\"viewData\\\";a:0:{}s:6:\\\"format\\\";s:8:\\\"filament\\\";}s:2:\\\"id\\\";s:36:\\\"f1aaad8c-978b-41ad-ae3c-8d41ae8a652c\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}}\",\"batchId\":null},\"createdAt\":1788765775,\"delay\":null}', 'PDOException: SQLSTATE[42S02]: Base table or view not found: 1146 Table \'si_jago_merah.notifications\' doesn\'t exist in C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php:47\nStack trace:\n#0 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php(47): PDO->prepare(\'insert into `no...\')\n#1 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php(846): Illuminate\\Database\\MySqlConnection->Illuminate\\Database\\{closure}(\'insert into `no...\', Array)\n#2 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php(813): Illuminate\\Database\\Connection->runQueryCallback(\'insert into `no...\', Array, Object(Closure))\n#3 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php(42): Illuminate\\Database\\Connection->run(\'insert into `no...\', Array, Object(Closure))\n#4 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Query\\Builder.php(4164): Illuminate\\Database\\MySqlConnection->insert(\'insert into `no...\', Array)\n#5 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Builder.php(2281): Illuminate\\Database\\Query\\Builder->insert(Array)\n#6 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1612): Illuminate\\Database\\Eloquent\\Builder->__call(\'insert\', Array)\n#7 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1405): Illuminate\\Database\\Eloquent\\Model->performInsert(Object(Illuminate\\Database\\Eloquent\\Builder))\n#8 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany.php(393): Illuminate\\Database\\Eloquent\\Model->save()\n#9 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\helpers.php(393): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->Illuminate\\Database\\Eloquent\\Relations\\{closure}(Object(Illuminate\\Notifications\\DatabaseNotification))\n#10 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany.php(390): tap(Object(Illuminate\\Notifications\\DatabaseNotification), Object(Closure))\n#11 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Channels\\DatabaseChannel.php(19): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->create(Array)\n#12 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(165): Illuminate\\Notifications\\Channels\\DatabaseChannel->send(Object(App\\Models\\User), Object(Filament\\Notifications\\DatabaseNotification))\n#13 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(120): Illuminate\\Notifications\\NotificationSender->sendToNotifiable(Object(App\\Models\\User), \'a5ab914a-b70c-4...\', Object(Filament\\Notifications\\DatabaseNotification), \'database\')\n#14 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\Traits\\Localizable.php(21): Illuminate\\Notifications\\NotificationSender->Illuminate\\Notifications\\{closure}()\n#15 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(115): Illuminate\\Notifications\\NotificationSender->withLocale(NULL, Object(Closure))\n#16 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\ChannelManager.php(61): Illuminate\\Notifications\\NotificationSender->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Filament\\Notifications\\DatabaseNotification), Array)\n#17 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\SendQueuedNotifications.php(130): Illuminate\\Notifications\\ChannelManager->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Filament\\Notifications\\DatabaseNotification), Array)\n#18 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle(Object(Illuminate\\Notifications\\ChannelManager))\n#19 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#20 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#21 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#22 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(800): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#23 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(136): Illuminate\\Container\\Container->call(Array)\n#24 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#25 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#26 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(140): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#27 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(155): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Notifications\\SendQueuedNotifications), false)\n#28 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#29 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#30 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(148): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#31 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(86): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#32 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#33 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(559): Illuminate\\Queue\\Jobs\\Job->fire()\n#34 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(505): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#35 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(257): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#36 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#37 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#38 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#39 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#40 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#41 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#42 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(800): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#43 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(292): Illuminate\\Container\\Container->call(Array)\n#44 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#45 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(261): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#46 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(1117): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#47 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#48 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#49 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#50 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1242): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#51 C:\\laragon\\www\\si-jago-merah\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#52 {main}\n\nNext Illuminate\\Database\\QueryException: SQLSTATE[42S02]: Base table or view not found: 1146 Table \'si_jago_merah.notifications\' doesn\'t exist (Connection: mysql, Host: 127.0.0.1, Port: 3306, Database: si_jago_merah, SQL: insert into `notifications` (`id`, `type`, `data`, `read_at`, `notifiable_id`, `notifiable_type`, `updated_at`, `created_at`) values (f1aaad8c-978b-41ad-ae3c-8d41ae8a652c, Filament\\Notifications\\DatabaseNotification, {\"actions\":[{\"name\":\"downloadFailedRowsCsv\",\"alpineClickHandler\":null,\"color\":\"danger\",\"event\":null,\"eventData\":[],\"dispatchDirection\":false,\"dispatchToComponent\":null,\"extraAttributes\":[],\"icon\":null,\"iconPosition\":\"before\",\"iconSize\":null,\"isOutlined\":false,\"isDisabled\":false,\"label\":\"Download information about the failed rows\",\"shouldClose\":false,\"shouldMarkAsRead\":true,\"shouldMarkAsUnread\":false,\"shouldOpenUrlInNewTab\":true,\"shouldPostToUrl\":false,\"size\":\"sm\",\"tooltip\":null,\"url\":\"\\/filament\\/imports\\/2\\/failed-rows\\/download?authGuard=web&signature=248466607293dc58321b73f4c1d5d3b7750ac1013ae0fddc166f13629a7b9090\",\"view\":\"filament::components.link\"}],\"body\":\"Import hotspot SIPONGI selesai. 0 data berhasil diimport. 216 data gagal diimport.\",\"color\":null,\"duration\":\"persistent\",\"icon\":\"heroicon-o-x-circle\",\"iconColor\":\"danger\",\"status\":\"danger\",\"title\":\"Import completed\",\"view\":null,\"viewData\":[],\"format\":\"filament\"}, ?, 1, App\\Models\\User, 2026-09-07 07:22:55, 2026-09-07 07:22:55)) in C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php:857\nStack trace:\n#0 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php(813): Illuminate\\Database\\Connection->runQueryCallback(\'insert into `no...\', Array, Object(Closure))\n#1 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php(42): Illuminate\\Database\\Connection->run(\'insert into `no...\', Array, Object(Closure))\n#2 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Query\\Builder.php(4164): Illuminate\\Database\\MySqlConnection->insert(\'insert into `no...\', Array)\n#3 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Builder.php(2281): Illuminate\\Database\\Query\\Builder->insert(Array)\n#4 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1612): Illuminate\\Database\\Eloquent\\Builder->__call(\'insert\', Array)\n#5 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1405): Illuminate\\Database\\Eloquent\\Model->performInsert(Object(Illuminate\\Database\\Eloquent\\Builder))\n#6 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany.php(393): Illuminate\\Database\\Eloquent\\Model->save()\n#7 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\helpers.php(393): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->Illuminate\\Database\\Eloquent\\Relations\\{closure}(Object(Illuminate\\Notifications\\DatabaseNotification))\n#8 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany.php(390): tap(Object(Illuminate\\Notifications\\DatabaseNotification), Object(Closure))\n#9 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Channels\\DatabaseChannel.php(19): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->create(Array)\n#10 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(165): Illuminate\\Notifications\\Channels\\DatabaseChannel->send(Object(App\\Models\\User), Object(Filament\\Notifications\\DatabaseNotification))\n#11 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(120): Illuminate\\Notifications\\NotificationSender->sendToNotifiable(Object(App\\Models\\User), \'a5ab914a-b70c-4...\', Object(Filament\\Notifications\\DatabaseNotification), \'database\')\n#12 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\Traits\\Localizable.php(21): Illuminate\\Notifications\\NotificationSender->Illuminate\\Notifications\\{closure}()\n#13 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(115): Illuminate\\Notifications\\NotificationSender->withLocale(NULL, Object(Closure))\n#14 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\ChannelManager.php(61): Illuminate\\Notifications\\NotificationSender->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Filament\\Notifications\\DatabaseNotification), Array)\n#15 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\SendQueuedNotifications.php(130): Illuminate\\Notifications\\ChannelManager->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Filament\\Notifications\\DatabaseNotification), Array)\n#16 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle(Object(Illuminate\\Notifications\\ChannelManager))\n#17 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#18 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#19 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#20 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(800): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#21 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(136): Illuminate\\Container\\Container->call(Array)\n#22 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#23 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#24 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(140): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#25 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(155): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Notifications\\SendQueuedNotifications), false)\n#26 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#27 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#28 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(148): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#29 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(86): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#30 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#31 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(559): Illuminate\\Queue\\Jobs\\Job->fire()\n#32 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(505): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#33 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(257): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#34 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#35 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#36 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#37 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#38 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#39 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#40 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(800): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#41 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(292): Illuminate\\Container\\Container->call(Array)\n#42 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#43 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(261): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#44 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(1117): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#45 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#46 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#47 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#48 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1242): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#49 C:\\laragon\\www\\si-jago-merah\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#50 {main}', '2026-09-07 00:22:55');
INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(3, 'f38e483d-dc32-4e50-af8f-0875fed1616c', 'database', 'default', '{\"uuid\":\"f38e483d-dc32-4e50-af8f-0875fed1616c\",\"displayName\":\"Filament\\\\Notifications\\\\DatabaseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"deleteWhenMissingModels\":false,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:1;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:43:\\\"Filament\\\\Notifications\\\\DatabaseNotification\\\":2:{s:4:\\\"data\\\";a:11:{s:7:\\\"actions\\\";a:0:{}s:4:\\\"body\\\";s:59:\\\"Import hotspot SIPONGI selesai. 216 data berhasil diimport.\\\";s:5:\\\"color\\\";N;s:8:\\\"duration\\\";s:10:\\\"persistent\\\";s:4:\\\"icon\\\";s:23:\\\"heroicon-o-check-circle\\\";s:9:\\\"iconColor\\\";s:7:\\\"success\\\";s:6:\\\"status\\\";s:7:\\\"success\\\";s:5:\\\"title\\\";s:16:\\\"Import completed\\\";s:4:\\\"view\\\";N;s:8:\\\"viewData\\\";a:0:{}s:6:\\\"format\\\";s:8:\\\"filament\\\";}s:2:\\\"id\\\";s:36:\\\"9c77b43d-8b1e-46e7-b8db-3f5f9b97ac18\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}}\",\"batchId\":null},\"createdAt\":1788766030,\"delay\":null}', 'PDOException: SQLSTATE[42S02]: Base table or view not found: 1146 Table \'si_jago_merah.notifications\' doesn\'t exist in C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php:47\nStack trace:\n#0 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php(47): PDO->prepare(\'insert into `no...\')\n#1 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php(846): Illuminate\\Database\\MySqlConnection->Illuminate\\Database\\{closure}(\'insert into `no...\', Array)\n#2 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php(813): Illuminate\\Database\\Connection->runQueryCallback(\'insert into `no...\', Array, Object(Closure))\n#3 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php(42): Illuminate\\Database\\Connection->run(\'insert into `no...\', Array, Object(Closure))\n#4 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Query\\Builder.php(4164): Illuminate\\Database\\MySqlConnection->insert(\'insert into `no...\', Array)\n#5 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Builder.php(2281): Illuminate\\Database\\Query\\Builder->insert(Array)\n#6 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1612): Illuminate\\Database\\Eloquent\\Builder->__call(\'insert\', Array)\n#7 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1405): Illuminate\\Database\\Eloquent\\Model->performInsert(Object(Illuminate\\Database\\Eloquent\\Builder))\n#8 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany.php(393): Illuminate\\Database\\Eloquent\\Model->save()\n#9 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\helpers.php(393): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->Illuminate\\Database\\Eloquent\\Relations\\{closure}(Object(Illuminate\\Notifications\\DatabaseNotification))\n#10 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany.php(390): tap(Object(Illuminate\\Notifications\\DatabaseNotification), Object(Closure))\n#11 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Channels\\DatabaseChannel.php(19): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->create(Array)\n#12 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(165): Illuminate\\Notifications\\Channels\\DatabaseChannel->send(Object(App\\Models\\User), Object(Filament\\Notifications\\DatabaseNotification))\n#13 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(120): Illuminate\\Notifications\\NotificationSender->sendToNotifiable(Object(App\\Models\\User), \'6a7c88a2-826b-4...\', Object(Filament\\Notifications\\DatabaseNotification), \'database\')\n#14 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\Traits\\Localizable.php(21): Illuminate\\Notifications\\NotificationSender->Illuminate\\Notifications\\{closure}()\n#15 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(115): Illuminate\\Notifications\\NotificationSender->withLocale(NULL, Object(Closure))\n#16 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\ChannelManager.php(61): Illuminate\\Notifications\\NotificationSender->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Filament\\Notifications\\DatabaseNotification), Array)\n#17 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\SendQueuedNotifications.php(130): Illuminate\\Notifications\\ChannelManager->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Filament\\Notifications\\DatabaseNotification), Array)\n#18 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle(Object(Illuminate\\Notifications\\ChannelManager))\n#19 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#20 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#21 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#22 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(800): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#23 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(136): Illuminate\\Container\\Container->call(Array)\n#24 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#25 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#26 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(140): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#27 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(155): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Notifications\\SendQueuedNotifications), false)\n#28 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#29 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#30 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(148): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#31 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(86): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#32 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#33 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(559): Illuminate\\Queue\\Jobs\\Job->fire()\n#34 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(505): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#35 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(257): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#36 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#37 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#38 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#39 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#40 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#41 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#42 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(800): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#43 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(292): Illuminate\\Container\\Container->call(Array)\n#44 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#45 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(261): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#46 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(1117): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#47 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#48 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#49 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#50 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1242): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#51 C:\\laragon\\www\\si-jago-merah\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#52 {main}\n\nNext Illuminate\\Database\\QueryException: SQLSTATE[42S02]: Base table or view not found: 1146 Table \'si_jago_merah.notifications\' doesn\'t exist (Connection: mysql, Host: 127.0.0.1, Port: 3306, Database: si_jago_merah, SQL: insert into `notifications` (`id`, `type`, `data`, `read_at`, `notifiable_id`, `notifiable_type`, `updated_at`, `created_at`) values (9c77b43d-8b1e-46e7-b8db-3f5f9b97ac18, Filament\\Notifications\\DatabaseNotification, {\"actions\":[],\"body\":\"Import hotspot SIPONGI selesai. 216 data berhasil diimport.\",\"color\":null,\"duration\":\"persistent\",\"icon\":\"heroicon-o-check-circle\",\"iconColor\":\"success\",\"status\":\"success\",\"title\":\"Import completed\",\"view\":null,\"viewData\":[],\"format\":\"filament\"}, ?, 1, App\\Models\\User, 2026-09-07 07:27:10, 2026-09-07 07:27:10)) in C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php:857\nStack trace:\n#0 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php(813): Illuminate\\Database\\Connection->runQueryCallback(\'insert into `no...\', Array, Object(Closure))\n#1 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php(42): Illuminate\\Database\\Connection->run(\'insert into `no...\', Array, Object(Closure))\n#2 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Query\\Builder.php(4164): Illuminate\\Database\\MySqlConnection->insert(\'insert into `no...\', Array)\n#3 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Builder.php(2281): Illuminate\\Database\\Query\\Builder->insert(Array)\n#4 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1612): Illuminate\\Database\\Eloquent\\Builder->__call(\'insert\', Array)\n#5 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1405): Illuminate\\Database\\Eloquent\\Model->performInsert(Object(Illuminate\\Database\\Eloquent\\Builder))\n#6 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany.php(393): Illuminate\\Database\\Eloquent\\Model->save()\n#7 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\helpers.php(393): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->Illuminate\\Database\\Eloquent\\Relations\\{closure}(Object(Illuminate\\Notifications\\DatabaseNotification))\n#8 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany.php(390): tap(Object(Illuminate\\Notifications\\DatabaseNotification), Object(Closure))\n#9 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Channels\\DatabaseChannel.php(19): Illuminate\\Database\\Eloquent\\Relations\\HasOneOrMany->create(Array)\n#10 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(165): Illuminate\\Notifications\\Channels\\DatabaseChannel->send(Object(App\\Models\\User), Object(Filament\\Notifications\\DatabaseNotification))\n#11 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(120): Illuminate\\Notifications\\NotificationSender->sendToNotifiable(Object(App\\Models\\User), \'6a7c88a2-826b-4...\', Object(Filament\\Notifications\\DatabaseNotification), \'database\')\n#12 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\Traits\\Localizable.php(21): Illuminate\\Notifications\\NotificationSender->Illuminate\\Notifications\\{closure}()\n#13 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(115): Illuminate\\Notifications\\NotificationSender->withLocale(NULL, Object(Closure))\n#14 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\ChannelManager.php(61): Illuminate\\Notifications\\NotificationSender->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Filament\\Notifications\\DatabaseNotification), Array)\n#15 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\SendQueuedNotifications.php(130): Illuminate\\Notifications\\ChannelManager->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Filament\\Notifications\\DatabaseNotification), Array)\n#16 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle(Object(Illuminate\\Notifications\\ChannelManager))\n#17 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#18 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#19 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#20 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(800): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#21 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(136): Illuminate\\Container\\Container->call(Array)\n#22 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#23 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#24 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(140): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#25 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(155): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Notifications\\SendQueuedNotifications), false)\n#26 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#27 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#28 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(148): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#29 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(86): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#30 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#31 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(559): Illuminate\\Queue\\Jobs\\Job->fire()\n#32 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(505): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#33 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(257): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#34 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#35 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#36 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#37 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#38 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#39 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#40 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(800): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#41 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(292): Illuminate\\Container\\Container->call(Array)\n#42 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#43 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(261): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#44 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(1117): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#45 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#46 C:\\laragon\\www\\si-jago-merah\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#47 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#48 C:\\laragon\\www\\si-jago-merah\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1242): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#49 C:\\laragon\\www\\si-jago-merah\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#50 {main}', '2026-09-07 00:27:10');

-- --------------------------------------------------------

--
-- Table structure for table `hotspots`
--

CREATE TABLE `hotspots` (
  `id` bigint UNSIGNED NOT NULL,
  `latitude` decimal(10,6) NOT NULL,
  `longitude` decimal(10,6) NOT NULL,
  `source` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bright_ti4` decimal(8,2) DEFAULT NULL,
  `scan` decimal(8,4) DEFAULT NULL,
  `track` decimal(8,4) DEFAULT NULL,
  `acq_date` date DEFAULT NULL,
  `acq_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `satellite` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instrument` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `confidence` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bright_ti5` decimal(8,2) DEFAULT NULL,
  `frp` decimal(10,2) DEFAULT NULL,
  `daynight` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hotspots`
--

INSERT INTO `hotspots` (`id`, `latitude`, `longitude`, `source`, `region`, `bright_ti4`, `scan`, `track`, `acq_date`, `acq_time`, `satellite`, `instrument`, `confidence`, `version`, `bright_ti5`, `frp`, `daynight`, `created_at`, `updated_at`) VALUES
(1, -3.154400, 108.151790, 'MODIS_NRT', 'Belitung Timur', NULL, 1.3400, 1.1500, '2026-08-20', '141', 'Terra', 'MODIS', '65', '6.1NRT', NULL, 44.45, 'D', '2026-08-20 01:06:56', '2026-08-20 01:06:56'),
(2, -3.152790, 108.140040, 'MODIS_NRT', 'Belitung Timur', NULL, 1.3400, 1.1500, '2026-08-20', '141', 'Terra', 'MODIS', '73', '6.1NRT', NULL, 28.05, 'D', '2026-08-20 01:06:56', '2026-08-20 01:06:56'),
(3, -3.144270, 108.153150, 'MODIS_NRT', 'Belitung Timur', NULL, 1.3400, 1.1500, '2026-08-20', '141', 'Terra', 'MODIS', '70', '6.1NRT', NULL, 22.03, 'D', '2026-08-20 01:06:56', '2026-08-20 01:06:56'),
(4, -3.142670, 108.141400, 'MODIS_NRT', 'Belitung Timur', NULL, 1.3400, 1.1500, '2026-08-20', '141', 'Terra', 'MODIS', '64', '6.1NRT', NULL, 13.53, 'D', '2026-08-20 01:06:56', '2026-08-20 01:06:56'),
(5, -2.918620, 106.840280, 'MODIS_NRT', 'Bangka Selatan', NULL, 1.1200, 1.0600, '2026-08-20', '141', 'Terra', 'MODIS', '0', '6.1NRT', NULL, 31.79, 'D', '2026-08-20 01:06:56', '2026-08-20 01:06:56'),
(6, -2.917230, 106.830440, 'MODIS_NRT', 'Bangka Selatan', NULL, 1.1200, 1.0600, '2026-08-20', '141', 'Terra', 'MODIS', '76', '6.1NRT', NULL, 36.24, 'D', '2026-08-20 01:06:56', '2026-08-20 01:06:56'),
(7, -2.066490, 105.263150, 'MODIS_NRT', 'Bangka Barat', NULL, 1.0000, 1.0000, '2026-08-20', '141', 'Terra', 'MODIS', '53', '6.1NRT', NULL, 5.01, 'D', '2026-08-20 01:06:56', '2026-08-20 01:06:56'),
(8, -2.065240, 105.254360, 'MODIS_NRT', 'Bangka Barat', NULL, 1.0000, 1.0000, '2026-08-20', '141', 'Terra', 'MODIS', '55', '6.1NRT', NULL, 7.11, 'D', '2026-08-20 01:06:56', '2026-08-20 01:06:56'),
(9, -3.138130, 107.650270, 'MODIS_NRT', 'Belitung', NULL, 1.1900, 1.0800, '2026-09-01', '120', 'Terra', 'MODIS', '59', '6.1NRT', NULL, 6.93, 'D', '2026-08-31 22:08:38', '2026-08-31 22:08:38'),
(10, -2.900860, 106.400540, 'MODIS_NRT', 'Bangka Selatan', NULL, 2.0200, 1.3900, '2026-09-07', '156', 'Terra', 'MODIS', '64', '6.1NRT', NULL, 15.99, 'D', '2026-09-06 21:30:10', '2026-09-06 21:30:10'),
(11, -2.898470, 106.382930, 'MODIS_NRT', 'Bangka Selatan', NULL, 2.0200, 1.3800, '2026-09-07', '156', 'Terra', 'MODIS', '80', '6.1NRT', NULL, 47.18, 'D', '2026-09-06 21:30:10', '2026-09-06 21:30:10'),
(12, -1.554490, 105.728710, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(13, -1.553270, 105.737560, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(14, -2.219050, 105.932950, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(15, -1.559900, 105.925740, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(16, -1.555210, 105.733750, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(17, -1.555740, 105.730290, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(18, -1.552430, 105.729790, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(19, -1.551370, 105.736700, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(20, -1.683480, 105.782130, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(21, -2.065600, 106.148050, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(22, -1.750080, 105.991660, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(23, -1.942070, 106.157190, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(24, -1.553280, 105.735890, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-07', '0151', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(25, -1.552720, 105.732350, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-07', '0151', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(26, -1.549220, 105.736530, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-07', '0151', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(27, -1.684240, 105.784930, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '1312', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(28, -1.682520, 105.784870, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '1312', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(29, -1.679940, 105.784300, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '1312', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(30, -1.819010, 106.098200, 'SIPONGI', 'BANGKA', NULL, NULL, NULL, '2026-09-06', '1312', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(31, -1.867900, 105.606230, 'SIPONGI', 'BANGKA BARAT', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(32, -1.980860, 105.454220, 'SIPONGI', 'BANGKA BARAT', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(33, -1.974720, 105.499310, 'SIPONGI', 'BANGKA BARAT', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(34, -1.795460, 105.405570, 'SIPONGI', 'BANGKA BARAT', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(35, -2.005190, 105.477080, 'SIPONGI', 'BANGKA BARAT', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(36, -1.666260, 105.539750, 'SIPONGI', 'BANGKA BARAT', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(37, -2.019090, 105.496750, 'SIPONGI', 'BANGKA BARAT', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(38, -2.008490, 105.477580, 'SIPONGI', 'BANGKA BARAT', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(39, -2.007970, 105.481020, 'SIPONGI', 'BANGKA BARAT', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(40, -1.981840, 105.485500, 'SIPONGI', 'BANGKA BARAT', NULL, NULL, NULL, '2026-09-07', '0210', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(41, -1.720160, 105.602110, 'SIPONGI', 'BANGKA BARAT', NULL, NULL, NULL, '2026-09-06', '1312', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(42, -2.071560, 105.147160, 'SIPONGI', 'BANGKA BARAT', NULL, NULL, NULL, '2026-09-06', '1312', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(43, -2.007470, 105.478430, 'SIPONGI', 'BANGKA BARAT', NULL, NULL, NULL, '2026-09-06', '1312', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(44, -2.006830, 105.482690, 'SIPONGI', 'BANGKA BARAT', NULL, NULL, NULL, '2026-09-06', '1312', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(45, -2.733540, 106.345950, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '90', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(46, -2.854110, 106.270580, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '90', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(47, -2.852900, 106.279370, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '90', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(48, -2.828060, 106.329610, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '90', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(49, -2.708410, 106.136440, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '90', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(50, -2.806530, 106.093380, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '90', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(51, -2.895270, 106.380570, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '90', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(52, -2.894070, 106.389340, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '90', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(53, -2.890980, 106.389170, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0329', 'NASA-MODIS', NULL, '90', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(54, -2.800780, 105.992520, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1509', 'NASA-MODIS', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(55, -2.727990, 106.255740, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(56, -2.707210, 106.145260, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(57, -2.738050, 106.593630, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(58, -2.736850, 106.602370, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(59, -2.900860, 106.400540, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0856', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(60, -2.898470, 106.382930, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0856', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(61, -2.892230, 106.383200, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0032', 'NASA-NOAA20', NULL, '90', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(62, -2.846560, 106.300310, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(63, -2.832270, 106.216260, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(64, -2.853800, 106.208850, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(65, -2.836840, 106.142350, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(66, -2.806410, 106.097960, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(67, -2.833100, 106.166640, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(68, -2.824250, 106.203620, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(69, -2.705400, 105.936630, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(70, -2.704870, 105.940080, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(71, -2.916460, 106.375540, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(72, -2.909800, 106.374530, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(73, -2.866930, 106.278450, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(74, -2.864140, 106.274470, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(75, -2.849890, 106.300820, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(76, -2.849350, 106.304300, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(77, -2.846030, 106.303790, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(78, -2.837010, 106.273900, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(79, -2.839510, 106.125020, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(80, -2.834220, 106.269910, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(81, -2.818720, 106.039610, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(82, -2.818190, 106.043080, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(83, -2.812520, 106.102430, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(84, -2.809200, 106.101930, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(85, -2.806940, 106.094500, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(86, -2.803620, 106.093990, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(87, -2.792730, 106.032140, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(88, -2.768990, 106.032090, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(89, -2.759160, 106.140460, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(90, -2.758630, 106.143940, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(91, -2.755310, 106.143430, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(92, -2.810890, 106.024270, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(93, -2.798020, 105.997560, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(94, -2.797490, 106.001020, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(95, -2.794170, 106.000520, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(96, -2.793650, 106.003970, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(97, -2.793260, 106.028680, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(98, -2.793120, 106.007430, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(99, -2.788740, 106.013850, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(100, -2.788210, 106.017310, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(101, -2.787550, 105.999520, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(102, -2.764880, 105.992550, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(103, -2.754010, 106.019210, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(104, -2.753480, 106.022670, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(105, -2.749630, 106.025620, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(106, -2.744100, 105.949540, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(107, -2.734840, 105.965810, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(108, -2.728590, 105.940130, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(109, -2.940090, 106.443520, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(110, -2.751660, 106.590180, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(111, -3.040540, 106.585170, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:09', '2026-09-07 00:27:09'),
(112, -2.966710, 106.336720, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(113, -2.908190, 106.385010, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(114, -2.901390, 106.387180, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(115, -2.898060, 106.386670, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(116, -2.891270, 106.364190, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(117, -2.887940, 106.363680, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(118, -2.895730, 106.389660, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0032', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(119, -2.894660, 106.383510, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0032', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(120, -2.893620, 106.377490, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0032', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(121, -2.893250, 106.389330, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0032', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(122, -2.891220, 106.377170, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0032', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(123, -2.887950, 106.384860, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0032', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(124, -2.894060, 106.385550, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0210', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(125, -2.893210, 106.379860, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0210', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(126, -3.075030, 106.583210, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(127, -3.074490, 106.586730, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(128, -3.031620, 106.710220, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(129, -2.895320, 106.385990, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0153', 'NASA-SNPP', NULL, '90', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(130, -2.748700, 106.382850, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(131, -2.868240, 106.277870, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(132, -2.847220, 106.302560, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(133, -2.832700, 106.331380, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0153', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(134, -2.832070, 106.327320, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0153', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(135, -2.833990, 106.216920, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(136, -2.834330, 106.273030, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(137, -2.811850, 106.100290, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(138, -2.811270, 106.104290, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(139, -2.809050, 106.100280, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(140, -2.805370, 106.095660, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(141, -2.803990, 106.091290, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0153', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(142, -2.759080, 106.141730, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(143, -2.754810, 106.141110, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(144, -2.797920, 105.999940, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(145, -2.794220, 105.995260, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(146, -2.793610, 105.999310, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(147, -2.786870, 106.014870, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(148, -2.889640, 106.364110, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(149, -2.889330, 106.364150, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(150, -2.899650, 106.385350, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0153', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(151, -2.895940, 106.390080, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0153', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(152, -2.894700, 106.381920, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0153', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(153, -2.890980, 106.386630, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-07', '0153', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(154, -3.076260, 106.585860, 'SIPONGI', 'BANGKA SELATAN', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(155, -2.426640, 106.240450, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '90', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(156, -2.435440, 106.241670, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(157, -2.432750, 106.242160, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-07', '0329', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(158, -2.471600, 105.977510, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(159, -2.470390, 105.986350, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(160, -2.379970, 105.840960, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(161, -2.477780, 105.982350, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(162, -2.575350, 106.740370, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(163, -2.569860, 106.776040, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(164, -2.566500, 106.775530, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(165, -2.535280, 106.584820, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(166, -2.429920, 106.239470, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-07', '0032', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(167, -2.427670, 106.241060, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-07', '0210', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(168, -2.481630, 105.979380, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(169, -2.475520, 105.974920, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(170, -2.374300, 105.822790, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-07', '0032', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(171, -2.569060, 106.776240, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(172, -2.540790, 106.657550, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(173, -2.534570, 106.585560, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(174, -2.429970, 106.242150, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-07', '0151', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(175, -2.472800, 105.982640, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-07', '0153', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(176, -2.471820, 105.981780, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-07', '0153', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(177, -2.474820, 105.975460, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(178, -2.409680, 105.953870, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(179, -2.407840, 105.953240, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(180, -2.401290, 105.857840, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-07', '0151', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(181, -2.385990, 105.841170, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-07', '0151', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(182, -2.381280, 105.838110, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-07', '0151', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(183, -2.375440, 105.827620, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-07', '0151', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(184, -2.374870, 105.823910, 'SIPONGI', 'BANGKA TENGAH', NULL, NULL, NULL, '2026-09-07', '0151', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(185, -2.700580, 107.791620, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '90', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(186, -2.747470, 107.715420, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '90', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(187, -2.748710, 107.706440, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '2036', 'NASA-MODIS', NULL, '90', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(188, -2.900880, 107.560200, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '30', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(189, -2.927830, 107.545170, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(190, -2.918090, 107.539860, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(191, -2.916940, 107.547340, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(192, -2.913510, 107.546810, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(193, -2.907740, 107.584280, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(194, -3.009910, 107.603560, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(195, -2.604090, 107.708260, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(196, -2.596430, 107.734440, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(197, -2.704350, 107.792960, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-07', '0032', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(198, -2.699480, 107.792010, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-07', '0032', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(199, -2.604720, 107.818050, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(200, -2.637820, 107.651190, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(201, -2.916430, 107.540190, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(202, -2.916360, 107.542200, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(203, -2.915720, 107.545090, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(204, -2.915610, 107.547090, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(205, -2.897790, 107.559390, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(206, -2.921540, 107.555660, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-07', '0153', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(207, -2.604630, 107.706450, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(208, -2.706640, 107.690670, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(209, -2.637010, 107.648010, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(210, -2.709780, 107.696010, 'SIPONGI', 'BELITUNG', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(211, -3.066330, 108.154830, 'SIPONGI', 'BELITUNG TIMUR', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(212, -3.066950, 108.150890, 'SIPONGI', 'BELITUNG TIMUR', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(213, -3.066320, 108.151290, 'SIPONGI', 'BELITUNG TIMUR', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(214, -3.162070, 108.141290, 'SIPONGI', 'BELITUNG TIMUR', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(215, -2.825380, 108.025910, 'SIPONGI', 'BELITUNG TIMUR', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(216, -2.682250, 107.918540, 'SIPONGI', 'BELITUNG TIMUR', NULL, NULL, NULL, '2026-09-07', '0032', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(217, -2.626790, 108.092740, 'SIPONGI', 'BELITUNG TIMUR', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(218, -2.956040, 108.069490, 'SIPONGI', 'BELITUNG TIMUR', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(219, -2.954650, 108.071320, 'SIPONGI', 'BELITUNG TIMUR', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(220, -2.954200, 108.073520, 'SIPONGI', 'BELITUNG TIMUR', NULL, NULL, NULL, '2026-09-06', '1310', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(221, -2.126940, 106.168400, 'SIPONGI', 'KOTA PANGKAL PINANG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(222, -2.124140, 106.164420, 'SIPONGI', 'KOTA PANGKAL PINANG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(223, -2.123610, 106.167920, 'SIPONGI', 'KOTA PANGKAL PINANG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(224, -2.090940, 106.070370, 'SIPONGI', 'KOTA PANGKAL PINANG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(225, -2.081650, 106.064980, 'SIPONGI', 'KOTA PANGKAL PINANG', NULL, NULL, NULL, '2026-09-06', '1329', 'NASA-NOAA20', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(226, -2.126800, 106.167390, 'SIPONGI', 'KOTA PANGKAL PINANG', NULL, NULL, NULL, '2026-09-06', '1312', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(227, -2.089460, 106.070450, 'SIPONGI', 'KOTA PANGKAL PINANG', NULL, NULL, NULL, '2026-09-06', '1312', 'NASA-SNPP', NULL, '65', NULL, NULL, NULL, NULL, '2026-09-07 00:27:10', '2026-09-07 00:27:10'),
(228, -1.582680, 105.961870, 'MODIS_NRT', 'Bangka', NULL, 1.0000, 1.0000, '2026-09-09', '134', 'Terra', 'MODIS', '56', '6.1NRT', NULL, 6.55, 'D', '2026-09-09 02:50:12', '2026-09-09 02:50:12'),
(229, -1.581430, 105.953110, 'MODIS_NRT', 'Bangka', NULL, 1.0000, 1.0000, '2026-09-09', '134', 'Terra', 'MODIS', '58', '6.1NRT', NULL, 7.11, 'D', '2026-09-09 02:50:12', '2026-09-09 02:50:12'),
(230, -2.962350, 108.071220, 'MODIS_NRT', 'Belitung Timur', NULL, 1.1700, 1.0800, '2026-09-09', '137', 'Terra', 'MODIS', '82', '6.1NRT', NULL, 25.29, 'D', '2026-09-09 02:50:14', '2026-09-09 02:50:14'),
(231, -2.812710, 106.381870, 'MODIS_NRT', 'Bangka Selatan', NULL, 1.0200, 1.0100, '2026-09-09', '137', 'Terra', 'MODIS', '71', '6.1NRT', NULL, 10.56, 'D', '2026-09-09 02:50:14', '2026-09-09 02:50:14'),
(232, -2.745750, 106.039760, 'MODIS_NRT', 'Bangka Selatan', NULL, 1.0000, 1.0000, '2026-09-09', '137', 'Terra', 'MODIS', '61', '6.1NRT', NULL, 6.87, 'D', '2026-09-09 02:50:14', '2026-09-09 02:50:14'),
(233, -2.447880, 106.270260, 'MODIS_NRT', 'Bangka Tengah', NULL, 1.0100, 1.0000, '2026-09-09', '137', 'Terra', 'MODIS', '85', '6.1NRT', NULL, 24.39, 'D', '2026-09-09 02:50:14', '2026-09-09 02:50:14'),
(234, -2.439030, 106.271480, 'MODIS_NRT', 'Bangka Tengah', NULL, 1.0100, 1.0000, '2026-09-09', '137', 'Terra', 'MODIS', '55', '6.1NRT', NULL, 10.41, 'D', '2026-09-09 02:50:14', '2026-09-09 02:50:14'),
(235, -2.437780, 106.262650, 'MODIS_NRT', 'Bangka Tengah', NULL, 1.0100, 1.0000, '2026-09-09', '137', 'Terra', 'MODIS', '35', '6.1NRT', NULL, 6.77, 'D', '2026-09-09 02:50:14', '2026-09-09 02:50:14'),
(236, -2.306940, 105.865680, 'MODIS_NRT', 'Bangka', NULL, 1.0000, 1.0000, '2026-09-09', '137', 'Terra', 'MODIS', '76', '6.1NRT', NULL, 13.90, 'D', '2026-09-09 02:50:14', '2026-09-09 02:50:14'),
(237, -2.151590, 106.006810, 'MODIS_NRT', 'Bangka', NULL, 1.0000, 1.0000, '2026-09-09', '137', 'Terra', 'MODIS', '55', '6.1NRT', NULL, 4.93, 'D', '2026-09-09 02:50:14', '2026-09-09 02:50:14'),
(238, -2.861360, 108.071530, 'MODIS_NRT', 'Belitung Timur', NULL, 1.4000, 1.1700, '2026-09-08', '1314', 'Terra', 'MODIS', '87', '6.1NRT', NULL, 17.71, 'N', '2026-09-09 04:34:03', '2026-09-09 04:34:03'),
(239, -2.813920, 107.818250, 'MODIS_NRT', 'Belitung', NULL, 1.4600, 1.1900, '2026-09-08', '1314', 'Terra', 'MODIS', '60', '6.1NRT', NULL, 8.18, 'N', '2026-09-09 04:34:03', '2026-09-09 04:34:03'),
(240, -2.694930, 106.143230, 'MODIS_NRT', 'Bangka Selatan', NULL, 1.9500, 1.3600, '2026-09-08', '1314', 'Terra', 'MODIS', '62', '6.1NRT', NULL, 13.32, 'N', '2026-09-09 04:34:03', '2026-09-09 04:34:03'),
(241, -2.686850, 106.378940, 'MODIS_NRT', 'Bangka Selatan', NULL, 1.8700, 1.3400, '2026-09-08', '1314', 'Terra', 'MODIS', '56', '6.1NRT', NULL, 11.52, 'N', '2026-09-09 04:34:03', '2026-09-09 04:34:03'),
(242, -2.655960, 107.861910, 'MODIS_NRT', 'Belitung', NULL, 1.4400, 1.1900, '2026-09-08', '1314', 'Terra', 'MODIS', '53', '6.1NRT', NULL, 6.57, 'N', '2026-09-09 04:34:03', '2026-09-09 04:34:03'),
(243, -2.654250, 107.874380, 'MODIS_NRT', 'Belitung', NULL, 1.4400, 1.1900, '2026-09-08', '1314', 'Terra', 'MODIS', '100', '6.1NRT', NULL, 36.93, 'N', '2026-09-09 04:34:03', '2026-09-09 04:34:03'),
(244, -2.446510, 106.267180, 'MODIS_NRT', 'Bangka Tengah', NULL, 1.8900, 1.3400, '2026-09-08', '1314', 'Terra', 'MODIS', '93', '6.1NRT', NULL, 31.58, 'N', '2026-09-09 04:34:03', '2026-09-09 04:34:03'),
(245, -2.439630, 106.259960, 'MODIS_NRT', 'Bangka Tengah', NULL, 1.8900, 1.3400, '2026-09-08', '1314', 'Terra', 'MODIS', '82', '6.1NRT', NULL, 23.13, 'N', '2026-09-09 04:34:03', '2026-09-09 04:34:03'),
(246, -2.030770, 105.721310, 'MODIS_NRT', 'Bangka Barat', NULL, 2.0600, 1.4000, '2026-09-08', '1314', 'Terra', 'MODIS', '64', '6.1NRT', NULL, 14.14, 'N', '2026-09-09 04:34:03', '2026-09-09 04:34:03'),
(247, -2.003860, 105.735890, 'MODIS_NRT', 'Bangka Barat', NULL, 2.0500, 1.3900, '2026-09-08', '1314', 'Terra', 'MODIS', '49', '6.1NRT', NULL, 9.17, 'N', '2026-09-09 04:34:04', '2026-09-09 04:34:04'),
(248, -1.872770, 105.349730, 'MODIS_NRT', 'Bangka Barat', NULL, 2.1900, 1.4400, '2026-09-08', '1314', 'Terra', 'MODIS', '60', '6.1NRT', NULL, 11.17, 'N', '2026-09-09 04:34:04', '2026-09-09 04:34:04'),
(249, -2.443800, 106.277630, 'MODIS_NRT', 'Bangka Tengah', NULL, 2.3700, 1.4900, '2026-09-08', '2006', 'Aqua', 'MODIS', '50', '6.1NRT', NULL, 16.02, 'N', '2026-09-09 04:34:04', '2026-09-09 04:34:04'),
(250, -2.805370, 106.019410, 'VIIRS_SNPP_NRT', 'Bangka Selatan', 337.58, 0.4200, 0.6100, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 292.27, 4.59, 'D', '2026-09-09 04:34:07', '2026-09-09 04:34:07'),
(251, -2.800960, 106.538960, 'VIIRS_SNPP_NRT', 'Bangka Selatan', 331.85, 0.4500, 0.6300, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 291.38, 3.50, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(252, -2.772690, 106.025090, 'VIIRS_SNPP_NRT', 'Bangka Selatan', 344.31, 0.4200, 0.6100, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 292.55, 5.74, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(253, -2.767040, 106.024150, 'VIIRS_SNPP_NRT', 'Bangka Selatan', 351.64, 0.4200, 0.6100, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 292.61, 6.65, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(254, -2.726890, 106.196080, 'VIIRS_SNPP_NRT', 'Bangka Selatan', 346.88, 0.4300, 0.6200, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 291.56, 6.18, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(255, -2.674440, 106.116810, 'VIIRS_SNPP_NRT', 'Bangka Selatan', 336.61, 0.4200, 0.6100, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 288.72, 3.45, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(256, -2.512870, 105.975070, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 336.46, 0.4200, 0.6100, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 292.32, 5.77, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(257, -2.508910, 105.975810, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 356.25, 0.4200, 0.6100, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 292.14, 6.60, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(258, -2.483940, 105.974310, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 344.52, 0.4200, 0.6100, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 292.02, 3.80, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08');
INSERT INTO `hotspots` (`id`, `latitude`, `longitude`, `source`, `region`, `bright_ti4`, `scan`, `track`, `acq_date`, `acq_time`, `satellite`, `instrument`, `confidence`, `version`, `bright_ti5`, `frp`, `daynight`, `created_at`, `updated_at`) VALUES
(259, -2.483320, 105.978140, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 331.27, 0.4200, 0.6100, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 290.63, 3.80, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(260, -2.478270, 105.973440, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 367.00, 0.4200, 0.6100, '2026-09-08', '714', 'N', 'VIIRS', 'h', '2.0NRT', 292.22, 17.46, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(261, -2.336100, 105.833800, 'VIIRS_SNPP_NRT', 'Bangka', 333.75, 0.4100, 0.6100, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 292.40, 14.57, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(262, -2.330480, 105.832920, 'VIIRS_SNPP_NRT', 'Bangka', 349.91, 0.4100, 0.6100, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 292.55, 14.57, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(263, -2.329850, 105.836690, 'VIIRS_SNPP_NRT', 'Bangka', 367.00, 0.4100, 0.6100, '2026-09-08', '714', 'N', 'VIIRS', 'h', '2.0NRT', 292.23, 14.57, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(264, -2.076150, 106.146810, 'VIIRS_SNPP_NRT', 'Bangka', 330.42, 0.4400, 0.6200, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 294.07, 3.33, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(265, -2.071040, 106.141930, 'VIIRS_SNPP_NRT', 'Bangka', 337.83, 0.4400, 0.6200, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 293.48, 8.69, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(266, -2.070380, 106.145900, 'VIIRS_SNPP_NRT', 'Bangka', 367.00, 0.4400, 0.6200, '2026-09-08', '714', 'N', 'VIIRS', 'h', '2.0NRT', 294.50, 8.69, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(267, -2.021320, 105.491520, 'VIIRS_SNPP_NRT', 'Bangka Barat', 332.84, 0.3900, 0.6000, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 296.44, 3.54, 'D', '2026-09-09 04:34:08', '2026-09-09 04:34:08'),
(268, -1.982030, 105.488990, 'VIIRS_SNPP_NRT', 'Bangka Barat', 348.00, 0.4000, 0.6000, '2026-09-08', '714', 'N', 'VIIRS', 'n', '2.0NRT', 295.03, 6.43, 'D', '2026-09-09 04:34:09', '2026-09-09 04:34:09'),
(269, -2.950620, 106.907300, 'VIIRS_SNPP_NRT', 'Bangka Selatan', 329.87, 0.4500, 0.3900, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 294.82, 2.79, 'N', '2026-09-09 04:34:11', '2026-09-09 04:34:11'),
(270, -2.908700, 108.118670, 'VIIRS_SNPP_NRT', 'Belitung Timur', 317.75, 0.4100, 0.3700, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 292.21, 1.48, 'N', '2026-09-09 04:34:11', '2026-09-09 04:34:11'),
(271, -2.896600, 106.387620, 'VIIRS_SNPP_NRT', 'Bangka Selatan', 307.48, 0.4800, 0.4000, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 294.00, 1.33, 'N', '2026-09-09 04:34:11', '2026-09-09 04:34:11'),
(272, -2.892910, 106.388220, 'VIIRS_SNPP_NRT', 'Bangka Selatan', 307.62, 0.4800, 0.4000, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 294.54, 1.33, 'N', '2026-09-09 04:34:11', '2026-09-09 04:34:11'),
(273, -2.890080, 106.370900, 'VIIRS_SNPP_NRT', 'Bangka Selatan', 305.14, 0.4800, 0.4000, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 293.85, 1.66, 'N', '2026-09-09 04:34:11', '2026-09-09 04:34:11'),
(274, -2.873240, 107.598880, 'VIIRS_SNPP_NRT', 'Belitung', 308.67, 0.4300, 0.3800, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 292.91, 0.81, 'N', '2026-09-09 04:34:11', '2026-09-09 04:34:11'),
(275, -2.851520, 108.090070, 'VIIRS_SNPP_NRT', 'Belitung Timur', 304.61, 0.4100, 0.3700, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 291.73, 0.46, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(276, -2.810320, 106.381510, 'VIIRS_SNPP_NRT', 'Bangka Selatan', 307.26, 0.4800, 0.4000, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 292.41, 1.80, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(277, -2.767790, 106.023560, 'VIIRS_SNPP_NRT', 'Bangka Selatan', 307.54, 0.5000, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 293.14, 1.30, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(278, -2.746630, 106.036290, 'VIIRS_SNPP_NRT', 'Bangka Selatan', 304.41, 0.5000, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 291.26, 1.18, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(279, -2.691210, 106.149650, 'VIIRS_SNPP_NRT', 'Bangka Selatan', 345.46, 0.5000, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 290.42, 7.18, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(280, -2.666420, 106.162930, 'VIIRS_SNPP_NRT', 'Bangka Selatan', 306.53, 0.5000, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 284.80, 1.32, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(281, -2.596120, 107.870720, 'VIIRS_SNPP_NRT', 'Belitung', 316.17, 0.4200, 0.3800, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 292.57, 1.08, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(282, -2.579940, 106.711590, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 318.25, 0.4700, 0.4000, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 290.47, 2.86, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(283, -2.508710, 105.975980, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 308.84, 0.5100, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 292.01, 1.77, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(284, -2.481870, 105.973290, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 306.64, 0.5100, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 291.26, 1.43, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(285, -2.481370, 105.975650, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 307.27, 0.5100, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 291.13, 1.03, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(286, -2.473540, 105.969920, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 311.03, 0.5100, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 291.11, 0.93, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(287, -2.470390, 106.240410, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 301.76, 0.5000, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 288.39, 0.47, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(288, -2.448540, 106.271310, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 310.29, 0.4900, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 290.19, 1.34, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(289, -2.447820, 106.266860, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 304.01, 0.4900, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 289.75, 1.34, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(290, -2.444800, 106.271910, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 334.12, 0.4900, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 291.51, 5.83, 'N', '2026-09-09 04:34:12', '2026-09-09 04:34:12'),
(291, -2.444080, 106.267460, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 344.54, 0.4900, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 294.40, 5.83, 'N', '2026-09-09 04:34:13', '2026-09-09 04:34:13'),
(292, -2.443350, 106.263020, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 314.44, 0.4900, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 288.33, 3.19, 'N', '2026-09-09 04:34:13', '2026-09-09 04:34:13'),
(293, -2.441000, 105.937160, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 305.06, 0.5200, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 292.89, 1.54, 'N', '2026-09-09 04:34:13', '2026-09-09 04:34:13'),
(294, -2.440340, 106.268070, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 334.23, 0.4900, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 291.74, 5.83, 'N', '2026-09-09 04:34:13', '2026-09-09 04:34:13'),
(295, -2.439620, 106.263620, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 324.51, 0.4900, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 289.96, 3.19, 'N', '2026-09-09 04:34:13', '2026-09-09 04:34:13'),
(296, -2.367810, 105.896410, 'VIIRS_SNPP_NRT', 'Bangka Tengah', 310.30, 0.5200, 0.4100, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 292.39, 1.12, 'N', '2026-09-09 04:34:13', '2026-09-09 04:34:13'),
(297, -2.309850, 105.865280, 'VIIRS_SNPP_NRT', 'Bangka', 316.33, 0.5200, 0.4200, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 291.11, 2.29, 'N', '2026-09-09 04:34:13', '2026-09-09 04:34:13'),
(298, -1.876930, 105.316530, 'VIIRS_SNPP_NRT', 'Bangka Barat', 310.47, 0.5700, 0.4300, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 291.32, 1.08, 'N', '2026-09-09 04:34:13', '2026-09-09 04:34:13'),
(299, -1.775760, 105.855720, 'VIIRS_SNPP_NRT', 'Bangka', 304.57, 0.5300, 0.4200, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 287.88, 0.84, 'N', '2026-09-09 04:34:13', '2026-09-09 04:34:13'),
(300, -1.580190, 105.959660, 'VIIRS_SNPP_NRT', 'Bangka', 316.59, 0.5300, 0.4200, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 278.85, 2.61, 'N', '2026-09-09 04:34:13', '2026-09-09 04:34:13'),
(301, -1.579430, 105.954920, 'VIIRS_SNPP_NRT', 'Bangka', 314.61, 0.5300, 0.4200, '2026-09-08', '1815', 'N', 'VIIRS', 'n', '2.0NRT', 280.32, 2.61, 'N', '2026-09-09 04:34:13', '2026-09-09 04:34:13'),
(302, -2.831100, 108.088170, 'VIIRS_NOAA20_NRT', 'Belitung Timur', 341.37, 0.5200, 0.5000, '2026-09-08', '553', 'N20', 'VIIRS', 'n', '2.0NRT', 297.54, 58.35, 'D', '2026-09-09 04:34:16', '2026-09-09 04:34:16'),
(303, -2.808230, 106.542410, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 337.04, 0.3400, 0.5600, '2026-09-08', '553', 'N20', 'VIIRS', 'n', '2.0NRT', 291.75, 3.89, 'D', '2026-09-09 04:34:16', '2026-09-09 04:34:16'),
(304, -2.796820, 105.992210, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 336.70, 0.3700, 0.5800, '2026-09-08', '553', 'N20', 'VIIRS', 'n', '2.0NRT', 293.82, 4.43, 'D', '2026-09-09 04:34:16', '2026-09-09 04:34:16'),
(305, -2.770840, 106.027370, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 342.07, 0.3600, 0.5800, '2026-09-08', '553', 'N20', 'VIIRS', 'n', '2.0NRT', 293.21, 5.08, 'D', '2026-09-09 04:34:16', '2026-09-09 04:34:16'),
(306, -2.769990, 106.028260, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 333.41, 0.3600, 0.5800, '2026-09-08', '553', 'N20', 'VIIRS', 'n', '2.0NRT', 292.66, 4.40, 'D', '2026-09-09 04:34:17', '2026-09-09 04:34:17'),
(307, -2.483260, 105.974590, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 350.39, 0.3600, 0.5800, '2026-09-08', '553', 'N20', 'VIIRS', 'n', '2.0NRT', 295.28, 16.88, 'D', '2026-09-09 04:34:17', '2026-09-09 04:34:17'),
(308, -2.482780, 105.977830, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 354.71, 0.3600, 0.5800, '2026-09-08', '553', 'N20', 'VIIRS', 'n', '2.0NRT', 293.25, 16.88, 'D', '2026-09-09 04:34:17', '2026-09-09 04:34:17'),
(309, -2.482310, 105.981050, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 332.41, 0.3600, 0.5800, '2026-09-08', '553', 'N20', 'VIIRS', 'n', '2.0NRT', 292.93, 6.63, 'D', '2026-09-09 04:34:17', '2026-09-09 04:34:17'),
(310, -2.332600, 105.836120, 'VIIRS_NOAA20_NRT', 'Bangka', 367.00, 0.3700, 0.5800, '2026-09-08', '553', 'N20', 'VIIRS', 'h', '2.0NRT', 293.43, 8.25, 'D', '2026-09-09 04:34:17', '2026-09-09 04:34:17'),
(311, -2.147720, 106.065960, 'VIIRS_NOAA20_NRT', 'Bangka', 353.85, 0.3500, 0.5700, '2026-09-08', '553', 'N20', 'VIIRS', 'n', '2.0NRT', 295.28, 8.25, 'D', '2026-09-09 04:34:17', '2026-09-09 04:34:17'),
(312, -2.147260, 106.069080, 'VIIRS_NOAA20_NRT', 'Bangka', 367.00, 0.3500, 0.5700, '2026-09-08', '553', 'N20', 'VIIRS', 'h', '2.0NRT', 294.66, 8.25, 'D', '2026-09-09 04:34:17', '2026-09-09 04:34:17'),
(313, -2.076160, 106.146770, 'VIIRS_NOAA20_NRT', 'Bangka', 367.00, 0.3500, 0.5700, '2026-09-08', '553', 'N20', 'VIIRS', 'h', '2.0NRT', 297.43, 8.52, 'D', '2026-09-09 04:34:17', '2026-09-09 04:34:17'),
(314, -2.070980, 106.146030, 'VIIRS_NOAA20_NRT', 'Bangka', 350.58, 0.3500, 0.5700, '2026-09-08', '553', 'N20', 'VIIRS', 'n', '2.0NRT', 295.03, 8.52, 'D', '2026-09-09 04:34:17', '2026-09-09 04:34:17'),
(315, -1.880130, 105.318400, 'VIIRS_NOAA20_NRT', 'Bangka Barat', 342.27, 0.4000, 0.6000, '2026-09-08', '553', 'N20', 'VIIRS', 'n', '2.0NRT', 295.33, 6.12, 'D', '2026-09-09 04:34:17', '2026-09-09 04:34:17'),
(316, -1.578560, 105.955970, 'VIIRS_NOAA20_NRT', 'Bangka', 352.51, 0.3500, 0.5700, '2026-09-08', '553', 'N20', 'VIIRS', 'n', '2.0NRT', 296.73, 5.61, 'D', '2026-09-09 04:34:17', '2026-09-09 04:34:17'),
(317, -1.578070, 105.959110, 'VIIRS_NOAA20_NRT', 'Bangka', 345.12, 0.3500, 0.5700, '2026-09-08', '553', 'N20', 'VIIRS', 'n', '2.0NRT', 295.87, 5.61, 'D', '2026-09-09 04:34:17', '2026-09-09 04:34:17'),
(318, -1.572870, 105.958310, 'VIIRS_NOAA20_NRT', 'Bangka', 339.84, 0.3500, 0.5700, '2026-09-08', '553', 'N20', 'VIIRS', 'n', '2.0NRT', 297.31, 5.61, 'D', '2026-09-09 04:34:17', '2026-09-09 04:34:17'),
(319, -1.558230, 105.737200, 'VIIRS_NOAA20_NRT', 'Bangka', 331.02, 0.3700, 0.5800, '2026-09-08', '553', 'N20', 'VIIRS', 'n', '2.0NRT', 293.25, 2.49, 'D', '2026-09-09 04:34:17', '2026-09-09 04:34:17'),
(320, -2.950240, 106.904560, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 318.34, 0.4800, 0.4000, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 293.74, 1.98, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(321, -2.911000, 108.118530, 'VIIRS_NOAA20_NRT', 'Belitung Timur', 309.84, 0.5700, 0.4300, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 291.91, 1.97, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(322, -2.896630, 106.385670, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 304.25, 0.4600, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 293.61, 1.59, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(323, -2.895050, 106.388850, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 306.11, 0.4600, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 294.18, 1.36, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(324, -2.894410, 106.384800, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 311.08, 0.4600, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 294.61, 1.36, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(325, -2.893040, 106.386210, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 312.52, 0.4600, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 294.89, 1.59, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(326, -2.891830, 106.368500, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 305.60, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 293.79, 1.30, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(327, -2.890550, 106.369900, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 307.81, 0.4600, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 294.06, 1.41, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(328, -2.871800, 107.598470, 'VIIRS_NOAA20_NRT', 'Belitung', 308.90, 0.5300, 0.4200, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 292.98, 1.83, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(329, -2.809550, 106.381100, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 304.81, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 291.84, 1.21, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(330, -2.808920, 106.377040, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 304.97, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 291.40, 0.70, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(331, -2.768820, 106.023830, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 309.49, 0.4400, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 294.18, 2.01, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(332, -2.745420, 106.035450, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 307.26, 0.4400, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 291.14, 1.46, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(333, -2.690960, 106.152140, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 326.07, 0.4400, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 289.38, 2.67, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(334, -2.690340, 106.148180, 'VIIRS_NOAA20_NRT', 'Bangka Selatan', 331.88, 0.4400, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 290.59, 3.87, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(335, -2.596420, 107.871790, 'VIIRS_NOAA20_NRT', 'Belitung', 307.19, 0.5400, 0.4200, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 291.81, 0.98, 'N', '2026-09-09 04:34:20', '2026-09-09 04:34:20'),
(336, -2.583250, 106.711900, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 305.07, 0.4700, 0.4000, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 290.67, 1.34, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(337, -2.579630, 106.712460, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 310.98, 0.4700, 0.4000, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 291.43, 1.41, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(338, -2.512270, 105.977460, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 307.57, 0.4300, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 290.61, 0.81, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(339, -2.508170, 105.974110, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 308.26, 0.4300, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 290.95, 0.96, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(340, -2.506950, 105.973830, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 306.08, 0.4300, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 291.30, 0.72, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(341, -2.481840, 105.973720, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 307.64, 0.4300, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 288.64, 1.07, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(342, -2.474240, 105.970920, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 315.52, 0.4300, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 288.95, 1.32, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(343, -2.449070, 106.272570, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 301.51, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 288.47, 0.55, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(344, -2.448460, 106.268590, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 302.72, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 288.15, 0.55, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(345, -2.445790, 106.272060, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 343.84, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 291.09, 7.27, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(346, -2.445530, 106.273120, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 329.36, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 290.28, 6.34, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(347, -2.445160, 106.268090, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 346.10, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 295.17, 7.27, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(348, -2.444910, 106.269130, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 346.50, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 294.92, 6.34, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(349, -2.444530, 106.264110, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 310.87, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 287.63, 5.47, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(350, -2.444300, 106.265140, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 324.00, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 288.69, 4.59, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(351, -2.441620, 106.268620, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 328.78, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 291.39, 7.27, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(352, -2.441370, 106.269680, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 310.60, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 289.43, 6.34, 'N', '2026-09-09 04:34:21', '2026-09-09 04:34:21'),
(353, -2.440980, 106.264650, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 352.11, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 292.00, 5.47, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(354, -2.440760, 106.265690, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 353.20, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 294.25, 4.59, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(355, -2.440230, 105.936590, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 307.02, 0.4300, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 291.84, 1.07, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(356, -2.440150, 106.261700, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 306.21, 0.4500, 0.3900, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 286.88, 4.59, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(357, -2.439630, 105.932740, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 306.71, 0.4300, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 291.87, 1.07, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(358, -2.435530, 105.929430, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 310.29, 0.4300, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 292.64, 1.69, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(359, -2.395870, 105.903990, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 310.67, 0.4300, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 292.96, 1.13, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(360, -2.382330, 105.839380, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 309.62, 0.4300, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 295.76, 2.49, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(361, -2.368160, 105.895760, 'VIIRS_NOAA20_NRT', 'Bangka Tengah', 313.58, 0.4300, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 293.26, 1.24, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(362, -2.309950, 105.865520, 'VIIRS_NOAA20_NRT', 'Bangka', 325.06, 0.4300, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 292.73, 2.42, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(363, -1.877340, 105.316680, 'VIIRS_NOAA20_NRT', 'Bangka Barat', 313.03, 0.4100, 0.3700, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 293.78, 1.20, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(364, -1.793500, 105.407840, 'VIIRS_NOAA20_NRT', 'Bangka Barat', 305.93, 0.4100, 0.3700, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 293.08, 0.62, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(365, -1.775990, 105.855650, 'VIIRS_NOAA20_NRT', 'Bangka', 308.39, 0.4200, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 289.60, 0.95, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(366, -1.716300, 105.431020, 'VIIRS_NOAA20_NRT', 'Bangka Barat', 304.58, 0.4100, 0.3700, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 291.88, 0.67, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(367, -1.674160, 105.652180, 'VIIRS_NOAA20_NRT', 'Bangka Barat', 302.41, 0.4200, 0.3700, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 287.42, 0.37, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(368, -1.639810, 105.457450, 'VIIRS_NOAA20_NRT', 'Bangka Barat', 306.66, 0.4100, 0.3700, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 291.02, 0.70, 'N', '2026-09-09 04:34:22', '2026-09-09 04:34:22'),
(369, -1.581900, 105.957860, 'VIIRS_NOAA20_NRT', 'Bangka', 330.87, 0.4300, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 286.37, 3.57, 'N', '2026-09-09 04:34:23', '2026-09-09 04:34:23'),
(370, -1.581300, 105.954070, 'VIIRS_NOAA20_NRT', 'Bangka', 312.41, 0.4300, 0.3800, '2026-09-08', '1834', 'N20', 'VIIRS', 'n', '2.0NRT', 285.74, 1.62, 'N', '2026-09-09 04:34:23', '2026-09-09 04:34:23');

-- --------------------------------------------------------

--
-- Table structure for table `imports`
--

CREATE TABLE `imports` (
  `id` bigint UNSIGNED NOT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `importer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `processed_rows` int UNSIGNED NOT NULL DEFAULT '0',
  `total_rows` int UNSIGNED NOT NULL,
  `successful_rows` int UNSIGNED NOT NULL DEFAULT '0',
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `imports`
--

INSERT INTO `imports` (`id`, `completed_at`, `file_name`, `file_path`, `importer`, `processed_rows`, `total_rows`, `successful_rows`, `user_id`, `created_at`, `updated_at`) VALUES
(3, '2026-09-07 00:27:10', 'sebaran-hotspot (2).csv', 'C:\\laragon\\www\\si-jago-merah\\storage\\app/private\\livewire-tmp/w3x3AExxxQkgatCi2YyTS2cMyPNjMYWIiVXIWpeH.csv', 'App\\Filament\\Imports\\HotspotImporter', 216, 216, 216, 1, '2026-09-07 00:27:08', '2026-09-07 00:27:10');

-- --------------------------------------------------------

--
-- Table structure for table `instansi_bantuan`
--

CREATE TABLE `instansi_bantuan` (
  `id` bigint UNSIGNED NOT NULL,
  `nama_instansi` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job_batches`
--

INSERT INTO `job_batches` (`id`, `name`, `total_jobs`, `pending_jobs`, `failed_jobs`, `failed_job_ids`, `options`, `cancelled_at`, `created_at`, `finished_at`) VALUES
('a2afecfa-082c-43f8-8bc4-d4df22985d51', '', 3, 0, 0, '[]', 'a:2:{s:13:\"allowFailures\";b:1;s:7:\"finally\";a:1:{i:0;O:47:\"Laravel\\SerializableClosure\\SerializableClosure\":1:{s:12:\"serializable\";O:46:\"Laravel\\SerializableClosure\\Serializers\\Signed\":2:{s:12:\"serializable\";s:4025:\"O:46:\"Laravel\\SerializableClosure\\Serializers\\Native\":5:{s:3:\"use\";a:5:{s:9:\"authGuard\";s:3:\"web\";s:9:\"columnMap\";a:7:{s:8:\"latitude\";s:8:\"Latitude\";s:9:\"longitude\";s:9:\"Longitude\";s:6:\"region\";s:8:\"Kab Kota\";s:8:\"acq_date\";s:7:\"Tanggal\";s:8:\"acq_time\";s:5:\"Waktu\";s:9:\"satellite\";s:7:\"Satelit\";s:10:\"confidence\";s:10:\"Confidence\";}s:6:\"import\";O:45:\"Illuminate\\Contracts\\Database\\ModelIdentifier\":5:{s:5:\"class\";s:38:\"Filament\\Actions\\Imports\\Models\\Import\";s:2:\"id\";i:1;s:9:\"relations\";a:0:{}s:10:\"connection\";s:5:\"mysql\";s:15:\"collectionClass\";N;}s:13:\"jobConnection\";N;s:7:\"options\";a:0:{}}s:8:\"function\";s:3292:\"function () use ($authGuard, $columnMap, $import, $jobConnection, $options): void {\n                    $import->touch(\'completed_at\');\n\n                    event(new \\Filament\\Actions\\Imports\\Events\\ImportCompleted($import, $columnMap, $options));\n\n                    if (! $import->user instanceof \\Illuminate\\Contracts\\Auth\\Authenticatable) { /** @phpstan-ignore instanceof.alwaysTrue */\n                        return;\n                    }\n\n                    $import->columnMap($columnMap);\n                    $import->options($options);\n\n                    $failedRowsCount = $import->getFailedRowsCount();\n\n                    $isSynchronous = ($jobConnection === \'sync\') || (blank($jobConnection) && (config(\'queue.default\') === \'sync\'));\n\n                    $notification = \\Filament\\Notifications\\Notification::make()\n                        ->title($import->importer::getCompletedNotificationTitle($import))\n                        ->body($import->importer::getCompletedNotificationBody($import))\n                        ->when(\n                            ! $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->success(),\n                        )\n                        ->when(\n                            $failedRowsCount && ($failedRowsCount < $import->total_rows),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->warning(),\n                        )\n                        ->when(\n                            $failedRowsCount === $import->total_rows,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->danger(),\n                        )\n                        ->when(\n                            $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->actions([\n                                \\Filament\\Actions\\Action::make(\'downloadFailedRowsCsv\')\n                                    ->label(trans_choice(\'filament-actions::import.notifications.completed.actions.download_failed_rows_csv.label\', $failedRowsCount, [\n                                        \'count\' => \\Illuminate\\Support\\Number::format($failedRowsCount),\n                                    ]))\n                                    ->color(\'danger\')\n                                    ->url(\\Illuminate\\Support\\Facades\\URL::signedRoute(\'filament.imports.failed-rows.download\', [\'authGuard\' => $authGuard, \'import\' => $import], absolute: false), shouldOpenInNewTab: true)\n                                    ->markAsRead(),\n                            ]),\n                        )\n                        ->when(\n                            $isSynchronous,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->persistent(),\n                        );\n\n                    $notification = $import->importer::modifyCompletedNotification($notification, $import);\n\n                    if ($isSynchronous) {\n                        $notification->send();\n                    } else {\n                        $notification->sendToDatabase($import->user, isEventDispatched: true);\n                    }\n                }\";s:5:\"scope\";s:29:\"Filament\\Actions\\ImportAction\";s:4:\"this\";N;s:4:\"self\";s:32:\"0000000000000c640000000000000000\";}\";s:4:\"hash\";s:44:\"arLt3Or35gG6Vf04oq1EluD5sP083INAqoYv5bq8i40=\";}}}}', NULL, 1788764787, 1788765148),
('a2aff2db-c53f-43d1-842d-3291f5882281', '', 3, 0, 0, '[]', 'a:2:{s:13:\"allowFailures\";b:1;s:7:\"finally\";a:1:{i:0;O:47:\"Laravel\\SerializableClosure\\SerializableClosure\":1:{s:12:\"serializable\";O:46:\"Laravel\\SerializableClosure\\Serializers\\Signed\":2:{s:12:\"serializable\";s:4025:\"O:46:\"Laravel\\SerializableClosure\\Serializers\\Native\":5:{s:3:\"use\";a:5:{s:9:\"authGuard\";s:3:\"web\";s:9:\"columnMap\";a:7:{s:8:\"latitude\";s:8:\"Latitude\";s:9:\"longitude\";s:9:\"Longitude\";s:6:\"region\";s:8:\"Kab Kota\";s:8:\"acq_date\";s:7:\"Tanggal\";s:8:\"acq_time\";s:5:\"Waktu\";s:9:\"satellite\";s:7:\"Satelit\";s:10:\"confidence\";s:10:\"Confidence\";}s:6:\"import\";O:45:\"Illuminate\\Contracts\\Database\\ModelIdentifier\":5:{s:5:\"class\";s:38:\"Filament\\Actions\\Imports\\Models\\Import\";s:2:\"id\";i:2;s:9:\"relations\";a:0:{}s:10:\"connection\";s:5:\"mysql\";s:15:\"collectionClass\";N;}s:13:\"jobConnection\";N;s:7:\"options\";a:0:{}}s:8:\"function\";s:3292:\"function () use ($authGuard, $columnMap, $import, $jobConnection, $options): void {\n                    $import->touch(\'completed_at\');\n\n                    event(new \\Filament\\Actions\\Imports\\Events\\ImportCompleted($import, $columnMap, $options));\n\n                    if (! $import->user instanceof \\Illuminate\\Contracts\\Auth\\Authenticatable) { /** @phpstan-ignore instanceof.alwaysTrue */\n                        return;\n                    }\n\n                    $import->columnMap($columnMap);\n                    $import->options($options);\n\n                    $failedRowsCount = $import->getFailedRowsCount();\n\n                    $isSynchronous = ($jobConnection === \'sync\') || (blank($jobConnection) && (config(\'queue.default\') === \'sync\'));\n\n                    $notification = \\Filament\\Notifications\\Notification::make()\n                        ->title($import->importer::getCompletedNotificationTitle($import))\n                        ->body($import->importer::getCompletedNotificationBody($import))\n                        ->when(\n                            ! $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->success(),\n                        )\n                        ->when(\n                            $failedRowsCount && ($failedRowsCount < $import->total_rows),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->warning(),\n                        )\n                        ->when(\n                            $failedRowsCount === $import->total_rows,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->danger(),\n                        )\n                        ->when(\n                            $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->actions([\n                                \\Filament\\Actions\\Action::make(\'downloadFailedRowsCsv\')\n                                    ->label(trans_choice(\'filament-actions::import.notifications.completed.actions.download_failed_rows_csv.label\', $failedRowsCount, [\n                                        \'count\' => \\Illuminate\\Support\\Number::format($failedRowsCount),\n                                    ]))\n                                    ->color(\'danger\')\n                                    ->url(\\Illuminate\\Support\\Facades\\URL::signedRoute(\'filament.imports.failed-rows.download\', [\'authGuard\' => $authGuard, \'import\' => $import], absolute: false), shouldOpenInNewTab: true)\n                                    ->markAsRead(),\n                            ]),\n                        )\n                        ->when(\n                            $isSynchronous,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->persistent(),\n                        );\n\n                    $notification = $import->importer::modifyCompletedNotification($notification, $import);\n\n                    if ($isSynchronous) {\n                        $notification->send();\n                    } else {\n                        $notification->sendToDatabase($import->user, isEventDispatched: true);\n                    }\n                }\";s:5:\"scope\";s:29:\"Filament\\Actions\\ImportAction\";s:4:\"this\";N;s:4:\"self\";s:32:\"0000000000000c640000000000000000\";}\";s:4:\"hash\";s:44:\"GIGlgacRdF75nK4KmSh62XtZytInVzSZwZN0i3dKLgc=\";}}}}', NULL, 1788765774, 1788765775),
('a2aff45f-0a85-472b-8255-fca9466b0980', '', 3, 0, 0, '[]', 'a:2:{s:13:\"allowFailures\";b:1;s:7:\"finally\";a:1:{i:0;O:47:\"Laravel\\SerializableClosure\\SerializableClosure\":1:{s:12:\"serializable\";O:46:\"Laravel\\SerializableClosure\\Serializers\\Signed\":2:{s:12:\"serializable\";s:4025:\"O:46:\"Laravel\\SerializableClosure\\Serializers\\Native\":5:{s:3:\"use\";a:5:{s:9:\"authGuard\";s:3:\"web\";s:9:\"columnMap\";a:7:{s:8:\"latitude\";s:8:\"Latitude\";s:9:\"longitude\";s:9:\"Longitude\";s:6:\"region\";s:8:\"Kab Kota\";s:8:\"acq_date\";s:7:\"Tanggal\";s:8:\"acq_time\";s:5:\"Waktu\";s:9:\"satellite\";s:7:\"Satelit\";s:10:\"confidence\";s:10:\"Confidence\";}s:6:\"import\";O:45:\"Illuminate\\Contracts\\Database\\ModelIdentifier\":5:{s:5:\"class\";s:38:\"Filament\\Actions\\Imports\\Models\\Import\";s:2:\"id\";i:3;s:9:\"relations\";a:0:{}s:10:\"connection\";s:5:\"mysql\";s:15:\"collectionClass\";N;}s:13:\"jobConnection\";N;s:7:\"options\";a:0:{}}s:8:\"function\";s:3292:\"function () use ($authGuard, $columnMap, $import, $jobConnection, $options): void {\n                    $import->touch(\'completed_at\');\n\n                    event(new \\Filament\\Actions\\Imports\\Events\\ImportCompleted($import, $columnMap, $options));\n\n                    if (! $import->user instanceof \\Illuminate\\Contracts\\Auth\\Authenticatable) { /** @phpstan-ignore instanceof.alwaysTrue */\n                        return;\n                    }\n\n                    $import->columnMap($columnMap);\n                    $import->options($options);\n\n                    $failedRowsCount = $import->getFailedRowsCount();\n\n                    $isSynchronous = ($jobConnection === \'sync\') || (blank($jobConnection) && (config(\'queue.default\') === \'sync\'));\n\n                    $notification = \\Filament\\Notifications\\Notification::make()\n                        ->title($import->importer::getCompletedNotificationTitle($import))\n                        ->body($import->importer::getCompletedNotificationBody($import))\n                        ->when(\n                            ! $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->success(),\n                        )\n                        ->when(\n                            $failedRowsCount && ($failedRowsCount < $import->total_rows),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->warning(),\n                        )\n                        ->when(\n                            $failedRowsCount === $import->total_rows,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->danger(),\n                        )\n                        ->when(\n                            $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->actions([\n                                \\Filament\\Actions\\Action::make(\'downloadFailedRowsCsv\')\n                                    ->label(trans_choice(\'filament-actions::import.notifications.completed.actions.download_failed_rows_csv.label\', $failedRowsCount, [\n                                        \'count\' => \\Illuminate\\Support\\Number::format($failedRowsCount),\n                                    ]))\n                                    ->color(\'danger\')\n                                    ->url(\\Illuminate\\Support\\Facades\\URL::signedRoute(\'filament.imports.failed-rows.download\', [\'authGuard\' => $authGuard, \'import\' => $import], absolute: false), shouldOpenInNewTab: true)\n                                    ->markAsRead(),\n                            ]),\n                        )\n                        ->when(\n                            $isSynchronous,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->persistent(),\n                        );\n\n                    $notification = $import->importer::modifyCompletedNotification($notification, $import);\n\n                    if ($isSynchronous) {\n                        $notification->send();\n                    } else {\n                        $notification->sendToDatabase($import->user, isEventDispatched: true);\n                    }\n                }\";s:5:\"scope\";s:29:\"Filament\\Actions\\ImportAction\";s:4:\"this\";N;s:4:\"self\";s:32:\"0000000000000c640000000000000000\";}\";s:4:\"hash\";s:44:\"m6IfhAfl1K33FWSfimf2K04KeKvlzRbmjUpUOa0y01U=\";}}}}', NULL, 1788766028, 1788766030);

-- --------------------------------------------------------

--
-- Table structure for table `kegiatan_edukasi`
--

CREATE TABLE `kegiatan_edukasi` (
  `id` bigint UNSIGNED NOT NULL,
  `tanggal` date NOT NULL,
  `waktu` time DEFAULT NULL,
  `alamat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tempat` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_tempat` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tema` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hasil_kegiatan` text COLLATE utf8mb4_unicode_ci,
  `kapasitas` int UNSIGNED NOT NULL DEFAULT '0',
  `pos_id` bigint UNSIGNED DEFAULT NULL,
  `status` enum('terjadwal','berlangsung','selesai','dibatalkan') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'terjadwal',
  `dibuat_pada` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kegiatan_edukasi_foto`
--

CREATE TABLE `kegiatan_edukasi_foto` (
  `id` bigint UNSIGNED NOT NULL,
  `kegiatan_id` bigint UNSIGNED NOT NULL,
  `url_foto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kegiatan_edukasi_personil`
--

CREATE TABLE `kegiatan_edukasi_personil` (
  `id` bigint UNSIGNED NOT NULL,
  `kegiatan_id` bigint UNSIGNED NOT NULL,
  `personil_id` bigint UNSIGNED NOT NULL,
  `peran` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'instruktur'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kejadian`
--

CREATE TABLE `kejadian` (
  `id` bigint UNSIGNED NOT NULL,
  `laporan_warga_id` bigint UNSIGNED DEFAULT NULL,
  `jenis_kejadian` enum('kebakaran','evakuasi_penyelamatan') COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_kejadian` date NOT NULL,
  `waktu_kejadian` time DEFAULT NULL,
  `alamat_lokasi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `pelapor_asal` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_kontak_pelapor` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `waktu_laporan_diterima` datetime DEFAULT NULL,
  `waktu_tiba_lokasi` datetime DEFAULT NULL,
  `kronologi` text COLLATE utf8mb4_unicode_ci,
  `pemilik` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dampak_kerugian` text COLLATE utf8mb4_unicode_ci,
  `korban_luka` int UNSIGNED NOT NULL DEFAULT '0',
  `korban_meninggal` int UNSIGNED NOT NULL DEFAULT '0',
  `kendala_lapangan` text COLLATE utf8mb4_unicode_ci,
  `pos_id` bigint UNSIGNED DEFAULT NULL,
  `waktu_selesai` datetime DEFAULT NULL,
  `dibuat_pada` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kejadian_bantuan`
--

CREATE TABLE `kejadian_bantuan` (
  `id` bigint UNSIGNED NOT NULL,
  `kejadian_id` bigint UNSIGNED NOT NULL,
  `instansi_id` bigint UNSIGNED NOT NULL,
  `keterangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kejadian_foto`
--

CREATE TABLE `kejadian_foto` (
  `id` bigint UNSIGNED NOT NULL,
  `kejadian_id` bigint UNSIGNED NOT NULL,
  `url_foto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diunggah_pada` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kejadian_kendaraan`
--

CREATE TABLE `kejadian_kendaraan` (
  `id` bigint UNSIGNED NOT NULL,
  `kejadian_id` bigint UNSIGNED NOT NULL,
  `kendaraan_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kejadian_regu`
--

CREATE TABLE `kejadian_regu` (
  `id` bigint UNSIGNED NOT NULL,
  `kejadian_id` bigint UNSIGNED NOT NULL,
  `personil_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kendaraan`
--

CREATE TABLE `kendaraan` (
  `id` bigint UNSIGNED NOT NULL,
  `no_lambung` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plat_nomor` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('siap','perbaikan','rusak') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'siap',
  `pos_id` bigint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `laporan_warga`
--

CREATE TABLE `laporan_warga` (
  `id` bigint UNSIGNED NOT NULL,
  `nama_pelapor` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_kontak_pelapor` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat_lokasi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `jenis_laporan` enum('kebakaran','evakuasi_penyelamatan') COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi_singkat` text COLLATE utf8mb4_unicode_ci,
  `foto_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `waktu_lapor` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('baru','diverifikasi','ditindaklanjuti','ditolak') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'baru'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_08_20_030753_create_pos_damkar_table', 1),
(5, '2026_08_20_031110_create_personil_table', 2),
(6, '2026_08_20_031212_create_kendaraan_table', 3),
(7, '2026_08_20_031257_create_instansi_bantuan_table', 4),
(8, '2026_08_20_031446_create_laporan_warga_table', 5),
(9, '2026_08_20_031447_create_kejadian_table', 5),
(10, '2026_08_20_031448_create_detail_kebakaran_table', 5),
(11, '2026_08_20_031449_create_detail_evakuasi_table', 5),
(12, '2026_08_20_031450_create_kejadian_regu_table', 5),
(13, '2026_08_20_031451_create_kejadian_kendaraan_table', 5),
(14, '2026_08_20_031452_create_kejadian_bantuan_table', 5),
(15, '2026_08_20_031453_create_kejadian_foto_table', 5),
(16, '2026_08_20_031827_create_kegiatan_edukasi_table', 6),
(17, '2026_08_20_031828_create_kegiatan_edukasi_personil_table', 6),
(18, '2026_08_20_031829_create_kegiatan_edukasi_foto_table', 6),
(19, '2026_08_20_031830_create_pendaftaran_edukasi_table', 6),
(21, '2026_08_20_031831_create_hotspots_table', 7),
(22, '2026_08_20_073500_add_source_to_hotspots_table', 8),
(23, '2026_08_20_075944_add_region_to_hotspots_table', 9),
(24, '2026_09_07_070443_create_imports_table', 10),
(25, '2026_09_07_070444_create_exports_table', 10),
(26, '2026_09_07_070445_create_failed_import_rows_table', 10);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pendaftaran_edukasi`
--

CREATE TABLE `pendaftaran_edukasi` (
  `id` bigint UNSIGNED NOT NULL,
  `kegiatan_id` bigint UNSIGNED NOT NULL,
  `nama_pendaftar` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_hp` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instansi_asal` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jumlah_peserta` int UNSIGNED NOT NULL DEFAULT '1',
  `catatan` text COLLATE utf8mb4_unicode_ci,
  `status` enum('menunggu','terkonfirmasi','hadir','dibatalkan') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'menunggu',
  `tanggal_daftar` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personil`
--

CREATE TABLE `personil` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `nama` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nrp` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jabatan` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_hp` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pos_id` bigint UNSIGNED DEFAULT NULL,
  `status` enum('aktif','nonaktif') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'aktif',
  `dibuat_pada` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pos_damkar`
--

CREATE TABLE `pos_damkar` (
  `id` bigint UNSIGNED NOT NULL,
  `nama_pos` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_telepon` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `dibuat_pada` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('D4mjD54EqxukkVlfJIenJ4DgkfhiIPSrMabXtcu5', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJ0b1FDQ25oWUp6ZE93dXV0dG1FUzNnTnVVdVdwMmVzS0c2Vk9RY1RxIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwXC9naXNcL2hvdHNwb3RzIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX0sImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjoxLCJwYXNzd29yZF9oYXNoX3dlYiI6IjZlY2EwYmIxMTRmOTg2MmY1ODk0ODgyOWMwZDgyOTc2MjE4ZDIyMzMwOTQ4ZDBjOTVhYjk4YzViMzI2ZGJjYjkiLCJ0YWJsZXMiOnsiZTg4ZThkMzc3ZDA5YzUzZDM0MWU0ZTExY2JkMDk5NmVfY29sdW1ucyI6W3sidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJsYXRpdHVkZSIsImxhYmVsIjoiTGF0aXR1ZGUiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoibG9uZ2l0dWRlIiwibGFiZWwiOiJMb25naXR1ZGUiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoic291cmNlIiwibGFiZWwiOiJTb3VyY2UiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoicmVnaW9uIiwibGFiZWwiOiJSZWdpb24iLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoiYnJpZ2h0X3RpNCIsImxhYmVsIjoiQnJpZ2h0IHRpNCIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJzY2FuIiwibGFiZWwiOiJTY2FuIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InRyYWNrIiwibGFiZWwiOiJUcmFjayIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJhY3FfZGF0ZSIsImxhYmVsIjoiQWNxIGRhdGUiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoiYWNxX3RpbWUiLCJsYWJlbCI6IkFjcSB0aW1lIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InNhdGVsbGl0ZSIsImxhYmVsIjoiU2F0ZWxsaXRlIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6Imluc3RydW1lbnQiLCJsYWJlbCI6Ikluc3RydW1lbnQiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoiY29uZmlkZW5jZSIsImxhYmVsIjoiQ29uZmlkZW5jZSIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJ2ZXJzaW9uIiwibGFiZWwiOiJWZXJzaW9uIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImJyaWdodF90aTUiLCJsYWJlbCI6IkJyaWdodCB0aTUiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoiZnJwIiwibGFiZWwiOiJGcnAiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoiZGF5bmlnaHQiLCJsYWJlbCI6IkRheW5pZ2h0IiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImNyZWF0ZWRfYXQiLCJsYWJlbCI6IkNyZWF0ZWQgYXQiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6ZmFsc2UsImlzVG9nZ2xlYWJsZSI6dHJ1ZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0Ijp0cnVlfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoidXBkYXRlZF9hdCIsImxhYmVsIjoiVXBkYXRlZCBhdCIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjpmYWxzZSwiaXNUb2dnbGVhYmxlIjp0cnVlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOnRydWV9XX19', 1788838136),
('NmD1jvwTfp6Qj0RTj4hTsO4srv60r3YgUk8IIlu5', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiI3ODRqeGpGSnhKdTRPRXFIYmJqa3JzNkJBcUZNZ2tSaUlNNTJBRFFwIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwXC9naXNcL2hvdHNwb3RzIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX0sImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjoxLCJwYXNzd29yZF9oYXNoX3dlYiI6IjZlY2EwYmIxMTRmOTg2MmY1ODk0ODgyOWMwZDgyOTc2MjE4ZDIyMzMwOTQ4ZDBjOTVhYjk4YzViMzI2ZGJjYjkifQ==', 1788929503),
('RI5lVMhrhtOdoQ0kDsrTdyY4w4A5NPeNoyP4Qe7L', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiI5dmtBN0E0WXlyMmZCYXR4SVdpRHZ0UmM2Z1JUUDUwVnNQSFY0UUEzIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwXC9naXNcL2hvdHNwb3RzIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1788937710);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'mrizkinew65@gmail.com', NULL, '$2y$12$0j/WdR2bERC8g1J58twjaeVbGFK4u2RQkSim/7w.e.irKdCpR8gBm', 'InsPhhLpy608Z174XloCHOjXR00J8W6fewjqWSKNGAFtnUOYDEAp0XIEVM0n', '2026-08-19 20:42:36', '2026-08-19 20:42:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `detail_evakuasi`
--
ALTER TABLE `detail_evakuasi`
  ADD PRIMARY KEY (`kejadian_id`);

--
-- Indexes for table `detail_kebakaran`
--
ALTER TABLE `detail_kebakaran`
  ADD PRIMARY KEY (`kejadian_id`);

--
-- Indexes for table `exports`
--
ALTER TABLE `exports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exports_user_id_foreign` (`user_id`);

--
-- Indexes for table `failed_import_rows`
--
ALTER TABLE `failed_import_rows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `failed_import_rows_import_id_foreign` (`import_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  ADD KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`);

--
-- Indexes for table `hotspots`
--
ALTER TABLE `hotspots`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `hotspots_unique_detection` (`latitude`,`longitude`,`acq_date`,`acq_time`,`source`),
  ADD KEY `hotspots_latitude_longitude_index` (`latitude`,`longitude`),
  ADD KEY `hotspots_acq_date_index` (`acq_date`),
  ADD KEY `hotspots_source_index` (`source`),
  ADD KEY `hotspots_region_index` (`region`);

--
-- Indexes for table `imports`
--
ALTER TABLE `imports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `imports_user_id_foreign` (`user_id`);

--
-- Indexes for table `instansi_bantuan`
--
ALTER TABLE `instansi_bantuan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kegiatan_edukasi`
--
ALTER TABLE `kegiatan_edukasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kegiatan_edukasi_pos_id_foreign` (`pos_id`);

--
-- Indexes for table `kegiatan_edukasi_foto`
--
ALTER TABLE `kegiatan_edukasi_foto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kegiatan_edukasi_foto_kegiatan_id_foreign` (`kegiatan_id`);

--
-- Indexes for table `kegiatan_edukasi_personil`
--
ALTER TABLE `kegiatan_edukasi_personil`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_kegiatan_personil` (`kegiatan_id`,`personil_id`),
  ADD KEY `kegiatan_edukasi_personil_personil_id_foreign` (`personil_id`);

--
-- Indexes for table `kejadian`
--
ALTER TABLE `kejadian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kejadian_laporan_warga_id_foreign` (`laporan_warga_id`),
  ADD KEY `kejadian_pos_id_foreign` (`pos_id`);

--
-- Indexes for table `kejadian_bantuan`
--
ALTER TABLE `kejadian_bantuan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kejadian_bantuan_kejadian_id_foreign` (`kejadian_id`),
  ADD KEY `kejadian_bantuan_instansi_id_foreign` (`instansi_id`);

--
-- Indexes for table `kejadian_foto`
--
ALTER TABLE `kejadian_foto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kejadian_foto_kejadian_id_foreign` (`kejadian_id`);

--
-- Indexes for table `kejadian_kendaraan`
--
ALTER TABLE `kejadian_kendaraan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_kejadian_kendaraan` (`kejadian_id`,`kendaraan_id`),
  ADD KEY `kejadian_kendaraan_kendaraan_id_foreign` (`kendaraan_id`);

--
-- Indexes for table `kejadian_regu`
--
ALTER TABLE `kejadian_regu`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_kejadian_personil` (`kejadian_id`,`personil_id`),
  ADD KEY `kejadian_regu_personil_id_foreign` (`personil_id`);

--
-- Indexes for table `kendaraan`
--
ALTER TABLE `kendaraan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kendaraan_pos_id_foreign` (`pos_id`);

--
-- Indexes for table `laporan_warga`
--
ALTER TABLE `laporan_warga`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pendaftaran_edukasi`
--
ALTER TABLE `pendaftaran_edukasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pendaftaran_edukasi_kegiatan_id_foreign` (`kegiatan_id`);

--
-- Indexes for table `personil`
--
ALTER TABLE `personil`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personil_user_id_unique` (`user_id`),
  ADD UNIQUE KEY `personil_nrp_unique` (`nrp`),
  ADD KEY `personil_pos_id_foreign` (`pos_id`);

--
-- Indexes for table `pos_damkar`
--
ALTER TABLE `pos_damkar`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `exports`
--
ALTER TABLE `exports`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_import_rows`
--
ALTER TABLE `failed_import_rows`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=433;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `hotspots`
--
ALTER TABLE `hotspots`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=371;

--
-- AUTO_INCREMENT for table `imports`
--
ALTER TABLE `imports`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `instansi_bantuan`
--
ALTER TABLE `instansi_bantuan`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `kegiatan_edukasi`
--
ALTER TABLE `kegiatan_edukasi`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kegiatan_edukasi_foto`
--
ALTER TABLE `kegiatan_edukasi_foto`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kegiatan_edukasi_personil`
--
ALTER TABLE `kegiatan_edukasi_personil`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kejadian`
--
ALTER TABLE `kejadian`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kejadian_bantuan`
--
ALTER TABLE `kejadian_bantuan`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kejadian_foto`
--
ALTER TABLE `kejadian_foto`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kejadian_kendaraan`
--
ALTER TABLE `kejadian_kendaraan`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kejadian_regu`
--
ALTER TABLE `kejadian_regu`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kendaraan`
--
ALTER TABLE `kendaraan`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `laporan_warga`
--
ALTER TABLE `laporan_warga`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `pendaftaran_edukasi`
--
ALTER TABLE `pendaftaran_edukasi`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personil`
--
ALTER TABLE `personil`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pos_damkar`
--
ALTER TABLE `pos_damkar`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_evakuasi`
--
ALTER TABLE `detail_evakuasi`
  ADD CONSTRAINT `detail_evakuasi_kejadian_id_foreign` FOREIGN KEY (`kejadian_id`) REFERENCES `kejadian` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `detail_kebakaran`
--
ALTER TABLE `detail_kebakaran`
  ADD CONSTRAINT `detail_kebakaran_kejadian_id_foreign` FOREIGN KEY (`kejadian_id`) REFERENCES `kejadian` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `exports`
--
ALTER TABLE `exports`
  ADD CONSTRAINT `exports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `failed_import_rows`
--
ALTER TABLE `failed_import_rows`
  ADD CONSTRAINT `failed_import_rows_import_id_foreign` FOREIGN KEY (`import_id`) REFERENCES `imports` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `imports`
--
ALTER TABLE `imports`
  ADD CONSTRAINT `imports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `kegiatan_edukasi`
--
ALTER TABLE `kegiatan_edukasi`
  ADD CONSTRAINT `kegiatan_edukasi_pos_id_foreign` FOREIGN KEY (`pos_id`) REFERENCES `pos_damkar` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `kegiatan_edukasi_foto`
--
ALTER TABLE `kegiatan_edukasi_foto`
  ADD CONSTRAINT `kegiatan_edukasi_foto_kegiatan_id_foreign` FOREIGN KEY (`kegiatan_id`) REFERENCES `kegiatan_edukasi` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `kegiatan_edukasi_personil`
--
ALTER TABLE `kegiatan_edukasi_personil`
  ADD CONSTRAINT `kegiatan_edukasi_personil_kegiatan_id_foreign` FOREIGN KEY (`kegiatan_id`) REFERENCES `kegiatan_edukasi` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `kegiatan_edukasi_personil_personil_id_foreign` FOREIGN KEY (`personil_id`) REFERENCES `personil` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `kejadian`
--
ALTER TABLE `kejadian`
  ADD CONSTRAINT `kejadian_laporan_warga_id_foreign` FOREIGN KEY (`laporan_warga_id`) REFERENCES `laporan_warga` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `kejadian_pos_id_foreign` FOREIGN KEY (`pos_id`) REFERENCES `pos_damkar` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `kejadian_bantuan`
--
ALTER TABLE `kejadian_bantuan`
  ADD CONSTRAINT `kejadian_bantuan_instansi_id_foreign` FOREIGN KEY (`instansi_id`) REFERENCES `instansi_bantuan` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `kejadian_bantuan_kejadian_id_foreign` FOREIGN KEY (`kejadian_id`) REFERENCES `kejadian` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `kejadian_foto`
--
ALTER TABLE `kejadian_foto`
  ADD CONSTRAINT `kejadian_foto_kejadian_id_foreign` FOREIGN KEY (`kejadian_id`) REFERENCES `kejadian` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `kejadian_kendaraan`
--
ALTER TABLE `kejadian_kendaraan`
  ADD CONSTRAINT `kejadian_kendaraan_kejadian_id_foreign` FOREIGN KEY (`kejadian_id`) REFERENCES `kejadian` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `kejadian_kendaraan_kendaraan_id_foreign` FOREIGN KEY (`kendaraan_id`) REFERENCES `kendaraan` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `kejadian_regu`
--
ALTER TABLE `kejadian_regu`
  ADD CONSTRAINT `kejadian_regu_kejadian_id_foreign` FOREIGN KEY (`kejadian_id`) REFERENCES `kejadian` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `kejadian_regu_personil_id_foreign` FOREIGN KEY (`personil_id`) REFERENCES `personil` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `kendaraan`
--
ALTER TABLE `kendaraan`
  ADD CONSTRAINT `kendaraan_pos_id_foreign` FOREIGN KEY (`pos_id`) REFERENCES `pos_damkar` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `pendaftaran_edukasi`
--
ALTER TABLE `pendaftaran_edukasi`
  ADD CONSTRAINT `pendaftaran_edukasi_kegiatan_id_foreign` FOREIGN KEY (`kegiatan_id`) REFERENCES `kegiatan_edukasi` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `personil`
--
ALTER TABLE `personil`
  ADD CONSTRAINT `personil_pos_id_foreign` FOREIGN KEY (`pos_id`) REFERENCES `pos_damkar` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `personil_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
