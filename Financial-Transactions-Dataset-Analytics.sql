--Dataset exploration
--How many transactions does the dataset have?
SELECT COUNT(*)
FROM `side-projects-454319.Financial_Transactions_Dataset.transactions_data`;
--13,305,915

--How many merchant categories does the dataset have?
SELECT *
FROM `side-projects-454319.Financial_Transactions_Dataset.mcc_codes`
LIMIT 100;
--109

--What's the average transaction amount
SELECT 
    ROUND(AVG(amount), 2)
FROM `side-projects-454319.Financial_Transactions_Dataset.transactions_data`;
--42.98

-- Which merchant categories generate the highest total spending, and how frequently do customers transact in these categories?
SELECT   t.mcc, 
    m.category, 
    SUM(t.amount) AS total_spent,
    COUNT(t.id) AS total_transactions 
FROM `side-projects-454319.Financial_Transactions_Dataset.transactions_data` t 
JOIN`side-projects-454319.Financial_Transactions_Dataset.mcc_codes` m 
    ON t.mcc = m.mcc_code
GROUP BY t.mcc, m.category
ORDER BY total_spent DESC;

--Who are the top 10 most important clients?
SELECT 
    t.client_id, 
    ROUND(SUM(t.amount), 2) AS total_spent, 
    COUNT(t.id) AS total_transactions
FROM `side-projects-454319.Financial_Transactions_Dataset.transactions_data` t
JOIN `side-projects-454319.Financial_Transactions_Dataset.users_data` u 
    ON t.client_id = u.id
GROUP BY t.client_id
ORDER BY total_spent DESC
LIMIT 10;

--Extract data for time series analysis
SELECT 
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    SUM(t.amount) AS total_spent,
    COUNT(t.id) AS total_transactions
FROM `side-projects-454319.Financial_Transactions_Dataset.transactions_data` t
GROUP BY year, month
ORDER BY year DESC, month DESC;

--Find the high spenders as top 10% of 
WITH SpendingThreshold AS (
    SELECT 
        APPROX_QUANTILES(total_spent, 100)[OFFSET(90)] AS percentile_cutoff
    FROM (
        SELECT 
            client_id, 
            SUM(amount) AS total_spent
        FROM 
            `side-projects-454319.Financial_Transactions_Dataset.transactions_data`
        GROUP BY 
            client_id
    )
)
SELECT 
    t.client_id, 
    SUM(t.amount) AS total_spent
FROM 
    `side-projects-454319.Financial_Transactions_Dataset.transactions_data` t
GROUP BY 
    t.client_id
HAVING 
    SUM(t.amount) >= (SELECT percentile_cutoff FROM SpendingThreshold)
ORDER BY 
    total_spent ASC;

--A total of 122 clients with a minimum total spent of 838,648.95

--Which are the top merchant categories for high-spending customers?
WITH HighSpenders AS (
    SELECT 
        client_id, 
        SUM(amount) AS total_spent
    FROM 
        `side-projects-454319.Financial_Transactions_Dataset.transactions_data`
    GROUP BY 
        client_id
    HAVING 
        SUM(amount) >= 838648.95  -- Adjust the threshold as needed (for example, top 10% of spenders)
)
SELECT  
    t.mcc, 
    m.category, 
    SUM(t.amount) AS total_spent
FROM 
    `side-projects-454319.Financial_Transactions_Dataset.transactions_data` t
JOIN 
    HighSpenders hs 
    ON t.client_id = hs.client_id
JOIN 
    `side-projects-454319.Financial_Transactions_Dataset.mcc_codes` m 
    ON t.mcc = m.mcc_code
GROUP BY 
    m.category, t.mcc
ORDER BY 
    total_spent DESC
    LIMIT 10;

--Create a new table for the demographic information of the high spenders
WITH SpendingThreshold AS (
    SELECT 
        APPROX_QUANTILES(total_spent, 100)[OFFSET(90)] AS percentile_cutoff
    FROM (
        SELECT 
            client_id, 
            SUM(amount) AS total_spent
        FROM 
            `side-projects-454319.Financial_Transactions_Dataset.transactions_data`
        GROUP BY 
            client_id
    )
),
HighSpenders AS (
    SELECT 
        t.client_id, 
        SUM(t.amount) AS total_spent
    FROM 
        `side-projects-454319.Financial_Transactions_Dataset.transactions_data` t
    GROUP BY 
        t.client_id
    HAVING 
        SUM(t.amount) >= (SELECT percentile_cutoff FROM SpendingThreshold)
)
SELECT 
    u.*,
    hs.total_spent
FROM 
    `side-projects-454319.Financial_Transactions_Dataset.users_data` u
JOIN 
    HighSpenders hs 
ON 
    u.id = hs.client_id
ORDER BY 
    hs.total_spent DESC;

-- Identify risky clients (where Debt-to-Income Ratio (DTI) is higher than 40%)
WITH RiskyClients AS (
    SELECT 
        id,
        yearly_income,
        total_debt,
        ROUND((total_debt / NULLIF(yearly_income, 0)) * 100, 2) AS dti_ratio
    FROM `side-projects-454319.Financial_Transactions_Dataset.users_data`
)
SELECT * 
FROM RiskyClients
WHERE dti_ratio > 40
ORDER BY dti_ratio DESC;

--Create a table with the demographic data for those risky clients
WITH RiskyClients AS (
    SELECT 
        id,
        yearly_income,
        total_debt,
        ROUND((total_debt / NULLIF(yearly_income, 0)) * 100, 2) AS dti_ratio
    FROM `side-projects-454319.Financial_Transactions_Dataset.users_data`
)
SELECT u.*, 
       RiskyClients.dti_ratio
FROM `side-projects-454319.Financial_Transactions_Dataset.users_data` u
JOIN RiskyClients
    ON u.id = RiskyClients.id
WHERE RiskyClients.dti_ratio > 40
ORDER BY RiskyClients.dti_ratio DESC;


