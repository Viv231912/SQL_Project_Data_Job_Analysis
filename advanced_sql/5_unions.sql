SELECT *
FROM january_jobs;
SELECT *
FROM feburary_jobs;
SELECT *
FROM march_jobs;
-- Get jobs and companies from January
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