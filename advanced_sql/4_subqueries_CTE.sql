--SubQueries CTE - Common Table Expression  
SELECT *
FROM (
        SELECT *
        FROM job_postings_fact
        WHERE MONTH(job_posted_date) = 1
    ) AS january_jobs;
--CTE define using with statement
WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE MONTH(job_posted_date) = 1
)
SELECT *
FROM january_jobs;
-- SubQueries for company no degree mentioned
SELECT company.company_id,
    company.name AS company_name,
    j.job_location AS company_location
FROM company_dim company
    JOIN job_postings_fact j ON company.company_id = j.company_id
WHERE company.company_id IN(
        SELECT j.company_id
        FROM job_postings_fact j
        WHERE job_no_degree_mention = 'True'
    )
SELECT company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN(
        SELECT company_id
        FROM job_postings_fact
        WHERE job_no_degree_mention = 'True'
    )
    /*
     Find the companies that have the most job openings.
     - Get the total number of job postings per company id
     - Return the total number of jobs with the company name
     */
SELECT company_id,
    COUNT(*)
FROM job_postings_fact
GROUP BY company_id;
-- Using WITH statement, temp table
WITH company_job_count AS (
    SELECT company_id,
        COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
    LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC -- SELECT *
    -- FROM company_job_count;
    --LEFT JOIN A (company_dim)
    -- INNER JOIN A&B
    /*
     Find the count of the number of remote job postings per skill
     - Display the top 5 skills by their demand in remote jobs
     - Include skill ID, and count of postings requiring the skill
     */
    WITH remote_job_skills AS(
        SELECT skill_id,
            COUNT(*) AS skill_count
        FROM skills_job_dim AS skills_to_job
            INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job._id
        WHERE job_postings.job_work_from_home = 'True'
            AND job_postings.job_title_short = 'Data Analyst'
        GROUP BY skill_id
    )
SELECT skills.skill_id,
    skills as skill_name,
    skill_count
FROM remote_job_skills
    INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 5;