-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-07-2017 a las 13:16:26
-- Versión del servidor: 10.1.13-MariaDB
-- Versión de PHP: 5.6.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `assisto_app`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `cod_category` int(11) NOT NULL,
  `name_category` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `excercises`
--

CREATE TABLE `excercises` (
  `cod_excercise` int(11) NOT NULL,
  `name_category` int(11) DEFAULT NULL,
  `name_excercise` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plans`
--

CREATE TABLE `plans` (
  `cod_plan` int(11) NOT NULL,
  `cod_routine` int(11) DEFAULT NULL,
  `cod_user` int(11) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profiles`
--

CREATE TABLE `profiles` (
  `cod_profile` int(11) NOT NULL,
  `type_profile` varchar(50) DEFAULT NULL,
  `cod_user` int(11) DEFAULT NULL,
  `meta_key` varchar(50) DEFAULT NULL,
  `meta_value` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `cod_profile` int(11) NOT NULL,
  `state` tinyint(1) DEFAULT NULL,
  `desc` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `routines`
--

CREATE TABLE `routines` (
  `cod_routine` int(11) NOT NULL,
  `cod_excercise` int(11) DEFAULT NULL,
  `cod_user` int(11) DEFAULT NULL,
  `type_routine` int(11) DEFAULT NULL,
  `rep_routine` int(11) DEFAULT NULL,
  `serie_routine` int(11) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `cod_user` int(11) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `token` varchar(100) DEFAULT NULL,
  `abstract` varchar(300) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`cod_user`, `firstname`, `lastname`, `email`, `username`, `password`, `token`, `abstract`, `created_at`) VALUES
(1, 'david', 'de la cruz', 'david@assistoapp.com', 'daviddlc', '123456', NULL, NULL, '2017-07-14 08:14:16'),
(2, 'testing', 'pruebaaa', 'test@assistoapp.com', 'testing', '741852', NULL, NULL, '2017-07-13 00:00:00'),
(4, 'testing001', 'pruebaaa', 'tes007@001.com', 'lasttestt', '$2y$10$AESoF8XvBI.6Nom/FdMR4eolNvCTFNh8Z.ES//lyOaJ4ZFSe0JCmK', NULL, NULL, '2017-07-15 11:52:47');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`cod_category`);

--
-- Indices de la tabla `excercises`
--
ALTER TABLE `excercises`
  ADD PRIMARY KEY (`cod_excercise`);

--
-- Indices de la tabla `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`cod_plan`),
  ADD KEY `FK` (`cod_routine`,`cod_user`);

--
-- Indices de la tabla `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`cod_profile`),
  ADD KEY `FK` (`cod_user`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`cod_profile`);

--
-- Indices de la tabla `routines`
--
ALTER TABLE `routines`
  ADD PRIMARY KEY (`cod_routine`),
  ADD KEY `FK` (`cod_excercise`,`cod_user`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`cod_user`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `cod_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
