-- Level 1: Base Tables
CREATE TABLE person (
    person_id INT AUTO_INCREMENT PRIMARY KEY,
    person_number VARCHAR(50) UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL
);

CREATE TABLE phone (
    phone_id INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(15) UNIQUE
);

CREATE TABLE email (
    email_id INT AUTO_INCREMENT PRIMARY KEY,
    email_address VARCHAR(255) UNIQUE
);

CREATE TABLE instrument (
    instrument_id INT AUTO_INCREMENT PRIMARY KEY,
    instrument_name VARCHAR(100) NOT NULL,
    brand VARCHAR(100),
    instrument_type VARCHAR(50) NOT NULL,
    quantity_in_stock INT,
    rental_price_per_month DECIMAL(10, 2) NOT NULL
);

CREATE TABLE student_level (
    level_id INT AUTO_INCREMENT PRIMARY KEY,
    level_name VARCHAR(50) UNIQUE NOT NULL
);

-- Level 2: Tables Dependent on Level 1
CREATE TABLE person_phone (
    person_id INT NOT NULL,
    phone_id INT NOT NULL,
    PRIMARY KEY (person_id, phone_id)
);

CREATE TABLE person_email (
    person_id INT NOT NULL,
    email_id INT NOT NULL,
    PRIMARY KEY (person_id, email_id)
);

CREATE TABLE student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT NOT NULL,
    enrollment_date DATE,
    grade_level VARCHAR(50)
);

CREATE TABLE instructor (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT NOT NULL,
    hire_date DATE,
    specialization VARCHAR(100)
);

CREATE TABLE contact_person (
    contact_person_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT NOT NULL,
    relationship_to_student VARCHAR(100) NOT NULL
);

-- Level 3: Tables Dependent on Level 2
CREATE TABLE student_contact_person (
    student_id INT NOT NULL,
    contact_person_id INT NOT NULL,
    relationship_type VARCHAR(100),
    PRIMARY KEY (student_id, contact_person_id)
);

CREATE TABLE sibling (
    student_id1 INT NOT NULL,
    student_id2 INT NOT NULL,
    PRIMARY KEY (student_id1, student_id2)
);

CREATE TABLE pricing_scheme (
    pricing_scheme_id INT AUTO_INCREMENT PRIMARY KEY,
    lesson_type VARCHAR(50) NOT NULL,
    level_id INT NOT NULL,
    price_per_lesson DECIMAL(10, 2) NOT NULL,
    effective_from DATE,
    effective_to DATE
);

CREATE TABLE lesson (
    lesson_id INT AUTO_INCREMENT PRIMARY KEY,
    level_id INT NOT NULL,
    instructor_id INT NOT NULL,
    pricing_scheme_id INT NOT NULL
);

CREATE TABLE student_lesson (
    student_id INT NOT NULL,
    lesson_id INT NOT NULL,
    PRIMARY KEY (student_id, lesson_id)
);

-- Level 4: Tables Dependent on Level 3
CREATE TABLE lesson_instrument (
    lesson_instrument_id INT AUTO_INCREMENT PRIMARY KEY,
    lesson_id INT NOT NULL,
    instrument_id INT NOT NULL
);

CREATE TABLE individual_lesson (
    lesson_id INT PRIMARY KEY,
    appointment_time TIME
);

CREATE TABLE group_lesson (
    lesson_id INT PRIMARY KEY,
    max_students INT,
    min_students INT
);

CREATE TABLE ensemble_lesson (
    lesson_id INT PRIMARY KEY,
    target_genre VARCHAR(100),
    max_students INT,
    min_students INT
);

-- Updated Booking Table to Remove Redundancy
CREATE TABLE booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    lesson_id INT NOT NULL,
    booking_date DATE NOT NULL,
    scheduled_date_time TIMESTAMP,
    duration INT,
    status VARCHAR(50) NOT NULL
);

CREATE TABLE rental (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    instrument_id INT NOT NULL,
    rental_start_date DATE NOT NULL,
    rental_end_date DATE,
    rental_duration INT GENERATED ALWAYS AS (TIMESTAMPDIFF(MONTH, rental_start_date, rental_end_date)) STORED,
    total_cost DECIMAL(10, 2) 
);

-- Alter tables to add constraints for relationships

-- person_phone
ALTER TABLE person_phone
ADD CONSTRAINT FK_person_phone_person FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE;

ALTER TABLE person_phone
ADD CONSTRAINT FK_person_phone_phone FOREIGN KEY (phone_id) REFERENCES phone(phone_id) ON DELETE CASCADE;

-- person_email
ALTER TABLE person_email
ADD CONSTRAINT FK_person_email_person FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE;

ALTER TABLE person_email
ADD CONSTRAINT FK_person_email_email FOREIGN KEY (email_id) REFERENCES email(email_id) ON DELETE CASCADE;

-- student
ALTER TABLE student
ADD CONSTRAINT FK_student_person FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE;

-- instructor
ALTER TABLE instructor
ADD CONSTRAINT FK_instructor_person FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE;

-- contact_person
ALTER TABLE contact_person
ADD CONSTRAINT FK_contact_person_person FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE;

-- student_contact_person
ALTER TABLE student_contact_person
ADD CONSTRAINT FK_student_contact_person_student FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE;

ALTER TABLE student_contact_person
ADD CONSTRAINT FK_student_contact_person_contact FOREIGN KEY (contact_person_id) REFERENCES contact_person(contact_person_id) ON DELETE CASCADE;

-- sibling
ALTER TABLE sibling
ADD CONSTRAINT FK_sibling_student1 FOREIGN KEY (student_id1) REFERENCES student(student_id) ON DELETE CASCADE;

ALTER TABLE sibling
ADD CONSTRAINT FK_sibling_student2 FOREIGN KEY (student_id2) REFERENCES student(student_id) ON DELETE CASCADE;

-- pricing_scheme
ALTER TABLE pricing_scheme
ADD CONSTRAINT FK_pricing_scheme_level FOREIGN KEY (level_id) REFERENCES student_level(level_id) ON DELETE CASCADE;

-- lesson
ALTER TABLE lesson
ADD CONSTRAINT FK_lesson_level FOREIGN KEY (level_id) REFERENCES student_level(level_id) ON DELETE CASCADE;

ALTER TABLE lesson
ADD CONSTRAINT FK_lesson_instructor FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id) ON DELETE CASCADE;

ALTER TABLE lesson
ADD CONSTRAINT FK_lesson_pricing_scheme FOREIGN KEY (pricing_scheme_id) REFERENCES pricing_scheme(pricing_scheme_id) ON DELETE CASCADE;

-- lesson_instrument
ALTER TABLE lesson_instrument
ADD CONSTRAINT FK_lesson_instrument_lesson FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE;

ALTER TABLE lesson_instrument
ADD CONSTRAINT FK_lesson_instrument_instrument FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id) ON DELETE CASCADE;

-- individual_lesson
ALTER TABLE individual_lesson
ADD CONSTRAINT FK_individual_lesson FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE;

-- group_lesson
ALTER TABLE group_lesson
ADD CONSTRAINT FK_group_lesson FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE;

-- ensemble_lesson
ALTER TABLE ensemble_lesson
ADD CONSTRAINT FK_ensemble_lesson FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE;

-- booking
ALTER TABLE booking
ADD CONSTRAINT FK_booking_student FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE;

ALTER TABLE booking
ADD CONSTRAINT FK_booking_lesson FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE;

-- rental
ALTER TABLE rental
ADD CONSTRAINT FK_rental_student FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE;

ALTER TABLE rental
ADD CONSTRAINT FK_rental_instrument FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id) ON DELETE CASCADE;

-- Foreign key for student_id in student_lesson
ALTER TABLE student_lesson
ADD CONSTRAINT FK_student_lesson_student
FOREIGN KEY (student_id)
REFERENCES student(student_id)
ON DELETE CASCADE;

-- Foreign key for lesson_id in student_lesson
ALTER TABLE student_lesson
ADD CONSTRAINT FK_student_lesson_lesson
FOREIGN KEY (lesson_id)
REFERENCES lesson(lesson_id)
ON DELETE CASCADE;

-- Primary Entity Tables
ALTER TABLE person AUTO_INCREMENT = 1001;
ALTER TABLE phone AUTO_INCREMENT = 2001;
ALTER TABLE email AUTO_INCREMENT = 3001;
ALTER TABLE student AUTO_INCREMENT = 4001;
ALTER TABLE instructor AUTO_INCREMENT = 5001;
ALTER TABLE contact_person AUTO_INCREMENT = 6001;
ALTER TABLE student_level AUTO_INCREMENT = 7001;
ALTER TABLE pricing_scheme AUTO_INCREMENT = 8001;
ALTER TABLE lesson AUTO_INCREMENT = 9001;
ALTER TABLE lesson_instrument AUTO_INCREMENT = 11001;
ALTER TABLE booking AUTO_INCREMENT = 12001;
ALTER TABLE rental AUTO_INCREMENT = 13001;
ALTER TABLE instrument AUTO_INCREMENT = 14001;
