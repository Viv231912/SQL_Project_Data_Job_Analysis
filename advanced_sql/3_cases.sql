SELECT *
FROM job_postings_fact
WHERE salary_year_avg > 8000
    AND job_title_short = 'data analyst'
LIMIT 10;
-- Filter job posted date with January only
SELECT *
FROM job_postings_fact
WHERE EXTRACT(
        MONTH
        FROM job_posted_date
    ) = 1;
-- Create talbe
--Janurary
CREATE TABLE january_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(
        MONTH
        FROM job_posted_date
    ) = 1;
-- Feburary
CREATE TABLE feburary_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(
        MONTH
        FROM job_posted_date
    ) = 2;
-- March
CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(
        MONTH
        FROM job_posted_date
    ) = 3;
---------------------------------------------------
--Case statement
SELECT job_title_short,
    job_location
FROM job_postings_fact;
/*
 Label new column as follows:
 - 'Anywhere' jobs as 'Remote'
 - 'New York, NY' jobs 'Local'
 - Otherwise 'Onsite'
 */
SELECT job_title_short,
    job_location,
    Case
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact;
-- how many jobs are local, remote and onsite using group by, match any data analyst jobs
SELECT COUNT(job_id) AS number_of_jobs,
    Case
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category
Order BY number_of_jobs;
/*
 CASE WHEN
 CASE, WHEN, THEN, ELSE, END
 
 Categorise the salaries from each job posting. To see if it fits in desired salary range.
 1. Put salary into different buckets
 2. Define what's a high, standard, or low salary with own expectation
 3. Why? It is easy to determine which job postings are worth looking at based on salary. Bucketing is a commom practice when viewing categories
 4. Only want to look at data analyst roles
 5. Order from highest to lowest 
 
 */
SELECT COUNT(job_id) AS number_of_jobs,
    search_location AS job_location,
    CASE
        WHEN salary_year_avg <= 60000 THEN 'Low'
        WHEN salary_year_avg > 60000
        AND salary_year_avg <= 80000 THEN 'Standard'
        ELSE 'High'
    END AS salary_categories
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
    AND search_location = 'Australia'
GROUP BY salary_categories;
SELECT job_id,
    job_title_short AS title,
    search_location AS job_location,
    salary_year_avg AS yearly_salary,
    salary_hour_avg AS hourly_salary,
    job_posted_date AS posted_date,
    CASE
        WHEN salary_year_avg <= 60000 THEN 'Low'
        WHEN salary_year_avg > 60000
        AND salary_year_avg <= 80000 THEN 'Standard'
        ELSE 'High'
    END AS salary_categories
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
    AND search_location = 'Australia'
ORDER BY salary_categories,
    yearly_salary;