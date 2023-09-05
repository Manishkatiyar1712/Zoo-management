-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 05, 2023 at 01:51 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `zoomanagment`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `validate_email` (IN `email` VARCHAR(120))  DETERMINISTIC NO SQL BEGIN
	IF NOT (SELECT email REGEXP '^[a-zA-Z0-9][+a-zA-Z0-9._-]*@[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9]*\\.[a-zA-Z]{2,4}$') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Wrong email';
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validate_mob` (IN `mobilenumber` VARCHAR(10))   BEGIN
	IF NOT (SELECT mobilenumber REGEXP '^[0-9]{10}$') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Wrong number';
	END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbladmin`
--

CREATE TABLE `tbladmin` (
  `e_id` int(11) NOT NULL,
  `adminname` varchar(120) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `mobilenumber` varchar(10) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `designation` varchar(250) NOT NULL,
  `password` varchar(120) DEFAULT NULL,
  `adminregdate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbladmin`
--

INSERT INTO `tbladmin` (`e_id`, `adminname`, `username`, `mobilenumber`, `email`, `designation`, `password`, `adminregdate`) VALUES
(1, 'manish', 'dark', '9005046625', 'darkmatter423342@gmail.com', 'chief', 'manishk', '2016-12-17'),
(2, 'mudassir', 'muddu', '1111111111', 'muddubhai@mymail.com', 'receptionist', 'hehehe', '2018-01-02');

--
-- Triggers `tbladmin`
--
DELIMITER $$
CREATE TRIGGER `valid_date_insert` BEFORE INSERT ON `tbladmin` FOR EACH ROW BEGIN
	CALL validate_date(NEW.adminregdate);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `valid_date_update` BEFORE UPDATE ON `tbladmin` FOR EACH ROW BEGIN
	CALL validate_date(NEW.adminregdate);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validate_email_update` BEFORE UPDATE ON `tbladmin` FOR EACH ROW BEGIN
	CALL validate_email(NEW.email);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validate_mob_update` BEFORE UPDATE ON `tbladmin` FOR EACH ROW BEGIN
	CALL validate_mob(NEW.mobilenumber);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tblanimal`
--

CREATE TABLE `tblanimal` (
  `a_id` int(11) NOT NULL,
  `animalname` varchar(200) DEFAULT NULL,
  `cagenumber` int(11) DEFAULT NULL,
  `breed` varchar(200) DEFAULT NULL,
  `animalimage` varchar(200) DEFAULT NULL,
  `creationdate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblanimal`
--

INSERT INTO `tblanimal` (`a_id`, `animalname`, `cagenumber`, `breed`, `animalimage`, `creationdate`) VALUES
(10, 'nithin', 130, 'grizzly bear', '75ee4e9e8e16a08551ccf68951ca1e511673782422.jpg', '2023-01-15 19:42:41'),
(11, 'jatin', 110, 'Bikaneri camel', '36ed498765d047256a7bb03101ec6c651673802617jpeg', '2023-01-15 17:10:17'),
(12, 'muddu', 140, 'french alpine', '29cf73ec0da643d1a1fd8fbfdb2e664d1673861774jpeg', '2023-01-16 09:36:14'),
(13, 'goat', 1087, 'bear', 'd63af5756cb7c9cde9234479c2429de41673933366.jpg', '2023-01-17 05:29:26');

-- --------------------------------------------------------

--
-- Table structure for table `tblhealth`
--

CREATE TABLE `tblhealth` (
  `d_id` int(11) NOT NULL,
  `dname` varchar(200) DEFAULT NULL,
  `novisit` int(11) DEFAULT NULL,
  `a_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblhealth`
--

INSERT INTO `tblhealth` (`d_id`, `dname`, `novisit`, `a_id`) VALUES
(7, 'dr.shivendra', 3, 10),
(103, 'nurse azam', 1, 12);

-- --------------------------------------------------------

--
-- Table structure for table `tblticindian`
--

CREATE TABLE `tblticindian` (
  `t_id` int(11) NOT NULL,
  `visitorname` varchar(200) DEFAULT NULL,
  `noadult` int(11) DEFAULT NULL,
  `nochild` int(11) DEFAULT NULL,
  `adultprice` varchar(50) DEFAULT NULL,
  `childprice` varchar(50) DEFAULT NULL,
  `postingdate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `e_id` int(11) NOT NULL,
  `total` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblticindian`
--

INSERT INTO `tblticindian` (`t_id`, `visitorname`, `noadult`, `nochild`, `adultprice`, `childprice`, `postingdate`, `e_id`, `total`) VALUES
(109, 'riya', 2, 0, '200', '100', '2023-01-19 07:40:41', 1, 400),
(110, 'prateek', 2, 3, '200', '100', '2023-01-19 07:40:28', 1, 700),
(111, 'tanya', 2, 0, '200', '100', '2023-01-19 07:40:14', 2, 400),
(112, 'kuma', 2, 1, '200', '100', '2023-01-19 07:40:01', 1, 500),
(131, 'hehe', 2, 3, '200', '100', '2023-02-02 04:32:04', 2, 700);

--
-- Triggers `tblticindian`
--
DELIMITER $$
CREATE TRIGGER `insert_total` BEFORE INSERT ON `tblticindian` FOR EACH ROW BEGIN
   SET NEW.total = (200*NEW.noadult) + (100*NEW.nochild);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbltickettype`
--

CREATE TABLE `tbltickettype` (
  `id` int(11) NOT NULL,
  `tickettype` varchar(200) DEFAULT NULL,
  `price` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbltickettype`
--

INSERT INTO `tbltickettype` (`id`, `tickettype`, `price`) VALUES
(1, 'adult', '200'),
(2, 'child', '100');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbladmin`
--
ALTER TABLE `tbladmin`
  ADD PRIMARY KEY (`e_id`);

--
-- Indexes for table `tblanimal`
--
ALTER TABLE `tblanimal`
  ADD PRIMARY KEY (`a_id`);

--
-- Indexes for table `tblhealth`
--
ALTER TABLE `tblhealth`
  ADD PRIMARY KEY (`d_id`,`a_id`),
  ADD KEY `a_id` (`a_id`);

--
-- Indexes for table `tblticindian`
--
ALTER TABLE `tblticindian`
  ADD PRIMARY KEY (`t_id`),
  ADD KEY `e_id` (`e_id`);

--
-- Indexes for table `tbltickettype`
--
ALTER TABLE `tbltickettype`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbladmin`
--
ALTER TABLE `tbladmin`
  MODIFY `e_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tblhealth`
--
ALTER TABLE `tblhealth`
  MODIFY `d_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `tblticindian`
--
ALTER TABLE `tblticindian`
  MODIFY `t_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `tbltickettype`
--
ALTER TABLE `tbltickettype`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblhealth`
--
ALTER TABLE `tblhealth`
  ADD CONSTRAINT `tblhealth_ibfk_1` FOREIGN KEY (`a_id`) REFERENCES `tblanimal` (`a_id`);

--
-- Constraints for table `tblticindian`
--
ALTER TABLE `tblticindian`
  ADD CONSTRAINT `fd3` FOREIGN KEY (`e_id`) REFERENCES `tbladmin` (`e_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
