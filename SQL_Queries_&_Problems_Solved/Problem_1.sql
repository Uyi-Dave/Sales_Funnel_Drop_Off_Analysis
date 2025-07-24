/*
Question 1:
        At what stage in the user journey do most users drop off?
*/

-- Count of sessions with the different page visits
WITH admin AS (
    SELECT 
        COUNT(administrative) AS admin_page_visitors
    FROM online_sessions
    WHERE 
        administrative <> 0
), info AS (
    SELECT 
        COUNT(informational) AS info_page_visitors
    FROM online_sessions
    WHERE 
        informational <> 0
), prod_rel AS (
    SELECT
        COUNT(productrelated) AS prod_rel_page_visitors
    FROM online_sessions
    WHERE 
        productrelated <> 0
), 
-- Average bounce rate for non-revenue sessions
    admin_bounce_rate AS (
    SELECT
        AVG(BounceRates) AS avg_admin_bounce_rate
    FROM online_sessions
    WHERE
        administrative <> 0 AND 
        Revenue = FALSE
), info_bounce_rate AS (
    SELECT
        AVG(BounceRates) AS avg_info_bounce_rate
    FROM online_sessions
    WHERE
        informational <> 0 AND 
        Revenue = FALSE
), prod_bounce_rate AS (
    SELECT
        AVG(BounceRates) AS avg_prod_bounce_rate
    FROM online_sessions
    WHERE
        productrelated <> 0 AND 
        Revenue = FALSE
)

-- Combine the results into a single formatted table
SELECT 
  'Administrative' AS "Stage(Page)",
  admin.admin_page_visitors AS "Page Visitors",
  ROUND((admin_bounce_rate.avg_admin_bounce_rate)::numeric, 4) AS "Average Bounce Rate",
  ROUND((admin.admin_page_visitors * admin_bounce_rate.avg_admin_bounce_rate)::numeric, 0) AS "Drop-Off Estimate"
FROM admin
CROSS JOIN admin_bounce_rate

UNION ALL

SELECT 
  'Informational' AS "Stage(Page)",
  info.info_page_visitors AS "Page Visitors",
  ROUND((info_bounce_rate.avg_info_bounce_rate)::numeric, 4) AS "Average Bounce Rate",
  ROUND((info.info_page_visitors * info_bounce_rate.avg_info_bounce_rate)::numeric, 0) AS "Drop-Off Estimate"
FROM info
CROSS JOIN info_bounce_rate

UNION ALL

SELECT 
  'Product Related' AS "Stage(Page)",
  prod_rel.prod_rel_page_visitors AS "Page Visitors",
  ROUND((prod_bounce_rate.avg_prod_bounce_rate)::numeric, 4) AS "Average Bounce Rate",
  ROUND((prod_rel.prod_rel_page_visitors * prod_bounce_rate.avg_prod_bounce_rate)::numeric, 0) AS "Drop-Off Estimate"
FROM prod_rel
CROSS JOIN prod_bounce_rate;

