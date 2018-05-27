-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 15, 2018 at 08:11 PM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 7.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `canviodb`
--

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `billsID` int(11) NOT NULL,
  `userID` varchar(20) NOT NULL,
  `electricityUsage` varchar(20) NOT NULL,
  `tariff` varchar(20) NOT NULL,
  `billAmt` double NOT NULL,
  `billingMonth` varchar(50) NOT NULL,
  `billingYear` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `complaint`
--

CREATE TABLE `complaint` (
  `complaintID` int(11) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ON GOING',
  `description` varchar(200) NOT NULL,
  `image` blob,
  `category` varchar(30) NOT NULL,
  `complaintTime` datetime NOT NULL,
  `userID` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `complaint`
--

INSERT INTO `complaint` (`complaintID`, `status`, `description`, `image`, `category`, `complaintTime`, `userID`) VALUES
(5, 'ON GOING', 'test admin', NULL, 'error', '2018-04-16 00:00:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `consumption`
--

CREATE TABLE `consumption` (
  `comsumptionID` int(11) NOT NULL,
  `consumption` double NOT NULL,
  `dateTime` datetime NOT NULL,
  `meterID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `consumption`
--

INSERT INTO `consumption` (`comsumptionID`, `consumption`, `dateTime`, `meterID`) VALUES
(1224, 250, '2018-01-03 00:00:00', 123412),
(123415, 100, '2018-02-14 00:00:00', 123412),
(131413, 150, '2018-03-14 00:00:00', 123412),
(1231155, 100, '2018-05-16 00:00:00', 123412),
(1232132, 200, '2018-04-21 00:00:00', 123412);

-- --------------------------------------------------------

--
-- Table structure for table `smartmeter`
--

CREATE TABLE `smartmeter` (
  `meterID` int(11) NOT NULL,
  `category` varchar(25) NOT NULL,
  `address` varchar(200) NOT NULL,
  `postcode` int(5) NOT NULL,
  `City` varchar(20) NOT NULL,
  `Negeri` varchar(25) NOT NULL,
  `report` varchar(50) DEFAULT NULL,
  `performance` varchar(50) DEFAULT NULL,
  `userID` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `smartmeter`
--

INSERT INTO `smartmeter` (`meterID`, `category`, `address`, `postcode`, `City`, `Negeri`, `report`, `performance`, `userID`) VALUES
(8080, 'Household', 'UPM Bintulu', 2500, 'Bintulu', 'Sarawak', NULL, 'Fair', 'Admin'),
(123412, 'HouseHold', 'maradsad', 43400, 'Serdang', 'Selangor', NULL, 'Good', 'tee'),
(182581, 'Household', 'UPM Serdang', 123, 'Putrajaya', 'Selangor', NULL, 'Poor', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userID` varchar(20) NOT NULL,
  `name` varchar(45) CHARACTER SET latin1 NOT NULL,
  `phonenum` varchar(35) NOT NULL,
  `uname` varchar(30) NOT NULL,
  `address` varchar(200) NOT NULL,
  `postcode` int(5) NOT NULL,
  `City` varchar(20) NOT NULL,
  `Negeri` varchar(25) NOT NULL,
  `email` varchar(100) NOT NULL,
  `pass` varchar(40) NOT NULL,
  `regdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userID`, `name`, `phonenum`, `uname`, `address`, `postcode`, `City`, `Negeri`, `email`, `pass`, `regdate`) VALUES
('Admin', 'Administrator', '0112345678', 'Admin', 'UPM Serdang', 123457, 'Sri Kembangan', 'Selangor', 'a@gmail.com', 'admin123', '2018-04-16'),
('tee', 'Tee Szen Yew', '01110978725', 'tee', 'Jln F3-2, Kampung Kota Jelasin', 25000, 'Ipoh', 'Perak', 'Tee@gmail.com', 'qwer', '2018-03-21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`billsID`),
  ADD KEY `userbill` (`userID`);

--
-- Indexes for table `complaint`
--
ALTER TABLE `complaint`
  ADD PRIMARY KEY (`complaintID`),
  ADD KEY `usercomplaint` (`userID`);

--
-- Indexes for table `consumption`
--
ALTER TABLE `consumption`
  ADD PRIMARY KEY (`comsumptionID`),
  ADD KEY `meterconsumption` (`meterID`);

--
-- Indexes for table `smartmeter`
--
ALTER TABLE `smartmeter`
  ADD PRIMARY KEY (`meterID`),
  ADD KEY `usermeter` (`userID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userID`),
  ADD UNIQUE KEY `userID` (`userID`),
  ADD UNIQUE KEY `uname` (`uname`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `complaint`
--
ALTER TABLE `complaint`
  MODIFY `complaintID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bills`
--
ALTER TABLE `bills`
  ADD CONSTRAINT `userbill` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `complaint`
--
ALTER TABLE `complaint`
  ADD CONSTRAINT `usercomplaint` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `consumption`
--
ALTER TABLE `consumption`
  ADD CONSTRAINT `meterconsumption` FOREIGN KEY (`meterID`) REFERENCES `smartmeter` (`meterID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `smartmeter`
--
ALTER TABLE `smartmeter`
  ADD CONSTRAINT `usermeter` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
