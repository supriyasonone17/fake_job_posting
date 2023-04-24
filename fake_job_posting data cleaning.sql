--Cleaning Data in SQL queries

SELECT *
FROM [MY Work].DBO.[fake job postings]

--To Check if there are any Duplicates

SELECT job_id, COUNT(*)
FROM [MY Work].DBO.[fake job postings]
GROUP BY job_id
ORDER BY COUNT(*) DESC

--Finding Unique values

SELECT COUNT(DISTINCT title)
FROM [MY Work].DBO.[fake job postings]

SELECT COUNT(DISTINCT location)
FROM [MY Work].DBO.[fake job postings]

SELECT COUNT(DISTINCT company_profile)
FROM [MY Work].DBO.[fake job postings]

SELECT COUNT(DISTINCT description)
FROM [MY Work].DBO.[fake job postings]

SELECT COUNT(DISTINCT requirements)
FROM [MY Work].DBO.[fake job postings]

SELECT COUNT(DISTINCT telecommuting)
FROM [MY Work].DBO.[fake job postings]

SELECT COUNT(DISTINCT employment_type)
FROM [MY Work].DBO.[fake job postings]

SELECT COUNT(DISTINCT required_experience)
FROM [MY Work].DBO.[fake job postings]

SELECT COUNT(DISTINCT required_education)
FROM [MY Work].DBO.[fake job postings]

SELECT COUNT(DISTINCT industry)
FROM [MY Work].DBO.[fake job postings]

SELECT COUNT(DISTINCT fraudulent)
FROM [MY Work].DBO.[fake job postings]

--Handling Null Values

SELECT COUNT(department) AS [TOT NO OF NULL]
FROM [MY Work].DBO.[fake job postings]
WHERE department IS NOT NULL

SELECT COUNT(salary_range) AS [TOT NO OF NULL]
FROM [MY Work].DBO.[fake job postings]
WHERE salary_range IS NULL

SELECT COUNT(benefits) AS [TOT NO OF NULL]
FROM [MY Work].DBO.[fake job postings]
WHERE benefits IS NULL;

--Deleting column 

ALTER TABLE [MY Work].DBO.[fake job postings]
DROP COLUMN department;
GO
SELECT *
FROM [MY Work].DBO.[fake job postings]

ALTER TABLE [MY Work].DBO.[fake job postings]
DROP COLUMN salary_range, benefits;
GO
SELECT *
FROM [MY Work].DBO.[fake job postings]

--Splitting the Data

--SELECT *
--FROM [MY Work].DBO.[fake job postings]

--SELECT
--SUBSTRING(location, 1, CHARINDEX(',',location) -1) AS Address

--FROM [MY Work].DBO.[fake job postings]

SELECT *
FROM [MY Work].DBO.[fake job postings]

SELECT job_id, lo_cation
FROM [MY Work].DBO.[fake job postings]

SELECT job_id, lo_cation, '' AS l1, '' AS l2, '' AS l3 FROM [MY Work].DBO.[fake job postings]

--String_split() - Split commaseparated string into single coulmn table
--Pivot - Transform row level data into column data
--Cross Apply - Returns only row from the outer tablethat produce a result set from the table-valued function

--SELECT * FROM string_split('US, FL, Orlando ',',')

SELECT job_id, lo_cation
FROM [MY Work].DBO.[fake job postings]


--SELECT job_id, lo_cation, Split.value
--FROM [MY Work].DBO.[fake job postings] as postings
--CROSS APPLY string_split('lo_cation' , ',') AS Split

SELECT job_id, lo_cation, ISNULL([l1],'') AS [l1], ISNULL([l2],'') AS [l2], ISNULL([l3],'') AS [l3] FROM(
SELECT job_id, lo_cation, 'l'+CAST(ROW_NUMBER() OVER(PARTITION BY job_id ORDER BY job_id) AS varchar) AS col, Split.value
FROM [MY Work].DBO.[fake job postings] as postings
CROSS APPLY string_split(lo_cation , ',') AS Split
) AS tbl
PIVOT (MAX(value) FOR col in ([l1],[l2],[l3])) AS pvt