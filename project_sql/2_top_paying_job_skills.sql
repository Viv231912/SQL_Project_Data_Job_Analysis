/*
 Question: What skills are required for the top-paying data analyst jobs?
 - Use the top 10 highest-paying Data Analyst jobs from previous query
 - Add the specific skills required for these roles
 - Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries.
 */
--CTE
WITH top_paying_jobs AS(
    SELECT job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg != ''
    ORDER BY CAST(salary_year_avg AS DECIMAL) DESC
    LIMIT 10
)
SELECT top_paying_jobs.*,
    skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
    /*
     Here's the breakdown of the most demanded skills for data analysis in 2023, based on job postings:
     SQL is leading, Python, r, go, crystal
     
     
     [
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "salary_year_avg": "255829.5",
     "company_name": "AT&T",
     "skills": "sql"
     },
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "salary_year_avg": "255829.5",
     "company_name": "AT&T",
     "skills": "python"
     },
     {
     "job_id": 552322,
     "job_title": "Associate Director- Data Insights",
     "salary_year_avg": "255829.5",
     "company_name": "AT&T",
     "skills": "r"
     },
     {
     "job_id": 99305,
     "job_title": "Data Analyst, Marketing",
     "salary_year_avg": "232423.0",
     "company_name": "Pinterest Job Advertisements",
     "skills": "sql"
     },
     {
     "job_id": 99305,
     "job_title": "Data Analyst, Marketing",
     "salary_year_avg": "232423.0",
     "company_name": "Pinterest Job Advertisements",
     "skills": "python"
     },
     {
     "job_id": 99305,
     "job_title": "Data Analyst, Marketing",
     "salary_year_avg": "232423.0",
     "company_name": "Pinterest Job Advertisements",
     "skills": "r"
     },
     {
     "job_id": 1021647,
     "job_title": "Data Analyst (Hybrid/Remote)",
     "salary_year_avg": "217000.0",
     "company_name": "Uclahealthcareers",
     "skills": "sql"
     },
     {
     "job_id": 1021647,
     "job_title": "Data Analyst (Hybrid/Remote)",
     "salary_year_avg": "217000.0",
     "company_name": "Uclahealthcareers",
     "skills": "crystal"
     },
     {
     "job_id": 168310,
     "job_title": "Principal Data Analyst (Remote)",
     "salary_year_avg": "205000.0",
     "company_name": "SmartAsset",
     "skills": "sql"
     },
     {
     "job_id": 168310,
     "job_title": "Principal Data Analyst (Remote)",
     "salary_year_avg": "205000.0",
     "company_name": "SmartAsset",
     "skills": "python"
     },
     {
     "job_id": 168310,
     "job_title": "Principal Data Analyst (Remote)",
     "salary_year_avg": "205000.0",
     "company_name": "SmartAsset",
     "skills": "go"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "salary_year_avg": "189309.0",
     "company_name": "Inclusively",
     "skills": "sql"
     },
     {
     "job_id": 731368,
     "job_title": "Director, Data Analyst - HYBRID",
     "salary_year_avg": "189309.0",
     "company_name": "Inclusively",
     "skills": "python"
     },
     {
     "job_id": 310660,
     "job_title": "Principal Data Analyst, AV Performance Analysis",
     "salary_year_avg": "189000.0",
     "company_name": "Motional",
     "skills": "sql"
     },
     {
     "job_id": 310660,
     "job_title": "Principal Data Analyst, AV Performance Analysis",
     "salary_year_avg": "189000.0",
     "company_name": "Motional",
     "skills": "python"
     },
     {
     "job_id": 310660,
     "job_title": "Principal Data Analyst, AV Performance Analysis",
     "salary_year_avg": "189000.0",
     "company_name": "Motional",
     "skills": "r"
     },
     {
     "job_id": 1749593,
     "job_title": "Principal Data Analyst",
     "salary_year_avg": "186000.0",
     "company_name": "SmartAsset",
     "skills": "sql"
     },
     {
     "job_id": 1749593,
     "job_title": "Principal Data Analyst",
     "salary_year_avg": "186000.0",
     "company_name": "SmartAsset",
     "skills": "python"
     },
     {
     "job_id": 1749593,
     "job_title": "Principal Data Analyst",
     "salary_year_avg": "186000.0",
     "company_name": "SmartAsset",
     "skills": "go"
     }
     ]
     */