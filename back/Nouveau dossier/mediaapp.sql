-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  ven. 21 déc. 2018 à 14:13
-- Version du serveur :  5.7.23
-- Version de PHP :  7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `mediaapp`
--

-- --------------------------------------------------------

--
-- Structure de la table `loaning`
--

DROP TABLE IF EXISTS `loaning`;
CREATE TABLE IF NOT EXISTS `loaning` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `media_id` int(11) DEFAULT NULL,
  `start` date NOT NULL,
  `end` date NOT NULL,
  `user` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_38DDD8D0EA9FDD75` (`media_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `loaning`
--

INSERT INTO `loaning` (`id`, `media_id`, `start`, `end`, `user`) VALUES
(1, 1, '2018-12-21', '2019-01-20', 'Aurélie'),
(2, 2, '2018-12-21', '2019-01-20', 'Aurélie'),
(3, 5, '2018-12-21', '2019-01-20', 'Aurélie'),
(4, 4, '2018-12-21', '2019-01-20', 'Aurélie');

-- --------------------------------------------------------

--
-- Structure de la table `media`
--

DROP TABLE IF EXISTS `media`;
CREATE TABLE IF NOT EXISTS `media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `media`
--

INSERT INTO `media` (`id`, `type`, `title`, `author`) VALUES
(1, 'Livre', 'Devenir', 'Michelle Obama'),
(2, 'Livre', 'L\'Arbre-Monde', 'Richard POWERS'),
(3, 'Livre', 'La Vraie Vie', 'Adeline Dieudonné'),
(4, 'Film', 'L\'Antidote', 'Vincent de Brus'),
(5, 'Film', 'À cause des filles…?', 'Pascal Thomas'),
(6, 'Film', 'Une Famille italienne', 'Gabriele Muccino'),
(7, 'Audio', 'Let The Music Play', 'Barry White'),
(8, 'Audio', 'You\'re The First, The Last, My Everything', 'Barry White'),
(9, 'Audio', 'You Give Me Something', 'Jamiroquai');

-- --------------------------------------------------------

--
-- Structure de la table `migration_versions`
--

DROP TABLE IF EXISTS `migration_versions`;
CREATE TABLE IF NOT EXISTS `migration_versions` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `migration_versions`
--

INSERT INTO `migration_versions` (`version`) VALUES
('20181217093421'),
('20181217094813'),
('20181220140903'),
('20181220141712');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pseudo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pwd` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `pseudo`, `pwd`, `token`) VALUES
(1, 'Aurélie', 'Nantes44', '2574'),
(2, 'Vicky', 'dd38c4ce6700ee7992d922b1bcbbbc19', NULL);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `loaning`
--
ALTER TABLE `loaning`
  ADD CONSTRAINT `FK_38DDD8D0EA9FDD75` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
