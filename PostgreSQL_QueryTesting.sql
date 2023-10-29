select * from hrdata;
select sum(employee_count) as Employee_Count from hrdata;
select sum(employee_count) from hrdata where education = 'High School';
select sum(employee_count) from hrdata where department = 'Sales';
select sum(employee_count) from hrdata where education_field = 'Medical';

select count(attrition) from hrdata where attrition = 'Yes' and department = 'R&D' and
education_field = 'Medical' and education = 'High School';

select round (((select count(attrition) from hrdata 
where attrition='Yes')/ sum(employee_count)) * 100,2) from hrdata;

select sum(employee_count) - (select count(attrition) from hrdata  
where attrition='Yes' and gender = 'Male') from hrdata where gender = 'Male';

select round(avg(age), 0) from hrdata;

select gender, count(attrition) as attrition_count from hrdata
where attrition='Yes' and education = 'High School'
group by gender
order by count(attrition) desc;

select department, count(attrition), round ((cast (count(attrition) as numeric) / 
(select count(attrition) from hrdata where attrition= 'Yes' and gender = 'Female')) * 100, 2) as pct from hrdata
where attrition='Yes' and gender = 'Female'
group by department 
order by count(attrition) desc;

SELECT age, sum (employee_count) AS employee_count FROM hrdata GROUP BY age order by age;

select education_field, count(attrition) as attrition_count from hrdata
where attrition='Yes'
group by education_field
order by count(attrition) desc;

select age_band, gender, count(attrition) as attrition, 
round((cast(count(attrition) as numeric) / (select count(attrition) from hrdata 
where attrition = 'Yes')) * 100,2) as pct
from hrdata
where attrition = 'Yes'
group by age_band, gender
order by age_band, gender desc;

CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT *
FROM crosstab(
  'SELECT job_role, job_satisfaction, sum(employee_count)
   FROM hrdata
   GROUP BY job_role, job_satisfaction
   ORDER BY job_role, job_satisfaction'
	) AS ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role;
 


