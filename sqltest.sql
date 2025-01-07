--ali kar mikone
SELECT      
    MONTHNAME(b.booking_date) AS Month,      
    COUNT(*) AS Total,      
    SUM(CASE WHEN ps.lesson_type = 'Individual' THEN 1 ELSE 0 END) AS Individual,     
    SUM(CASE WHEN ps.lesson_type = 'Group' THEN 1 ELSE 0 END) AS GroupLessons,     
    SUM(CASE WHEN ps.lesson_type = 'Ensemble' THEN 1 ELSE 0 END) AS Ensemble 
FROM 
    booking b 
JOIN 
    lesson l ON b.lesson_id = l.lesson_id 
JOIN 
    pricing_scheme ps ON l.pricing_scheme_id = ps.pricing_scheme_id 
WHERE 
    YEAR(b.booking_date) = 2024
GROUP BY 
    MONTH(b.booking_date), MONTHNAME(b.booking_date)
ORDER BY 
    MONTH(b.booking_date) 
LIMIT 1000;








SELECT 
    DAYNAME(b.scheduled_date_time) AS Day,
    el.target_genre AS Genre,
    CASE 
        WHEN (el.max_students - COUNT(b.booking_id)) = 0 THEN 'No Seats'
        WHEN (el.max_students - COUNT(b.booking_id)) <= 2 THEN '1 or 2 Seats'
        ELSE 'Many Seats'
    END AS No_of_Free_Seats
FROM ensemble_lesson el
LEFT JOIN booking b ON el.lesson_id = b.lesson_id
WHERE b.scheduled_date_time BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY el.lesson_id, Day, Genre, el.max_students
ORDER BY Genre, Day;

---khob kar mikone

SELECT 
    COALESCE(sibling_count, 0) AS No_of_Siblings,
    COUNT(s.student_id) AS No_of_Students
FROM student s
LEFT JOIN (
    SELECT 
        student_id1 AS student_id, 
        COUNT(student_id2) AS sibling_count
    FROM sibling
    GROUP BY student_id1
) AS sibling_counts ON s.student_id = sibling_counts.student_id
GROUP BY No_of_Siblings
ORDER BY No_of_Siblings;




EXPLAIN
SELECT
    MONTHNAME(b.booking_date) AS Month,
    COUNT(*) AS Total,
    SUM(CASE WHEN ps.lesson_type = 'Individual' THEN 1 ELSE 0 END) AS Individual,
    SUM(CASE WHEN ps.lesson_type = 'Group' THEN 1 ELSE 0 END) AS GroupLessons,
    SUM(CASE WHEN ps.lesson_type = 'Ensemble' THEN 1 ELSE 0 END) AS Ensemble
FROM
    booking b
JOIN
    lesson l ON b.lesson_id = l.lesson_id
JOIN
    pricing_scheme ps ON l.pricing_scheme_id = ps.pricing_scheme_id
WHERE
    YEAR(b.booking_date) = 2024
GROUP BY
    MONTH(b.booking_date), MONTHNAME(b.booking_date)
ORDER BY
    MONTH(b.booking_date);



---khob kar mikone
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
HAVING No_of_Lessons > 1
ORDER BY No_of_Lessons DESC;




SELECT 
    DAYNAME(b.scheduled_date_time) AS Day,
    el.target_genre AS Genre,
    CASE 
        WHEN (el.max_students - COUNT(b.booking_id)) = 0 THEN 'No Seats'
        WHEN (el.max_students - COUNT(b.booking_id)) <= 2 THEN '1 or 2 Seats'
        ELSE 'Many Seats'
    END AS No_of_Free_Seats
FROM ensemble_lesson el
LEFT JOIN booking b ON el.lesson_id = b.lesson_id
WHERE b.scheduled_date_time BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY el.lesson_id, Day, Genre, el.max_students
ORDER BY Genre, Day;







EXPLAIN SELECT 
    MONTHNAME(b.booking_date) AS Month,      
    COUNT(*) AS Total,      
    SUM(CASE WHEN ps.lesson_type = 'Individual' THEN 1 ELSE 0 END) AS Individual,     
    SUM(CASE WHEN ps.lesson_type = 'Group' THEN 1 ELSE 0 END) AS GroupLessons,     
    SUM(CASE WHEN ps.lesson_type = 'Ensemble' THEN 1 ELSE 0 END) AS Ensemble 
FROM 
    booking b 
JOIN 
    lesson l ON b.lesson_id = l.lesson_id 
JOIN 
    pricing_scheme ps ON l.pricing_scheme_id = ps.pricing_scheme_id 
WHERE 
    YEAR(b.booking_date) = 2024
GROUP BY 
    MONTH(b.booking_date), MONTHNAME(b.booking_date)
ORDER BY 
    MONTH(b.booking_date);



EXPLAIN FORMAT=JSON SELECT 
    MONTHNAME(b.booking_date) AS Month,      
    COUNT(*) AS Total,      
    SUM(CASE WHEN ps.lesson_type = 'Individual' THEN 1 ELSE 0 END) AS Individual,     
    SUM(CASE WHEN ps.lesson_type = 'Group' THEN 1 ELSE 0 END) AS GroupLessons,     
    SUM(CASE WHEN ps.lesson_type = 'Ensemble' THEN 1 ELSE 0 END) AS Ensemble 
FROM 
    booking b 
JOIN 
    lesson l ON b.lesson_id = l.lesson_id 
JOIN 
    pricing_scheme ps ON l.pricing_scheme_id = ps.pricing_scheme_id 
WHERE 
    YEAR(b.booking_date) = 2024
GROUP BY 
    MONTH(b.booking_date), MONTHNAME(b.booking_date)
ORDER BY 
    MONTH(b.booking_date);




EXPLAIN SELECT      
    MONTHNAME(b.booking_date) AS Month,      
    COUNT(*) AS Total,      
    SUM(CASE WHEN ps.lesson_type = 'Individual' THEN 1 ELSE 0 END) AS Individual,     
    SUM(CASE WHEN ps.lesson_type = 'Group' THEN 1 ELSE 0 END) AS GroupLessons,     
    SUM(CASE WHEN ps.lesson_type = 'Ensemble' THEN 1 ELSE 0 END) AS Ensemble 
FROM 
    booking b 
JOIN 
    lesson l ON b.lesson_id = l.lesson_id 
JOIN 
    pricing_scheme ps ON l.pricing_scheme_id = ps.pricing_scheme_id 
WHERE 
    YEAR(b.booking_date) = 2024
GROUP BY 
    MONTH(b.booking_date), MONTHNAME(b.booking_date)
ORDER BY 
    MONTH(b.booking_date);
