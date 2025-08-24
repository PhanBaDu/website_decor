-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Aug 24, 2025 at 09:09 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shopping_decor_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `product_id`, `quantity`, `price`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 6, 800000, '2025-08-24 18:23:03', '2025-08-24 18:28:08'),
(2, 1, 1, 2, 150000, '2025-08-24 18:24:25', '2025-08-24 18:53:26');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Đèn'),
(2, 'Bàn'),
(3, 'Ghế'),
(4, 'Thảm'),
(5, 'Tranh'),
(6, 'Chậu cây');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` longtext NOT NULL,
  `image` longtext DEFAULT NULL,
  `price` double NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `id_category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `image`, `price`, `quantity`, `status`, `id_category`) VALUES
(1, 'Đèn ngủ LED', 'https://imgs.search.brave.com/UGiSPfbxwSu6L42t12Smzq2IpkG5L7A_TNii9_V1x2E/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tYXJr/ZXRwbGFjZS5jYW52/YS5jb20vRUFHakZW/akFqN1UvMS8wLzE2/MDB3L2NhbnZhLXJl/ZC1hbmQtYmxhY2st/cmV0cm8tbGFuZHNj/YXBlLXlvdXR1YmUt/dGh1bWJuYWlsLWJh/Y2tncm91bmQtWUlY/aTJtQzVSOFkuanBn', 150000, 15, 1, 1),
(2, 'Đèn trần pha lê', 'https://imgs.search.brave.com/UGiSPfbxwSu6L42t12Smzq2IpkG5L7A_TNii9_V1x2E/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tYXJr/ZXRwbGFjZS5jYW52/YS5jb20vRUFHakZW/akFqN1UvMS8wLzE2/MDB3L2NhbnZhLXJl/ZC1hbmQtYmxhY2st/cmV0cm8tbGFuZHNj/YXBlLXlvdXR1YmUt/dGh1bWJuYWlsLWJh/Y2tncm91bmQtWUlY/aTJtQzVSOFkuanBn', 800000, 5, 1, 1),
(3, 'Bàn gỗ sồi', 'https://imgs.search.brave.com/UGiSPfbxwSu6L42t12Smzq2IpkG5L7A_TNii9_V1x2E/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tYXJr/ZXRwbGFjZS5jYW52/YS5jb20vRUFHakZW/akFqN1UvMS8wLzE2/MDB3L2NhbnZhLXJl/ZC1hbmQtYmxhY2st/cmV0cm8tbGFuZHNj/YXBlLXlvdXR1YmUt/dGh1bWJuYWlsLWJh/Y2tncm91bmQtWUlY/aTJtQzVSOFkuanBn', 1200000, 8, 1, 2),
(4, 'Bàn cafe mini', 'https://imgs.search.brave.com/UGiSPfbxwSu6L42t12Smzq2IpkG5L7A_TNii9_V1x2E/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tYXJr/ZXRwbGFjZS5jYW52/YS5jb20vRUFHakZW/akFqN1UvMS8wLzE2/MDB3L2NhbnZhLXJl/ZC1hbmQtYmxhY2st/cmV0cm8tbGFuZHNj/YXBlLXlvdXR1YmUt/dGh1bWJuYWlsLWJh/Y2tncm91bmQtWUlY/aTJtQzVSOFkuanBn', 450000, 12, 1, 2),
(5, 'Ghế sofa vải', 'https://imgs.search.brave.com/UGiSPfbxwSu6L42t12Smzq2IpkG5L7A_TNii9_V1x2E/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tYXJr/ZXRwbGFjZS5jYW52/YS5jb20vRUFHakZW/akFqN1UvMS8wLzE2/MDB3L2NhbnZhLXJl/ZC1hbmQtYmxhY2st/cmV0cm8tbGFuZHNj/YXBlLXlvdXR1YmUt/dGh1bWJuYWlsLWJh/Y2tncm91bmQtWUlY/aTJtQzVSOFkuanBn', 2000000, 0, 1, 3),
(6, 'Ghế ăn gỗ', 'https://imgs.search.brave.com/UGiSPfbxwSu6L42t12Smzq2IpkG5L7A_TNii9_V1x2E/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tYXJr/ZXRwbGFjZS5jYW52/YS5jb20vRUFHakZW/akFqN1UvMS8wLzE2/MDB3L2NhbnZhLXJl/ZC1hbmQtYmxhY2st/cmV0cm8tbGFuZHNj/YXBlLXlvdXR1YmUt/dGh1bWJuYWlsLWJh/Y2tncm91bmQtWUlY/aTJtQzVSOFkuanBn', 600000, 10, 1, 3),
(7, 'Thảm trang trí', 'https://imgs.search.brave.com/UGiSPfbxwSu6L42t12Smzq2IpkG5L7A_TNii9_V1x2E/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tYXJr/ZXRwbGFjZS5jYW52/YS5jb20vRUFHakZW/akFqN1UvMS8wLzE2/MDB3L2NhbnZhLXJl/ZC1hbmQtYmxhY2st/cmV0cm8tbGFuZHNj/YXBlLXlvdXR1YmUt/dGh1bWJuYWlsLWJh/Y2tncm91bmQtWUlY/aTJtQzVSOFkuanBn', 200000, 5, 0, 4),
(8, 'Tranh treo tường Canvas', 'https://imgs.search.brave.com/UGiSPfbxwSu6L42t12Smzq2IpkG5L7A_TNii9_V1x2E/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tYXJr/ZXRwbGFjZS5jYW52/YS5jb20vRUFHakZW/akFqN1UvMS8wLzE2/MDB3L2NhbnZhLXJl/ZC1hbmQtYmxhY2st/cmV0cm8tbGFuZHNj/YXBlLXlvdXR1YmUt/dGh1bWJuYWlsLWJh/Y2tncm91bmQtWUlY/aTJtQzVSOFkuanBn', 300000, 8, 1, 5),
(9, 'Chậu cây mini', 'https://imgs.search.brave.com/UGiSPfbxwSu6L42t12Smzq2IpkG5L7A_TNii9_V1x2E/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tYXJr/ZXRwbGFjZS5jYW52/YS5jb20vRUFHakZW/akFqN1UvMS8wLzE2/MDB3L2NhbnZhLXJl/ZC1hbmQtYmxhY2st/cmV0cm8tbGFuZHNj/YXBlLXlvdXR1YmUt/dGh1bWJuYWlsLWJh/Y2tncm91bmQtWUlY/aTJtQzVSOFkuanBn', 120000, 20, 1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` longtext NOT NULL,
  `email` longtext NOT NULL,
  `phone` varchar(15) NOT NULL,
  `password` longtext NOT NULL,
  `role` enum('ADMIN','USER') NOT NULL DEFAULT 'USER'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `password`, `role`) VALUES
(1, 'Phan Bá Đủ', 'duphan03@gmail.com', '0357013424', '123123', 'ADMIN');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_product` (`user_id`,`product_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_product_id` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_category` (`id_category`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
