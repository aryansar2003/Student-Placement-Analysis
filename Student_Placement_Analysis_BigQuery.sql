select * 
from  `cool-component-515108-h8.student_placement_analysis.student_placement` 
limit 10 ;
select count(*)
from  `cool-component-515108-h8.student_placement_analysis.student_placement` ;

-- What is the overall placement rate?
  
 SELECT
    sum(CASE WHEN Placement_Status = 'Placed' THEN 1 else 0 END) * 100.0
    / COUNT(*) AS placement_rate
FROM `cool-component-515108-h8.student_placement_analysis.student_placement`;	

-- How many students are not placed?
select count(*) as Unplaced_Students
from `cool-component-515108-h8.student_placement_analysis.student_placement`
where Placement_Status = "Not Placed";

-- How many students are  placed?
select count(*) as Placed_Students
from `cool-component-515108-h8.student_placement_analysis.student_placement`
where Placement_Status = "Placed";

-- What is the placement rate by Gender?
select gender, 
 sum(case when Placement_Status = 'Placed' THEN 1 else 0 END)*100 /count(*) as placement_status
 from `cool-component-515108-h8.student_placement_analysis.student_placement`
 group by gender ;
 
 -- What is the placement rate by Degree?
select degree , 
sum(case when PLacement_Status ="Placed" then 1 else 0 end )*100 /count(*) as status_by_degree
from `cool-component-515108-h8.student_placement_analysis.student_placement`
group by Degree ;
-- What is the placement rate by Branch?
select  Branch ,
sum(case when PLacement_Status ="Placed" then 1 else 0 end )*100 /count(*) as status_by_branch 
from `cool-component-515108-h8.student_placement_analysis.student_placement`
group by Branch ;

-- Which Branch has the highest and lowest placement rate?
select  Branch ,
sum(case when PLacement_Status ="Placed" then 1 else 0 end )*100 /count(*) as status_by_branch 
from `cool-component-515108-h8.student_placement_analysis.student_placement`
group by Branch 
order by status_by_branch desc
limit 1;

select  Branch ,
sum(case when PLacement_Status ="Placed" then 1 else 0 end )*100 /count(*) as status_by_branch 
from `cool-component-515108-h8.student_placement_analysis.student_placement`
group by Branch 
order by status_by_branch 
limit 1;

-- What is the average CGPA of placed students vs unplaced students?
select Placement_Status , avg(CGPA) avg_cgpa
from `cool-component-515108-h8.student_placement_analysis.student_placement`
group by Placement_Status ;

-- Does placement rate increase as CGPA increases?
with cgpa_bands as (
select * , CASE
               WHEN CGPA < 6 THEN 'Below 6'
               WHEN CGPA >= 6 AND CGPA < 7 THEN '6-7'
               WHEN CGPA >= 7 AND CGPA < 8 THEN '7-8'
               WHEN CGPA >= 8 THEN 'Above 8'
           END AS bands
    FROM `cool-component-515108-h8.student_placement_analysis.student_placement` )
    select bands , count( case when PLacement_Status ="Placed" then 1 end )*100.0  /count(*) as placement_status
    from cgpa_bands
   group by bands 
   ;
   -- Which CGPA band has the highest placement rate?
   with band_rates as (
select * , CASE
               WHEN CGPA < 6 THEN 'Below 6'
               WHEN CGPA >= 6 AND CGPA < 7 THEN '6-7'
               WHEN CGPA >= 7 AND CGPA < 8 THEN '7-8'
               WHEN CGPA >= 8 THEN 'Above 8'
           END AS bands
    FROM `cool-component-515108-h8.student_placement_analysis.student_placement` )
    select bands , count( case when PLacement_Status ="Placed" then 1 end )*100.0  /count(*) as placement_status
    from band_rates
   group by bands 
   order by placement_status desc 
   limit 1;
   
   -- What is the average number of internships for placed vs unplaced students?
   select Placement_Status , avg(Internships)
   from `cool-component-515108-h8.student_placement_analysis.student_placement`
   group by Placement_Status ;
   
   -- Does placement rate improve with more internships?
 SELECT Internships ,
    sum(CASE WHEN Placement_Status = 'Placed' THEN 1 else 0 END) * 100.0
    / COUNT(*) AS placement_rate
FROM `cool-component-515108-h8.student_placement_analysis.student_placement`
group by Internships ;

-- Which internship count has the highest placement rate?
 SELECT Internships ,
    sum(CASE WHEN Placement_Status = 'Placed' THEN 1 else 0 END) * 100.0
    / COUNT(*) AS placement_rate
FROM `cool-component-515108-h8.student_placement_analysis.student_placement`
group by Internships
order by placement_rate desc
limit 1 ;

-- What is the average number of projects for placed vs unplaced students?
select Placement_Status,  avg(Projects) as avg_projects
from `cool-component-515108-h8.student_placement_analysis.student_placement`
group by Placement_Status ;

-- Does placement rate increase as project count increases?
 SELECT Projects ,
    sum(CASE WHEN Placement_Status = 'Placed' THEN 1 else 0 END) * 100.0
    / COUNT(*) AS placement_rate
FROM `cool-component-515108-h8.student_placement_analysis.student_placement`
group by Projects ;

-- What is the average Coding Skills score for placed vs unplaced students?
select Placement_status , avg(Coding_Skills) as avg_coding_skills 
FROM `cool-component-515108-h8.student_placement_analysis.student_placement`
group by Placement_status ;

-- Average Aptitude Score by placement status
select Placement_status , avg(Aptitude_Test_Score) as avg_Aptitude
FROM `cool-component-515108-h8.student_placement_analysis.student_placement`
group by Placement_status ;

-- Average Communication Skills by placement status
 select Placement_status , avg(Communication_skills) as avg_communication
FROM `cool-component-515108-h8.student_placement_analysis.student_placement`
group by Placement_status ;  

-- Rank the three skills by difference between placed and unplaced students.
WITH skill_analysis as (
select 'Coding' as skill ,
avg(case when Placement_Status = "Placed" then Coding_skills end) as placed_avg ,
avg(case when Placement_Status = "Not Placed" then Coding_skills end) as unplaced_avg 
from `cool-component-515108-h8.student_placement_analysis.student_placement` 
 union all 
select 'Aptitude ' as skill ,
avg(case when Placement_Status = "Placed" then Aptitude_Test_Score end) as placed_avg ,
avg(case when Placement_Status = "Not Placed" then Aptitude_Test_Score  end) as unplaced_avg 
from `cool-component-515108-h8.student_placement_analysis.student_placement` 
 union all
select 'Communication' as skill ,
avg(case when Placement_Status = "Placed" then Communication_Skills end) as placed_avg ,
avg(case when Placement_Status = "Not Placed" then Communication_Skills end) as unplaced_avg 
from `cool-component-515108-h8.student_placement_analysis.student_placement` ) 
select skill , placed_avg , unplaced_avg , placed_avg - unplaced_avg as diff ,  
RANK() OVER (ORDER BY placed_avg - unplaced_avg DESC) AS skill_rank
from skill_analysis;

-- 	Which Branch has the highest number of unplaced students?
select Branch , count(Placement_Status) as unplaced_students , dense_rank() over( order by  count(Placement_Status) desc ) as ranking
from `cool-component-515108-h8.student_placement_analysis.student_placement`
where Placement_Status = "Not Placed"
group by  Branch ;

-- Which Degree has the highest number of unplaced students?
select Degree , count(Placement_Status) as unplaced_students , dense_rank() over( order by  count(Placement_Status) desc ) as ranking
from `cool-component-515108-h8.student_placement_analysis.student_placement`
where Placement_Status = "Not Placed"
group by  Degree ;

-- Placement rate by backlog count.
select Backlogs ,sum(case when Placement_Status = "Placed" then 1 else 0 end)*100.0 /count(*) as  placement_rate 
FROM `cool-component-515108-h8.student_placement_analysis.student_placement`
group by Backlogs ;	

-- Which backlog count has the worst (lowest) placement rate?
select Backlogs ,sum(case when Placement_Status = "Placed" then 1 else 0 end)*100.0 /count(*) as  placement_rate 
FROM `cool-component-515108-h8.student_placement_analysis.student_placement`
group by Backlogs  
order by placement_rate
limit 1 ;

-- Which combination of CGPA Band and Backlog Count has the lowest placement rate?
with bands as(
select * , case 
            when CGPA < 6 then 'Below 6'
			when CGPA >= 6 and CGPA < 7 then '6-7'
            when CGPA >= 7 and CGPA < 8 then '7-8'
             when CGPA >=8 then 'Above 8' end as CGPA_bands
from `cool-component-515108-h8.student_placement_analysis.student_placement` 
)
select  Backlogs , CGPA_bands   , sum(case when Placement_Status = "Placed" then 1 else 0 end)*100.0 /count(*) as  placement_rate 
FROM bands
group by Backlogs , CGPA_bands   
order by placement_rate
limit 1 ;

-- Rank students within each Branch based on CGPA.
select Student_ID , Branch , CGPA , dense_rank() over( partition by Branch order by CGPA desc) as rank_
from `cool-component-515108-h8.student_placement_analysis.student_placement` ;  

-- Find the Top 3 students in every Branch.
with ranking as (
select Student_ID , Branch , CGPA , ROW_NUMBER()over( partition by Branch order by CGPA desc) as rank_
from `cool-component-515108-h8.student_placement_analysis.student_placement` )
select * from ranking 
where rank_ <4 ;

-- Find students whose CGPA is above the average CGPA of their own branch.
with ranked as (
select * , avg(CGPA) over( partition by Branch) as avg_branch
from `cool-component-515108-h8.student_placement_analysis.student_placement` ) 
select Student_ID , Branch, CGPA ,avg_branch
from ranked 
where CGPA >avg_branch ;

-- Show each student's CGPA along with the average CGPA of their Branch and indicate whether they are Above Average or Below Average.
with ranked as (
select * , avg(CGPA) over( partition by Branch) as avg_branch
from `cool-component-515108-h8.student_placement_analysis.student_placement` ) 
select Student_ID , Branch, CGPA , round(avg_branch ,2) , 
case when CGPA > avg_branch then "Above Average" 
     when CGPA < avg_branch then "Below Average" 
     ELSE 'Average' end as Category
from ranked 
;
-- Show every student's deviation from their branch average.
with branch_avg as ( 
select student_ID , Branch , CGPA , avg(CGPA) over( partition by Branch) as avg_branch
from `cool-component-515108-h8.student_placement_analysis.student_placement` ) 
select student_ID , Branch ,CGPA , ROUND(avg_branch,2)  , round(CGPA - avg_branch ,2) as Difference
from branch_avg ;

-- Find the student(s) with the highest CGPA in each Branch.
WITH ranking AS (
    SELECT Student_ID, Branch, CGPA,
           ROW_NUMBER() OVER (PARTITION BY Branch ORDER BY CGPA DESC) AS rank_
    FROM `cool-component-515108-h8.student_placement_analysis.student_placement`
)
SELECT Student_ID, Branch ,CGPA
FROM ranking
WHERE rank_ = 1;

-- Executive KPI Summary
select  round(sum(CASE WHEN Placement_Status = 'Placed' THEN 1 else 0 END) * 100.0
    / COUNT(*) ,2) AS Placement_rate , count(Student_ID) as Total_Students , 
    SUM(CASE WHEN Placement_Status = 'Placed' THEN 1 ELSE 0 END) as Placed_Students ,
    SUM(CASE WHEN Placement_Status = 'Not Placed' THEN 1 ELSE 0 END) Unplaced_Students , 
    round(avg(CGPA),2) as Avg_CGPA , round(avg(Internships),2) as Avg_Internships , round(avg(Projects),2) as Avg_Projects , 
    round(avg(Coding_Skills),2) as Avg_Coding_Skills
    from `cool-component-515108-h8.student_placement_analysis.student_placement` 
;
-- Branch Performance Summary

select Branch ,  round(sum(CASE WHEN Placement_Status = 'Placed' THEN 1 else 0 END) * 100.0 / COUNT(*) ,2) AS Placement_rate ,
round(avg(CGPA),2) as Avg_CGPA , round(avg(Coding_Skills),2) as Avg_Coding_Skills , round(avg(Internships),2) as Avg_Internships 
, round(avg(Projects),2) as Avg_Projects 
  from `cool-component-515108-h8.student_placement_analysis.student_placement` 
  group by Branch ;
    
-- Degree Performance Summary
select Degree ,  round(sum(CASE WHEN Placement_Status = 'Placed' THEN 1 else 0 END) * 100.0 / COUNT(*) ,2) AS Placement_rate ,
round(avg(CGPA),2) as Avg_CGPA , round(avg(Coding_Skills),2) as Avg_Coding_Skills , round(avg(Internships),2) as Avg_Internships 
, round(avg(Projects),2) as Avg_Projects 
  from `cool-component-515108-h8.student_placement_analysis.student_placement` 
  group by Degree ;
  
-- Student Risk Categories
with category as
(select Student_ID , case WHEN CGPA < 6 THEN 2 ELSE 0 END +
       case WHEN Backlogs>=3 THEN 2 ELSE 0 END +
       case WHEN Coding_Skills < 5 THEN 1 ELSE 0 END +
       case WHEN Communication_Skills < 5 THEN 1 ELSE 0 END +
       case WHEN Aptitude_Test_Score < 60 THEN 1 ELSE 0 END +
        case WHEN Internships =0 THEN 1 ELSE 0 END as risk_score
        from `cool-component-515108-h8.student_placement_analysis.student_placement`
        )
select Student_ID , case when risk_score = 0 then 'Low Risk'
						when risk_score between 1 and 3 then 'Medium Risk'
                        else 'High Risk' end as Risk_categories
	   from category ;
       
-- What is the placement rate for each Risk Category?
with student_risk as
(select Student_ID , case WHEN CGPA < 6 THEN 2 ELSE 0 END +
       case WHEN Backlogs>=3 THEN 2 ELSE 0 END +
       case WHEN Coding_Skills < 5 THEN 1 ELSE 0 END +
       case WHEN Communication_Skills < 5 THEN 1 ELSE 0 END +
       case WHEN Aptitude_Test_Score < 60 THEN 1 ELSE 0 END +
        case WHEN Internships =0 THEN 1 ELSE 0 END as risk_score
        from `cool-component-515108-h8.student_placement_analysis.student_placement`
       
        ) ,
 categories as (select Student_ID , risk_score , case when risk_score = 0 then 'Low Risk'
						when risk_score between 1 and 3 then 'Medium Risk'
                        else 'High Risk' end as Risk_categories
	   from student_risk )

-- What is the placement rate for each Risk Category?
 select Risk_categories ,sum(CASE WHEN Placement_Status = 'Placed' THEN 1 else 0 END) * 100.0
    / COUNT(*) AS placement_rate
from categories c left join `cool-component-515108-h8.student_placement_analysis.student_placement` sd on
c.Student_ID =sd.Student_ID
group by Risk_categories ;


-- What are the characteristics of students who get placed?
 select 
round(avg(CGPA),2) as Avg_CGPA , round(avg(Coding_Skills),2) as Avg_Coding_Skills , round(avg(Internships),2) as Avg_Internships 
, round(avg(Projects),2) as Avg_Projects , round(avg(Communication_Skills),2) as Avg_Communication_Skills , 
round(avg(Aptitude_Test_Score),2) as Avg_Aptitude
  from `cool-component-515108-h8.student_placement_analysis.student_placement` 
  where Placement_status = 'Placed' ;
  
  -- What are the characteristics of students who do not get placed?
 select 
round(avg(CGPA),2) as Avg_CGPA , round(avg(Coding_Skills),2) as Avg_Coding_Skills , round(avg(Internships),2) as Avg_Internships 
, round(avg(Projects),2) as Avg_Projects , round(avg(Communication_Skills),2) as Avg_Communication_Skills , 
round(avg(Aptitude_Test_Score),2) as Avg_Aptitude
  from `cool-component-515108-h8.student_placement_analysis.student_placement` 
  where Placement_status = 'Not Placed';
  
  -- Branch Recommendation
  with placement as (select Branch , sum(CASE WHEN Placement_Status = 'Placed' THEN 1 else 0 END) * 100.0 / COUNT(*) AS Placement_rate 
  from `cool-component-515108-h8.student_placement_analysis.student_placement`
  group by Branch )
  select Branch , ROUND(Placement_rate,2) AS Placement_rate , case when Placement_rate >= 40 then 'Excellent' 
                                         when Placement_rate between 35 and 40 then 'Good'
                                         when Placement_rate between 30 and 35 then 'Needs Improvement'
                                         else 'Critical Attention' end as Recommendation
	from placement 
    
    order by Placement_rate desc ;
