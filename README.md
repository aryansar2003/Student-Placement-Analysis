# Student Placement Analysis

Analysis of 45,000 student records using SQL, Python and Power BI, to see which factors affect whether a student gets placed.

## Dataset

- 45,000 student records with CGPA, internships, coding skills, communication skills, backlogs, projects, branch and degree
- Source: [add dataset link here, and mention if it is a synthetic or public practice dataset]

## What I found

- Placement was about 70% for students with CGPA above 8 and close to 0% below 6.
- Placement was 67.3% for students with 3 internships vs 20.9% for students with none.
- Higher coding skill levels and fewer backlogs were linked to better placement outcomes.

## Dashboard

The Power BI dashboard has 4 pages, built with DAX measures, slicers and drill-throughs.

1. **Executive Dashboard:** total, placed and unplaced students, and placement rate by branch, degree, CGPA band and internships.
2. **Placement Drivers:** placement by coding skills, communication skills, projects, backlogs and risk category.
3. **Student Explorer:** student-level table with filters and highlighting for CGPA, backlogs and placement status.
4. **Strategic Insights:** summary of findings and recommended actions.

![Executive Dashboard](Executive%20Dashboard.png)
![Placement Drivers](Placement%20Drivers.png)

## SQL and Python

- SQL: CTEs, window functions, CASE WHEN, GROUP BY, joins and ranking, used to answer questions on placement by branch, degree, CGPA, internships and skills.
- Python (Pandas, NumPy, Matplotlib, Seaborn): data cleaning, missing values, exploratory analysis and correlation checks.

## Recommendations

- Identify students with low CGPA or backlogs early and give them extra support.
- Increase internship opportunities.
- Run coding workshops for students with low coding scores.

## Files

- `Student Placement Analysis.sql`: SQL analysis
- `Student Placement EDA.ipynb`: Python analysis
- `student placement dashboard.pbix`: Power BI dashboard
- `student_placement_dataset.csv`: dataset
- Four `.png` files: dashboard page screenshots
