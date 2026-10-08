use cancer;

Select * from Cancer limit 5;


-- Select gender,stage,count(stage)No_Of_Cases from cancer where gender='F' and status='Dead' group by gender,stage order by count(stage) desc;

-- Select gender,stage,count(stage)No_Of_Cases from cancer where gender='M' and status='Dead' group by gender,stage order by count(stage) desc;

-- Q1)OVerall death Percentage (63.58%) > Survival Percentage(36.42%)
Select round((count(case when status='Dead' then status end)/count(status))*100,2)Overall_Death_Percentage ,round((count(case when status='Alive' then status end)/count(status))*100,2)Overall_Survival_Percentage from Cancer; -- 63.58%
-- Reasons
-- As Most of the cases are Identified at Stage 3 , it was paving a way for most of the cases to end up the status as Dead
Select stage,count(*)Total_Cases,count(case when status='Dead' then status end)Death_Count from Cancer group by stage;
-- The Death Percentage for the cases that were Identified at Stage 3 are more than any of the stage.
Select Stage,round(count(status)/(Select count(status) from Cancer where status='Dead')*100,2)Death_Percentage from Cancer where status='Dead' group by Stage order by Death_Percentage desc; -- 3-37.89%, 4-33.69%

-- Least Deaths Pattern
-- Cases that are Detected at Stage 1 and 2 are having low Death Percentage and least Amount of Deaths.
Select stage,count(*)Total_Cases,count(case when status='Dead' then status end)Death_Count from Cancer group by stage order by Death_Count asc; -- 1- 5507,  2- 12559.
Select Stage,round(count(status)/(Select count(status) from Cancer where status='Dead')*100,2)Death_Percentage from Cancer where status='Dead' group by Stage order by Death_Percentage asc; -- 1-8.66%,  2-19.75%


-- Q2)Middle Age People Mostly Affected and Desceased by Cancer.
Select Age_Group,round(count(*)/(Select count(*) from Cancer)*100,2)Total_Cases_Percent,round(count(status)/(Select count(status) from Cancer where status='Dead')*100,2)Death_Percentage from Cancer group by Age_Group order by Total_Cases_Percent desc; -- Middle Age -- 51.93%
-- Reasons
-- Cancer Stage Causing Most Deaths for Middle Age
Select Age_Group, Stage, count(*)Total_Cases,count(case when status='Dead' then status end)Death_Count from Cancer where Age_Group='Middle Age' group by Age_Group,Stage order by Death_Count desc;
-- Total Death Percentage -- StageWise Cancer
Select Stage,round(count(status)/(Select count(status) from Cancer where status='Dead')*100,2)Death_Percentage from Cancer where status='Dead' group by Stage order by Death_Percentage desc; -- 3-37.89%, 4-33.69%

-- Mostly The Middle Age People were Diagnozed by Stage 3(18320) and Stage 4(12903) Cancer
-- Of which Both Stages are having High Death count and Death Percentage Stage -3 - 37.89% , 4-33.69%
-- As the Diagnozed Stage of Cancer is mostly leading to Death Middle aged people are the age group with most deaths

-- In depth Analysis
-- Type of Gender Mostly in Middle Age
Select Gender,count(*)Total_MiddleAge_People from Cancer where Age_Group='Middle Age' group by Gender,Age_Group order by Total_MiddleAge_People desc;
-- Percentage of Gender Mostly in Middle age 
Select round(count(case when Gender='F' then Gender end)/count(*)*100,2)Female,round(count(case when Gender='M' then Gender end)/count(*)*100,2)Male from Cancer where Age_Group='Middle Age'; -- F-73.41% , M- 26.59%
-- GenderWise Death Rate -F- 70.63%,  M-29.37%
Select round(count(case when Gender='F' then Gender end)/count(*)*100,2)Female,round(count(case when Gender='M' then Gender end)/count(*)*100,2)Male from Cancer where Age_Group='Middle Age' and status='Dead'; -- F-73.41% , M- 26.59%
-- Cancer Type that was causing most deaths -- Middle Age -- Breast Cancer -- Total Cases -- 16888 -- Total Deaths -- 8836
Select Age_Group, Cancer_Type, count(*)Total_Cases,count(case when status='Dead' then status end)Death_Count from Cancer where Age_Group='Middle Age' group by Age_Group,Cancer_Type order by Death_Count desc;
-- Cancer Stage Causing Most Deaths for Middle Age
Select Age_Group, Stage, count(*)Total_Cases,count(case when status='Dead' then status end)Death_Count from Cancer where Age_Group='Middle Age' group by Age_Group,Stage order by Death_Count desc;
-- Cancer Type Stage wise Deaths
Select Cancer_Type,Stage,count(status)Total_Deaths from Cancer where Age_Group='Middle Age' and status='Dead' group by Cancer_Type,Stage order by Total_Deaths Desc;
-- GenderWise Cancer Type Stage Wise Deaths
Select Gender,Cancer_Type,Stage,count(status)Death_Count from Cancer where Age_Group='Middle Age' and status='Dead' group by Gender,Cancer_Type,Stage order by Death_Count desc;

-- Middle Age Pattern
-- In Middle Age Most of the Females are Attacked by Cancer than Men ==> F(73.41%), M(26.59%)
-- In Middle Age GenderWise Death Rate -F- 70.63%,  M-29.37%
-- Most Cancer and Death causing Stage is Stage 3 with Cases -- 18320, Deaths-- 12312
-- Middle Age Breast Cancer is Causing Most Deaths in Stage 3 and 4

-- Overall Middle Age People Females are most affected gender and also having the most Death Count experiencing Breast Cancer Detected Mostly in Stage 3 and Stage 4.

-- Q3)StateWise Total Cases and Total Deaths are mostly from Delhi
-- Percentage Affected By Cancer -- Delhi -- 19%
Select State,round(count(*)/(Select count(*) from Cancer)*100,2)Total_Cases_Percent from Cancer group by State order by Total_Cases_Percent desc; -- Delhi- 19.94% ,Karnataka - 10.16%, Chandigarh,Gujarat- 10.11%
-- Total Death Percentage -- Delhi -- 20%
Select State,round(count(status)/(Select count(status) from Cancer where status='Dead')*100,2)Death_Percentage from Cancer where status='Dead' group by State order by Death_Percentage desc; -- Delhi - 20%, Gujarat - 10.15%, Chandigarh-10.15%

-- Reasons and Proofs
-- CancerType Cases in Delhi -- Breast Cancer - 5647 - Death_Count-2922
Select State, Cancer_Type, count(*)Total_Cases,count(case when status='Dead' then status end)Death_Count from Cancer where State='Delhi' group by State,Cancer_Type order by Death_Count desc;
-- Cancer StageWise Deaths in Delhi -- Cases - Stage 3(7079), Stage 4(4948)  Deaths-- Stage -3(4840), Stage -4(4321)
Select State, Stage, count(*)Total_Cases,count(case when status='Dead' then status end)Death_Count from Cancer where State='Delhi' group by State,Stage order by Death_Count desc;
-- Cancer StageWise Deaths
Select Stage,count(Status)Overall_Death_Count from Cancer  where Status='Dead' group by Stage order by Overall_Death_Count desc; -- Most Deaths -- 3 - 24092, 4 - 21419

-- As Most of the Cases are detected at stage 3 and 4 which are the stages having low survival rate Delhi is being getting the most deathrate

-- Q4)YearWise Total Cases and Total Deaths are mostly in 2024
-- Percentage Affected By Cancer -- 2024 -- Total Cases -- 25.10%
Select yr,round(count(*)/(Select count(*) from Cancer)*100,2)Total_Cases_Percent from Cancer group by yr order by Total_Cases_Percent desc; -- 2024- 25.10% ,2022 - 25.06%, 2023- 24.92%
-- Total Death Percentage --- 2024 -- Death Percentage-- 63.68% -- 2023--63.67
Select yr,count(*)Total_Cases,count(case when status='Dead' then status end)Overall_Death_Count,round(count(case when status='Dead' then status end)/count(*)*100,2)YearWise_Death_Percentage from Cancer group by yr order by Overall_Death_Count desc; -- 2024 - 15984, 2023 - 15866, 2025 - 15861

-- Reasons and Proofs
-- CancerType Cases in 2024 -- Breast Cancer - 7116 - Death_Count-3720
Select yr, Cancer_Type, count(*)Total_Cases,count(case when status='Dead' then status end)Death_Count from Cancer where yr=2024 group by yr,Cancer_Type order by Death_Count desc;
-- Cancer StageWise Deaths in 2024 -- Cases - Stage 3(1835),  Deaths-- Stage -3(1272
Select yr, Stage, count(*)Total_Cases,count(case when status='Dead' then status end)Death_Count from Cancer where State='Delhi' group by yr,Stage order by Death_Count desc;
-- Cancer StageWise Deaths
Select Stage,count(Status)Overall_Death_Count from Cancer  where Status='Dead' group by Stage order by Overall_Death_Count desc; -- Most Deaths -- 3 - 24092, 4 - 21419

-- As Most of the Cases are detected at stage 3 and 4 which are the stages having low survival rate so year 2024 is being getting the most deathrate

-- Mens Cancer Analysis
-- Mens Most Affected Cancer -- Oral Cancer -- 9871
Select gender,Cancer_type,count(*)No_of_Cases from Cancer where gender='M' group by gender,Cancer_type order by No_of_Cases desc;
-- Mens Most Death Causing Cancer -- Lung Cancer -- 6384
Select gender, Cancer_Type, count(*)Total_Cases,count(case when status='Dead' then status end)Death_Count from Cancer where gender='m' group by gender,Cancer_Type order by Death_Count desc;
-- Mens CancerType Wise StageWise Death Analysis
Select gender, Cancer_Type,stage,count(case when status='Dead' then status end)Death_Count from Cancer where gender='M' and Cancer_Type in('Lung Cancer','Oral Cancer') group by gender, Cancer_Type,stage order by Death_Count desc;

-- Men Are Mostly Affected by Oral and Lung Cancer detected in Stage 3 and 4 leading to deaths