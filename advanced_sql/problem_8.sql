/*
 Find job postings from the first quarter that have a salary greater than $70k
 - Combine job posting tables from the first quarter of 2023 (Jan-Mar)
 - Gets job postings with an average yearly salary > $70,000
 */
WITH job_posts_q1 AS(
    SELECT job_id,
        job_title_short,
        company_id,
        job_location,
        salary_year_avg
    FROM january_jobs
    UNION ALL
    SELECT job_id,
        job_title_short,
        company_id,
        job_location,
        salary_year_avg
    FROM feburary_jobs
    UNION ALL
    SELECT job_id,
        job_title_short,
        company_id,
        job_location,
        salary_year_avg
    FROM march_jobs
)
SELECT job_posts_q1.job_id,
    skills_to_job.skill_id,
    skills_dim.skills,
    job_posts_q1.salary_year_avg
FROM job_posts_q1
    INNER JOIN skills_job_dim AS skills_to_job ON skills_to_job.job_id = job_posts_q1.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_to_job.skill_id
WHERE salary_year_avg > 70000
    /*---------------------------------------------------*/
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