/*
Question 2:
        How do visitor types (New vs Returning) affect conversion rates?
        */

SELECT 
    visitortype AS "Visitor Type",
    SUM(CASE WHEN revenue = TRUE THEN 1 ELSE 0 END) * 100/COUNT(*) AS "Conversion Rate Percentage"
FROM
    online_sessions
GROUP BY
    visitortype;