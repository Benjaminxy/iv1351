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

CREATE TABLE level (
    level_id INT AUTO_INCREMENT PRIMARY KEY,
    level_name VARCHAR(50) UNIQUE NOT NULL
);

-- Level 2: Tables Dependent on Level 1
CREATE TABLE person_phone (
    person_id INT NOT NULL,
    phone_id INT NOT NULL,
    PRIMARY KEY (person_id, phone_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE,
    FOREIGN KEY (phone_id) REFERENCES phone(phone_id) ON DELETE CASCADE
);

CREATE TABLE person_email (
    person_id INT NOT NULL,
    email_id INT NOT NULL,
    PRIMARY KEY (person_id, email_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE,
    FOREIGN KEY (email_id) REFERENCES email(email_id) ON DELETE CASCADE
);

CREATE TABLE student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT NOT NULL,
    enrollment_date DATE,
    grade_level VARCHAR(50),
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE
);

CREATE TABLE instructor (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT NOT NULL,
    hire_date DATE,
    specialization VARCHAR(100),
    salary DECIMAL(10, 2),
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE
);

CREATE TABLE contact_person (
    contact_person_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT NOT NULL,
    relationship_to_student VARCHAR(100) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE
);

-- Level 3: Tables Dependent on Level 2
CREATE TABLE student_contact_person (
    student_id INT NOT NULL,
    contact_person_id INT NOT NULL,
    relationship_type VARCHAR(100),
    PRIMARY KEY (student_id, contact_person_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (contact_person_id) REFERENCES contact_person(contact_person_id) ON DELETE CASCADE
);

CREATE TABLE sibling (
    student_id1 INT NOT NULL,
    student_id2 INT NOT NULL,
    PRIMARY KEY (student_id1, student_id2),
    FOREIGN KEY (student_id1) REFERENCES student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id2) REFERENCES student(student_id) ON DELETE CASCADE
);

CREATE TABLE pricing_scheme (
    pricing_scheme_id INT AUTO_INCREMENT PRIMARY KEY,
    lesson_type VARCHAR(50) NOT NULL,
    level_id INT NOT NULL,
    price_per_lesson DECIMAL(10, 2) NOT NULL,
    effective_from DATE,
    effective_to DATE,
    FOREIGN KEY (level_id) REFERENCES level(level_id) ON DELETE CASCADE
);

CREATE TABLE lesson (
    lesson_id INT AUTO_INCREMENT PRIMARY KEY,
    level_id INT NOT NULL,
    instructor_id INT NOT NULL,
    pricing_scheme_id INT NOT NULL,
    FOREIGN KEY (level_id) REFERENCES level(level_id) ON DELETE CASCADE,
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id) ON DELETE CASCADE,
    FOREIGN KEY (pricing_scheme_id) REFERENCES pricing_scheme(pricing_scheme_id) ON DELETE CASCADE
);

-- Level 4: Tables Dependent on Level 3
CREATE TABLE lesson_instrument (
    lesson_instrument_id INT AUTO_INCREMENT PRIMARY KEY,
    lesson_id INT NOT NULL,
    instrument_id INT NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE,
    FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id) ON DELETE CASCADE
);

CREATE TABLE individual_lesson (
    lesson_id INT PRIMARY KEY,
    appointment_time TIME,
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE
);

CREATE TABLE group_lesson (
    lesson_id INT PRIMARY KEY,
    max_students INT,
    min_students INT,
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE
);

CREATE TABLE ensemble_lesson (
    lesson_id INT PRIMARY KEY,
    target_genre VARCHAR(100),
    max_students INT,
    min_students INT,
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE
);

CREATE TABLE booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    lesson_id INT NOT NULL,
    lesson_type VARCHAR(50),
    booking_date DATE NOT NULL,
    scheduled_date_time TIMESTAMP,
    duration INT,
    status VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    level_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE,
    FOREIGN KEY (level_id) REFERENCES level(level_id) ON DELETE CASCADE
);

CREATE TABLE student_payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    payment_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    discount_amount DECIMAL(5, 2) DEFAULT 0,
    net_amount DECIMAL(10, 2) NOT NULL,
    payment_period VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE
);

CREATE TABLE student_payment_detail (
    payment_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_id INT NOT NULL,
    booking_id INT NOT NULL,
    lesson_fee DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (payment_id) REFERENCES student_payment(payment_id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE CASCADE
);

CREATE TABLE instructor_payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    instructor_id INT NOT NULL,
    payment_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    tax_withheld DECIMAL(5, 2) DEFAULT 0,
    net_amount DECIMAL(10, 2) NOT NULL,
    payment_period VARCHAR(50),
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id) ON DELETE CASCADE
);

CREATE TABLE instructor_payment_detail (
    payment_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_id INT NOT NULL,
    lesson_id INT NOT NULL,
    payment_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (payment_id) REFERENCES instructor_payment(payment_id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE
);

CREATE TABLE rental (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    instrument_id INT NOT NULL,
    rental_start_date DATE NOT NULL,
    rental_end_date DATE,
    monthly_fee DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id) ON DELETE CASCADE
);

CREATE TABLE rental_payment_detail (
    payment_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_id INT NOT NULL,
    rental_id INT NOT NULL,
    rental_fee DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (payment_id) REFERENCES student_payment(payment_id) ON DELETE CASCADE,
    FOREIGN KEY (rental_id) REFERENCES rental(rental_id) ON DELETE CASCADE
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
ADD CONSTRAINT FK_pricing_scheme_level FOREIGN KEY (level_id) REFERENCES level(level_id) ON DELETE CASCADE;

-- lesson
ALTER TABLE lesson
ADD CONSTRAINT FK_lesson_level FOREIGN KEY (level_id) REFERENCES level(level_id) ON DELETE CASCADE;

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

ALTER TABLE booking
ADD CONSTRAINT FK_booking_level FOREIGN KEY (level_id) REFERENCES level(level_id) ON DELETE CASCADE;

-- student_payment
ALTER TABLE student_payment
ADD CONSTRAINT FK_student_payment_student FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE;

-- student_payment_detail
ALTER TABLE student_payment_detail
ADD CONSTRAINT FK_student_payment_detail_payment FOREIGN KEY (payment_id) REFERENCES student_payment(payment_id) ON DELETE CASCADE;

ALTER TABLE student_payment_detail
ADD CONSTRAINT FK_student_payment_detail_booking FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE CASCADE;

-- instructor_payment
ALTER TABLE instructor_payment
ADD CONSTRAINT FK_instructor_payment_instructor FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id) ON DELETE CASCADE;

-- instructor_payment_detail
ALTER TABLE instructor_payment_detail
ADD CONSTRAINT FK_instructor_payment_detail_payment FOREIGN KEY (payment_id) REFERENCES instructor_payment(payment_id) ON DELETE CASCADE;

ALTER TABLE instructor_payment_detail
ADD CONSTRAINT FK_instructor_payment_detail_lesson FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE;

-- rental
ALTER TABLE rental
ADD CONSTRAINT FK_rental_student FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE;

ALTER TABLE rental
ADD CONSTRAINT FK_rental_instrument FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id) ON DELETE CASCADE;

-- rental_payment_detail
ALTER TABLE rental_payment_detail
ADD CONSTRAINT FK_rental_payment_detail_payment FOREIGN KEY (payment_id) REFERENCES student_payment(payment_id) ON DELETE CASCADE;

ALTER TABLE rental_payment_detail
ADD CONSTRAINT FK_rental_payment_detail_rental FOREIGN KEY (rental_id) REFERENCES rental(rental_id) ON DELETE CASCADE;




-- Set AUTO_INCREMENT values for all relevant tables
ALTER TABLE person AUTO_INCREMENT = 1001;
ALTER TABLE phone AUTO_INCREMENT = 2001;
ALTER TABLE email AUTO_INCREMENT = 3001;
ALTER TABLE student AUTO_INCREMENT = 4001;
ALTER TABLE instructor AUTO_INCREMENT = 5001;
ALTER TABLE contact_person AUTO_INCREMENT = 6001;
ALTER TABLE level AUTO_INCREMENT = 7001;
ALTER TABLE pricing_scheme AUTO_INCREMENT = 8001;
ALTER TABLE lesson AUTO_INCREMENT = 9001;
ALTER TABLE lesson_instrument AUTO_INCREMENT = 10001;
ALTER TABLE booking AUTO_INCREMENT = 11001;
ALTER TABLE student_payment AUTO_INCREMENT = 12001;
ALTER TABLE student_payment_detail AUTO_INCREMENT = 13001;
ALTER TABLE instructor_payment AUTO_INCREMENT = 14001;
ALTER TABLE instructor_payment_detail AUTO_INCREMENT = 15001;
ALTER TABLE rental AUTO_INCREMENT = 16001;
ALTER TABLE rental_payment_detail AUTO_INCREMENT = 17001;
ALTER TABLE instrument AUTO_INCREMENT = 18001;


