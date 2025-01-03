-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 02, 2025 at 02:59 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ticketting_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id` varchar(50) NOT NULL,
  `ticketId` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `birthDate` date NOT NULL,
  `bookingDate` datetime NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id`, `ticketId`, `name`, `phone`, `birthDate`, `bookingDate`, `quantity`) VALUES
('160f8593-4df7-4976-ae63-19ecca71b7e8', '4', 'Rasyiid', '08231938219', '0007-06-16', '2024-12-26 13:14:47', 1),
('251ec7dc-9327-4f36-aae5-6971c5be29f1', '6', 'Gipari', '082137268374', '0007-06-16', '2024-12-26 14:30:51', 1),
('832cb28b-e924-4e86-96e2-a8696dd8431c', '9', 'lon', '08231938219', '0017-07-27', '2024-12-26 13:43:53', 1),
('9449a759-7519-4749-bb2b-b35f071ac343', '4', 'Rasyid', '08231938219', '0032-06-15', '2024-12-26 13:12:51', 1),
('aaecc7e7-cdf3-4683-8186-9b7d8c6fbce1', '8', 'hasan', '081231231231', '0007-06-16', '2024-12-26 14:18:18', 1),
('cacd49d0-f1c2-4657-b523-96324a85adff', '4', 'hasan', '081231231231', '0008-06-15', '2024-12-26 14:28:54', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` varchar(36) NOT NULL,
  `bookingId` varchar(36) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `paymentMethod` varchar(20) NOT NULL,
  `paymentStatus` varchar(20) NOT NULL,
  `paymentDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `transactionId` varchar(36) NOT NULL
) ;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`id`, `bookingId`, `amount`, `paymentMethod`, `paymentStatus`, `paymentDate`, `transactionId`) VALUES
('15f801ca-cbc2-459e-98e3-b913353211af', 'cacd49d0-f1c2-4657-b523-96324a85adff', '150000.00', 'GOPAY', 'SUCCESS', '2024-12-26 07:28:58', '29c2afa6-fdb7-460c-abe2-c8316dc4fc1b'),
('456725fb-598c-4f72-b3b0-3aa790fea397', '251ec7dc-9327-4f36-aae5-6971c5be29f1', '175000.00', 'BANK_TRANSFER', 'SUCCESS', '2024-12-26 07:33:55', '43af71b6-b45c-43df-a605-8e492a112630'),
('63ec2008-f480-4c4b-ba83-966a5a364dd1', '251ec7dc-9327-4f36-aae5-6971c5be29f1', '175000.00', 'BANK_TRANSFER', 'SUCCESS', '2024-12-26 07:30:57', 'e47160f8-eff6-4d43-896b-023a5f06eafb'),
('a659cb01-81fb-4a1e-9790-b4e061f5e613', 'aaecc7e7-cdf3-4683-8186-9b7d8c6fbce1', '200000.00', 'BANK_TRANSFER', 'SUCCESS', '2024-12-26 07:18:46', '251da128-32f3-4967-abdc-220f7ee24481'),
('af60c2a1-84c9-48ff-b969-263942283b2b', 'aaecc7e7-cdf3-4683-8186-9b7d8c6fbce1', '200000.00', 'BANK_TRANSFER', 'SUCCESS', '2024-12-26 07:19:43', '610bec25-70eb-4e73-8ad2-135e2d05d23b'),
('cd2f7acb-5a6c-4a3e-a5cd-7b4eee3375ca', '832cb28b-e924-4e86-96e2-a8696dd8431c', '3000000.00', 'BANK_TRANSFER', 'SUCCESS', '2024-12-26 06:44:52', '035d91dd-d838-4f15-947c-29c4dab92286'),
('d1a1080b-9ea0-4391-9f24-85e2b6fd5af4', 'aaecc7e7-cdf3-4683-8186-9b7d8c6fbce1', '200000.00', 'BANK_TRANSFER', 'SUCCESS', '2024-12-26 07:18:23', 'd31f75bd-0549-49c3-8e3f-86a801ef1103');

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `id` int(11) NOT NULL,
  `reservationNumber` varchar(50) NOT NULL,
  `travelDate` date NOT NULL,
  `ticketStatus` varchar(20) NOT NULL,
  `origin` varchar(100) DEFAULT NULL,
  `destination` varchar(100) DEFAULT NULL,
  `stock` int(11) DEFAULT 0,
  `ticketType` varchar(20) DEFAULT NULL,
  `basePrice` decimal(10,2) DEFAULT NULL,
  `facilities` varchar(255) DEFAULT NULL,
  `departureTime` time NOT NULL,
  `arrivalTime` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`id`, `reservationNumber`, `travelDate`, `ticketStatus`, `origin`, `destination`, `stock`, `ticketType`, `basePrice`, `facilities`, `departureTime`, `arrivalTime`) VALUES
(1, 'RES12345', '2024-01-15', 'Available', 'Jakarta', 'Bandungg', 20, 'Regular', '5000000.00', '', '08:00:00', '10:00:00'),
(4, 'RES12348', '2024-01-18', 'active', 'Bali', 'Lombok', 2, 'Executive', '150000.00', NULL, '07:00:00', '09:00:00'),
(6, 'RES12350', '2024-01-20', 'active', 'Palembang', 'Lampung', 11, 'Executive', '175000.00', NULL, '18:30:00', '20:30:00'),
(7, 'RSVMNT4P', '2025-01-03', 'Available', 'Jakarta', 'Surabaya', 100, NULL, '250000.00', 'Makanan Enak', '21:00:00', '23:00:00'),
(8, 'RSVHRNY', '2025-01-03', 'Available', 'Jakarta', 'Malang', 99, NULL, '200000.00', NULL, '08:00:00', '09:00:00'),
(9, 'RSVHRNYS', '2025-01-08', 'Available', 'Jakarta', 'Bali', 99, NULL, '3000000.00', NULL, '14:00:00', '16:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookingId` (`bookingId`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`bookingId`) REFERENCES `booking` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
