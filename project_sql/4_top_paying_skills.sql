/*
 Answer: What are the top skills based on salary?
 - Look at the average salary associated with each skill for Data Anaylst positions
 - Focuses on roles with specified salaries, regardless of location
 - Why? It reveals how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acqurie or improve
 */
SELECT skills,
    AVG(CAST(salary_year_avg AS DECIMAL(10, 2))) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg != '' --job_work_from_home = 'True'
GROUP BY skills
ORDER BY avg_salary
LIMIT 25 DESCRIBE job_postings_fact;
SELECT AVG(CAST(salary_year_avg AS DECIMAL(10, 2))) AS avg_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL;
SELECT skills,
    ROUND(AVG(CAST(salary_year_avg AS DECIMAL)), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg != ''
    AND job_work_from_home = 'True'
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25
    /*
     [
     {
     "skills": "swift",
     "avg_salary": "153750"
     },
     {
     "skills": "golang",
     "avg_salary": "145000"
     },
     {
     "skills": "shell",
     "avg_salary": "125000"
     },
     {
     "skills": "scala",
     "avg_salary": "117379"
     },
     {
     "skills": "go",
     "avg_salary": "116147"
     },
     {
     "skills": "crystal",
     "avg_salary": "114000"
     },
     {
     "skills": "c",
     "avg_salary": "109817"
     },
     {
     "skills": "r",
     "avg_salary": "103431"
     },
     {
     "skills": "python",
     "avg_salary": "102992"
     },
     {
     "skills": "nosql",
     "avg_salary": "102865"
     },
     {
     "skills": "javascript",
     "avg_salary": "102604"
     },
     {
     "skills": "sas",
     "avg_salary": "102161"
     },
     {
     "skills": "c++",
     "avg_salary": "101917"
     },
     {
     "skills": "t-sql",
     "avg_salary": "101214"
     },
     {
     "skills": "java",
     "avg_salary": "99881"
     },
     {
     "skills": "matlab",
     "avg_salary": "99000"
     },
     {
     "skills": "sql",
     "avg_salary": "98269"
     },
     {
     "skills": "rust",
     "avg_salary": "97500"
     },
     {
     "skills": "php",
     "avg_salary": "95000"
     },
     {
     "skills": "bash",
     "avg_salary": "93950"
     },
     {
     "skills": "pascal",
     "avg_salary": "92000"
     },
     {
     "skills": "powershell",
     "avg_salary": "90500"
     },
     {
     "skills": "html",
     "avg_salary": "90000"
     },
     {
     "skills": "vb.net",
     "avg_salary": "90000"
     },
     {
     "skills": "vba",
     "avg_salary": "88015"
     }
     ]
     */