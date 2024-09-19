/* ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
 Database Load Issues (follow if receiving permission denied when running SQL code below)
 
 NOTE: If you are having issues with permissions. And you get error: 
 
 'could not open file "[your file path]\job_postings_fact.csv" for reading: Permission denied.'
 
 1. Open pgAdmin
 2. In Object Explorer (left-hand pane), navigate to `sql_course` database
 3. Right-click `sql_course` and select `PSQL Tool`
 - This opens a terminal window to write the following code
 4. Get the absolute file path of your csv files
 1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
 5. Paste the following into `PSQL Tool`, (with the CORRECT file path)
 
 \copy company_dim FROM '[Insert File Path]/company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
 
 \copy skills_dim FROM '[Insert File Path]/skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
 
 \copy job_postings_fact FROM '[Insert File Path]/job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
 
 \copy skills_job_dim FROM '[Insert File Path]/skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
 
 */
-- NOTE: This has been updated from the video to fix issues with encoding
COPY company_dim
FROM 'C:\Program Files\PostgreSQL\16\data\Datasets\sql_course\company_dim.csv' WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ',',
        ENCODING 'UTF8'
    );
COPY skills_dim
FROM 'C:\Program Files\PostgreSQL\16\data\Datasets\sql_course\skills_dim.csv' WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ',',
        ENCODING 'UTF8'
    );
COPY job_postings_fact
FROM 'C:\Program Files\PostgreSQL\16\data\Datasets\sql_course\job_postings_fact.csv' WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ',',
        ENCODING 'UTF8'
    );
COPY skills_job_dim
FROM 'C:\Program Files\PostgreSQL\16\data\Datasets\sql_course\skills_job_dim.csv' WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ',',
        ENCODING 'UTF8'
    );
--Load CSV file for MySQL
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/csv_files/company_dim.csv' INTO TABLE company_dim FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/csv_files/job_postings_fact.csv' INTO TABLE job_postings_fact FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/csv_files/skills_dim.csv' INTO TABLE skills_dim FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/csv_files/skills_job_dim.csv' INTO TABLE skills_job_dim FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
SELECT *
FROM skills_job_dim
WHERE skill_id = 1 SHOW WARNINGS;
SHOW VARIABLES LIKE 'secure_file_priv';
--update columns with new data type for MYSQL
ALTER TABLE job_postings_fact
MODIFY COLUMN job_work_from_home VARCHAR(10);
ALTER TABLE job_postings_fact
MODIFY COLUMN job_no_degree_mention VARCHAR(10);
ALTER TABLE job_postings_fact
MODIFY COLUMN job_health_insurance VARCHAR(10);
ALTER TABLE job_postings_fact
MODIFY COLUMN salary_year_avg VARCHAR(20);
ALTER TABLE job_postings_fact
MODIFY COLUMN salary_hour_avg VARCHAR(20);
ALTER TABLE job_postings_fact
MODIFY COLUMN job_posted_date DATETIME;