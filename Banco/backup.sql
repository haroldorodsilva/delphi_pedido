-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.18-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Copiando estrutura para tabela pedidovendas.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `cli_id` int(11) NOT NULL AUTO_INCREMENT,
  `cli_nome` varchar(100) NOT NULL,
  `cli_cidade` varchar(50) NOT NULL,
  `cli_uf` char(2) NOT NULL,
  PRIMARY KEY (`cli_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela pedidovendas.cliente: ~30 rows (aproximadamente)
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` (`cli_id`, `cli_nome`, `cli_cidade`, `cli_uf`) VALUES
	(1, 'CLIENTE 1', 'PONTAL DO ARAGUAIA', 'MT'),
	(2, 'CLIENTE 2', 'BARRA DO GARCAS', 'MT'),
	(3, 'CLIENTE 3', 'ARAGUAIANA', 'MT'),
	(4, 'CLIENTE 4', 'BARRA DO GARCAS', 'MT'),
	(5, 'CLIENTE 5', 'BARRA DO GARCAS', 'MT'),
	(6, 'CLIENTE 6', 'BARRA DO GARCAS', 'MT'),
	(7, 'CLIENTE 7', 'NOVA XAVANTINA', 'MT'),
	(8, 'CLIENTE 8', 'BARRA DO GARCAS', 'MT'),
	(9, 'CLIENTE 9', 'PONTAL DO ARAGUAIA', 'MT'),
	(10, 'CLIENTE 10', 'BARRA DO GARCAS', 'MT'),
	(11, 'CLIENTE 11', 'BARRA DO GARCAS', 'MT'),
	(12, 'CLIENTE 12', 'AGUA BOA', 'MT'),
	(13, 'CLIENTE 13', 'BARRA DO GARCAS', 'MT'),
	(14, 'CLIENTE 14', 'ARAGUAIANA', 'MT'),
	(15, 'CLIENTE 15', 'ARAGUAIANA', 'MT'),
	(16, 'CLIENTE 16', 'ARAGUAIANA', 'MT'),
	(17, 'CLIENTE 17', 'CANA BRAVA DO NORTE', 'MT'),
	(18, 'CLIENTE 18', 'BARRA DO GARCAS', 'MT'),
	(19, 'CLIENTE 19', 'PONTAL DO ARAGUAIA', 'MT'),
	(20, 'CLIENTE 20', 'AGUA BOA', 'MT'),
	(21, 'CLIENTE 21', 'PONTAL DO ARAGUAIA', 'MT'),
	(22, 'CLIENTE 22', 'BARRA DO GARCAS', 'MT'),
	(23, 'CLIENTE 23', 'BARRA DO GARCAS', 'MT'),
	(24, 'CLIENTE 24', 'TORIXOREU', 'MT'),
	(25, 'CLIENTE 25', 'ARAGUAIANA', 'MT'),
	(26, 'CLIENTE 26', 'BOM JARDIM DE GOIAS', 'GO'),
	(27, 'CLIENTE 27', 'BARRA DO GARCAS', 'MT'),
	(28, 'CLIENTE 28', 'BARRA DO GARCAS', 'MT'),
	(29, 'CLIENTE 29', 'ARUANA', 'GO'),
	(30, 'CLIENTE 30', 'BARRA DO GARCAS', 'MT');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;

-- Copiando estrutura para tabela pedidovendas.pedido_itens
CREATE TABLE IF NOT EXISTS `pedido_itens` (
  `pit_id` int(11) NOT NULL AUTO_INCREMENT,
  `pit_quantidade` decimal(18,2) NOT NULL,
  `pit_valorunitario` decimal(18,2) NOT NULL,
  `pit_valortotal` decimal(18,2) NOT NULL,
  `pit_prod_id` int(11) NOT NULL,
  `pit_pve_numero` int(11) NOT NULL,
  PRIMARY KEY (`pit_id`),
  KEY `FK_prod_id` (`pit_prod_id`),
  KEY `FK_pedido` (`pit_pve_numero`),
  CONSTRAINT `FK_pedido` FOREIGN KEY (`pit_pve_numero`) REFERENCES `pedido_venda` (`pve_numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_prod_id` FOREIGN KEY (`pit_prod_id`) REFERENCES `produtos` (`prod_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela pedidovendas.pedido_itens: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `pedido_itens` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido_itens` ENABLE KEYS */;

-- Copiando estrutura para tabela pedidovendas.pedido_venda
CREATE TABLE IF NOT EXISTS `pedido_venda` (
  `pve_numero` int(11) NOT NULL AUTO_INCREMENT,
  `pve_dataemissao` datetime NOT NULL,
  `pve_valortotal` decimal(18,2) NOT NULL,
  `pve_cli_id` int(11) NOT NULL,
  PRIMARY KEY (`pve_numero`),
  KEY `FK1_cli_id` (`pve_cli_id`),
  CONSTRAINT `FK1_cli_id` FOREIGN KEY (`pve_cli_id`) REFERENCES `cliente` (`cli_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela pedidovendas.pedido_venda: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `pedido_venda` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido_venda` ENABLE KEYS */;

-- Copiando estrutura para tabela pedidovendas.produtos
CREATE TABLE IF NOT EXISTS `produtos` (
  `prod_id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_descricao` varchar(100) NOT NULL,
  `prod_preco` decimal(18,2) NOT NULL,
  PRIMARY KEY (`prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela pedidovendas.produtos: ~50 rows (aproximadamente)
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` (`prod_id`, `prod_descricao`, `prod_preco`) VALUES
	(1, 'PARAFUSO FRANCES', 1.85),
	(2, 'VIGOTA 5X11 DE 3,00MTS PEROBA', 33.00),
	(3, 'VIGOTA 5X15 DE 1,00MTS PEROBA', 15.00),
	(4, 'CAIBRO 5X5 DE 1,00MTS PEROBA', 5.50),
	(5, 'CAIBRO 5X7 DE 1,00MTS PERO', 6.12),
	(6, 'PORTEIRA 1.25X2.50MTS 4 TABUAS', 270.00),
	(7, 'PORTEIRA 1.75X2.00MTS 5 TABUAS', 276.90),
	(8, 'PORTEIRA 1.25X2.00MTS 4 TABUAS', 220.00),
	(9, 'PORTEIRA 1.25X3.00MTS 4 TABUAS', 295.00),
	(10, 'PORTEIRA 1.25X3.50MTS 4 TABUAS', 381.00),
	(11, 'PORTEIRA 1.25X4.00MTS 4 TABUAS', 411.00),
	(12, 'COCHO COB.ALUMINIO C/3TAMBORES', 1650.00),
	(13, 'TELA PINTEIRO 1,00X50 N24 AGRO', 1150.00),
	(14, 'COCHO COBERTO 2,00 MTS ITAUBA', 1250.00),
	(15, 'COCHO COBERTO 1,50 MTS ITAUBA', 1000.00),
	(16, 'COCHO COBERTO 1,00 MTS ITAUBA', 855.00),
	(17, 'PORTAL DE JATOBA 80X19', 130.00),
	(18, 'PORTAL DE ANGELIM 0,60X13.5', 95.00),
	(19, 'ARCO DE SERRA 10 REGUL.WESTERN', 20.71),
	(20, 'ARAME LISO GALVANIZADO', 16.20),
	(21, 'PARAFUSO FRANCES', 0.55),
	(22, 'ARAME RECOZIDO', 9.65),
	(23, 'GRAMPO CERCA POLIDO', 7.55),
	(24, 'ARRUELA LISA POLIDA', 0.20),
	(25, 'ARRUELA LISA POLIDA', 0.18),
	(26, 'ARRUELA LISA POLIDA', 0.67),
	(27, 'ARRUELA LISA POLIDA', 0.34),
	(28, 'ARRUELA LISA POLIDA', 0.28),
	(29, 'BARRA ROSCADA', 3.50),
	(30, 'BARRA ROSCADA', 19.75),
	(31, 'BARRA ROSCADA', 12.00),
	(32, 'BARRA ROSCADA UNC', 6.25),
	(33, 'BARRA ROSCADA', 4.70),
	(34, 'BARRA ROSCADA', 29.90),
	(35, 'BARRA ROSCADA', 38.90),
	(36, 'ARRUELA APV PT.P/PREGO', 0.05),
	(37, 'MEIA LUA 1.1/2X3/16X40CM', 22.60),
	(38, 'PORCA SEXTAVADA RG', 0.15),
	(39, 'PORCA SEXTAVADA 5/16 RG', 0.08),
	(40, 'ARAME LISO GALVANIZADO 1 KG', 12.00),
	(41, 'ENXO  ARTESANAL C/CABO JB#####', 41.05),
	(42, 'PORCA SEXTAVADA RG', 1.32),
	(43, 'PORCA SEXTAVADA 1/2 RG 13 FIO', 0.26),
	(44, 'FIO CABO NAMBEI PARAL.2X1,5MM', 1.65),
	(45, 'PORCA SEXTAVADA 1/4 RG', 0.06),
	(46, 'PORCA SEXTAVADA 5/8 RG #######', 0.50),
	(47, 'PORCA SEXTAVADA 3/4 RG', 0.99),
	(48, 'PARAF.R.SOB.SEXT.ZINC', 0.65),
	(49, 'PARAF.R.SOB.SEXT.ZINC', 1.35),
	(50, 'PUXADOR P/PORTEIRA GAL.GRANDE', 10.05);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
