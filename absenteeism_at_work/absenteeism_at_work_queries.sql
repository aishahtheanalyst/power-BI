# creating a join table 
SELECT *
FROM absenteeism_at_work a
LEFT JOIN compensation c
ON a.ID = c.ID
LEFT JOIN reasons r
ON a.`Reason for absence` = r.Number; 

# find the healthiest employees for the bonus
SELECT *
FROM absenteeism_at_work
WHERE `Social drinker`= 0 
AND `Social smoker` = 0
AND `Body mass index` < 25 
AND `Absenteeism time in hours`< (SELECT AVG(`Absenteeism time in hours`)
FROM absenteeism_at_work);

# compensation rate increase for non-smokers / budget $983,221  so .68 increase per hour / $1,414.40
SELECT COUNT(*) as Non_Smokers
FROM absenteeism_at_work 
WHERE `Social smoker`= 0;

# analysing absenteeism data with additional contextual information
SELECT 
    a.ID,
    r.Reason,
    `Month of absence`,
    `Body mass index`,
    CASE
        WHEN `Body mass index` < 18.5 THEN 'Underweight'
        WHEN `Body mass index` between 18.5 AND 24.9 THEN 'Healthy'
        WHEN `Body mass index` between 25 and 30 THEN 'Overweight'
        WHEN `Body mass index` < 30 THEN 'Obese'
        ELSE 'Unknown'
    END as BMI_Category,
    CASE
        WHEN `Month of absence` IN (12 , 1, 2) THEN 'Winter'
        WHEN `Month of absence` IN (3 , 4, 5) THEN 'Spring'
        WHEN `Month of absence` IN (6 , 7, 8) THEN 'Summer'
        WHEN `Month of absence` IN (9 , 10, 11) THEN 'Autumn'
        ELSE 'Unknown'
    END as Season_Names,
    `Month of absence`,
    `Day of the week`,
    `Transportation expense`,
    `Education`,
    `Son`,
    `Social drinker`,
    `Social smoker`,
    `Pet`,
    `Disciplinary failure`,
    `Age`,
    `Work load Average/day`,
    `Absenteeism time in hours`
FROM
    absenteeism_at_work a
        LEFT JOIN
    compensation c ON a.ID = c.ID
        LEFT JOIN
    reasons r ON a.`Reason for absence` = r.Number; 






