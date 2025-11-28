# SQL Example – Job Café

**Project:** Job Café – job search and recruitment platform
**Query purpose:** Retrieve a list of candidates, their skills, associated accounts, and the job title for their application, **only for candidates who do not have scheduled interviews**.

## Technologies

- PostgreSQL
- SQL (SELECT, JOIN, LEFT JOIN, Subquery)
- Working with real recruitment platform data

## Query Description

This query joins multiple tables and uses a subquery in the `SELECT` clause:
- **accounts** – job seeker accounts
- **candidates** – candidates applying to jobs, linked to accounts
- **candidate_skills** – candidates' skills
- **skills** – skills reference table
- **applications** – candidates' job applications
- **jobs** – job vacancies, containing the position title, employer company, company location, job description, posting date, and other relevant details
- **interviews** – scheduled interviews

It returns the **account name, candidate name, skill, interview date**, and the **job title** using a subquery, filtering out candidates who do not yet have an interview scheduled.

## SQL Query

```sql
SELECT 
    acc.name AS account_name, 
    cand.name AS candidate_name, 
    skil.name AS skill_name, 
    inter.date AS interview_date,
    (
        SELECT job.position
        FROM jobs AS job
        WHERE job.id = app.job_id
    ) AS job_title
FROM accounts AS acc
INNER JOIN candidates AS cand
    ON cand.account_id = acc.id
INNER JOIN candidate_skills AS candskil
    ON candskil.candidate_id = cand.id
INNER JOIN skills AS skil
    ON skil.id = candskil.skill_id
INNER JOIN applications AS app
    ON app.candidate_id = cand.id
LEFT JOIN interviews AS inter
    ON inter.applications_id = app.id
WHERE inter.date IS NULL
   OR inter.date = '';

## What it demonstrates

- Practical use of **INNER JOIN** and **LEFT JOIN** to combine multiple tables
- Using a **subquery in the SELECT clause** to fetch related data (job title)
- Filtering rows using **WHERE** with NULL and empty string checks
- Applying **aliases** for readability