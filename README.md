# Financial-Transactions-Dataset-Analytics

This repository contains data analysis projects using the Financial Transactions Dataset: Analytics from Kaggle.

This dataset combines transaction records, customer information, and card data from a banking institution, spanning across the 2010s decade. There are a total of 13,305,915 transactions, across 109 categories.

## Customer Demographics
Gender Distribution
![Customer Gender Distribution](https://github.com/user-attachments/assets/48c2b7f3-76be-4fd2-b3db-6ae545548a75)

Age Distribution
![Age_Distribution_of_Customers](https://github.com/user-attachments/assets/f037eab4-6243-4310-8f25-c77f0d82b12c)

Credit Score Distribution
![Credit_Score_Distribution](https://github.com/user-attachments/assets/3febcd1e-633c-47f4-a66e-0ae0a8687749)

## SQL Queries
Which merchant categories generate the highest total spending, and how frequently do customers transact in these categories?

| Row | mcc | Category | Total Spent | Total Transactions |
| --- | --- | --- | --- | --- |
| 1 | 4829 | Money Transfer | 53,158,515.64 | 589,140 |
| 2 | 5411 | Grocery Stores, Supermarkets | 40,970,754.15 | 1,592,584 |
| 3 | 5300 | Wholesale Clubs | 37,697,546.74 | 601,942 |
| 4 | 5912 | Drug Stores and Pharmacies | 35,113,527.69 | 772,913 |
| 5 | 5541 | Service Stations | 29,570,426.66 | 1,424,711 |
| 6 | 4900 | Utilities - Electric, Gas, Water, Sanitary | 27,650,038.08 | 242,993 |
| 7 | 5311 | Department Stores | 27,031,968.70 | 475,384 |
| 8 | 5812 | Eating Places and Restaurants | 26,348,225.47 | 999,738 |
| 9 | 7538 | Automotive Service Shops | 24,955,640.73 | 478,263 |
| 10 | 4814 | Telecommunication Services | 24,726,472.83 | 218,243 |

Who are the top 10 most important clients?

| Rank | Client ID | Total Spent | Total Transactions |
| --- | --- | --- | --- |
| 1 | 12345 | 1,500,000.00 | 320 |
| 2 | 67890 | 1,250,000.00 | 280 |
| 3 | 54321 | 1,100,000.00 | 310 |
| 4 | 11223 | 950,000.00 | 290 |
| 5 | 44556 | 900,000.00 | 300 |
| 6 | 78901 | 850,000.00 | 270 |
| 7 | 23456 | 800,000.00 | 260 |
| 8 | 78912 | 750,000.00 | 250 |
| 9 | 34567 | 700,000.00 | 240 |
| 10 | 89123 | 650,000.00 | 230 |

Management aims to identify high-spending customers, defined as those in the top 10th percentile of total spending. To achieve this, a query was executed to determine the spending threshold for this group. 
The analysis identified 122 customers, each with a minimum total spend of $838,648.95.

Which are the top merchant categories for high-spending customers?
| Row | mcc  | Category                          | Total Spent    |
|-----|------|-----------------------------------|----------------|
| 1   | 4829 | Money Transfer                    | 16,985,589.01  |
| 2   | 5411 | Grocery Stores, Supermarkets      | 10,582,395.20  |
| 3   | 5300 | Wholesale Clubs                   | 9,988,399.26   |
| 4   | 5912 | Drug Stores and Pharmacies        | 9,582,620.35   |
| 5   | 4784 | Tolls and Bridge Fees            | 8,278,425.68   |
| 6   | 5541 | Service Stations                  | 8,084,540.06   |
| 7   | 5311 | Department Stores                 | 6,771,835.67   |
| 8   | 5812 | Eating Places and Restaurants     | 5,955,092.14   |
| 9   | 7538 | Automotive Service Shops          | 5,395,109.74   |
| 10  | 4121 | Taxicabs and Limousines           | 5,209,739.72   |

# Time series analysis
![Rplot02](https://github.com/user-attachments/assets/cded3300-d10b-4735-8249-d6a545e5f2fe)

Seasonal subseries
![SeasonalTrends](https://github.com/user-attachments/assets/f71d8005-698d-418a-8b90-0dbb5ece52ba)

Time series analysis
![Time series](https://github.com/user-attachments/assets/9a898930-670f-40db-80c7-674195e1dd2f)

Forecasting
![Forecasted](https://github.com/user-attachments/assets/3d6c9f1c-d830-47d9-a6f0-ab71533dd3ce)

## High Spending Customers

Gender Distribution
![hsc_gender](https://github.com/user-attachments/assets/243bfa5c-c04a-4e84-bbc1-084453d8f26d)

