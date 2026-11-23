-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 12, 2026 at 12:23 PM
-- Server version: 10.11.16-MariaDB
-- PHP Version: 8.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bolsas_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `bolsas`
--

CREATE TABLE `bolsas` (
  `id` int(11) NOT NULL,
  `designacao` varchar(150) NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `area_estudo` varchar(100) NOT NULL,
  `montante` decimal(10,2) NOT NULL,
  `requisitos` text NOT NULL,
  `prazo` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bolsas`
--

INSERT INTO `bolsas` (`id`, `designacao`, `tipo`, `area_estudo`, `montante`, `requisitos`, `prazo`, `created_at`) VALUES
(1, 'Bolsa de Mérito Universitário', 'Mérito', 'Informática e Tecnologias', 2500.00, 'Média superior a 16 valores e aproveitamento pleno no ano anterior.', '2027-01-05', '2026-11-06 17:38:01'),
(2, 'Apoio Social de Emergência', 'Apoio Social', 'Geral', 1200.00, 'Rendimento do agregado familiar per capita inferior ao salário mínimo.', '2026-12-06', '2026-11-06 17:38:01'),
(3, 'Bolsa de Apoio à Insularidade', 'Deslocação', 'Todas as áreas', 1800.00, 'Estudantes deslocados de outras ilhas do arquipélago.', '2026-12-21', '2026-11-06 17:38:01'),
(4, 'Bolsa Expirada de Teste', 'Geral', 'Letras', 800.00, 'Bolsa com prazo já encerrado para teste de validação.', '2026-11-01', '2026-11-06 17:38:01');

-- --------------------------------------------------------

--
-- Table structure for table `candidaturas`
--

CREATE TABLE `candidaturas` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `bolsa_id` int(11) NOT NULL,
  `tecnico_id` int(11) DEFAULT NULL,
  `instituicao` varchar(150) NOT NULL,
  `curso` varchar(150) NOT NULL,
  `rendimento` decimal(10,2) NOT NULL,
  `iban` varchar(34) NOT NULL,
  `estado` enum('submetida','em analise','aprovada','rejeitada','aguardar documentacao') DEFAULT 'submetida',
  `observacoes_internas` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `candidaturas`
--

INSERT INTO `candidaturas` (`id`, `user_id`, `bolsa_id`, `tecnico_id`, `instituicao`, `curso`, `rendimento`, `iban`, `estado`, `observacoes_internas`, `created_at`, `updated_at`) VALUES
(1, 4, 2, 1, 'uac', 'daw', 1000000.00, '653467875675634524276', 'submetida', NULL, '2026-11-06 17:59:10', '2026-11-06 17:59:10'),
(2, 5, 2, 1, 'uac', 'daw', 120000.00, 'PT5099999999999', 'submetida', NULL, '2026-11-12 11:03:01', '2026-11-12 11:03:59');

-- --------------------------------------------------------

--
-- Table structure for table `documentos`
--

CREATE TABLE `documentos` (
  `id` int(11) NOT NULL,
  `candidatura_id` int(11) NOT NULL,
  `tipo_documento` varchar(100) NOT NULL,
  `nome_ficheiro` varchar(255) NOT NULL,
  `nome_original` varchar(255) NOT NULL,
  `data_upload` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `documentos`
--

INSERT INTO `documentos` (`id`, `candidatura_id`, `tipo_documento`, `nome_ficheiro`, `nome_original`, `data_upload`) VALUES
(1, 1, 'Comprovativo Inicial', 'a8329d47d43742da729459b7ae61a16b.pdf', 'Peddy-Paper-na-Lagoa-do-Fogo.pdf', '2026-11-06 17:59:10'),
(2, 2, 'Comprovativo Inicial', '8cfb7e0247b3bc2f4b227ab054a549ed.pdf', 'Projeto Segurança Web 2026_2027.pdf', '2026-11-12 11:03:01');

-- --------------------------------------------------------

--
-- Table structure for table `esclarecimentos`
--

CREATE TABLE `esclarecimentos` (
  `id` int(11) NOT NULL,
  `candidatura_id` int(11) NOT NULL,
  `remetente_id` int(11) NOT NULL,
  `mensagem` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `historico_estados`
--

CREATE TABLE `historico_estados` (
  `id` int(11) NOT NULL,
  `candidatura_id` int(11) NOT NULL,
  `tecnico_id` int(11) NOT NULL,
  `estado_anterior` varchar(50) NOT NULL,
  `estado_novo` varchar(50) NOT NULL,
  `data_alteracao` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('candidato','tecnico') NOT NULL DEFAULT 'candidato',
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nif` varchar(9) DEFAULT NULL,
  `morada` varchar(255) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password_hash`, `role`, `nome`, `email`, `nif`, `morada`, `telefone`, `created_at`) VALUES
(1, 'tecnico1', '$2y$10$e0MYzXy3tZt5M3k0lYxHmeR7I75q1tJ5yG8d1wA8s7tQy1tA0B2C.', 'tecnico', 'Dra. Maria Técnico', 'maria.tecnico@acores.pt', '123456789', 'Ponta Delgada', '912345678', '2026-11-06 17:38:01'),
(2, 'aluno1', '$2y$10$e0MYzXy3tZt5M3k0lYxHmeR7I75q1tJ5yG8d1wA8s7tQy1tA0B2C.', 'candidato', 'Carlos Estudante', 'carlos.aluno@uac.pt', '234567890', 'Rua da Universidade, 12', '961234567', '2026-11-06 17:38:01'),
(3, '5353454', '$2y$12$SlOlBiDcWP9VeJtHlZMU2.hLLgqSNNoPK6jqR6gDASS4DJcMaGguO', 'candidato', '<script>alert(\'XSS_Vulneravel\')</script>', 'garcilio123@gmail.com', '545455432', 'R. Manuel da Ponte', '296123456', '2026-11-06 17:53:46'),
(4, '543543', '$2y$12$rTnXyc0tulGvKswOlRWidurWXe5jF6VUAUGD4dWEWIkGhvKvDmRry', 'candidato', '<script>alert(\'XSS_Vulneravel\')</script>', 'joao@gmail.com', '543543543', 'R. Manuel da Ponte', '296123456', '2026-11-06 17:55:13'),
(5, 'leandro', '$2y$12$37doonpFiBEsUi7/mIJmIeNt3I/debgPXKl9mnuIsgIqE.I96mXme', 'candidato', 'Leandro Ramos', 'leandro@gmail.com', '122222222', 'Rua de Lá, 11', '222222222', '2026-11-12 10:50:07'),
(8, 'tecnico2', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tecnico', 'Ana Técnica', 'ana.tecnica@uac.pt', NULL, NULL, NULL, '2026-11-12 11:05:37'),
(9, 'tecnico3', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tecnico', 'Carlos Técnico', 'carlos.tecnico@uac.pt', NULL, NULL, NULL, '2026-11-12 11:05:37');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bolsas`
--
ALTER TABLE `bolsas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `candidaturas`
--
ALTER TABLE `candidaturas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_candidato_bolsa` (`user_id`,`bolsa_id`),
  ADD KEY `bolsa_id` (`bolsa_id`),
  ADD KEY `tecnico_id` (`tecnico_id`);

--
-- Indexes for table `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `candidatura_id` (`candidatura_id`);

--
-- Indexes for table `esclarecimentos`
--
ALTER TABLE `esclarecimentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `candidatura_id` (`candidatura_id`),
  ADD KEY `remetente_id` (`remetente_id`);

--
-- Indexes for table `historico_estados`
--
ALTER TABLE `historico_estados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `candidatura_id` (`candidatura_id`),
  ADD KEY `tecnico_id` (`tecnico_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bolsas`
--
ALTER TABLE `bolsas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `candidaturas`
--
ALTER TABLE `candidaturas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `esclarecimentos`
--
ALTER TABLE `esclarecimentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `historico_estados`
--
ALTER TABLE `historico_estados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `candidaturas`
--
ALTER TABLE `candidaturas`
  ADD CONSTRAINT `candidaturas_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `candidaturas_ibfk_2` FOREIGN KEY (`bolsa_id`) REFERENCES `bolsas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `candidaturas_ibfk_3` FOREIGN KEY (`tecnico_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `documentos`
--
ALTER TABLE `documentos`
  ADD CONSTRAINT `documentos_ibfk_1` FOREIGN KEY (`candidatura_id`) REFERENCES `candidaturas` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `esclarecimentos`
--
ALTER TABLE `esclarecimentos`
  ADD CONSTRAINT `esclarecimentos_ibfk_1` FOREIGN KEY (`candidatura_id`) REFERENCES `candidaturas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `esclarecimentos_ibfk_2` FOREIGN KEY (`remetente_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `historico_estados`
--
ALTER TABLE `historico_estados`
  ADD CONSTRAINT `historico_estados_ibfk_1` FOREIGN KEY (`candidatura_id`) REFERENCES `candidaturas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historico_estados_ibfk_2` FOREIGN KEY (`tecnico_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
