SELECT 
    MONTH(booking_date) AS Month, 
    COUNT(*) AS Total, 
    SUM(CASE WHEN lesson_type = 'Individual' THEN 1 ELSE 0 END) AS Individual,
    SUM(CASE WHEN lesson_type = 'Group' THEN 1 ELSE 0 END) AS Groupss,
    SUM(CASE WHEN lesson_type = 'Ensemble' THEN 1 ELSE 0 END) AS Ensemble
FROM booking
WHERE YEAR(booking_date) = 2024
GROUP BY MONTH(booking_date);


SELECT 
    CASE 
        WHEN sibling_count IS NULL THEN 0 
        ELSE sibling_count 
    END AS No_of_Siblings, 
    COUNT(student_id1) AS No_of_Students
FROM (
    SELECT student_id1, COUNT(student_id2) AS sibling_count
    FROM sibling
    GROUP BY student_id1
) AS sibling_counts
GROUP BY No_of_Siblings;




SELECT 
    instructor.instructor_id, 
    person.first_name, 
    person.last_name, 
    COUNT(lesson.lesson_id) AS No_of_Lessons
FROM instructor
JOIN person ON instructor.person_id = person.person_id
JOIN lesson ON instructor.instructor_id = lesson.instructor_id
JOIN booking ON lesson.lesson_id = booking.lesson_id
WHERE MONTH(booking_date) = MONTH(CURRENT_DATE())
GROUP BY instructor.instructor_id, person.first_name, person.last_name
HAVING No_of_Lessons > 1
ORDER BY No_of_Lessons DESC;



CREATE VIEW historical_lessons AS
SELECT 
    student.student_id,
    person.first_name AS student_name,
    lesson.price AS lesson_price,
    booking.booking_date
FROM booking
JOIN student ON booking.student_id = student.student_id
JOIN person ON student.person_id = person.person_id
JOIN lesson ON booking.lesson_id = lesson.lesson_id;
select * from  historical_lessons ;










SELECT 
    MONTH(booking_date) AS Month,
    COUNT(*) AS Total,
    SUM(CASE WHEN lesson_type = 'Individual' THEN 1 ELSE 0 END) AS Individual,
    SUM(CASE WHEN lesson_type = 'Group' THEN 1 ELSE 0 END) AS Group_Lessons,
    SUM(CASE WHEN lesson_type = 'Ensemble' THEN 1 ELSE 0 END) AS Ensemble
FROM booking
WHERE YEAR(booking_date) = 2024 -- Specify the year
GROUP BY MONTH(booking_date)
ORDER BY MONTH(booking_date);



SELECT 
    CASE 
        WHEN sibling_count IS NULL THEN 0 
        ELSE sibling_count 
    END AS No_of_Siblings,
    COUNT(student_id1) AS No_of_Students
FROM (
    SELECT 
        student_id1, 
        COUNT(student_id2) AS sibling_count
    FROM sibling
    GROUP BY student_id1
) AS sibling_counts
GROUP BY No_of_Siblings;


SELECT 
    i.instructor_id, 
    p.first_name, 
    p.last_name, 
    COUNT(b.lesson_id) AS No_of_Lessons
FROM instructor i
JOIN person p ON i.person_id = p.person_id
JOIN lesson l ON i.instructor_id = l.instructor_id
JOIN booking b ON l.lesson_id = b.lesson_id
WHERE MONTH(b.booking_date) = MONTH(CURRENT_DATE())
GROUP BY i.instructor_id, p.first_name, p.last_name
HAVING No_of_Lessons > 1 -- Adjust this number as needed
ORDER BY No_of_Lessons DESC;




SELECT 
    DAYNAME(b.scheduled_date_time) AS Day,
    el.target_genre AS Genre,
    CASE 
        WHEN (el.max_students - COUNT(b.booking_id)) = 1 THEN 'No Seats'
        WHEN (el.max_students - COUNT(b.booking_id)) <= 5 THEN 'Not Too Many Seats'
        ELSE 'Many Seats'
    END AS No_of_Free_Seats
FROM ensemble_lesson el
LEFT JOIN booking b ON el.lesson_id = b.lesson_id
WHERE b.scheduled_date_time BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY el.lesson_id, Day, Genre, el.max_students
ORDER BY Day, Genre;



SELECT 
    DAYNAME(b.scheduled_date_time) AS Day,
    el.target_genre AS Genre,
    CASE 
        WHEN (el.max_students - COUNT(b.booking_id)) = 0 THEN 'No Seats'
        WHEN (el.max_students - COUNT(b.booking_id)) <= 2 THEN '1 or 2 Seats'
        ELSE 'Many Seats'
    END AS No_of_Free_Seats
FROM booking b
JOIN ensemble_lesson el ON b.lesson_id = el.lesson_id
WHERE b.scheduled_date_time BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), INTERVAL 10 DAY)
GROUP BY el.lesson_id, Day, Genre, el.max_students
ORDER BY Genre, Day;





SELECT 
    MONTH(booking_date) AS Month,
    COUNT(*) AS Total,
    SUM(CASE WHEN lesson_type = 'Individual' THEN 1 ELSE 0 END) AS Individual,
    SUM(CASE WHEN lesson_type = 'Group' THEN 1 ELSE 0 END) AS GroupLessons,
    SUM(CASE WHEN lesson_type = 'Ensemble' THEN 1 ELSE 0 END) AS Ensemble
FROM booking
WHERE YEAR(booking_date) = 2024
GROUP BY MONTH(booking_date);



SELECT 
    i.instructor_id,
    p.first_name,
    p.last_name,
    COUNT(l.lesson_id) AS No_of_Lessons
FROM instructor i
JOIN person p ON i.person_id = p.person_id
JOIN lesson l ON i.instructor_id = l.instructor_id
JOIN booking b ON l.lesson_id = b.lesson_id
WHERE MONTH(b.booking_date) = MONTH(CURRENT_DATE())
GROUP BY i.instructor_id
HAVING COUNT(l.lesson_id) > 2
ORDER BY No_of_Lessons DESC;



SELECT 
    sibling_count AS No_of_Siblings,
    COUNT(student_id1) AS No_of_Students
FROM (
    SELECT 
        student_id1,
        COUNT(student_id2) AS sibling_count
    FROM sibling
    GROUP BY student_id1
) AS sibling_counts
GROUP BY No_of_Siblings;


SELECT 
    DAYNAME(b.scheduled_date_time) AS Day,
    el.target_genre AS Genre,
    CASE 
        WHEN (el.max_students - COUNT(b.booking_id)) = 0 THEN 'No Seats'
        WHEN (el.max_students - COUNT(b.booking_id)) <= 2 THEN '1 or 2 Seats'
        ELSE 'Many Seats'
    END AS No_of_Free_Seats
FROM booking b
JOIN ensemble_lesson el ON b.lesson_id = el.lesson_id
WHERE b.scheduled_date_time BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY el.lesson_id, Day, Genre, el.max_students;


