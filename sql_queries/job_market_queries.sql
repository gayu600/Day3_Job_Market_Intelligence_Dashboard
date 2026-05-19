CREATE DATABASE job_market_dashboard;
USE job_market_dashboard;
SHOW TABLES;

-- Total Job Postings --
SELECT COUNT(*) AS total_job_postings
FROM cleaned_job_market_2025;

-- Top 10 Job Roles --
SELECT job_title,
COUNT(*) AS job_count
FROM cleaned_job_market_2025
GROUP BY job_title
ORDER BY job_count DESC
LIMIT 10;

-- Top Hiring Locations --
SELECT location,
COUNT(*) AS job_count
FROM cleaned_job_market_2025
GROUP BY location
ORDER BY job_count DESC
LIMIT 10;

-- Seniority Level Distribution --
SELECT seniority_level,
COUNT(*) AS job_count
FROM cleaned_job_market_2025
GROUP BY seniority_level
ORDER BY job_count DESC;

-- Average Salary by Seniority --
SELECT seniority_level,
ROUND(AVG(salary_numeric), 2) AS avg_salary
FROM cleaned_job_market_2025
GROUP BY seniority_level
ORDER BY avg_salary DESC;

-- Top Hiring Companies --
SELECT company,
COUNT(*) AS job_count
FROM cleaned_job_market_2025
GROUP BY company
ORDER BY job_count DESC
LIMIT 10;

-- Top Industries Hiring --
SELECT industry,
COUNT(*) AS job_count
FROM cleaned_job_market_2025
GROUP BY industry
ORDER BY job_count DESC
LIMIT 10;

-- Recent Job Postings --
SELECT 
COUNT(*) AS recent_jobs
FROM cleaned_job_market_2025
WHERE days_ago <= 7;

-- Jobs Posted by Days Ago --
SELECT days_ago,
COUNT(*) AS job_count
FROM cleaned_job_market_2025
GROUP BY days_ago
ORDER BY days_ago;

-- Salary Distribution by Industry --
SELECT 
    industry,
    ROUND(AVG(salary_numeric), 2) AS avg_salary
FROM cleaned_job_market_2025
GROUP BY industry
ORDER BY avg_salary DESC
LIMIT 10;

-- Advanced SQL Queries 
-- High paying Jobs --
SELECT job_title,
company,location,
salary_numeric
FROM cleaned_job_market_2025
ORDER BY salary_numeric DESC
LIMIT 10;

-- Entry Level Jobs--
SELECT job_title,
    company,
    location,
    seniority_level
FROM cleaned_job_market_2025
WHERE seniority_level LIKE '%Entry%'
   OR seniority_level LIKE '%Junior%'
   OR seniority_level LIKE '%Associate%';

-- Python Skill Demand --
SELECT 
COUNT(*) AS python_skill_jobs
FROM cleaned_job_market_2025
WHERE skills LIKE '%Python%';

-- SQL Skill Demand --
SELECT 
COUNT(*) AS sql_skill_jobs
FROM cleaned_job_market_2025
WHERE skills LIKE '%SQL%';

-- Power BI Skill Demand --
SELECT 
COUNT(*) AS powerbi_skill_jobs
FROM cleaned_job_market_2025
WHERE skills LIKE '%Power BI%';


-- --------------Window Function Query--------------- --
-- Rank Jobs by Salary -- 
SELECT 
    job_title,
    company,
    location,
    salary_numeric,
RANK() OVER (ORDER BY salary_numeric DESC) AS salary_rank
FROM cleaned_job_market_2025
LIMIT 10;

-- --------------------CTE Query------------------- --
-- Top Industry Salary using CTE --
WITH industry_salary AS (
    SELECT 
        industry,
        ROUND(AVG(salary_numeric), 2) AS avg_salary
    FROM cleaned_job_market_2025
    GROUP BY industry
)
SELECT *
FROM industry_salary
ORDER BY avg_salary DESC
LIMIT 10;