
SELECT 
    acc.name AS account_name, 
    cand.name AS candidate_name, 
    skil.name AS skill_name, 
    inter.date AS interview_date,
    (
        SELECT job.position
        FROM jobs AS job
        WHERE job.id = app.job_id) AS job_title
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