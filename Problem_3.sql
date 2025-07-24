-- Question 3: Which traffic sources bring the most valuable (i.e converting) visitors?

SELECT
    CASE
        WHEN TrafficType = 1 THEN 'Direct'
        WHEN TrafficType = 2 THEN 'Organic Search'
        WHEN TrafficType = 3 THEN 'Paid Ads (PPC/SEM)'
        WHEN TrafficType = 4 THEN 'Referral'
        WHEN TrafficType = 5 THEN 'Social Media'
        WHEN TrafficType = 6 THEN 'Email Campaigns'
        WHEN TrafficType = 7 THEN 'Display Ads'
        WHEN TrafficType = 8 THEN 'Affiliate Marketing'
        WHEN TrafficType = 9 THEN 'Influencer Campaigns'
        WHEN TrafficType = 10 THEN 'Push Notifications'
        WHEN TrafficType = 11 THEN 'Retargeting Campaigns'
        WHEN TrafficType = 12 THEN 'Video Ads (YouTube etc.)'
        WHEN TrafficType = 13 THEN 'Native Advertising'
        WHEN TrafficType = 14 THEN 'SMS Campaigns'
        WHEN TrafficType = 15 THEN 'App Traffic'
        WHEN TrafficType = 16 THEN 'Offline Campaigns'
        WHEN TrafficType = 17 THEN 'QR Code Scans'
        WHEN TrafficType = 18 THEN 'Internal Promotions'
        WHEN TrafficType = 19 THEN 'Press Releases/PR'
        ELSE 'Unknown/Others'
    END AS "Traffic Source",
    COUNT(*) AS total_visits,
    SUM(revenue::int) AS purchases_made,
    ROUND(
        100.0 * COUNT(CASE WHEN revenue = TRUE THEN 1 END)::NUMERIC / COUNT(*), 
        2
    ) AS conversion_rate_percent
FROM
    online_sessions
GROUP BY
    traffictype
HAVING
    COUNT(*) >= 100
ORDER BY
    conversion_rate_percent DESC;