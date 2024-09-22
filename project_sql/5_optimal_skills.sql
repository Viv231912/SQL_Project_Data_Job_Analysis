/*
 Answer: What are the most optimal skills to learn (it's in high demand and a high-paying skill)?
 - Identify skills in high demand and associated with high average salaries for Data Analyst roles
 - Concentrates on remote positions with specified salaries
 - Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), offering strategic insights for career development in data analysis
 */
-- Using CTE
WITH top_demanded_skill AS (
    SELECT skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
        JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
        JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND job_work_from_home = 'True'
        AND salary_year_avg != ''
    GROUP BY skills_dim.skill_id
),
average_salary AS (
    SELECT skills_job_dim.skill_id,
        AVG(CAST(salary_year_avg AS DECIMAL(10, 2))) AS avg_salary
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
        INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND salary_year_avg != ''
        AND job_work_from_home = 'True'
    GROUP BY skills_job_dim.skill_id
)
SELECT top_demanded_skill.skill_id,
    top_demanded_skill.skills,
    demand_count,
    avg_salary
FROM top_demanded_skill
    INNER JOIN average_salary ON average_salary.skill_id = top_demanded_skill.skill_id
WHERE demand_count > 10
ORDER BY avg_salary DESC,
    demand_count DESC
LIMIT 25 -- rewriting above query more concisely
SELECT skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    AVG(CAST(salary_year_avg AS DECIMAL(10, 2))) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg != ''
    AND job_work_from_home = 'True'
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY avg_salary DESC,
    demand_count DESC
LIMIT 25