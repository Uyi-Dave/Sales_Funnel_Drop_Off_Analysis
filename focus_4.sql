-- Question:
-- Do users who spend time on the product related page bud don't purchase share any patterns?

-- COMPARING DURATION WITH NON CONVERSION GROUPED BY MONTH
SELECT 
    MONTH,
    ROUND(((SUM(ProductRelated_Duration))/3600)::numeric, 0) AS duration_hours,
     ROUND(
        100.0 * COUNT(CASE WHEN revenue = FALSE THEN 1 END)::NUMERIC / COUNT(*), 
        2
    ) AS non_conversion_rate_percent
FROM 
    online_sessions
WHERE productrelated_duration > 0
GROUP BY
    month
ORDER BY
     CASE month
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




-- COMPARING DURATION WITH NON CONVERSION - Do long durations convert?
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



-- EXIT RATES
SELECT 
    Exit_rate_range,
    COUNT(*) AS total_sessions,
    ROUND(
        100.0 * COUNT(CASE WHEN revenue = FALSE THEN 1 END)::NUMERIC / COUNT(*), 
        2
    ) AS non_conversion_rate_percent
FROM (
    SELECT *,
        ROUND((productrelated_duration / 3600.0)::numeric, 0) AS duration_hours,
        CASE
            WHEN ExitRates BETWEEN 0 AND 0.02 THEN '0–0.02 ER'
            WHEN ExitRates BETWEEN 0.02 AND 0.04 THEN '0.02–0.04 ER'
            WHEN ExitRates BETWEEN 0.04 AND 0.06 THEN '0.04–0.06 ER'
            WHEN ExitRates BETWEEN 0.06 AND 0.08 THEN '0.06–0.08 ER'
            WHEN ExitRates BETWEEN 0.08 AND 0.1 THEN '0.08–0.1 ER'
            WHEN ExitRates BETWEEN 0.1 AND 0.12 THEN '0.1–0.12 ER'
            WHEN ExitRates BETWEEN 0.12 AND 0.14 THEN '0.12–0.14 ER'
            WHEN ExitRates BETWEEN 0.14 AND 0.16 THEN '0.14–0.16 ER'
            WHEN ExitRates BETWEEN 0.16 AND 0.18 THEN '0.16–0.18 ER'
            WHEN ExitRates BETWEEN 0.18 AND 0.2 THEN '0.18–0.2 ER'
            ELSE '>0.2 ER'
        END AS Exit_rate_range
    FROM online_sessions
) AS page_bins
WHERE productrelated_duration > 0
GROUP BY Exit_rate_range
ORDER BY 
    CASE Exit_rate_range
        WHEN '0–0.02 ER' THEN 1
        WHEN '0.02–0.04 ER' THEN 2
        WHEN '0.04–0.06 ER' THEN 3
        WHEN '0.06–0.08 ER' THEN 4
        WHEN '0.08–0.1 ER' THEN 5
        WHEN '0.1–0.12 ER' THEN 6
        WHEN '0.12–0.14 ER' THEN 7
        WHEN '0.14–0.16 ER' THEN 8
        WHEN '0.16–0.18 ER' THEN 9
        WHEN '0.18–0.2 ER' THEN 10
        ELSE 11
    END;