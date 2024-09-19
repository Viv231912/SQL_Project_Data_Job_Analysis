-- Select jobs sorted by Months
SELECT job_id,
    EXTRACT(
        MONTH
        FROM job_posted_date
    ) AS MONTH
FROM job_postings_fact
LIMIT 5;
-- Aggregate count the jobs
SELECT COUNT(job_id) AS job_posted_count,
    EXTRACT(
        MONTH
        FROM job_posted_date
    ) AS MONTH
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY MONTH
ORDER BY job_posted_count DESC;
-- Average salary both yearly (salary_year_avg) and hourly(salary_hour_avg)
-- Where job postings that was posted after June 1, 2023 
-- Group by job schedule type
SELECT job_schedule_type AS type,
    AVG(salary_year_avg) AS yearly_salary,
    AVG(salary_hour_avg) AS hourly_salary,
    DATE(job_posted_date) AS date_time
FROM job_postings_fact
WHERE job_posted_date > '2023-06-01'
GROUP BY type,
    date_time;