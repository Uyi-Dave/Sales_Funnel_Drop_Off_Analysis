/*
Question:
        What impact does time(month or weekend) have on user purchase behaviour?
*/

SELECT
    CASE 
        WHEN MONTH = 'Jan' THEN 'January'
        WHEN MONTH = 'Feb' THEN 'February'
        WHEN MONTH = 'Mar' THEN 'March'
        WHEN MONTH = 'Apr' THEN 'April'
        WHEN MONTH = 'May' THEN 'May'
        WHEN MONTH = 'June' THEN 'June'
        WHEN MONTH = 'Jul' THEN 'July'
        WHEN MONTH = 'Aug' THEN 'August'
        WHEN MONTH = 'Sep' THEN 'September'    
        WHEN MONTH = 'Oct' THEN 'October'
        WHEN MONTH = 'Nov' THEN 'November'
        WHEN MONTH = 'Dec' THEN 'December'
    END AS Month_Name,
    ROUND(
        100.0 * COUNT(CASE WHEN revenue = TRUE THEN 1 END)::NUMERIC / COUNT(*), 
        2
    ) AS conversion_rate_percent,
    ROUND(
        100.0 * COUNT(CASE WHEN weekend = TRUE AND revenue = TRUE THEN 1 END)::NUMERIC
        / NULLIF(COUNT(CASE WHEN weekend = TRUE THEN 1 END), 0),
        2
    ) AS weekend_conversion_rate,
    ROUND(
        100.0 * COUNT(CASE WHEN weekend = FALSE AND revenue = TRUE THEN 1 END)::NUMERIC
        / NULLIF(COUNT(CASE WHEN weekend = FALSE THEN 1 END), 0),
        2
    ) AS weekday_conversion_rate,
    ROUND(
        100.0 * COUNT(CASE WHEN specialday <> 0 AND revenue = TRUE THEN 1 END):: NUMERIC
        / NULLIF(COUNT(CASE WHEN specialday <> 0 THEN 1 END), 0),
        2
    ) AS specialday_conversion_rate,
    ROUND(AVG(bouncerates)::NUMERIC, 3) * 100 AS avg_bounce_rate_percent
FROM 
    online_sessions
GROUP BY MONTH
ORDER BY 
    CASE MONTH
        WHEN 'Jan' THEN 1
        WHEN 'Feb' THEN 2
        WHEN 'Mar' THEN 3
        WHEN 'Apr' THEN 4
        WHEN 'May' THEN 5
        WHEN 'June' THEN 6
        WHEN 'Jul' THEN 7
        WHEN 'Aug' THEN 8
        WHEN 'Sep' THEN 9
        WHEN 'Oct' THEN 10
        WHEN 'Nov' THEN 11
        WHEN 'Dec' THEN 12
    END;

