/*
Question 4:
        Abandonment Behavior – Are there common traits among users who explore products but don’t convert?
*/

SELECT 
    time_bracket,
    COUNT(*) AS total_sessions,
    ROUND(
        100.0 * COUNT(CASE WHEN revenue = FALSE THEN 1 END)::NUMERIC / COUNT(*), 
        2
    ) AS non_conversion_rate_percent
FROM (
    SELECT *,
        ROUND((productrelated_duration / 3600.0)::numeric, 0) AS duration_hours,
        CASE
            WHEN productrelated_duration / 3600.0 BETWEEN 0 AND 2 THEN '0–2 hours'
            WHEN productrelated_duration / 3600.0 BETWEEN 2 AND 4 THEN '2–4 hours'
            WHEN productrelated_duration / 3600.0 BETWEEN 4 AND 6 THEN '4–6 hours'
            WHEN productrelated_duration / 3600.0 BETWEEN 6 AND 8 THEN '6–8 hours'
            WHEN productrelated_duration / 3600.0 BETWEEN 8 AND 10 THEN '8–10 hours'
            ELSE 'Above 10 hours'
        END AS time_bracket
    FROM online_sessions
) AS session_bins
WHERE productrelated_duration > 0
GROUP BY time_bracket
ORDER BY 
    CASE time_bracket
        WHEN '0–2 hours' THEN 1
        WHEN '2–4 hours' THEN 2
        WHEN '4–6 hours' THEN 3
        WHEN '6–8 hours' THEN 4
        WHEN '8–10 hours' THEN 5
        ELSE 6
    END;



