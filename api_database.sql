-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 04-Out-2021 às 12:37
-- Versão do servidor: 10.4.18-MariaDB
-- versão do PHP: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `api_database`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `cost_centers`
--

CREATE TABLE `cost_centers` (
  `cost_center_id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `cost_centers`
--

INSERT INTO `cost_centers` (`cost_center_id`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Centro de custo 1', '2021-10-04 06:03:06', '2021-10-04 06:03:06'),
(2, 'Centro de custo 2', '2021-10-04 06:04:23', '2021-10-04 06:04:31'),
(3, 'Centro de custo 3', '2021-10-04 06:04:36', '2021-10-04 06:04:36'),
(4, 'Centro de Custo 4', '2021-10-04 06:04:41', '2021-10-04 06:04:41');

-- --------------------------------------------------------

--
-- Estrutura da tabela `departaments`
--

CREATE TABLE `departaments` (
  `departament_id` bigint(20) UNSIGNED NOT NULL,
  `cost_center_idfk` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `departaments`
--

INSERT INTO `departaments` (`departament_id`, `cost_center_idfk`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'Departamento 1', '2021-10-04 06:03:17', '2021-10-04 06:03:17'),
(2, 1, 'Departamento 2', '2021-10-04 06:03:58', '2021-10-04 06:03:58');

-- --------------------------------------------------------

--
-- Estrutura da tabela `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2013_09_26_204710_create_offices_table', 1),
(2, '2013_09_26_204738_create_cost_centers_table', 1),
(3, '2013_09_26_204739_create_departaments_table', 1),
(4, '2014_10_12_000000_create_users_table', 1),
(5, '2014_10_12_100000_create_password_resets_table', 1),
(6, '2019_08_19_000000_create_failed_jobs_table', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `offices`
--

CREATE TABLE `offices` (
  `office_id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `offices`
--

INSERT INTO `offices` (`office_id`, `description`, `created_at`, `updated_at`) VALUES
(1, 'cargo 1', '2021-10-04 06:03:24', '2021-10-04 06:03:24'),
(2, 'Cargo 2', '2021-10-04 06:04:09', '2021-10-04 06:04:09'),
(3, 'Cargo 3', '2021-10-04 06:04:12', '2021-10-04 06:04:12'),
(4, 'Cargo 4', '2021-10-04 06:04:16', '2021-10-04 06:04:16');

-- --------------------------------------------------------

--
-- Estrutura da tabela `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `office_idfk` bigint(20) UNSIGNED NOT NULL,
  `departament_idfk` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `office_idfk`, `departament_idfk`, `name`, `email`, `password`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'admin', 'admin@gmail.com', '$2y$10$Xl3hCE5ji//uYgsN3SBWC.yKyaOpHAs0pH2xsswDypV1sE.s3LkSS', '2021-10-04 06:03:36', '2021-10-04 06:03:36');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `cost_centers`
--
ALTER TABLE `cost_centers`
  ADD PRIMARY KEY (`cost_center_id`);

--
-- Índices para tabela `departaments`
--
ALTER TABLE `departaments`
  ADD PRIMARY KEY (`departament_id`),
  ADD KEY `departaments_cost_center_idfk_foreign` (`cost_center_idfk`);

--
-- Índices para tabela `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `offices`
--
ALTER TABLE `offices`
  ADD PRIMARY KEY (`office_id`);

--
-- Índices para tabela `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_departament_idfk_foreign` (`departament_idfk`),
  ADD KEY `users_office_idfk_foreign` (`office_idfk`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cost_centers`
--
ALTER TABLE `cost_centers`
  MODIFY `cost_center_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `departaments`
--
ALTER TABLE `departaments`
  MODIFY `departament_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `offices`
--
ALTER TABLE `offices`
  MODIFY `office_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `departaments`
--
ALTER TABLE `departaments`
  ADD CONSTRAINT `departaments_cost_center_idfk_foreign` FOREIGN KEY (`cost_center_idfk`) REFERENCES `cost_centers` (`cost_center_id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_departament_idfk_foreign` FOREIGN KEY (`departament_idfk`) REFERENCES `departaments` (`departament_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_office_idfk_foreign` FOREIGN KEY (`office_idfk`) REFERENCES `offices` (`office_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
