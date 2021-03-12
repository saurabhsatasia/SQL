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
