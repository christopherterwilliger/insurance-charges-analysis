--------------------------------------------------
-- Insurance Premium Analysis
-- Christopher Terwilliger

-- Description:
-- This project analyzes a dataset of 1,338 insurance
-- policyholders using SQL to investigate demographic
-- and behavioral factors associated with medical
-- insurance charges.

-- Tools Used:
-- - SQLite
-- - DB Browser for SQLite
-- - Visual Studio Code

-- Skills Demonstrated:
-- - Data exploration
-- - Aggregate functions
-- - CASE statements
-- - GROUP BY
-- - ORDER BY
-- - WHERE filtering
-- - Multi-factor analysis
--------------------------------------------------

--------------------------------------------------
-- View first five rows
--------------------------------------------------

SELECT *
FROM insurance
LIMIT 5;

--------------------------------------------------
-- Dataset Size
--------------------------------------------------

SELECT COUNT(*)
FROM insurance;

-- Result:
-- 1,338 policyholders

--------------------------------------------------
-- Average Medical Charge
--------------------------------------------------

SELECT AVG(charges)
FROM insurance;

-- Result:
-- Average charge = $13,270.42

--------------------------------------------------
-- Average Charges by Smoking Status
--------------------------------------------------

SELECT smoker,
       AVG(charges)
FROM insurance
GROUP BY smoker;

-- Results:
-- Non-smokers: $8,434
-- Smokers:     $32,050
--
-- Observation:
-- Smokers have substantially higher average medical
-- charges than non-smokers in this dataset.

--------------------------------------------------
-- Number of Policyholders by Smoking Status
--------------------------------------------------

SELECT smoker,
	   COUNT(*)
FROM insurance
GROUP BY smoker;

-- Results:
-- Non-smokers: 1,064
-- Smokers:       274

--------------------------------------------------
-- Do medical charges differ by region?
--------------------------------------------------

SELECT region,
	   AVG(charges)
FROM insurance
GROUP BY region
ORDER BY AVG(charges) DESC;

-- Results:
-- Southeast: $14,735.41
-- Northeast: $13,406.38
-- Northwest: $12,417.58
-- Southwest: $12,346.94
--
-- Observation:
-- The Southeast has the highest average medical charges
-- while the Southwest has the lowest. Regional differences
-- exist but are considerably smaller than the differnces
-- observed between smokers and non-smokers.

--------------------------------------------------
-- Average Medical Charges by Age Group
--------------------------------------------------

SELECT 
	CASE
		WHEN age BETWEEN 18 AND 29 THEN '18-29'
		WHEN age BETWEEN 30 AND 39 THEN '30-39'
		WHEN age BETWEEN 40 AND 49 THEN '40-49'
		WHEN age BETWEEN 50 AND 59 THEN '50-59'
		ELSE '60+'
	END AS age_group,
	AVG(charges) AS average_charge
FROM insurance
GROUP BY age_group
ORDER BY age_group;

-- Results:
-- 18-29: $9,182.49
-- 30-39: $11,738.78
-- 40-49: $14,399.20
-- 50-59: $16,495.23
-- 60+:   $21,248.02
-- 
-- Observation:
-- Average medical charges increase steadily across age groups.
-- Older policyholders in this dataset tend to have higher
-- average medical charges than younger policyholders.

--------------------------------------------------
-- Average Medical Charges by BMI Category
--------------------------------------------------

SELECT 
	CASE
		WHEN bmi < 18.5 THEN 'Underweight'
		WHEN bmi < 25 THEN 'Normal'
		WHEN bmi < 30 THEN 'Overweight'
		ELSE 'Obese'
	END AS bmi_category,
	AVG(charges) AS average_charge
FROM insurance
GROUP BY bmi_category
ORDER BY average_charge DESC;

-- Results:
-- Obese:       $15,552.34
-- Overweight:  $10,987.51
-- Normal:      $10,409.34
-- Underweight: $8,852.20
--
-- Observation:
-- Average medical charges generally increase as BMI category
-- increase. Individuals in the obese category have the highest
-- average medical charges in this dataset.

--------------------------------------------------
-- Average Charges by Age Group and Smoking Status
--------------------------------------------------

SELECT
    CASE
        WHEN age BETWEEN 18 AND 29 THEN '18-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    smoker,
    AVG(charges) AS average_charge
FROM insurance
GROUP BY age_group, smoker
ORDER BY age_group, smoker;

-- Key Results:
-- - Within every age group, smokers had substantially
--   higher average medical charges than non-smokers.
-- - Average charges increased with age for both smokers
--   and non-smokers.
--
-- Observation:
-- Smoking status and age both appear to be associated
-- with higher medical charges. Smoking status showed
-- the larger difference across all age groups.

--------------------------------------------------
-- Average Medical Charges by BMI Category
-- and Smoking Status
--------------------------------------------------

SELECT
    CASE
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi < 25 THEN 'Normal'
        WHEN bmi < 30 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category,
    smoker,
    AVG(charges) AS average_charge
FROM insurance
GROUP BY bmi_category, smoker
ORDER BY
    CASE
        WHEN bmi_category = 'Underweight' THEN 1
        WHEN bmi_category = 'Normal' THEN 2
        WHEN bmi_category = 'Overweight' THEN 3
        WHEN bmi_category = 'Obese' THEN 4
    END,
    smoker;

-- Key Results:
-- - Smokers had substantially higher average medical
--   charges than non-smokers within every BMI category.
-- - Individuals in the obese category exhibited the
--   highest average medical charges overall.
--
-- Observation:
-- Both BMI and smoking status appear to be associated
-- with higher medical charges. Smoking status continues
-- to show the strongest difference regardless of BMI.

--------------------------------------------------
-- Average Medical Charges by Number of Children
--------------------------------------------------

SELECT
    children,
    AVG(charges) AS average_charge
FROM insurance
GROUP BY children
ORDER BY children;

-- Key Results:
-- - Average medical charges increased from 0 to 3 children.
-- - Policyholders with 3 children had the highest average
--   medical charges.
-- - Average charges decreased for policyholders with
--   4 and 5 children.
--
-- Observation:
-- Unlike age and smoking status, the relationship between
-- the number of children and average medical charges is not
-- consistently increasing. This suggests the number of
-- children may have a weaker or more variable association
-- with medical charges in this dataset.

--------------------------------------------------
-- Highest and Lowest Medical Charges
--------------------------------------------------

SELECT MAX(charges) AS highest_charge
FROM insurance;

SELECT MIN(charges) AS lowest_charge
FROM insurance;

-- Results:
-- Highest Charge: $63,770.43
-- Lowest Charge:  $1,121.87
--
-- Observation:
-- Medical charges vary substantially across policyholders,
-- ranging from approximately $1,121 to $63,770.

--------------------------------------------------
-- Top 10 Highest Medical Charges
--------------------------------------------------

SELECT *
FROM insurance
ORDER BY charges DESC
LIMIT 10;

-- Key Results:
-- - All 10 of the highest medical charges belonged to smokers.
-- - 9 of the 10 policyholders were over 30 years old.
-- - All 10 policyholders had a BMI greater than 30 (obese).
--
-- Observation:
-- The highest-cost policyholders in this dataset consistently
-- shared multiple high-risk characteristics, including smoking
-- status, obesity, and generally older age. This suggests that
-- medical charges may be associated with the combined presence
-- of multiple risk factors rather than a single characteristic.

--------------------------------------------------
-- Filtering Data with WHERE
--------------------------------------------------

-- Average medical charge for smokers

SELECT AVG(charges) AS average_charge
FROM insurance
WHERE smoker = 'yes';

-- Result:
-- Average charge: $32,050.23

--------------------------------------------------

-- Average medical charge for non-smokers

SELECT AVG(charges) AS average_charge
FROM insurance
WHERE smoker = 'no';

-- Result:
-- Average charge: $8,434.27

--------------------------------------------------

-- Policyholders with medical charges over $50,000

SELECT *
FROM insurance
WHERE charges > 50000;

-- Observation:
-- Only a small number of policyholders incurred medical
-- charges exceeding $50,000. These records represent
-- high-cost cases that may warrant further investigation.

--------------------------------------------------
-- Summary of Findings
--------------------------------------------------

-- Dataset Overview
-- - Analyzed medical insurance data for 1,338 policyholders.

-- Key Findings

-- - Smoking status exhibited the largest difference in
--   average medical charges. Smokers averaged approximately
--   $32,050 compared with $8,434 for non-smokers.

-- - Average medical charges increased consistently across
--   age groups, with policyholders aged 60+ having the
--   highest average charges.

-- - Obese policyholders had the highest average medical
--   charges among the BMI categories.

-- - Regional differences in average medical charges were
--   relatively small compared with smoking status, age,
--   and BMI.

-- - The highest-cost policyholders generally shared
--   multiple high-risk characteristics, including smoking,
--   obesity, and older age.

-- Overall Conclusion
-- Within this dataset, smoking status showed the strongest
-- association with higher medical charges. Age and BMI were
-- also associated with higher average charges, while region
-- and number of children exhibited comparatively smaller
-- differences.