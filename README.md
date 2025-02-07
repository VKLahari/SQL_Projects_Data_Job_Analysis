# Introduction
📊 Dive into the data job ,market! Focusing on data analyst roles, 🔥in-demand skills and where high demand 📈 meets high salary in data analytics.

🔍 SQL queries? Check them out here: [SQL_Projects_Data_job_Analysis](/project_sql/)
# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top_paid and in_demand skills, streamlining others work to find optimal jobs.

Data hails from the [SQL Course](https://lukebarousse.com/sql). It is packed with insights on job titles, salaries, locations and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top_paying data analyst jobs?
2. What skills are required for these top_paying jobs ?
3. What skills are most in demand for data analysts ?
4. Which skills are associated with high salaries ?
5. What are the most optimal skills to learn ?
# Tools I used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:
- SQL: The backbone of my analysis, allowing me to query the database and unearth critical insights.
- PotgreSL: The chosen database management system, ideal for handling the job posting data.
- Visual Studio Code: My go-to for database management and executing SQL queries
- Git & GitHub: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.
# The Analysis
### 1. Top Paying Data Analyst Jobs and location, focusing on remote jobs. This query highlights the high paying opportunities in the field. 
```sql
SELECT 
job_id, 
job_title, 
job_location, 
job_schedule_type, 
salary_year_avg, 
job_posted_date, 
name AS company_name 
FROM 
job_postings_fact 
LEFT JOIN company_dim ON job_postings_fact. 
company_id = company_dim.company_id 
WHERE 
job_title_short = 'Data Analyst' AND 
job_location = 'Anywhere' AND 
salary_year_avg IS NOT NULL 
ORDER BY 
salary_year_avg DESC
LIMIT 10
```
### Quick Insights on Top-Paying Data Analyst Jobs
Remote & Hybrid Jobs Are Competitive

Several high-paying jobs are labeled as remote/hybrid, including UCLA Healthcare ($217K), SmartAsset ($205K), and Inclusively ($189K).
Companies are willing to pay top dollar for analysts even in remote settings, reflecting high demand for top talent regardless of location.

Extreme Salary Variation

The highest-paying data analyst role (Mantys - $650K) is significantly higher than others, indicating either an equity-heavy compensation or a senior-level role disguised as an analyst position.
Other high-paying roles fall between $184K - $336K, suggesting that Director and Principal roles command top salaries.
![Top paying Roles](assets\top_paying_jobs.png)
*Here's a bar chart showcasing the top-paying data analyst jobs in 2023, categorized by company. Chatgpt generated this graph for SQL query results*
### 2. Top paying in-demand skills for a particular data analyst job.
```sql
WITH top_paying_jobs AS(
SELECT  job_id,
    job_title,
    job_location,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id=company_dim.company_id
    WHERE
    job_title_short='Data Analyst' AND job_location='Anywhere' AND salary_year_avg IS NOT NULL 
    ORDER BY salary_year_avg DESC LIMIT 10
)
SELECT top_paying_jobs.*,
skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id ORDER BY salary_year_avg DESC
```
![Top_paying_skills](assets\Top_paying_skills.png)
*Insights from the Skills Data:*
*Most In-Demand Skills (Top 10 by Frequency)*
*SQL (8 mentions)*
*Python (7 mentions)*
*Tableau (6 mentions)*
*R (4 mentions)*
*Snowflake (3 mentions)*
*Pandas (3 mentions)*
*Excel (3 mentions)*
*Azure (2 mentions)*
*Bitbucket (2 mentions)*
*Go (2 mentions)*
*Key Takeaway: SQL and Python are the most sought-after skills, followed by Tableau and R, which are crucial for data visualization and statistical analysis.*
### 3. Top demanded skills and the number times they were mentioned by a job
```sql
SELECT 
skills,
COUNT(skills_job_dim.job_id) AS demand_count
FROM  job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
WHERE
job_title_short='Data Analyst' AND job_work_from_home=TRUE
GROUP BY
skills ORDER BY demand_count DESC LIMIT 5
```
| Rank | Skill    | Demand Count |
|------|---------|--------------|
| 1    | SQL     | 7,291        |
| 2    | Excel   | 4,611        |
| 3    | Python  | 4,330        |
| 4    | Tableau | 3,745        |
| 5    | Power BI| 2,609        |
*Top 5 demanded skills for data analyst jobs Key Insights from the Table:SQL is the most in-demand skill with 7,291 job listings, reinforcing its importance in data analysis and database management.Excel and Python remain highly sought-after, with Excel (4,611) still playing a vital role in business analytics, while Python (4,330) is crucial for automation and advanced data processing.*
### 4.Top_paying_skills on demand
```sql
SELECT 
skills,
ROUND(AVG(salary_year_avg),0)AS avg_salary
FROM  job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
WHERE
job_title_short='Data Analyst' AND
salary_year_avg IS NOT NULL 
AND job_work_from_home=TRUE
GROUP BY
skills ORDER BY avg_salary
DESC LIMIT 25
```
| Rank | Skill           | Average Salary (USD) |
|------|---------------|----------------------|
| 1    | PySpark        | $208,172            |
| 2    | Bitbucket      | $189,155            |
| 3    | Couchbase      | $160,515            |
| 4    | Watson         | $160,515            |
| 5    | DataRobot      | $155,486            |
| 6    | GitLab         | $154,500            |
| 7    | Swift          | $153,750            |
| 8    | Jupyter        | $152,777            |
| 9    | Pandas         | $151,821            |
| 10   | Elasticsearch  | $145,000            |
### Key Insights:
*Big Data & Cloud Skills Lead*

*PySpark ($208K), Couchbase ($160K), Databricks ($141K), and GCP ($122K) indicate that expertise in big data processing and cloud platforms is highly valuable.*
*Version Control & DevOps Matter*

*Bitbucket ($189K), GitLab ($154K), and Jenkins ($125K) suggest that data professionals with DevOps and CI/CD knowledge can earn higher salaries.*
### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
```sql
SELECT skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY avg_salary DESC,
         demand_count DESC
LIMIT 25
```
| Rank | Skill        | Demand Count | Average Salary (USD) |
|------|------------|--------------|----------------------|
| 1    | Python      | 236          | $101,397            |
| 2    | Tableau     | 230          | $99,288             |
| 3    | R           | 148          | $100,499            |
| 4    | SAS         | 63           | $98,902             |
| 5    | Looker      | 49           | $103,795            |
| 6    | Snowflake   | 37           | $112,948            |
| 7    | Oracle      | 37           | $104,534            |
| 8    | SQL Server  | 35           | $97,786             |
| 9    | Azure       | 34           | $111,225            |
| 10   | AWS         | 32           | $108,317            |

*Key Insights:*
*Programming & BI Tools Dominate*
*Python (236), Tableau (230), and R (148) lead in demand, showing that proficiency in programming and business intelligence tools is crucial for data analysts.*
*Cloud & Big Data Technologies Pay Well*
*Snowflake ($112K), Azure ($111K), AWS ($108K), and Oracle ($104K) highlight that cloud and big data expertise yield higher salaries in the industry.*



# What I learned
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:
 - **🧩 Complex Query Crafting:** astered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers. 
 
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions Like COUNT() and AVG () into my data-summarizing sidekicks. 
- **💡Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries. 
# Conclusions
### Insights
1. **Top-paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000! 
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it's a critical skill for earning a top salary. 
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers. 
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise. 
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.
;
### Closing Thoughts
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.
