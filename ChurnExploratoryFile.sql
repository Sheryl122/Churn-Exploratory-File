-- Checking which services has the highest churn rate

-- Percentage of churned customers with Phone Service
SELECT PhoneService, COUNT(*) ChurnedPhoneService,
	(SELECT COUNT(PhoneService) 
    FROM `telco-customer-churn`
    WHERE PhoneService = 'YES') AS TotalPhoneService,
CONCAT(ROUND(COUNT(*) * 100 / 
	(SELECT COUNT(*) 
	FROM `telco-customer-churn` 
	WHERE PhoneService = 'YES'), 2), '%') AS CHURNPERCENT
FROM `telco-customer-churn`
WHERE Churn  = 'yes' AND PhoneService = 'YES';


--  Percentage of churned customers with MultipleLines
SELECT MultipleLines, COUNT(MultipleLines) AS MultipleLines,
	(SELECT COUNT(MultipleLines) 
    FROM `telco-customer-churn` WHERE Churn = 'YES') TotalMultiCUSTOMER,   
CONCAT(ROUND(COUNT(MultipleLines) * 100/ 
	(SELECT COUNT(MultipleLines) 
    FROM `telco-customer-churn` WHERE Churn = 'YES'), 2), '%') AS CHURNPERCENT
FROM `telco-customer-churn`
WHERE Churn = 'YES'
GROUP BY MultipleLines;


-- Percentage of churned customers with InternetService
SELECT InternetService, COUNT(InternetService) ChurnedPerInternet,
	(SELECT COUNT(InternetService) 
    FROM`telco-customer-churn` WHERE Churn = 'YES') TOTALCHURNEDINTERNET,    
 CONCAT(ROUND(COUNT(InternetService) * 100/
 (SELECT COUNT(InternetService) 
    FROM`telco-customer-churn` 
    WHERE Churn = 'YES'),3),'%') ChurnedPercentage  
FROM `telco-customer-churn`
WHERE Churn = 'YES'
GROUP BY InternetService
ORDER BY 2 DESC;

-- Checking the range of Monthly Charge so I can write an organized query
SELECT MIN(MonthlyCharges) MinMonthCharge, MAX(MonthlyCharges) MaxMonthCharge
FROM `telco-customer-churn`;

-- Seperating Monthly Charge into sections, and identifying which section has the highest turnout
SELECT COUNT(MonthlyCharges) AS MonthlyChargesSum,
CASE
	WHEN MonthlyCharges < 40 THEN 'Low Charge'
	WHEN MonthlyCharges BETWEEN 40 AND 65 THEN 'Medium Charge'
    WHEN MonthlyCharges BETWEEN 65 AND 90 THEN 'Medium High Charge'
    WHEN MonthlyCharges BETWEEN 90 AND 120 THEN 'Extra High Charge'
END AS MonthlyChargeRange,
CONCAT(ROUND(COUNT(MonthlyCharges)*100/
(SELECT COUNT(MonthlyCharges) FROM `telco-customer-churn` WHERE Churn = 'YES')),'%') AS MonthlyChargePercentage
FROM`telco-customer-churn`
WHERE CHURN = 'YES'
GROUP BY MonthlyChargeRange;

-- Identifying Percentage of Streamers who have churned
SELECT StreamingTV, COUNT(StreamingTV) TotalTVStreamers,
	(SELECT COUNT(StreamingTV) FROM `telco-customer-churn` WHERE churn = 'yes') OverallChurned,
    CONCAT(ROUND(COUNT(StreamingTV)*100/
    (SELECT COUNT(StreamingTV) FROM `telco-customer-churn` WHERE churn = 'yes'),2),'%')
FROM `telco-customer-churn`
WHERE churn = 'yes'
GROUP BY StreamingTV;

-- Comparing churned customers based on age
SELECT SeniorCitizen, COUNT(SeniorCitizen) Senior_vs_Young,
	CONCAT(ROUND(COUNT(SeniorCitizen)*100/
	(SELECT COUNT(SeniorCitizen) FROM `telco-customer-churn` WHERE Churn = 'yes'),2),'%')
FROM `telco-customer-churn`
WHERE Churn = 'yes'
GROUP BY SeniorCitizen;







