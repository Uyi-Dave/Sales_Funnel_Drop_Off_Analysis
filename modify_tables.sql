COPY online_sessions
FROM 'C:/Users/USER/OneDrive/Desktop/DA/Sales Funnel Drop Off Analysis/Sales_Funnel_Drop_Off_Analysis/online+shoppers+purchasing+intention+dataset/online_shoppers_intention.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

SELECT *
FROM online_sessions
LIMIT 5;