-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 07, 2025 at 05:42 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gym_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('SuperAdmin','Manager') DEFAULT 'Manager',
  `last_login` timestamp NOT NULL DEFAULT current_timestamp(),
  `profile_picture` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `email`, `password`, `role`, `last_login`, `profile_picture`, `full_name`, `username`, `title`) VALUES
(1, 'admin@example.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'Manager', '2025-04-02 02:44:53', NULL, NULL, NULL, NULL),
(2, 'admin@gmail.com', '$2y$10$4f5re9KduPv/QvfpAY4t5e2J9dqmICKAO8x1DDmSDq0YeaDn5kCVy', '', '2025-05-06 11:45:43', 'admin_68562a198e2223.82900778.jpg', 'Sharies Esoto', 'sha', 'ADMIN');

-- --------------------------------------------------------

--
-- Table structure for table `alerts_log`
--

CREATE TABLE `alerts_log` (
  `id` int(11) NOT NULL,
  `user_membership_id` int(11) NOT NULL,
  `alert_sent_at` datetime DEFAULT current_timestamp(),
  `message` text DEFAULT NULL,
  `via` enum('Email','SMS','Both') DEFAULT 'Email'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`id`, `title`, `message`, `created_at`) VALUES
(1, 'Gym Closure Notice', 'We would like to inform all members that the gym will be closed tomorrow. Please plan your workouts accordingly. Regular operations will resume the following day. Thank you for your understanding and cooperation.', '2025-05-17 16:03:01');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` enum('Login','Logout') NOT NULL,
  `login_time` datetime DEFAULT NULL,
  `logout_time` datetime DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `user_id`, `status`, `login_time`, `logout_time`, `timestamp`) VALUES
(1, 2, 'Logout', '2025-05-14 11:49:11', '2025-05-14 11:49:27', '2025-05-14 03:49:11'),
(6, 1, 'Login', '2025-05-14 12:48:18', NULL, '2025-05-14 04:48:18'),
(7, 2, 'Logout', '2025-05-14 13:13:35', '2025-05-14 15:01:28', '2025-05-14 05:13:35'),
(8, 1, 'Logout', '2025-05-14 15:24:58', '2025-05-14 15:25:04', '2025-05-14 07:24:58'),
(9, 2, 'Login', '2025-05-17 10:55:38', NULL, '2025-05-17 02:55:38'),
(11, 5, 'Logout', '2025-05-17 16:25:50', '2025-05-17 16:33:28', '2025-05-17 08:25:50'),
(13, 2, 'Login', '2025-05-17 16:34:25', NULL, '2025-05-17 08:34:25'),
(15, 2, 'Logout', '2025-05-17 16:35:53', '2025-05-17 16:35:59', '2025-05-17 08:35:53'),
(16, 2, 'Logout', '2025-05-17 16:37:06', '2025-05-17 21:45:48', '2025-05-17 08:37:06'),
(18, 2, 'Logout', '2025-05-17 17:00:13', '2025-05-17 21:45:40', '2025-05-17 09:00:13'),
(20, 2, 'Logout', '2025-05-17 21:18:28', '2025-05-17 21:45:33', '2025-05-17 13:18:28'),
(22, 2, 'Logout', '2025-05-17 21:19:18', '2025-05-17 21:20:03', '2025-05-17 13:19:18'),
(23, 2, 'Logout', '2025-05-17 21:28:11', '2025-05-17 21:28:36', '2025-05-17 13:28:11'),
(24, 2, 'Logout', '2025-05-17 21:35:35', '2025-05-17 21:35:48', '2025-05-17 13:35:35'),
(25, 2, 'Logout', '2025-05-17 21:37:23', '2025-05-17 21:37:37', '2025-05-17 13:37:23'),
(26, 2, 'Logout', '2025-05-17 21:38:00', '2025-05-17 21:38:05', '2025-05-17 13:38:00'),
(27, 2, 'Logout', '2025-05-17 21:44:10', '2025-05-17 21:44:38', '2025-05-17 13:44:10'),
(30, 2, 'Logout', '2025-05-17 21:46:20', '2025-05-17 21:46:24', '2025-05-17 13:46:20'),
(32, 2, 'Logout', '2025-05-17 21:47:27', '2025-05-17 21:48:02', '2025-05-17 13:47:27'),
(34, 2, 'Login', '2025-05-17 21:54:23', NULL, '2025-05-17 13:54:23'),
(36, 2, 'Login', '2025-05-17 21:54:57', NULL, '2025-05-17 13:54:57'),
(38, 2, 'Logout', '2025-05-17 21:55:07', '2025-05-17 21:55:35', '2025-05-17 13:55:07'),
(39, 2, 'Login', '2025-05-17 21:59:01', NULL, '2025-05-17 13:59:01'),
(41, 2, 'Logout', '2025-05-17 22:03:10', '2025-05-17 22:03:35', '2025-05-17 14:03:10'),
(43, 2, 'Logout', '2025-05-17 22:08:44', '2025-05-17 22:09:00', '2025-05-17 14:08:44'),
(46, 2, 'Login', '2025-05-17 22:10:53', NULL, '2025-05-17 14:10:53'),
(48, 2, 'Login', '2025-05-17 22:11:08', NULL, '2025-05-17 14:11:08'),
(50, 2, 'Login', '2025-05-17 22:13:56', NULL, '2025-05-17 14:13:56'),
(52, 2, 'Logout', '2025-05-17 22:14:15', '2025-05-17 22:14:28', '2025-05-17 14:14:15'),
(54, 2, 'Login', '2025-05-17 22:15:22', NULL, '2025-05-17 14:15:22'),
(56, 2, 'Login', '2025-05-17 22:15:32', NULL, '2025-05-17 14:15:32'),
(58, 2, 'Logout', '2025-05-18 17:11:54', '2025-05-20 15:01:36', '2025-05-18 09:11:54'),
(60, 2, 'Logout', '2025-05-20 14:40:03', '2025-05-20 14:59:47', '2025-05-20 06:40:03'),
(62, 2, 'Logout', '2025-05-20 14:43:13', '2025-05-20 14:43:39', '2025-05-20 06:43:13'),
(63, 2, 'Logout', '2025-05-20 14:59:16', '2025-05-20 14:59:42', '2025-05-20 06:59:16'),
(66, 2, 'Logout', '2025-05-20 15:03:37', '2025-05-20 15:07:38', '2025-05-20 07:03:37'),
(67, 2, 'Login', '2025-05-20 15:07:48', NULL, '2025-05-20 07:07:48'),
(69, 2, 'Login', '2025-05-20 15:08:06', NULL, '2025-05-20 07:08:06'),
(70, 2, 'Logout', '2025-05-20 15:09:23', '2025-05-20 15:09:28', '2025-05-20 07:09:23'),
(71, 2, 'Logout', '2025-05-20 15:10:23', '2025-05-20 15:15:31', '2025-05-20 07:10:23'),
(72, 2, 'Logout', '2025-05-20 15:16:04', '2025-05-20 15:16:11', '2025-05-20 07:16:04'),
(73, 2, 'Logout', '2025-05-20 15:27:51', '2025-05-20 15:27:57', '2025-05-20 07:27:51'),
(75, 2, 'Login', '2025-05-20 15:28:20', NULL, '2025-05-20 07:28:20'),
(76, 2, 'Logout', '2025-05-20 15:34:38', '2025-05-20 15:35:00', '2025-05-20 07:34:38'),
(78, 2, 'Logout', '2025-05-20 15:39:41', '2025-05-20 15:39:50', '2025-05-20 07:39:41'),
(79, 2, 'Logout', '2025-05-20 15:40:02', '2025-05-20 15:41:01', '2025-05-20 07:40:02'),
(80, 2, 'Logout', '2025-05-20 15:42:30', '2025-05-20 15:42:36', '2025-05-20 07:42:30'),
(81, 2, 'Logout', '2025-05-20 15:46:34', '2025-05-20 15:46:42', '2025-05-20 07:46:34'),
(82, 2, 'Logout', '2025-05-20 15:46:59', '2025-05-20 15:47:07', '2025-05-20 07:46:59'),
(84, 2, 'Logout', '2025-05-20 15:47:24', '2025-05-20 15:48:59', '2025-05-20 07:47:24'),
(85, 2, 'Logout', '2025-05-20 15:49:11', '2025-05-20 15:50:04', '2025-05-20 07:49:11'),
(87, 2, 'Logout', '2025-05-20 15:50:29', '2025-05-20 15:51:22', '2025-05-20 07:50:29'),
(89, 2, 'Logout', '2025-05-20 15:51:58', '2025-05-20 15:52:03', '2025-05-20 07:51:58'),
(90, 2, 'Login', '2025-05-20 15:52:10', NULL, '2025-05-20 07:52:10'),
(92, 2, 'Login', '2025-05-20 15:52:17', NULL, '2025-05-20 07:52:17'),
(94, 2, 'Logout', '2025-05-20 15:54:17', '2025-05-20 15:56:09', '2025-05-20 07:54:17'),
(96, 2, 'Logout', '2025-05-20 15:56:39', '2025-05-20 15:56:43', '2025-05-20 07:56:39'),
(98, 2, 'Logout', '2025-05-20 15:59:37', '2025-05-20 16:00:39', '2025-05-20 07:59:37'),
(102, 2, 'Login', '2025-05-20 16:06:22', NULL, '2025-05-20 08:06:22'),
(103, 2, 'Login', '2025-05-20 23:17:22', NULL, '2025-05-20 15:17:22'),
(106, 2, 'Logout', '2025-05-20 23:19:00', '2025-05-20 23:19:34', '2025-05-20 15:19:00'),
(107, 2, 'Logout', '2025-05-20 23:19:43', '2025-05-20 23:20:46', '2025-05-20 15:19:43'),
(112, 2, 'Logout', '2025-05-20 23:21:31', '2025-05-20 23:21:42', '2025-05-20 15:21:31'),
(114, 2, 'Login', '2025-05-20 23:23:44', NULL, '2025-05-20 15:23:44'),
(116, 2, 'Logout', '2025-05-20 23:25:51', '2025-05-20 23:33:42', '2025-05-20 15:25:51'),
(118, 2, 'Logout', '2025-05-20 23:44:16', '2025-05-20 23:49:39', '2025-05-20 15:44:16'),
(119, 2, 'Logout', '2025-05-20 23:49:55', '2025-05-20 23:50:03', '2025-05-20 15:49:55'),
(120, 2, 'Logout', '2025-05-20 23:50:18', '2025-05-20 23:50:24', '2025-05-20 15:50:18'),
(122, 2, 'Logout', '2025-05-20 23:51:10', '2025-05-20 23:54:52', '2025-05-20 15:51:10'),
(124, 2, 'Logout', '2025-05-20 23:55:22', '2025-05-20 23:59:27', '2025-05-20 15:55:22'),
(126, 2, 'Logout', '2025-05-20 23:59:41', '2025-05-21 10:13:15', '2025-05-20 15:59:41'),
(127, 2, 'Logout', '2025-05-21 10:13:21', '2025-05-21 10:20:32', '2025-05-21 02:13:21'),
(132, 1, 'Login', '2025-05-21 10:21:06', NULL, '2025-05-21 02:21:06'),
(134, 2, 'Login', '2025-05-21 10:24:01', NULL, '2025-05-21 02:24:01'),
(136, 1, 'Login', '2025-05-21 10:28:33', NULL, '2025-05-21 02:28:33'),
(137, 1, 'Logout', '2025-05-21 10:30:30', '2025-05-21 10:33:15', '2025-05-21 02:30:30'),
(138, 2, 'Logout', '2025-05-21 10:30:36', '2025-05-21 10:54:47', '2025-05-21 02:30:36'),
(139, 2, 'Logout', '2025-05-21 10:33:32', '2025-05-21 10:35:03', '2025-05-21 02:33:32'),
(140, 2, 'Logout', '2025-05-21 10:35:19', '2025-05-21 10:37:21', '2025-05-21 02:35:19'),
(141, 2, 'Logout', '2025-05-21 10:38:29', '2025-05-21 10:38:43', '2025-05-21 02:38:29'),
(142, 2, 'Logout', '2025-05-21 10:42:19', '2025-05-21 10:42:27', '2025-05-21 02:42:19'),
(143, 2, 'Logout', '2025-05-21 10:46:17', '2025-05-21 10:46:23', '2025-05-21 02:46:17'),
(144, 1, 'Login', '2025-05-21 10:50:42', NULL, '2025-05-21 02:50:42'),
(147, 1, 'Login', '2025-05-21 10:55:38', NULL, '2025-05-21 02:55:38'),
(149, 2, 'Login', '2025-05-21 10:56:38', NULL, '2025-05-21 02:56:38'),
(150, 2, 'Logout', '2025-05-21 10:56:58', '2025-05-21 10:57:48', '2025-05-21 02:56:58'),
(152, 2, 'Logout', '2025-05-21 11:01:29', '2025-05-21 11:10:41', '2025-05-21 03:01:29'),
(153, 1, 'Logout', '2025-05-21 11:06:04', '2025-05-21 11:06:14', '2025-05-21 03:06:04'),
(154, 1, 'Logout', '2025-05-21 11:06:22', '2025-05-21 11:11:06', '2025-05-21 03:06:22'),
(156, 1, 'Logout', '2025-05-21 11:11:36', '2025-05-21 11:13:18', '2025-05-21 03:11:36'),
(157, 1, 'Logout', '2025-05-21 11:13:43', '2025-05-21 11:13:57', '2025-05-21 03:13:43'),
(158, 2, 'Logout', '2025-05-21 11:13:53', '2025-05-21 11:18:26', '2025-05-21 03:13:53'),
(159, 1, 'Logout', '2025-05-21 11:18:06', '2025-05-21 11:25:21', '2025-05-21 03:18:06'),
(163, 2, 'Logout', '2025-05-21 11:23:32', '2025-05-21 11:24:16', '2025-05-21 03:23:32'),
(164, 2, 'Logout', '2025-05-21 11:25:26', '2025-05-21 11:28:54', '2025-05-21 03:25:26'),
(165, 1, 'Login', '2025-05-21 11:29:08', NULL, '2025-05-21 03:29:08'),
(167, 2, 'Logout', '2025-05-21 11:36:17', '2025-05-21 11:37:23', '2025-05-21 03:36:17'),
(168, 1, 'Login', '2025-05-21 11:37:39', NULL, '2025-05-21 03:37:39'),
(170, 1, 'Login', '2025-05-21 11:41:09', NULL, '2025-05-21 03:41:09'),
(171, 2, 'Logout', '2025-05-21 11:42:03', '2025-05-21 11:53:28', '2025-05-21 03:42:03'),
(172, 1, 'Logout', '2025-05-21 11:53:49', '2025-05-21 12:04:02', '2025-05-21 03:53:49'),
(173, 2, 'Logout', '2025-05-21 11:56:15', '2025-05-21 12:00:12', '2025-05-21 03:56:15'),
(177, 2, 'Logout', '2025-05-21 12:03:39', '2025-05-21 12:05:06', '2025-05-21 04:03:39'),
(180, 1, 'Logout', '2025-05-21 12:09:51', '2025-05-21 12:13:38', '2025-05-21 04:09:51'),
(181, 2, 'Logout', '2025-05-21 12:10:01', '2025-05-21 12:11:41', '2025-05-21 04:10:01'),
(182, 5, 'Logout', '2025-05-21 12:10:34', '2025-05-21 12:13:16', '2025-05-21 04:10:34'),
(184, 2, 'Logout', '2025-05-21 12:29:19', '2025-05-21 12:30:22', '2025-05-21 04:29:19'),
(185, 1, 'Login', '2025-05-21 12:29:32', NULL, '2025-05-21 04:29:32'),
(187, 2, 'Login', '2025-05-21 12:31:08', NULL, '2025-05-21 04:31:08'),
(188, 2, 'Logout', '2025-05-22 10:48:47', '2025-05-22 10:52:12', '2025-05-22 02:48:47'),
(189, 1, 'Login', '2025-05-22 10:49:38', NULL, '2025-05-22 02:49:38'),
(192, 2, 'Login', '2025-05-25 10:15:50', NULL, '2025-05-25 02:15:50'),
(193, 2, 'Logout', '2025-05-26 22:20:59', '2025-05-26 22:29:51', '2025-05-26 14:20:59'),
(195, 2, 'Login', '2025-05-26 22:42:46', NULL, '2025-05-26 14:42:46'),
(196, 2, 'Login', '2025-05-27 11:12:43', NULL, '2025-05-27 03:12:43'),
(198, 2, 'Login', '2025-06-17 13:39:29', NULL, '2025-06-17 05:39:29'),
(199, 2, 'Login', '2025-06-17 14:39:20', NULL, '2025-06-17 06:39:20'),
(200, 2, 'Logout', '2025-06-18 13:05:12', '2025-06-18 13:47:00', '2025-06-18 05:05:12'),
(201, 11, 'Login', '2025-06-19 15:53:04', NULL, '2025-06-19 07:53:04'),
(202, 2, 'Logout', '2025-06-20 13:54:54', '2025-06-20 15:04:01', '2025-06-20 05:54:54'),
(203, 11, 'Logout', '2025-06-20 22:10:26', '2025-06-20 22:10:54', '2025-06-20 14:10:26'),
(204, 5, 'Logout', '2025-06-20 22:10:41', '2025-06-20 22:12:12', '2025-06-20 14:10:41'),
(205, 1, 'Login', '2025-06-20 22:11:07', NULL, '2025-06-20 14:11:07'),
(206, 11, 'Login', '2025-06-20 22:31:49', NULL, '2025-06-20 14:31:49'),
(207, 2, 'Login', '2025-06-20 23:15:19', NULL, '2025-06-20 15:15:19'),
(208, 11, 'Logout', '2025-06-20 23:58:24', '2025-06-20 23:58:43', '2025-06-20 15:58:24'),
(209, 2, 'Logout', '2025-06-20 23:59:13', '2025-06-20 23:59:34', '2025-06-20 15:59:13'),
(210, 11, 'Login', '2025-06-20 23:59:24', NULL, '2025-06-20 15:59:24'),
(211, 2, 'Logout', '2025-06-21 00:03:26', '2025-06-21 11:27:05', '2025-06-20 16:03:26'),
(212, 2, 'Login', '2025-06-21 12:27:32', NULL, '2025-06-21 04:27:32'),
(213, 2, 'Login', '2025-07-02 09:16:02', NULL, '2025-07-02 01:16:02'),
(214, 12, 'Login', '2025-07-02 10:26:14', NULL, '2025-07-02 02:26:14'),
(215, 2, 'Login', '2025-07-02 14:36:12', NULL, '2025-07-02 06:36:12'),
(216, 22, 'Logout', '2025-08-07 11:38:57', '2025-08-07 11:39:10', '2025-08-07 03:38:57'),
(217, 22, 'Login', '2025-08-07 11:39:16', NULL, '2025-08-07 03:39:16'),
(218, 21, 'Login', '2025-08-07 11:39:30', NULL, '2025-08-07 03:39:30'),
(219, 19, 'Login', '2025-08-07 11:40:05', NULL, '2025-08-07 03:40:05');

-- --------------------------------------------------------

--
-- Table structure for table `attendance_folders`
--

CREATE TABLE `attendance_folders` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `month` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` varchar(10) NOT NULL,
  `login_time` datetime DEFAULT NULL,
  `logout_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `id` int(11) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `equipment_name` varchar(255) NOT NULL,
  `type` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `equipment`
--

INSERT INTO `equipment` (`id`, `photo`, `equipment_name`, `type`, `status`, `description`, `image_path`, `created_at`, `updated_at`) VALUES
(4, 'uploads/equip_68512083953819.05242117.jpg', 'Treadmill', 'aa', 'In Use', 'cutieeeee', NULL, '2025-06-17 08:00:03', '2025-06-17 08:07:46'),
(5, 'uploads/equip_6851249e499d79.70913114.jpg', 'Dumbbell', 'aa', 'Maintenance', 'gggggg', NULL, '2025-06-17 08:17:34', NULL),
(6, 'uploads/equip_68551fe2212509.44551219.webp', 'ithhitjgr', 'nrkhfrjfk', 'Maintenance', 'er3irj3w', NULL, '2025-06-20 08:46:26', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `memberships`
--

CREATE TABLE `memberships` (
  `id` int(11) NOT NULL,
  `plan_name` varchar(100) NOT NULL,
  `duration` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `user_id` int(11) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `memberships`
--

INSERT INTO `memberships` (`id`, `plan_name`, `duration`, `price`, `description`, `created_at`, `user_id`, `start_date`, `end_date`) VALUES
(5, 'Gym Access', '1 Day', 111.00, '', '2025-06-19 15:32:52', 2, '2025-06-21', '2025-06-22'),
(8, 'Gym Access', '1 Day', 111.00, '', '2025-06-19 15:51:19', 11, '2025-06-23', '2025-06-24');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `student_id` varchar(50) DEFAULT NULL,
  `course` varchar(50) DEFAULT NULL,
  `section` varchar(50) DEFAULT NULL,
  `customer_id` varchar(50) DEFAULT NULL,
  `payment_plan` varchar(50) DEFAULT NULL,
  `services` text DEFAULT NULL,
  `faculty_id` varchar(50) DEFAULT NULL,
  `faculty_dept` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `age`, `gender`, `email`, `phone`, `role`, `student_id`, `course`, `section`, `customer_id`, `payment_plan`, `services`, `faculty_id`, `faculty_dept`, `created_at`) VALUES
(1, 'Sharies', 'Esoto', 21, 'Female', 'shariesesoto@gmail.com', '09615273069', 'Faculty', NULL, NULL, NULL, NULL, '', '', '2212121', 'COT', '2025-05-07 04:52:31'),
(2, 'Yosef', 'Esoto', 5, 'Male', 'shariesesoto1@gmail.com', '09615273061', 'Student', '3221852', 'BSIT', '3B DAY', NULL, '', '', NULL, NULL, '2025-05-07 04:55:36'),
(4, 'Ethel', 'Esoto', 23, 'Female', 'shariesesotoaa@gmail.com', '09615273064', 'Faculty', NULL, NULL, NULL, NULL, '', '', '1111111', 'COE', '2025-05-07 05:04:46'),
(5, 'Sharies', 'sharies', 11, 'Male', 'shariesesoto111@gmail.com', '09615273111', 'Student', '3221811', 'BSIT', '3B DAY', NULL, '', '', NULL, NULL, '2025-05-07 05:15:04'),
(6, 'Sharies', 'sharies', 1111, 'Female', 'shariesesoto0@gmail.com', '09615273067', 'Faculty', NULL, NULL, NULL, NULL, '', '', '1111111', 'COT', '2025-05-07 05:16:22'),
(10, 'Selyn', 'Esoto', 30, 'Female', 'shariesesto@gmail.com', '0961527069', 'Customer', NULL, NULL, NULL, '7285640', '1 Week', 'Gym Access', NULL, NULL, '2025-05-26 14:38:34'),
(11, 'Drake', 'Ladeke', 21, 'Male', 'drake@gmail.com', '09615273000', 'Customer', NULL, NULL, NULL, '6784595', '1 Week', 'Gym Access', NULL, NULL, '2025-06-19 07:50:55'),
(12, 'chi', 'chang', 22, 'Male', 'ariesesoto@gmail.com', '09115273069', 'Customer', NULL, NULL, NULL, '5295400', '1 Week', 'Gym Access', NULL, NULL, '2025-07-02 02:25:25'),
(15, 'yvonne', 'batucan', 111, 'Female', 'shariese@gmail.com', '096152711169', 'Student', '23232323', 'BSIT', '3B DAY', NULL, '', '', NULL, NULL, '2025-07-02 06:19:20'),
(16, 'qqq', 'aaa', 111, 'Male', '1ariesesoto@gmail.com', '09625273069', 'Customer', NULL, NULL, NULL, '7255896', '30 Days', 'Gym Access', NULL, NULL, '2025-07-02 06:24:46'),
(17, 'aaaaaaaaaaaaa', 'aaaaaaaaaaa', 11, 'Female', 'sharieaasesoto@gmail.com', '096115273069', 'Customer', NULL, NULL, NULL, '0758696', '1 Week', 'Gym Access', NULL, NULL, '2025-07-02 06:33:17'),
(18, 'Shar', 'aaa', 21, 'Female', 'saariesesoto@gmail.com', '09615271069', 'Customer', NULL, NULL, NULL, '7616090', '1 Week', 'Gym Access', NULL, NULL, '2025-07-02 07:05:39'),
(19, 'heufga', 'asjagdj', 11, 'Male', 'shaqqriesesoto@gmail.com', '09615273009', 'Customer', NULL, NULL, NULL, '3687601', '30 Days', 'Gym Access', NULL, NULL, '2025-07-02 07:35:54'),
(20, 'mjay', 'pjilll', 22, 'Male', 'mjay@gmail.com', '09610273069', 'Customer', NULL, NULL, NULL, '7113378', '1 Week', 'Gym Access', NULL, NULL, '2025-08-07 03:17:05'),
(21, 'aaa', 'xxxx', 11, 'Male', 'qqqq1qqqq@gmail.com', '09015273069', 'Customer', NULL, NULL, NULL, '7042400', '30 Days', 'Gym Access', NULL, NULL, '2025-08-07 03:18:38'),
(22, 'kabang', 'aaa', 111, 'Male', 'bang@gmail.com', '09005273069', 'Customer', NULL, NULL, NULL, '1572517', '1 Week', 'Gym Access', NULL, NULL, '2025-08-07 03:38:31');

-- --------------------------------------------------------

--
-- Table structure for table `user_memberships`
--

CREATE TABLE `user_memberships` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `membership_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `expiry_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `alerts_log`
--
ALTER TABLE `alerts_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_membership_id` (`user_membership_id`);

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `attendance_folders`
--
ALTER TABLE `attendance_folders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `memberships`
--
ALTER TABLE `memberships`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_memberships`
--
ALTER TABLE `user_memberships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `membership_id` (`membership_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `alerts_log`
--
ALTER TABLE `alerts_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=220;

--
-- AUTO_INCREMENT for table `attendance_folders`
--
ALTER TABLE `attendance_folders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `memberships`
--
ALTER TABLE `memberships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `user_memberships`
--
ALTER TABLE `user_memberships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alerts_log`
--
ALTER TABLE `alerts_log`
  ADD CONSTRAINT `alerts_log_ibfk_1` FOREIGN KEY (`user_membership_id`) REFERENCES `user_memberships` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `attendance_folders`
--
ALTER TABLE `attendance_folders`
  ADD CONSTRAINT `attendance_folders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_memberships`
--
ALTER TABLE `user_memberships`
  ADD CONSTRAINT `user_memberships_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_memberships_ibfk_2` FOREIGN KEY (`membership_id`) REFERENCES `memberships` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
