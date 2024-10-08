/*
 Find job postings from the first quarter that have a salary greater than $70k
 - Combine job posting tables from the first quarter of 2023 (Jan-Mar)
 - Gets job postings with an average yearly salary > $70,000
 */
SELECT job_title_short,
    job_location,
    job_via,
    DATE(job_posted_date),
    salary_year_avg
FROM (
        SELECT *
        FROM january_jobs
        UNION ALL
        SELECT *
        FROM feburary_jobs
        UNION ALL
        SELECT *
        FROM march_jobs
    ) AS quarter1_job_postings
WHERE salary_year_avg > 70000
    AND job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC