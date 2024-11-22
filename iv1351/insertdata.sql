-- Person
INSERT INTO person (person_number, first_name, last_name, address) VALUES
('9508231921', 'Ali', 'Rezaei', '221B Baker Street, London'),
('9203152847', 'Sara', 'Mohammadi', '742 Evergreen Terrace, London'),
('8805093742', 'Hassan', 'Karimi', '1600 Pennsylvania Avenue NW, London'),
('9707184823', 'Zahra', 'Ghasemi', '10 Downing Street, London'),
('8902261937', 'Reza', 'Naghavi', '221A Baker Street, London');

-- Phone
INSERT INTO phone (phone_number) VALUES
('076-4464955'),
('076-4464932'),
('076-4464991'),
('076-4464923'),
('076-4464987');

-- Email
INSERT INTO email (email_address) VALUES
('ali.rezaei@example.com'),
('sara.mohammadi@example.com'),
('hassan.karimi@example.com'),
('zahra.ghasemi@example.com'),
('reza.naghavi@example.com');

-- Level
INSERT INTO level (level_name) VALUES
('Beginner'),
('Intermediate'),
('Advanced');

-- Instrument
INSERT INTO instrument (instrument_name, brand, instrument_type, quantity_in_stock, rental_price_per_month) VALUES
('Guitar', 'Yamaha', 'String', 10, 50.00),
('Piano', 'Steinway', 'Keyboard', 5, 100.00),
('Violin', 'Stradivarius', 'String', 7, 75.00),
('Flute', 'Yamaha', 'Wind', 8, 40.00),
('Drum Set', 'Pearl', 'Percussion', 3, 150.00);



-- Person-Phone Relationships
INSERT INTO person_phone (person_id, phone_id) VALUES
(1001, 2001),
(1002, 2002),
(1003, 2003),
(1004, 2004),
(1005, 2005);

-- Person-Email Relationships
INSERT INTO person_email (person_id, email_id) VALUES
(1001, 3001),
(1002, 3002),
(1003, 3003),
(1004, 3004),
(1005, 3005);

-- Students
INSERT INTO student (person_id, enrollment_date, grade_level) VALUES
(1001, '2023-01-15', 'Beginner'),
(1002, '2023-02-10', 'Intermediate'),
(1003, '2023-03-05', 'Advanced'),
(1004, '2023-04-20', 'Beginner'),
(1005, '2023-05-25', 'Intermediate');

-- Instructors
INSERT INTO instructor (person_id, hire_date, specialization, salary) VALUES
(1003, '2021-01-01', 'Guitar', 5000.00),
(1004, '2021-02-01', 'Piano', 5500.00),
(1005, '2021-03-01', 'Violin', 4800.00);

-- Contact Persons
INSERT INTO contact_person (person_id, relationship_to_student) VALUES
(1001, 'Parent'),
(1002, 'Parent'),
(1003, 'Sibling');



-- Student-Contact Relationships
INSERT INTO student_contact_person (student_id, contact_person_id, relationship_type) VALUES
(4001, 6001, 'Parent'),
(4002, 6002, 'Parent');

-- Sibling Relationships
INSERT INTO sibling (student_id1, student_id2) VALUES
(4001, 4002);

-- Pricing Schemes
INSERT INTO pricing_scheme (lesson_type, level_id, price_per_lesson, effective_from, effective_to) VALUES
('Individual', 7001, 20.00, '2023-01-01', '2023-12-31'),
('Group', 7002, 15.00, '2023-01-01', '2023-12-31'),
('Ensemble', 7003, 25.00, '2023-01-01', '2023-12-31');



-- Lessons
INSERT INTO lesson (level_id, instructor_id, pricing_scheme_id) VALUES
(7001, 5001, 8001),
(7002, 5002, 8002),
(7003, 5003, 8003);

-- Lesson-Instrument Relationships
INSERT INTO lesson_instrument (lesson_id, instrument_id) VALUES
(9001, 18001),
(9002, 18002),
(9003, 18003);

-- Bookings
INSERT INTO booking (student_id, lesson_id, lesson_type, booking_date, scheduled_date_time, duration, status, price, level_id) VALUES
(4001, 9001, 'Individual', '2023-06-01', '2023-06-01 10:00:00', 60, 'Confirmed', 20.00, 7001),
(4002, 9002, 'Group', '2023-06-02', '2023-06-02 14:00:00', 90, 'Confirmed', 15.00, 7002);




-- Student Payments
INSERT INTO student_payment (student_id, payment_date, total_amount, discount_amount, net_amount, payment_period) VALUES
(4001, '2023-06-30', 20.00, 0.00, 20.00, 'June'),
(4002, '2023-06-30', 15.00, 0.00, 15.00, 'June');

-- Student Payment Details
INSERT INTO student_payment_detail (payment_id, booking_id, lesson_fee) VALUES
(12001, 11001, 20.00),
(12002, 11002, 15.00);

-- Instructor Payments
INSERT INTO instructor_payment (instructor_id, payment_date, total_amount, tax_withheld, net_amount, payment_period) VALUES
(5001, '2023-06-30', 20.00, 2.00, 18.00, 'June'),
(5002, '2023-06-30', 15.00, 1.50, 13.50, 'June');

-- Instructor Payment Details
INSERT INTO instructor_payment_detail (payment_id, lesson_id, payment_amount) VALUES
(14001, 9001, 20.00),
(14002, 9002, 15.00);


-- Rentals
INSERT INTO rental (student_id, instrument_id, rental_start_date, rental_end_date, monthly_fee) VALUES
(4001, 18001, '2024-06-01', '2024-06-30', 50.00),
(4002, 18002, '2022-06-01', '2022-06-30', 100.00);

-- Rental Payment Details
INSERT INTO rental_payment_detail (payment_id, rental_id, rental_fee) VALUES
(12001, 16001, 50.00),
(12002, 16002, 100.00);

