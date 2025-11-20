-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Čtv 20. lis 2025, 09:20
-- Verze serveru: 10.4.32-MariaDB
-- Verze PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `conastine_swim2`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `age_category`
--

CREATE TABLE `age_category` (
  `category_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `min_age` int(11) DEFAULT NULL,
  `max_age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `coach`
--

CREATE TABLE `coach` (
  `coach_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `birthdate` date NOT NULL,
  `telephone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `discipline`
--

CREATE TABLE `discipline` (
  `discipline_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'e.g. Freestyle, Butterfly...'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `race`
--

CREATE TABLE `race` (
  `race_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `race_start` datetime NOT NULL,
  `discipline_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `race_events`
--

CREATE TABLE `race_events` (
  `event_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `event_date` date NOT NULL,
  `start_time` time NOT NULL,
  `location` varchar(255) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `race_swimmer`
--

CREATE TABLE `race_swimmer` (
  `race_id` int(11) NOT NULL,
  `swimmer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `swimmer`
--

CREATE TABLE `swimmer` (
  `swimmer_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `birthdate` date NOT NULL,
  `height` int(11) NOT NULL,
  `weight` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `team`
--

CREATE TABLE `team` (
  `team_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `member_count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Indexy pro exportované tabulky
--

--
-- Indexy pro tabulku `age_category`
--
ALTER TABLE `age_category`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `name` (`name`);

--
-- Indexy pro tabulku `coach`
--
ALTER TABLE `coach`
  ADD PRIMARY KEY (`coach_id`),
  ADD UNIQUE KEY `telephone` (`telephone`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `team_id` (`team_id`),
  ADD KEY `name_index` (`first_name`,`surname`);

--
-- Indexy pro tabulku `discipline`
--
ALTER TABLE `discipline`
  ADD PRIMARY KEY (`discipline_id`),
  ADD KEY `name_index` (`name`);

--
-- Indexy pro tabulku `race`
--
ALTER TABLE `race`
  ADD PRIMARY KEY (`race_id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `discipline_id` (`discipline_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexy pro tabulku `race_events`
--
ALTER TABLE `race_events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `name_location` (`name`,`location`);

--
-- Indexy pro tabulku `race_swimmer`
--
ALTER TABLE `race_swimmer`
  ADD PRIMARY KEY (`race_id`,`swimmer_id`),
  ADD KEY `swimmer_id` (`swimmer_id`);

--
-- Indexy pro tabulku `swimmer`
--
ALTER TABLE `swimmer`
  ADD PRIMARY KEY (`swimmer_id`),
  ADD KEY `team_id` (`team_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `name_index` (`first_name`,`surname`);

--
-- Indexy pro tabulku `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`team_id`),
  ADD KEY `name_country` (`name`,`country`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `age_category`
--
ALTER TABLE `age_category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pro tabulku `coach`
--
ALTER TABLE `coach`
  MODIFY `coach_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pro tabulku `discipline`
--
ALTER TABLE `discipline`
  MODIFY `discipline_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pro tabulku `race`
--
ALTER TABLE `race`
  MODIFY `race_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pro tabulku `race_events`
--
ALTER TABLE `race_events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pro tabulku `swimmer`
--
ALTER TABLE `swimmer`
  MODIFY `swimmer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pro tabulku `team`
--
ALTER TABLE `team`
  MODIFY `team_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `coach`
--
ALTER TABLE `coach`
  ADD CONSTRAINT `coach_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE CASCADE;

--
-- Omezení pro tabulku `race`
--
ALTER TABLE `race`
  ADD CONSTRAINT `race_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `race_events` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `race_ibfk_2` FOREIGN KEY (`discipline_id`) REFERENCES `discipline` (`discipline_id`),
  ADD CONSTRAINT `race_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `age_category` (`category_id`);

--
-- Omezení pro tabulku `race_swimmer`
--
ALTER TABLE `race_swimmer`
  ADD CONSTRAINT `race_swimmer_ibfk_1` FOREIGN KEY (`swimmer_id`) REFERENCES `swimmer` (`swimmer_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `race_swimmer_ibfk_2` FOREIGN KEY (`race_id`) REFERENCES `race` (`race_id`) ON DELETE CASCADE;

--
-- Omezení pro tabulku `swimmer`
--
ALTER TABLE `swimmer`
  ADD CONSTRAINT `swimmer_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `swimmer_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `age_category` (`category_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
