CREATE DATABASE IF NOT EXISTS TryCatch_Scooters;
USE TryCatch_Scooters;

CREATE TABLE TechnicalCharacteristics (
    model_id INT PRIMARY KEY,
    model_name VARCHAR(50) NOT NULL,
    max_speed INT CHECK (max_speed > 0),
    battery_capacity INT CHECK (battery_capacity > 0),
    weight DECIMAL(5,2) CHECK (weight > 0),
    release_year YEAR
);

CREATE TABLE Scooters (
    scooter_id INT PRIMARY KEY AUTO_INCREMENT,
    model_id INT,
    scooter_geolocation POINT NOT NULL,
    charge_status INT NOT NULL CHECK (charge_status BETWEEN 0 AND 100),
    kilometers_left DECIMAL(7,2) NOT NULL CHECK (kilometers_left >= 0),
    is_active BOOLEAN DEFAULT TRUE,
    last_maintenance DATETIME,
    FOREIGN KEY (model_id) REFERENCES TechnicalCharacteristics(model_id)
);

CREATE TABLE Pricing (
    pricing_id INT PRIMARY KEY AUTO_INCREMENT,
    price_per_minute DECIMAL(5,2),
    unlock_fee DECIMAL(5,2),
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE Subscriptions (
    subscription_type_id INT PRIMARY KEY AUTO_INCREMENT,
    subscription_type VARCHAR(50),
    price DECIMAL(6,2),
    durability_days INT
);

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Trips (
    trip_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    scooter_id INT,
    pricing_id INT,
    start_time DATETIME,
    end_time DATETIME,
    start_location POINT,
    end_location POINT,
    distance DECIMAL(6,2),
    total_price DECIMAL(6,2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE SET NULL,
    FOREIGN KEY (scooter_id) REFERENCES Scooters(scooter_id) ON DELETE SET NULL,
    FOREIGN KEY (pricing_id) REFERENCES Pricing(pricing_id) ON DELETE SET NULL
);

CREATE TABLE Tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    ticket_status VARCHAR(50),
    ticket_description TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Balances (
    balance_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    current_balance DECIMAL(8,2) DEFAULT 0.00,
    kilometres_available DECIMAL(6,2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Active_subscriptions (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    subscription_type_id INT,
    user_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (subscription_type_id) REFERENCES Subscriptions(subscription_type_id)
);

CREATE USER 'dzhupanenko'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON trycatch_scooters TO 'dzhupanenko'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;


