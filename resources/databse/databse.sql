-- Create the database schema
CREATE SCHEMA IF NOT EXISTS `user_crud_db`;

-- Select the schema for use
USE `user_crud_db`;

-- Create the users table
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) NOT NULL UNIQUE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

-- Optional: Insert initial user data (example only)
INSERT INTO `users` (`name`, `email`) VALUES
('Alice Silva', 'alice@example.com'),
('Bob Fernando', 'bob@example.com');