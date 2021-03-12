-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- Data Types - ---------------------------------------------------
-------------------------------------------------------------------------------------------------------------------


-- VARCHAR(25) - Is for characters - you cannot apply aggregated functions on this
-- NVARCHAR (25)  - Is for characters - you cannot apply aggregated functions on this
-- FLOAT - Is for Number values with decimal; so you can aggregate the data - SUM/AVG/MIN/MAX
-- Int is for Number swith no decimal places
-- Date is for dates

-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- SELECT Query ---------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

-- * means all
USE practice
SELECT * FROM Opportunities_Data
SELECT New_Account_NO, Opportunity_ID FROM Opportunities_Data

-- Exm 1 - 1 Condition: =
SELECT * FROM Opportunities_Data WHERE Product_Category = 'Services' --1269

-- Exm 2 - 1 Condition: <>
SELECT * FROM Opportunities_Data WHERE Opportunity_Stage != 'Stage - 0' --3390

-- Exm 3 - 1 Condition: IN/NOT IN
SELECT * FROM Opportunities_Data WHERE Opportunity_Stage IN ('Stage - 0', 'Stage - 1','Stage - 2', 'Stage - 3') 
SELECT * FROM Opportunities_Data WHERE Opportunity_Stage NOT IN ('Stage - 0', 'Stage - 1','Stage - 2', 'Stage - 3') 

-- Exm 4 - 1 Condition: LIKE/NOT LIKE
SELECT * FROM Opportunities_Data WHERE New_Opportunity_Name LIKE '%Phase - 1%'
SELECT * FROM Opportunities_Data WHERE New_Opportunity_Name NOT LIKE '%Phase - 1%'

-- Exm 5 - 1 Condition: AND 
SELECT * FROM Opportunities_Data WHERE Product_Category='Services' AND Opportunity_Stage='Stage - 5'

-- Exm 6 - 1 Condition: OR
SELECT * FROM Opportunities_Data WHERE Product_Category='Services' OR Opportunity_Stage='Stage - 5'

-- Exm 7 - 1 Condition: AND/OR
SELECT * FROM Opportunities_Data WHERE (Product_Category='Services' AND Opportunity_Stage='Stage - 5') OR New_Opportunity_Name LIKE '%Phase - 7%'

-- Exm 8 - 1 Condition: >/<
SELECT * FROM Opportunities_Data WHERE Est_Opportunity_Value > 50000
SELECT * FROM Opportunities_Data WHERE Est_Opportunity_Value < '50000'

-- Exm 9 - 1 Condition: BETWEEN
SELECT * FROM Opportunities_Data WHERE Est_Opportunity_Value BETWEEN '50000' AND '70000'


-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- WHERE CLAUSE with SubQueries ----------------------------------
-------------------------------------------------------------------------------------------------------------------

SELECT * FROM account_lookup
SELECT * FROM Opportunities_Data
SELECT * FROM Calendar_lookup

-- Exm 1 - 1 condition from another table
SELECT * FROM Opportunities_Data WHERE New_Account_No IN (SELECT New_Account_No FROM account_lookup WHERE Sector = 'Banking')

-- Exm 2 - 1 condition from another table - FY20
SELECT * FROM Opportunities_Data WHERE Est_Completion_Month_ID IN (SELECT Month_ID FROM Calendar_lookup WHERE Fiscal_Year = 'FY20')

-- Exm 3 - 1 condition from another table - FY20 & 1 Condition
SELECT * FROM Opportunities_Data WHERE Est_Completion_Month_ID IN (SELECT Month_ID FROM Calendar_lookup WHERE Fiscal_Year = 'FY20') AND Est_Opportunity_Value=50000

-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- IIF & Case Statements in SQL------------------------------------
-------------------------------------------------------------------------------------------------------------------

-- Exm 1: 1 IIF Condition - same column names
SELECT * FROM Opportunities_Data
SELECT New_Account_No, Opportunity_ID, New_Opportunity_Name,Est_Completion_Month_ID, 
		IIF(Product_Category = 'Services', 'Services & Marketing', Product_Category) AS Product_Category,
		Opportunity_Stage, Est_Opportunity_Value FROM Opportunities_Data

-- Exm 2: Multible iif statements with a new column
SELECT * FROM
	(
	SELECT *,
	IIF(New_Opportunity_Name LIKE '%Phase - 1%', 'Phase - 1',
	IIF(New_Opportunity_Name LIKE '%Phase - 2%', 'Phase - 2',
	IIF(New_Opportunity_Name LIKE '%Phase - 3%', 'Phase - 3',
	IIF(New_Opportunity_Name LIKE '%Phase - 4%', 'Phase - 4',
	IIF(New_Opportunity_Name LIKE '%Phase - 5%', 'Phase - 5', 'Need Mapping'))))) AS Oppor_Phase
	FROM Opportunities_Data
	) a
WHERE Oppor_Phase = 'Need Mapping'

-- Exm 1: Case 
SELECT New_Account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID,
CASE
	WHEN Product_Category = 'Services' THEN 'Services & Marketing'
	ELSE Product_Category
	END AS Product_Category,
Opportunity_Stage, Est_Opportunity_Value FROM Opportunities_Data

-- Exm 2: CASE with multible conditions
SELECT *,
CASE
	WHEN New_Opportunity_Name LIKE '%Phase - 1%' THEN 'Phase - 1'
	WHEN New_Opportunity_Name LIKE '%Phase - 2%' THEN 'Phase - 2'
	WHEN New_Opportunity_Name LIKE '%Phase - 3%' THEN 'Phase - 3'
	WHEN New_Opportunity_Name LIKE '%Phase - 4%' THEN 'Phase - 4'
	WHEN New_Opportunity_Name LIKE '%Phase - 5%' THEN 'Phase - 5'
	ELSE 'Need Mapping' 
	END AS Oppor_Phase
FROM Opportunities_Data

-------------------------------------------------------------------------------------------------------------------
---------------------------------------- UPDATE / REPLACE / INSERT INTO / DELETE-----------------------------------
-------------------------------------------------------------------------------------------------------------------

SELECT * FROM account_lookup

--Exm 1: renaming a column value
SELECT *, 
IIF(Sector = 'Capital Markets/Securities', 'Capital Markets',
IIF(Sector = 'Government Social Programs', 'Gov Social',
IIF(Sector = 'Broadcasters', 'Broadcasters/Media', Sector))) AS Sector2 
FROM account_lookup
-- To update these values in original table
UPDATE account_lookup
SET Sector = IIF(Sector = 'Capital Markets/Securities', 'Capital Markets',
			 IIF(Sector = 'Government Social Programs', 'Gov Social',
			 IIF(Sector = 'Broadcasters', 'Broadcasters/Media', Sector)))

--Exm 2: Replace
SELECT *, 
IIF(Sector = 'Capital Markets/Securities', 'Capital Markets',
IIF(Sector = 'Government Social Programs', 'Gov Social',
IIF(Sector = 'Broadcasters', 'Broadcasters/Media', Sector))) AS Sector2,
REPLACE(Account_Segment, 'PS', 'Public Sector') AS Account_Segment2
FROM account_lookup

UPDATE account_lookup
SET Account_Segment = REPLACE(Account_Segment, 'PS', 'Public Sector')

-- Exm 3: INSERT INTO
INSERT INTO account_lookup
SELECT '9974829689', 'New Account Name', 'Test Industry', NULL, NULL, NULL, NULL, 'SS'

SELECT * FROM account_lookup WHERE Industry_Manager = 'SS'

-- Exm 4: deleting data
DELETE FROM account_lookup WHERE Industry_Manager = 'SS'


-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- Main Aggregate Functions in SQL---------------------------------
-------------------------------------------------------------------------------------------------------------------

SELECT * FROM Opportunities_Data

-- Exm 1: SUM - 1 COLUMN
SELECT Product_Category, SUM(Est_Opportunity_Value) AS sum_oppor_value FROM Opportunities_Data
WHERE Opportunity_Stage = 'Stage - 5'
GROUP BY Product_Category 

-- Exm 2: SUM - 2 COLUMNS
SELECT Product_Category, Opportunity_Stage, SUM(Est_Opportunity_Value) FROM Opportunities_Data
GROUP BY Product_Category, Opportunity_Stage
ORDER BY Product_Category, Opportunity_Stage 

-- Exm 3: SUM - Order by Value
SELECT Product_Category, Opportunity_Stage, SUM(Est_Opportunity_Value) FROM Opportunities_Data
GROUP BY Product_Category, Opportunity_Stage
ORDER BY SUM(Est_Opportunity_Value) DESC

-- Exm 4: COUNT - 1 COLUMN
SELECT Product_Category, COUNT(Opportunity_ID) AS No_Of_Opportunities FROM Opportunities_Data
GROUP BY Product_Category
ORDER BY COUNT(Opportunity_ID)

-- Exm 5: MIN
SELECT Product_Category, MIN(Est_Opportunity_Value) as MIN_Est_Opportunity_Value FROM Opportunities_Data
GROUP BY Product_Category

-- Exm 6: MAX
SELECT Product_Category, MAX(Est_Opportunity_Value) as MAX_Est_Opportunity_Value FROM Opportunities_Data
GROUP BY Product_Category 

SELECT * FROM Opportunities_Data WHERE Est_Opportunity_Value = 1000000

-------------------------------------------------------------------------------------------------------------------
----------------------- INNER/LEFT(OUTER)/RIGHT(OUTER)/FULL/CROSS join Statements in SQL---------------------------
-------------------------------------------------------------------------------------------------------------------
SELECT * FROM Opportunities_Data
SELECT * FROM account_lookup

-- Exm 1: LEFT JOIN

-- 1. We need to SELECT the columns we need from the 2 or more tables we are going to JOIN
-- 2. Need to identify the column(s) that are identical in each table so we can JOIN them
-- 3. Need to specify on top which columns we need from each table
SELECT opportunities.*, accounts.New_Account_Name, accounts.Industry 
FROM
	(
	SELECT New_Account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, Product_Category, Opportunity_Stage, Est_Opportunity_Value FROM Opportunities_Data
	) opportunities

	LEFT JOIN
	(
	SELECT New_Account_No, New_Account_Name, Industry FROM account_lookup
	) accounts
	ON opportunities.New_Account_No = accounts.New_Account_No

SELECT DISTINCT New_Account_No FROM Opportunities_Data --1,139
SELECT DISTINCT New_Account_No FROM account_lookup -- 1,445

SELECT * FROM account_lookup WHERE New_Account_No NOT IN (SELECT DISTINCT New_Account_No FROM Opportunities_Data) --1,139)
--984131730

---Also but messy
SELECT a.*, b.New_Account_Name, b.Industry FROM Opportunities_Data a
LEFT JOIN account_lookup b
ON a.New_Account_No = b.New_Account_No
---------------

-- Exm 2: FULL JOIN
SELECT opportunities.*, accounts.New_Account_Name, accounts.Industry 
FROM
	(
	SELECT New_Account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, Product_Category, Opportunity_Stage, Est_Opportunity_Value FROM Opportunities_Data
	) opportunities

	FULL JOIN
	(
	SELECT New_Account_No, New_Account_Name, Industry FROM account_lookup
	) accounts
	ON opportunities.New_Account_No = accounts.New_Account_No
	-- BEFORE: 4,133
	-- NOW: 4,139 
	-- Here new records added from accounts table will have null values, 

SELECT ISNULL(o.New_Account_No, ac.New_Account_No) AS New_Account_No,
ISNULL(o.Opportunity_ID, 'No Opportunity') AS Opportunity_ID,
o.New_Opportunity_Name, o.Est_Completion_Month_ID, o.Product_Category, o.Opportunity_Stage, o.Est_Opportunity_Value ,
ac.New_Account_Name, ac.Industry
FROM
	(
	SELECT New_Account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, Product_Category, Opportunity_Stage, Est_Opportunity_Value FROM Opportunities_Data
	) o

	FULL JOIN
	(
	SELECT New_Account_No, New_Account_Name, Industry FROM account_lookup
	) ac
	ON o.New_Account_No = ac.New_Account_No
 -- 198169344	No Opportunity	NULL	NULL	NULL	NULL	NULL	Voice Caption Center FursKips	Professional Services


