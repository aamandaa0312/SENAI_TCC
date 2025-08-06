-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.32-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para tcc
DROP DATABASE IF EXISTS `tcc`;
CREATE DATABASE IF NOT EXISTS `tcc` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `tcc`;

-- Copiando estrutura para tabela tcc.cursos
DROP TABLE IF EXISTS `cursos`;
CREATE TABLE IF NOT EXISTS `cursos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curso` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`curso`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela tcc.cursos: ~6 rows (aproximadamente)
INSERT INTO `cursos` (`id`, `curso`) VALUES
	(5, 'Desenvolvimento de Sistemas'),
	(6, 'Eletrotécnica'),
	(8, 'Logística'),
	(7, 'Mecatrônica'),
	(10, 'adm'),
	(9, 'adriana');

-- Copiando estrutura para tabela tcc.tccs
DROP TABLE IF EXISTS `tccs`;
CREATE TABLE IF NOT EXISTS `tccs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `ano` int(11) NOT NULL,
  `autor` varchar(255) NOT NULL,
  `curso_id` int(11) NOT NULL,
  `arquivo` varchar(50) NOT NULL,
  `status` enum('pendente','aprovado','rejeitado') NOT NULL DEFAULT 'pendente',
  `comentario` text NOT NULL,
  `avaliado_em` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `curso_id` (`curso_id`),
  CONSTRAINT `tccs_ibfk_1` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela tcc.tccs: ~6 rows (aproximadamente)
INSERT INTO `tccs` (`id`, `titulo`, `ano`, `autor`, `curso_id`, `arquivo`, `status`, `comentario`, `avaliado_em`) VALUES
	(8, 'adri', 1222, 'sf', 6, '1747846963759.pdf', 'aprovado', '', NULL),
	(9, 'aaa', 2012, 'adr', 7, '', 'aprovado', '', NULL),
	(11, 'jo', 2025, 'joao', 5, '1749649554084.pdf', 'aprovado', '', '2025-06-25 16:43:56'),
	(12, 'rd', 6666, 'rr', 8, '1749658209572.pdf', 'rejeitado', '', '2025-06-25 13:57:51'),
	(14, 'dd', 1234, 'aa', 5, '1749662460687.pdf', 'aprovado', '', '2025-06-25 13:56:56'),
	(15, 'ww', 1234, 'ww', 5, '1749662478222.pdf', 'aprovado', '', '2025-06-25 13:24:36');

-- Copiando estrutura para tabela tcc.tcc_historico
DROP TABLE IF EXISTS `tcc_historico`;
CREATE TABLE IF NOT EXISTS `tcc_historico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tcc_id` int(11) NOT NULL,
  `acao` enum('criacao','atualizacao','aprovacao','rejeicao') NOT NULL,
  `detalhes` text DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `data_alteracao` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `tcc_id` (`tcc_id`),
  CONSTRAINT `tcc_historico_ibfk_1` FOREIGN KEY (`tcc_id`) REFERENCES `tccs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela tcc.tcc_historico: ~5 rows (aproximadamente)
INSERT INTO `tcc_historico` (`id`, `tcc_id`, `acao`, `detalhes`, `usuario_id`, `data_alteracao`) VALUES
	(1, 8, 'aprovacao', 'Status alterado de "pendente" para "aprovado"', NULL, '2025-06-11 13:06:36'),
	(2, 12, 'aprovacao', 'Status alterado de "pendente" para "aprovado"', NULL, '2025-06-11 13:29:25'),
	(3, 11, 'rejeicao', 'Status alterado de "pendente" para "rejeitado"', NULL, '2025-06-11 13:29:31'),
	(4, 9, 'aprovacao', 'Status alterado de "pendente" para "aprovado"', NULL, '2025-06-11 13:29:36'),
	(5, 15, 'aprovacao', 'Status alterado de "pendente" para "aprovado"', NULL, '2025-06-25 13:24:36'),
	(6, 14, 'aprovacao', 'Status alterado de "pendente" para "aprovado"', NULL, '2025-06-25 13:56:56'),
	(7, 12, 'rejeicao', 'Status alterado de "aprovado" para "rejeitado"', NULL, '2025-06-25 13:57:51'),
	(8, 11, 'aprovacao', 'Status alterado de "rejeitado" para "aprovado"', NULL, '2025-06-25 16:43:56');

-- Copiando estrutura para tabela tcc.usuarios
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `tipo` enum('aluno','administrador') NOT NULL DEFAULT 'aluno',
  `curso_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_usuarios_curso` (`curso_id`),
  CONSTRAINT `fk_usuarios_curso` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela tcc.usuarios: ~5 rows (aproximadamente)
INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `tipo`, `curso_id`) VALUES
	(1, 'de', 'adr@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', 8),
	(4, 'ddi', 'aa', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'aluno', 5),
	(5, 'sii', 'adri@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'administrador', 5),
	(6, 'dric', 'ad@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'administrador', 8),
	(7, 'gg', 'a@gmail', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'administrador', NULL);

-- Copiando estrutura para trigger tcc.after_tcc_update
DROP TRIGGER IF EXISTS `after_tcc_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER after_tcc_update
AFTER UPDATE ON tccs
FOR EACH ROW
BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO tcc_historico (tcc_id, acao, detalhes)
        VALUES (
            NEW.id, 
            CASE 
                WHEN NEW.status = 'aprovado' THEN 'aprovacao'
                WHEN NEW.status = 'rejeitado' THEN 'rejeicao'
                ELSE 'atualizacao'
            END,
            CONCAT('Status alterado de "', OLD.status, '" para "', NEW.status, '"')
        );
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
