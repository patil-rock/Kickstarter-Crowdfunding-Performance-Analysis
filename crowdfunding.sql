SELECT state AS outcome,
COUNT(*) AS no_of_projects
FROM project
GROUP BY state
ORDER BY COUNT(*) DESC;

SELECT country AS location,
COUNT(*) AS no_of_projects
FROM project
GROUP BY country
ORDER BY COUNT(*) DESC; 

SELECT c.name AS category,
COUNT(*) AS no_of_projects
FROM project AS p
LEFT JOIN category AS c
ON p.category_id = c.id
GROUP BY c.name
ORDER BY COUNT(*) DESC; 

SELECT 
EXTRACT(YEAR FROM created_date::date) AS year,
EXTRACT(QUARTER FROM created_date::date) AS quarter,
EXTRACT(MONTH FROM created_date::date) AS month,
COUNT(*) AS no_of_projects
FROM project
GROUP BY 1,2,3
ORDER BY 1,2,3;

SELECT SUM(usd_pledged) AS Amount_raised_by_successful_projects
FROM project
WHERE state = 'successful';

SELECT SUM(backers_count) AS no_of_backers
FROM project
WHERE state = 'successful';

SELECT backers_count, id
FROM project
WHERE state = 'successful'
GROUP BY backers_count, id
ORDER BY backers_count DESC;

SELECT backers_count, id
FROM project
WHERE state = 'successful'
GROUP BY backers_count, id
ORDER BY backers_count DESC;

SELECT 
    ROUND(
        COUNT(*) FILTER (WHERE state = 'successful') * 100.0 / COUNT(*), 2
    ) AS success_percentage
FROM project;

SELECT 
    c.name AS category,
    COUNT(*) AS total_projects,
    COUNT(*) FILTER (WHERE state = 'successful') AS successful_projects,
    ROUND(
        COUNT(*) FILTER (WHERE state = 'successful') * 100.0 / COUNT(*), 2
    )                                                               AS success_percentage
FROM project AS p
LEFT JOIN category AS c
ON p.category_id = c.id
GROUP BY c.name
ORDER BY success_percentage DESC;

SELECT 
    EXTRACT(YEAR FROM created_date::date)           AS year,
    TO_CHAR(created_date::date, 'Month')      AS month,
    COUNT(*)                                         AS total_projects,
    COUNT(*) FILTER (WHERE state = 'successful')     AS successful_projects,
    ROUND(
        COUNT(*) FILTER (WHERE state = 'successful') * 100.0 / COUNT(*), 2
    )                                                AS success_percentage
FROM project
GROUP BY 1, 2, EXTRACT(MONTH FROM created_date::date)
ORDER BY 1, EXTRACT(MONTH FROM created_date::date);

SELECT 
    CASE 
        WHEN goal < 1000              THEN '1. Micro     (< $1K)'
        WHEN goal BETWEEN 1000 AND 9999   THEN '2. Small     ($1K - $9.9K)'
        WHEN goal BETWEEN 10000 AND 49999 THEN '3. Medium    ($10K - $49.9K)'
        WHEN goal BETWEEN 50000 AND 99999 THEN '4. Large     ($50K - $99.9K)'
        ELSE                               '5. Very Large (>= $100K)'
    END                                                          AS goal_range,
    COUNT(*)                                                     AS total_projects,
    COUNT(*) FILTER (WHERE state = 'successful')                 AS successful_projects,
    ROUND(
        COUNT(*) FILTER (WHERE state = 'successful') * 100.0 / COUNT(*), 2
    )                                                            AS success_percentage
FROM project
GROUP BY 1
ORDER BY 1;



