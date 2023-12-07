-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 07, 2023 at 05:35 PM
-- Server version: 8.0.27
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `accredian`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(155) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `email` varchar(155) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `password` varchar(155) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`,`email`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(1, 'Gbcderr1411', 'gaurang@growmeorganic.com', '$2b$10$eWVx7zxFVAZ5X/SBMZVMWelJIC419CQWBZiAG21hKzFO7c2T3GEDS'),
(2, 'test124', 'test@gmail.com', '$2b$10$o7dYltR0ElGcj4iNyAbuLOvc7.H2oCL9qP81MQQcuh.BYzOYxklWe'),
(3, 'test@123', 'gaurang@gmail.com', '$2b$10$A4.wU9cz17cwP2Z.bcBsM.2GmvnK/g1FvUzoeW0g/tkfKHqI4J4iG'),
(4, 'test@1234', 'gaurang12@gmail.com', '$2b$10$3W1ICbiGUvmyAiTxKD1IPu6L4dMZt1U0ewslno1ut/Cd01ruhMZMe'),
(5, '8445285720', 'gaurangbhutani14@gmail.com', '$2b$10$.cX69vRfcknnUL9hvriYZuQfZ.WRxoUY1FYbPkWNT.1PY1UCu9CRu'),
(6, '9012231052', 'test2@gmail.com', '$2b$10$td7sE0d1PFE3nJYQmO8psezyiEaLveeSewTtNsjdTkJSCSVPCyq8q'),
(7, 'wetwkrjwk', 'test21@gmail.com', '$2b$10$b6GQ8uG8CdnO6lzxpWJ2De3/PgzqcUP26Va9TVttCs19gfgag6MDe'),
(8, 'test@12342983928', 'gaurangbhutani1145@gmail.com', '$2b$10$nEic83EIkR.dU4ohGTEGW.EKwQnxOTqWYMqkr7AX5YIDV3Y3L6FjS'),
(9, 'test@1231212121', 'abcdefg@gmail.com', '$2b$10$D1is/SMyZmhRU6t5ThFgGOrSfCHpTwYFbacYuDc8GDkxzPGb4fjNe');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
