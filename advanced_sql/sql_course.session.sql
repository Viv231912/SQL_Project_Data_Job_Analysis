CREATE TABLE job_applied(
    job_id INT,
    application_sent_data DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);
INSERT INTO job_applied (
        job_id,
        application_sent_data,
        custom_resume,
        resume_file_name,
        cover_letter_sent,
        cover_letter_file_name,
        status
    )
VALUES (
        1,
        '2024-02-01',
        true,
        'resume_01.pdf',
        true,
        'cover_letter_01.pdf',
        'submitted'
    ),
    (
        2,
        '2024-02-04',
        true,
        'resume_02.pdf',
        true,
        'cover_letter_02.pdf',
        'submitted'
    ),
    (
        3,
        '2024-02-07',
        true,
        'resume_03.pdf',
        false,
        'cover_letter_03.pdf',
        'submitted'
    ),
    (
        4,
        '2024-02-11',
        false,
        'resume_04.pdf',
        true,
        'cover_letter_04.pdf',
        'submitted'
    ),
    (
        5,
        '2024-02-13',
        false,
        'resume_05.pdf',
        true,
        'cover_letter_05.pdf',
        'rejected'
    );
SELECT *
FROM job_applied -- Add new column 
ALTER TABLE job_applied
ADD contact VARCHAR(50);
--Update column with new data
UPDATE job_applied
SET contact = 'Erlich Bachman'
WHERE job_id = 1;
UPDATE job_applied
SET contact = 'Janet Jackson'
WHERE job_id = 2;
UPDATE job_applied
SET contact = 'Lisa Simpson'
WHERE job_id = 3;
UPDATE job_applied
SET contact = 'Mario'
WHERE job_id = 4;
UPDATE job_applied
SET contact = 'Bart Simpson'
WHERE job_id = 5;
--Rename contact column
ALTER TABLE job_applied
    RENAME COLUMN contact TO contact_name;
--Update data type
ALTER TABLE job_applied
MODIFY COLUMN contact_name TEXT;
--Drop column
ALTER TABLE job_applied DROP COLUMN contact_name;
--Drop Table
DROP TABLE job_applied