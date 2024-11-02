create database project_DB;
use project_DB;

select * from Cars
select * from Users
select * from CarBookings
select * from Meetings

-- Create tables for Cars, Users, CarBookings, and Meetings
CREATE TABLE Cars (
    car_id INT IDENTITY(1,1) PRIMARY KEY,
    car_name VARCHAR(100) NOT NULL,
    price_per_hour FLOAT NOT NULL,
    availability BIT DEFAULT 1
);

CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    id_card_number VARCHAR(100) UNIQUE NOT NULL,
    date_of_issue DATE NOT NULL
);

CREATE TABLE CarBookings (
    booking_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    car_id INT NOT NULL,
    hours FLOAT NOT NULL,
    total_amount FLOAT NOT NULL,
    booking_date DATE NOT NULL,
    pickup_time TIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (car_id) REFERENCES Cars(car_id)
);

CREATE TABLE Meetings (
    meeting_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    meeting_date DATE NOT NULL,
    meeting_time TIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Insert car data into Cars table
INSERT INTO Cars (car_name, price_per_hour) VALUES
('Toyota Hilux', 25.0),
('BMW 3 Series', 28.0),
('Ford Mustang', 30.0),
('Honda Civic', 20.0),
('Tesla Model S', 30.0),
('Chevrolet Silverado', 25.0),
('Volkswagen Golf', 22.0),
('Mercedes-Benz C-Class', 28.0),
('Audi A4', 27.0),
('Nissan Altima', 21.0),
('Jeep Wrangler', 26.0),
('Subaru Outback', 23.0);

-- Insert user data into Users table
INSERT INTO Users (name, age, email, id_card_number, date_of_issue) VALUES
('Travis Scott', 30, 'travis@gmail.com', '123456789', '2024-06-02'),
('Drake', 28, 'drake@hotmail.com', '987654321', '2024-06-02'),
('Henry Cavill', 35, 'henry@outlook.com', '112233445', '2024-06-01'),
('James Beaufort', 40, 'james@hotmail.com', '667788990', '2024-06-01'),
('Harry Styles', 25, 'harry@gmail.com', '554433221', '2024-06-02'),
('Timothee Chalamet', 32, 'timothee@outlook.com', '998877665', '2024-06-03');

-- Insert booking data into CarBookings table
INSERT INTO CarBookings (user_id, car_id, hours, total_amount, booking_date, pickup_time)
VALUES
(1, 1, 5, 1125.0, '2024-06-02', '10:00:00'),
(2, 2, 3, 284.0, '2024-06-02', '11:00:00'),
(3, 3, 4, 1320.0, '2024-06-03', '12:00:00'),
(4, 4, 4, 4021.0, '2024-06-03', '13:00:00'),
(5, 5, 5, 1803.0, '2024-06-03', '14:00:00'),
(6, 6, 6, 7522.0, '2024-06-03', '15:00:00'),
(1, 7, 5, 1120.0, '2024-06-04', '09:00:00'),
(2, 8, 2, 5116.0, '2024-06-04', '10:00:00'),
(3, 9, 1, 1365.0, '2024-06-04', '11:00:00'),
(4, 10, 2, 7563.0, '2024-06-04', '12:00:00'),
(5, 11, 4, 5480.0, '2024-06-05', '13:00:00'),
(6, 12, 3, 6969.0, '2024-06-05', '14:00:00'),
(1, 3, 2, 6340.0, '2024-06-06', '15:00:00'),
(2, 4, 3, 9230.0, '2024-06-06', '16:00:00'),
(3, 5, 4, 1240.0, '2024-06-07', '17:00:00'),
(4, 6, 5, 1503.0, '2024-06-07', '18:00:00');

-- Insert meeting data into Meetings table
INSERT INTO Meetings (user_id, meeting_date, meeting_time) VALUES
(1, '2024-06-03', '14:00:00'),
(2, '2024-06-04', '15:00:00'),
(3, '2024-06-05', '16:00:00'),
(4, '2024-06-06', '17:00:00'),
(5, '2024-06-07', '18:00:00'),
(6, '2024-06-08', '19:00:00'),
(1, '2024-06-09', '09:00:00'),
(2, '2024-06-10', '10:00:00'),
(3, '2024-06-11', '11:00:00'),
(4, '2024-06-12', '12:00:00'),
(5, '2024-06-13', '13:00:00'),
(6, '2024-06-14', '14:00:00'),
(1, '2024-06-15', '15:00:00'),
(2, '2024-06-16', '16:00:00');

-- Display available cars
SELECT car_id, car_name, price_per_hour FROM Cars WHERE availability = 1;

-- Display all meetings and bookings for each user
SELECT 
    u.user_id,
    u.name,
    'Booking' AS activity_type,
    b.booking_id AS activity_id,
    c.car_name AS activity_name,
    b.booking_date AS activity_date,
    b.pickup_time AS activity_time,
    b.total_amount AS activity_amount
FROM 
    Users u JOIN CarBookings b ON u.user_id = b.user_id JOIN Cars c ON b.car_id = c.car_id
UNION
SELECT 
    u.user_id,u.name,
    'Meeting' AS activity_type,
    m.meeting_id AS activity_id,
    NULL AS activity_name,
    m.meeting_date AS activity_date,
    m.meeting_time AS activity_time,
    NULL AS activity_amount
FROM 
    Users u JOIN Meetings m ON u.user_id = m.user_id
ORDER BY 
    u.user_id, activity_date, activity_time;


-- List all car bookings for a specific user

SELECT b.booking_id, c.car_name, b.hours, b.total_amount, b.booking_date, b.pickup_time
FROM CarBookings b
JOIN Cars c ON b.car_id = c.car_id
WHERE b.user_id = 3;

SELECT meeting_id, meeting_date, meeting_time
FROM Meetings
WHERE user_id = 3;

--displaying total bill for each user
SELECT 
    u.user_id,
    u.name,
    SUM(b.total_amount) AS total_bill
FROM 
    Users u
JOIN 
    CarBookings b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.name
ORDER BY 
    u.user_id;


-- Display the total bill for each user based on each car
SELECT 
    u.user_id,
    u.name,
    c.car_name,
    SUM(b.total_amount) AS total_bill
FROM 
    Users u
JOIN 
    CarBookings b ON u.user_id = b.user_id
JOIN 
    Cars c ON b.car_id = c.car_id
GROUP BY 
    u.user_id, u.name, c.car_name
ORDER BY 
    u.user_id, c.car_name;


-- Display the total bill for a specific user based on each car
SELECT 
    u.user_id,
    u.name,
    c.car_name,
    SUM(b.total_amount) AS total_bill
FROM 
    Users u
JOIN 
    CarBookings b ON u.user_id = b.user_id
JOIN 
    Cars c ON b.car_id = c.car_id
WHERE 
    u.user_id = 6 
GROUP BY 
    u.user_id, u.name, c.car_name
ORDER BY 
    c.car_name;
