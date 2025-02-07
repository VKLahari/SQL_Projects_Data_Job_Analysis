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
/*Big Data & Cloud Technologies Dominate

Skills like PySpark ($208K), Databricks ($141K), Kubernetes ($132K), GCP ($122K), and Airflow ($126K) highlight the demand for cloud and big data processing tools.
These skills are essential for handling large-scale data pipelines and distributed computing.
Machine Learning & Data Science Are Highly Rewarded

Pandas ($151K), Scikit-learn ($125K), Numpy ($143K), Jupyter ($152K) reflect strong salaries for data science and ML-related tools.
Employers are valuing expertise in ML frameworks and data manipulation libraries.
DevOps & Version Control Are Gaining Value

Bitbucket ($189K), GitLab ($154K), Jenkins ($125K) indicate that data analysts with DevOps and version control experience earn higher salaries.
Integration of CI/CD, automation, and collaboration tools is becoming essential for modern data workflows.*/