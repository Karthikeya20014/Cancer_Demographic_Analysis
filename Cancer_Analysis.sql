-- Creating a database for the project
create database cancer;
-- Using the Database Cancer
use cancer;
-- Looking at the tables present
show tables;

-- Renaming the table to Cancer
rename table india_cancer_patients_2022_2025 to Cancer;
-- Renaming Column Year and Month
alter table Cancer rename column Year to yr;
alter table Cancer rename column Month to mt;
-- Basic Profile of the table
Select * from Cancer limit 5;

-- Overall Analysis 

-- Total no of Cancer Cases
Select count(*)Total_Cases from Cancer; -- 100000
-- Total no of Deaths 
Select count(Status)Overall_Death_Count from Cancer where Status='Dead'; -- 63577
-- Total no of Survivals
Select count(Status)Overall_Survival_Count from Cancer where Status='Alive'; -- 36423
-- Total Death Percentage
Select round((count(case when status='Dead' then status end)/count(status))*100,2)Overall_Death_Percentage from Cancer; -- 63.58%
-- Total Survival Percentage
Select round((count(case when status='Alive' then status end)/count(status))*100,2)Overall_Survival_Percentage from Cancer; -- 36.42%

-- Genderwise Analysis
-- Total no of Cancer Cases
Select gender,count(*)Total_Cases from Cancer group by gender; -- F- 67151, M - 32849.
-- Percentage Affected By Cancer
Select gender,round(count(*)/(Select count(*) from Cancer)*100,2)Total_Cases_Percent from Cancer group by gender; -- F- 67.15%, M - 32.85%.
-- Total no of Deaths 
Select gender,count(Status)Overall_Death_Count from Cancer where Status='Dead' group by gender; -- F- 41273 M - 22304
-- Total no of Survivals
Select gender,count(Status)Overall_Survival_Count from Cancer where Status='Alive' group by gender; -- F-- 25878 M- 10545
-- Total Death Percentage
Select gender, round(count(status)/(Select count(status) from Cancer where status='Dead')*100,2)Death_Percentage from Cancer where status='Dead' group by gender ; -- M - 35.08% F--64.92%
-- Total Survival Percentage
Select gender, round(count(status)/(Select count(status) from Cancer where status='Alive')*100,2)Survival_Percentage from Cancer where status='Alive' group by gender ; -- M - 28.95% F--71.05%

-- Type of Cancer Affecting the most for each Gender
Select * from cancer;
-- Most Attacked Cancer in Female
Select gender,Cancer_Type,count(*)No_of_Cases from  Cancer where gender='F' group by gender,Cancer_Type order by count(*) desc limit 1; -- Female -- Breast Cancer -- 28169
-- Death Causing Cancer in Female
Select gender,Cancer_Type,count(*)No_of_Deaths from  Cancer where gender='F' and status ='Dead' group by gender,Cancer_Type order by count(*) desc ; -- Female -- Breast Cancer -- 14711

-- Most Attacked Cancer in Male
Select gender,Cancer_Type,count(*)No_of_Cases from  Cancer where gender='M' group by gender,Cancer_Type order by count(*) desc limit 1 ; -- Male -- Oral Cancer -- 9871
-- Death Causing Cancer in Female
Select gender,Cancer_Type,count(*)No_of_Deaths from  Cancer where gender='M' and status ='Dead' group by gender,Cancer_Type order by count(*) desc limit 1; -- Male -- Lung Cancer -- 6384


-- 3 -- Cancer Type Analysis
-- Total no of Cancer Cases
Select cancer_type,count(*)Total_Cases from Cancer group by Cancer_Type order by count(*) desc;
-- Top Most Cancer Occuring Type
Select cancer_type,count(*)Total_Cases from Cancer group by Cancer_Type order by count(*) desc limit 3;
-- Breast Cancer - 28169 , Oral Cancer-- 16259 , Cervical Cancer - 13881
-- Cancer Type Deaths
Select cancer_type,count(*)Total_Cases from Cancer where status='Dead' group by Cancer_Type order by count(*) desc;
-- Top Most Cancer Occuring Type
Select cancer_type,count(*)Total_Cases from Cancer where status='Dead' group by Cancer_Type order by count(*) desc limit 3;
-- Total no of Survivals
Select Cancer_Type,count(Status)Overall_Death_Count from Cancer  where Status='Alive' group by Cancer_Type order by Overall_Death_Count desc; -- Most Deaths -- Breast Cancer -- 13458
-- Total Death Percentage
Select Cancer_Type,round(count(status)/(Select count(status) from Cancer where status='Dead')*100,2)Death_Percentage from Cancer where status='Dead' group by Cancer_Type order by Death_Percentage desc; -- Breast Cancer -- 23.14%
-- Total Survival Percentage
Select Cancer_Type,round(count(status)/(Select count(status) from Cancer where status='Dead')*100,2)Survival_Percentage from Cancer where status='Alive' group by Cancer_Type order by Survival_Percentage desc; -- Breast Cancer -- 21.17%


-- Cancer_Type Cases Ranking
Select Cancer_Type,count(*)Case_Count,dense_rank() over(order by count(*) desc)ranking from cancer group by Cancer_Type;
-- Cancer_Type Deaths Ranking
Select Cancer_Type,count(*)Case_Count,dense_rank() over(order by count(*) desc)ranking from cancer where status='Dead' group by Cancer_Type;



-- Age Group Analysis
Select * from Cancer;
-- Total no of Cancer Cases
Select Age_Group,count(*)Total_Cases from Cancer group by Age_Group order by Total_Cases desc; -- Middle Age People Most Affected -- 51932
-- Percentage Affected By Cancer
Select Age_Group,round(count(*)/(Select count(*) from Cancer)*100,2)Total_Cases_Percent from Cancer group by Age_Group order by Total_Cases_Percent desc; -- F- 67.15%, M - 32.85%.
-- Total no of Deaths 
Select Age_Group,count(Status)Overall_Death_Count from Cancer where Status='Dead' group by Age_Group order by Overall_Death_Count desc; -- Most Deaths Middle Aged people -- 32670
-- Total Death Percentage
Select Age_Group,round(count(status)/(Select count(status) from Cancer where status='Dead')*100,2)Death_Percentage from Cancer where status='Dead' group by Age_Group order by Death_Percentage desc; 

-- Middle Age Genderwise Cases Affected
Select gender,Age_Group,count(*)Total_Cases from Cancer where Age_Group='Middle Age' group by gender,Age_Group order by Total_Cases desc; -- F- 38121  M- 13811
-- Middle Age Genderwise Deaths
Select gender,Age_Group,count(status)Total_deaths from Cancer where Age_Group='Middle Age' and status='Dead' group by gender,Age_Group order by Total_deaths desc; -- F- 23075  M- 9595

-- AgeGroupWise Cases Ranking
Select Age_Group,count(*)Case_Count,dense_rank() over(order by count(*) desc)ranking from cancer group by Age_Group;
-- StageWise Deaths Ranking
Select Age_Group,count(*)Case_Count,dense_rank() over(order by count(*) desc)ranking from cancer where status='Dead' group by Age_Group;


-- Cancer StageWise Analysis
Select * from Cancer;
-- Total no of Cancer Cases
Select Stage,count(*)Total_Cases from Cancer group by Stage order by Total_Cases desc; -- Most -- 3- 35261  2 - 24915
-- Percentage Affected By Cancer
Select Stage,round(count(*)/(Select count(*) from Cancer)*100,2)Total_Cases_Percent from Cancer group by Stage order by Total_Cases_Percent desc; -- 3- 35.36% 2 - 24.92%, 4 - 24.77%
-- Total no of Deaths 
Select Stage,count(Status)Overall_Death_Count from Cancer  where Status='Dead' group by Stage order by Overall_Death_Count desc; -- Most Deaths -- 3 - 24092, 4 - 21419
-- Total no of Survivals
Select Stage,count(Status)Overall_Survival_Count from Cancer  where Status='Alive' group by Stage order by Overall_Survival_Count desc; -- 2- 12356, 3-11169
-- Total Death Percentage
Select Stage,round(count(status)/(Select count(status) from Cancer where status='Dead')*100,2)Death_Percentage from Cancer where status='Dead' group by Stage order by Death_Percentage desc; -- 3-37.89%, 4-33.69%
-- Total Survival Percentage
Select Stage,round(count(status)/(Select count(status) from Cancer where status='Dead')*100,2)Survival_Percentage from Cancer where status='Alive' group by Stage order by Survival_Percentage desc; -- highest - 2 - 19.43% lowest - 4 - 5.27%

-- StageWise Cases Ranking
Select Stage,count(*)Case_Count,dense_rank() over(order by count(*) desc)ranking from cancer group by Stage;
-- StageWise Deaths Ranking
Select Stage,count(*)Case_Count,dense_rank() over(order by count(*) desc)ranking from cancer where status='Dead' group by Stage;

-- StateWise Analysis
Select * from Cancer;
-- Total no of Cancer Cases
Select State,count(*)Total_Cases from Cancer group by State order by Total_Cases desc; -- Delhi -- 19938, Karnataka - 10163, Chandigarh - 10108.
-- Percentage Affected By Cancer
Select State,round(count(*)/(Select count(*) from Cancer)*100,2)Total_Cases_Percent from Cancer group by State order by Total_Cases_Percent desc; -- Delhi- 19.94% ,Karnataka - 10.16%, Chandigarh,Gujarat- 10.11%
-- Total no of Deaths 
Select State,count(Status)Overall_Death_Count from Cancer where Status='Dead' group by State order by Overall_Death_Count desc; -- Delhi - 12716, Gujarat - 6456, Chandigarh - 6456
-- Total no of Survivals
Select State,count(Status)Overall_Alive_Count from Cancer where Status='Alive' group by State order by Overall_Alive_Count desc; -- Delhi - 7222, Karnataka - 3726, Kerala - 3698
-- Total Death Percentage
Select State,round(count(status)/(Select count(status) from Cancer where status='Dead')*100,2)Death_Percentage from Cancer where status='Dead' group by State order by Death_Percentage desc; -- Delhi - 20%, Gujarat - 10.15%, Chandigarh-10.15%
-- Total Survival Percentage
Select State,round(count(status)/(Select count(status) from Cancer where status='Alive')*100,2)Alive_Percentage from Cancer where status='Alive' group by State order by Alive_Percentage desc; -- Delhi - 19.83%, Karnataka - 10.23%, Kerala-10.15%

-- StateWise Cases Ranking
Select state,count(*)Case_Count,dense_rank() over(order by count(*) desc)ranking from cancer group by state;
-- StateWise Deaths Ranking
Select state,count(*)Case_Count,dense_rank() over(order by count(*) desc)ranking from cancer where status='Dead' group by state;

-- Year Analysis
Select * from Cancer;
-- Total no of Cancer Cases
Select yr,count(*)Total_Cases from Cancer group by yr order by Total_Cases desc; -- 2024 - 25100, 2022-25063, 2023- 24918
-- Percentage Affected By Cancer
Select yr,round(count(*)/(Select count(*) from Cancer)*100,2)Total_Cases_Percent from Cancer group by yr order by Total_Cases_Percent desc; -- 2024- 25.10% ,2022 - 25.06%, 2023- 24.92%
-- Total no of Deaths 
Select yr,count(*)Total_Cases,count(case when status='Dead' then status end)Overall_Death_Count from Cancer group by yr order by Overall_Death_Count desc; -- 2024 - 15984, 2023 - 15866, 2025 - 15861
-- Total no of Survivals
Select yr,count(*)Total_Cases,count(case when status='Alive' then status end)Overall_Alive_Count from Cancer group by yr order by Overall_Alive_Count desc; -- 2024 - 15984, 2023 - 15866, 2025 - 15861
-- Total Death Percentage
Select yr,count(*)Total_Cases,count(case when status='Dead' then status end)Overall_Death_Count,round(count(case when status='Dead' then status end)/count(*)*100,2)YearWise_Death_Percentage from Cancer group by yr order by Overall_Death_Count desc; -- 2024 - 15984, 2023 - 15866, 2025 - 15861
-- Total Survival Percentage
Select yr,count(*)Total_Cases,count(case when status='Alive' then status end)Overall_Survival_Count,round(count(case when status='Dead' then status end)/count(*)*100,2)YearWise_Survival_Percentage from Cancer group by yr order by Overall_Survival_Count desc; -- 2024 - 15984, 2023 - 15866, 2025 - 15861

-- YearWise Cases Ranking
Select yr,count(*)Case_Count,dense_rank() over(order by count(*) desc)ranking from cancer group by yr;
-- YearWise Deaths Ranking
Select yr,count(*)Case_Count,dense_rank() over(order by count(*) desc)ranking from cancer where status='Dead' group by yr;
