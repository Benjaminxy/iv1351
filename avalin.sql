-- Insert into person
INSERT INTO person (person_number, first_name, last_name, address) VALUES
('9508231921', 'Ali', 'Rezaei', '221B Baker Street, London'),
('9203152847', 'Sara', 'Mohammadi', '742 Evergreen Terrace, London'),
('8805093742', 'Hassan', 'Karimi', '1600 Pennsylvania Avenue NW, London'),
('9707184823', 'Zahra', 'Ghasemi', '10 Downing Street, London'),
('8902261937', 'Reza', 'Naghavi', '221A Baker Street, London'),
('9301013741', 'Maryam', 'Fakharian', '45 Soho Square, London'),
('9902035821', 'Sina', 'Mokhtari', '10 Piccadilly Circus, London'),
('8807112345', 'Parisa', 'Ahmadi', '50 Oxford Street, London'),
('8901234567', 'Nima', 'Shirazi', '25 Trafalgar Square, London'),
('8605039123', 'Farhad', 'Rasouli', '77 Regent Street, London'),
('8504015678', 'Elham', 'Najafi', '88 Covent Garden, London');



-- Insert into phone
INSERT INTO phone (phone_number) VALUES
('076-4464955'),
('076-4464932'),
('076-4464991'),
('076-4464923'),
('076-4464987'),
('076-4464976'),
('076-4464911'),
('076-4464909'),
('076-4464944'),
('076-4464928'),
('076-4464998');


-- Insert into email
INSERT INTO email (email_address) VALUES
('ali.rezaei@example.com'),
('sara.mohammadi@example.com'),
('hassan.karimi@example.com'),
('zahra.ghasemi@example.com'),
('reza.naghavi@example.com'),
('maryam.fakharian@example.com'),
('sina.mokhtari@example.com'),
('parisa.ahmadi@example.com'),
('nima.shirazi@example.com'),
('farhad.rasouli@example.com'),
('elham.najafi@example.com');



-- Insert into person_phone
INSERT INTO person_phone (person_id, phone_id) VALUES
(1001, 2001),
(1002, 2002),
(1003, 2003),
(1004, 2004),
(1005, 2005),
(1006, 2006),
(1007, 2007),
(1008, 2008),
(1009, 2009),
(1010, 2010),
(1011, 2011);


-- Insert into person_email
INSERT INTO person_email (person_id, email_id) VALUES
(1001, 3001),
(1002, 3002),
(1003, 3003),
(1004, 3004),
(1005, 3005),
(1006, 3006),
(1007, 3007),
(1008, 3008),
(1009, 3009),
(1010, 3010),
(1011, 3011);


-- Insert into student
-- Ali Rezaei
INSERT INTO student (person_id, enrollment_date, grade_level) VALUES
(1001, '2023-01-15', 'Beginner');

-- Sara Mohammadi
INSERT INTO student (person_id, enrollment_date, grade_level) VALUES
(1002, '2023-02-10', 'Intermediate');

-- Hassan Karimi
INSERT INTO student (person_id, enrollment_date, grade_level) VALUES
(1003, '2023-03-05', 'Advanced');

-- Zahra Ghasemi
INSERT INTO student (person_id, enrollment_date, grade_level) VALUES
(1004, '2023-04-20', 'Beginner');

-- Reza Naghavi
INSERT INTO student (person_id, enrollment_date, grade_level) VALUES
(1005, '2023-05-25', 'Intermediate');

-- Maryam Fakharian
INSERT INTO student (person_id, enrollment_date, grade_level) VALUES
(1006, '2023-06-01', 'Beginner');

-- Sina Mokhtari
INSERT INTO student (person_id, enrollment_date, grade_level) VALUES
(1007, '2023-07-01', 'Intermediate');


-- Insert into instructor

-- Maryam Fakharian
INSERT INTO instructor (person_id, hire_date, specialization) VALUES
(1006, '2022-06-01', 'Piano');

-- Sina Mokhtari
INSERT INTO instructor (person_id, hire_date, specialization) VALUES
(1007, '2022-07-01', 'Guitar');

-- Parisa Ahmadi
INSERT INTO instructor (person_id, hire_date, specialization) VALUES
(1008, '2022-08-01', 'Violin');

-- Nima Shirazi
INSERT INTO instructor (person_id, hire_date, specialization) VALUES
(1009, '2022-09-01', 'Flute');


-- Insert into contact_person


INSERT INTO contact_person (person_id, relationship_to_student) VALUES
(1001, 'Parent'),
(1002, 'Parent'),
(1003, 'Sibling'),
(1004, 'Parent'),
(1005, 'Parent'),
(1006, 'Guardian'),
(1007, 'Sibling');



-- Insert into student_contact_person
INSERT INTO student_contact_person (student_id, contact_person_id, relationship_type) VALUES
(4001, 6001, 'Parent'),
(4002, 6002, 'Parent'),
(4004, 6003, 'Sibling'),
(4005, 6003, 'Sibling'),
(4006, 6006, 'Guardian'),
(4007, 6003, 'Sibling');


-- Insert into sibling
INSERT INTO sibling (student_id1, student_id2) VALUES
(4001, 4002), -- Ali and Sara are siblings
(4003, 4004), -- Hassan and Zahra are siblings
(4005, 4006); -- Reza and a new student are siblings


-- Insert into level
INSERT INTO student_level (level_name) VALUES
('Beginner'),
('Intermediate'),
('Advanced'),
('Expert');






-- Insert into pricing_scheme
INSERT INTO pricing_scheme (lesson_type, level_id, price_per_lesson, effective_from, effective_to) VALUES
('Individual', 7001, 20.00, '2023-01-01', '2023-12-31'),
('Group', 7002, 15.00, '2023-01-01', '2023-12-31'),
('Ensemble', 7003, 25.00, '2023-01-01', '2023-12-31'),
('Individual', 7004, 30.00, '2024-01-01', '2024-12-31');





-- Insert into instrument
INSERT INTO instrument (instrument_name, brand, instrument_type, quantity_in_stock, rental_price_per_month) VALUES
('Guitar', 'Yamaha', 'String', 10, 50.00),
('Piano', 'Steinway', 'Keyboard', 5, 100.00),
('Violin', 'Stradivarius', 'String', 7, 75.00),
('Flute', 'Yamaha', 'Wind', 8, 40.00),
('Drum Set', 'Pearl', 'Percussion', 3, 150.00),
('Trumpet', 'Bach', 'Wind', 6, 45.00),
('Saxophone', 'Selmer', 'Wind', 4, 80.00);

select * from pricing_scheme ;
-- Insert into lesson
INSERT INTO lesson (level_id, instructor_id, pricing_scheme_id, price) VALUES
(7001, 5001, 8001, 20.00), -- Beginner lesson by Instructor 5001
(7002, 5002, 8002, 15.00), -- Intermediate lesson by Instructor 5002
(7003, 5003, 8003, 25.00), -- Advanced lesson by Instructor 5003
(7004, 5004, 8004, 30.00), -- Advanced lesson by Instructor 5004
(7001, 5001, 8004, 15.00); -- Additional Beginner lesson by Instructor 5001





select * from lesson ;


-- Insert into lesson_instrument
INSERT INTO lesson_instrument (lesson_id, instrument_id) VALUES
(9001, 14001),
(9002, 14002),
(9003, 14003),
(9004, 14004),
(9005, 14005);
-- Insert into student_lesson
INSERT INTO student_lesson (student_id, lesson_id) VALUES
(4001, 9001),
(4002, 9002),
(4003, 9003),
(4004, 9005),
(4005, 9001),
(4006, 9004),
(4007, 9002);



-- Insert into individual_lesson
INSERT INTO individual_lesson (lesson_id, appointment_time) VALUES
(9001, '10:00:00'),
(9004, '14:00:00'),
(9005, '16:30:00');

-- Insert into group_lesson
INSERT INTO group_lesson (lesson_id, max_students, min_students) VALUES
(9002, 6, 3),
(9003, 8, 4),
(9001, 10, 5);

-- Insert into ensemble_lesson
INSERT INTO ensemble_lesson (lesson_id, target_genre, max_students, min_students) VALUES
(9003, 'Jazz', 10, 5),
(9005, 'Rock', 15, 8),
(9001, 'Classical', 12, 6);




-- Insert into booking
INSERT INTO booking (student_id, lesson_id, lesson_type, booking_date, scheduled_date_time, duration, status, price) VALUES
(4001, 9001, 'Individual', '2024-12-01', '2024-12-01 10:00:00', 60, 'Confirmed', 20.00),
(4002, 9002, 'Group', '2024-12-02', '2024-12-02 14:00:00', 90, 'Confirmed', 15.00),
(4003, 9003, 'Ensemble', '2024-12-03', '2024-12-03 16:00:00', 120, 'Confirmed', 25.00),
(4001, 9001, 'Individual', '2024-12-04', '2024-12-04 10:00:00', 60, 'Confirmed', 22.00),
(4002, 9002, 'Group', '2024-12-05', '2024-12-05 14:00:00', 90, 'Confirmed', 15.00),
(4003, 9003, 'Ensemble', '2024-12-06', '2024-12-06 16:00:00', 120, 'Confirmed', 25.00),
(4004, 9004, 'Individual', '2024-12-07', '2024-12-07 11:00:00', 60, 'Confirmed', 30.00),
(4005, 9005, 'Group', '2024-12-08', '2024-12-08 15:00:00', 90, 'Confirmed', 27.50);


-- Insert into rental
INSERT INTO rental (student_id, instrument_id, rental_start_date, rental_end_date) VALUES
(4001, 14001, '2024-06-01', '2024-09-30'), -- Ali renting a Guitar
(4002, 14002, '2024-07-01', '2024-08-31'), -- Sara renting a Piano
(4006, 14003, '2024-12-01', '2024-12-31'), -- Zahra renting a Violin
(4003, 14004, '2024-10-01', '2024-12-31'), -- Hassan renting a Flute
(4004, 14005, '2024-09-01', '2024-11-30'), -- Reza renting a Drum Set
(4005, 14002, '2024-08-01', '2024-10-31');-- Maryam renting a Piano again