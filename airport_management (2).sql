-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 12, 2020 at 09:51 AM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `airport management`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `showaircraft` ()  SELECT * from aircraft$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `aircraft`
--

CREATE TABLE `aircraft` (
  `AIRCRAFTTYPE` char(3) NOT NULL,
  `NOSEATS` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `aircraft`
--

INSERT INTO `aircraft` (`AIRCRAFTTYPE`, `NOSEATS`) VALUES
('300', 45),
('301', 60),
('302', 80),
('360', 44),
('370', 44),
('400', 70);

-- --------------------------------------------------------

--
-- Table structure for table `airport`
--

CREATE TABLE `airport` (
  `AIRPORT` varchar(10) NOT NULL,
  `ANAME` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `airport`
--

INSERT INTO `airport` (`AIRPORT`, `ANAME`) VALUES
('BLR', 'KEMPEGOWDA AIRPORT'),
('BOM', 'CHATRAPATHI SHIVAJI'),
('DEL', 'INDIRA GANDHI'),
('IXE', 'MANGALURU AIRPORT '),
('KLR', 'COCHIN AIRPORT');

-- --------------------------------------------------------

--
-- Table structure for table `deleted_passengers`
--

CREATE TABLE `deleted_passengers` (
  `PID` int(11) NOT NULL,
  `NAME` varchar(40) NOT NULL,
  `ADDRESS` varchar(40) NOT NULL,
  `TELNO` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `deleted_passengers`
--

INSERT INTO `deleted_passengers` (`PID`, `NAME`, `ADDRESS`, `TELNO`) VALUES
(1, 'xyz', 'managlore', '9876544321'),
(500, 'SHAWN DSOUZA', 'DELHI', '7439384'),
(600, 'DYLANE', 'MUMBAI', '485439'),
(201, 'ELVEENA VAS ', 'MANGALORE', '3248783'),
(700, 'FATHIMA', 'DELHI', '5657654');

-- --------------------------------------------------------

--
-- Table structure for table `fares`
--

CREATE TABLE `fares` (
  `FARETYPE` char(3) NOT NULL,
  `FDESCRIPTION` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fares`
--

INSERT INTO `fares` (`FARETYPE`, `FDESCRIPTION`) VALUES
('BUR', 'BUSINESS'),
('ECO', 'ECONOMIC'),
('fir', 'first class'),
('sec', 'second'),
('tu', 'first');

-- --------------------------------------------------------

--
-- Table structure for table `flights`
--

CREATE TABLE `flights` (
  `FLIGHTNO` varchar(5) NOT NULL,
  `FROMAIRPORT` varchar(4) NOT NULL,
  `TOAIRPORT` varchar(4) NOT NULL,
  `SERVICE` varchar(10) NOT NULL,
  `AIRCRAFTTYPE` char(3) NOT NULL,
  `ROUTENO` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `flights`
--

INSERT INTO `flights` (`FLIGHTNO`, `FROMAIRPORT`, `TOAIRPORT`, `SERVICE`, `AIRCRAFTTYPE`, `ROUTENO`) VALUES
('100', 'IXE', 'BOM', 'Breakfast', '300', 3),
('200', 'IXE', 'DEL', 'SNACKS', '302', 4);

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`username`, `password`) VALUES
('uname', 'psw');

-- --------------------------------------------------------

--
-- Table structure for table `passenger`
--

CREATE TABLE `passenger` (
  `PID` int(11) NOT NULL,
  `NAME` varchar(40) NOT NULL,
  `ADDRESS` varchar(40) NOT NULL,
  `TELNO` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `passenger`
--

INSERT INTO `passenger` (`PID`, `NAME`, `ADDRESS`, `TELNO`) VALUES
(100, 'DONNA', 'GULBARGA', '23124718'),
(200, 'DIVYA', 'MOODBIDRE', '5345353'),
(220, 'IRAL NORONHA', 'UDUPI', '382355245'),
(300, 'FLOYD', 'KARKALA', '464354345'),
(303, 'MACLEAN DSOUZA', 'MUMBAI', '3843205'),
(400, 'DERYL', 'KARKALA', '4593475037'),
(800, 'HARSHITA', 'MYSURU', '45436546');

--
-- Triggers `passenger`
--
DELIMITER $$
CREATE TRIGGER `delpasng` AFTER DELETE ON `passenger` FOR EACH ROW INSERT into deleted_passengers(pid,name,address,telno) values(old.pid,old.name,old.address,old.telno)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

CREATE TABLE `route` (
  `ROUTENO` int(10) NOT NULL,
  `RDESCRIPTION` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `route`
--

INSERT INTO `route` (`ROUTENO`, `RDESCRIPTION`) VALUES
(1, 'IXE-KLR'),
(2, 'IXE-BLR'),
(3, 'IXE-BOM'),
(4, 'IXE-DEL'),
(5, 'IXE-GOA'),
(7, 'IXE-KLR'),
(9, 'IXE-BLR');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aircraft`
--
ALTER TABLE `aircraft`
  ADD PRIMARY KEY (`AIRCRAFTTYPE`);

--
-- Indexes for table `airport`
--
ALTER TABLE `airport`
  ADD UNIQUE KEY `AIRPORT` (`AIRPORT`);

--
-- Indexes for table `fares`
--
ALTER TABLE `fares`
  ADD PRIMARY KEY (`FARETYPE`);

--
-- Indexes for table `flights`
--
ALTER TABLE `flights`
  ADD PRIMARY KEY (`FLIGHTNO`),
  ADD KEY `fk_air` (`AIRCRAFTTYPE`),
  ADD KEY `fk_rou` (`ROUTENO`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`username`,`password`);

--
-- Indexes for table `passenger`
--
ALTER TABLE `passenger`
  ADD PRIMARY KEY (`PID`);

--
-- Indexes for table `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`ROUTENO`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `passenger`
--
ALTER TABLE `passenger`
  MODIFY `PID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=801;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `flights`
--
ALTER TABLE `flights`
  ADD CONSTRAINT `fk_air` FOREIGN KEY (`AIRCRAFTTYPE`) REFERENCES `aircraft` (`AIRCRAFTTYPE`),
  ADD CONSTRAINT `fk_rou` FOREIGN KEY (`ROUTENO`) REFERENCES `route` (`ROUTENO`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
