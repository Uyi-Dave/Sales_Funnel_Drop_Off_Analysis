/*
Question 2:
        Visitor Type Impact – How do new vs. returning visitors influence conversion rates?
*/

SELECT 
    visitortype AS "Visitor Type",
    SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END) * 100/COUNT(*) AS "Conversion Rate Percentage"
FROM
    online_sessions
GROUP BY
    visitortype;