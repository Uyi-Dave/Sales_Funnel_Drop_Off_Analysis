/*
Question 1:
At what stage in the user journey do most users drop off?
My Note:
- Do they leave when they get into the Admin page (login,user settings, FAQs),
informational page (about us, product guides, how-to-pages), product related page 
(product listings, category pages, specific item pages)?
- They do not buy when Revenue = FALSE, so do a count and group by Revenue = FALSE
TIME SPENT - Compare the average duration for the three pages (using their duration)
PAGE VISITED COUNT - Count of the number of pages
BOUNCE RATE - % of users who landed on a page & left without any further interaction
*/


-- PAGE VISITORS (NUMBER)
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
)

SELECT 
    admin.admin_page_visitors,
    info.info_page_visitors,
    prod_rel.prod_rel_page_visitors
FROM 
    admin, info, prod_rel;

-- AVERAGE DURATION FOR PAGES

