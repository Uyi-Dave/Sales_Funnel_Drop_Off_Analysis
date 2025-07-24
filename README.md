## 📊PROJECT OVERVIEW
### 🏷️ **TITLE:**  **Sales Funnel Drop-Off Analysis Using SQL and Power BI**

❓ **PROBLEM STATEMENT**

Many online businesses struggle to understand where and why users drop off before completing a purchase. Without clarity on these drop-off points, valuable opportunities to optimize the user journey and increase revenue are lost. Identifying behavioral patterns and conversion blockers is crucial to improving user experience and business outcomes.

🎯 **PROJECT GOAL**

To analyze user behavior across different stages of an online shopping funnel, identify where most users drop off, and uncover insights that can inform decisions to improve conversion rates and user engagement. This includes segmenting user activity by traffic source, visitor type, session timing, and product interaction.

🛠️ **TOOLS USED**

- ***SQL (PostgreSQL)*** – For querying and analyzing raw session data.

- ***Power BI*** – For interactive data visualization and dashboard creation.

- ***Visual Studio Code (VS Code)*** – As the primary code editor.




## 🧹DATA & CLEANING
### 📂 **DATA SOURCE** ###

The dataset used in this project was sourced from UC Irvine Machine Learning Repository, titled "Online Shoppers Purchasing Intention Dataset". It contains detailed records of individual user sessions on an e-commerce website collected over a one-year period.
Find dataset here: [Online Shoppers Purchasing Intention Dataset](/project_file/online_shoppers_intention.csv) 

Each row represents a unique session by a unique user — eliminating repeat bias and offering a wide view of behavioral patterns across 12,330 visitors.

### 🧾 **DATA SUMMARY** ###
The dataset consists of 18 columns capturing user behavior, engagement metrics, session characteristics, and final outcomes. Below are the most relevant columns analyzed in this project:
| Column                        | Description                                               | Business Relevance                                                  |
| ----------------------------- | --------------------------------------------------------- | ------------------------------------------------------------------- |
| **Administrative / Duration** | Number & time spent on admin pages (e.g., FAQs, login).   | Can hint at pre-purchase hesitation or post-decision navigation.    |
| **Informational / Duration**  | Pages like “About Us” or product help pages.              | High interaction may signal strong interest or uncertainty.         |
| **ProductRelated / Duration** | Key pages like product listings and item details.         | Core funnel engagement metric — vital for conversion analysis.      |
| **BounceRates / ExitRates**   | Bounce = left immediately; Exit = last page visited.      | Identifies weak entry points and critical exit zones.               |
| **PageValues**                | Average value contributed by a visit to each page.        | Insight into which pages influence revenue directly.                |
| **SpecialDay**                | Indicates how close a session was to a marketing holiday. | Useful for promotional timing and behavior shifts.                  |
| **Month**                     | Session month (e.g., Feb, Nov).                           | Helps spot seasonal buying trends or dips.                          |
| **TrafficType**               | Traffic origin (direct, referral, ad campaigns, etc.).    | Measures acquisition quality and drop-off patterns.                 |
| **VisitorType**               | Visitor status (New vs Returning).                        | Returning visitors are more likely to convert. (We'll verify).                      |
| **Weekend**                   | Whether session occurred on a weekend.                    | Behavioral differences often emerge here.                           |
| **Revenue** ✅                 | Binary indicator of purchase: `TRUE` or `FALSE`.          | The main target — distinguishes converting vs non-converting users. |


- 🧠 Note: Duration values (like ProductRelated_Duration) are recorded in seconds, not minutes. For example, a value of 300 = 5 minutes spent.

### 🧩 **ENCODED COLUMNS EXPLAINED** ###

Some columns use numeric encoding instead of text labels:
| Column               | Meaning                                               |
| -------------------- | ----------------------------------------------------- |
| **OperatingSystems** | Numeric codes for OS types (e.g., 1 = Windows, etc.). |
| **Browser**          | Encoded browser type (e.g., Chrome, Safari).          |
| **Region**           | Represents geographic user zones.                     |
| **TrafficType**      | Campaign or channel categories.                       |
These were treated as categorical variables, not quantitative measures.

### 🧼 **CLEANING & FORMATTING STEPS** ###
To ensure clarity and ease of analysis, the following cleaning steps were performed:

- ***Categorical Mapping:*** Numerical codes in columns like OperatingSystems, Browser, and TrafficType were mapped to more interpretable labels where applicable.

- ***Date Consistency:*** Month values were standardized for chronological ordering and seasonal trend analysis.

- ***Boolean Consistency:*** Revenue and Weekend values were validated as logical TRUE/FALSE, ensuring consistency across rows.

- ***Type Conversion:*** Duration values remained in seconds, but were later converted to minutes/hours during analysis for clearer insight communication.

- ***Missing Values:*** The dataset was already clean with no null values — a rare benefit that allowed direct analysis.

```sql
-- Example: Mapping Traffic Type codes to readable labels
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
    END AS "Traffic Source";
```

## 📈DATA ANALYSIS
 This section explores user behavior and conversion patterns across various dimensions of the online sales funnel. The goal was not just to observe trends, but to answer critical business questions using data-driven evidence.

Each analysis is supported by visuals and was framed around a specific, actionable business question.

**1.**  ***Where Do Most Users Drop Off in the Sales Funnel?***

**Focus:** Page category engagement (Administrative, Informational, Product-related)

**Metric Analyzed:** Bounce rate + Drop-off estimate

Despite the majority of visitors (12,292) reaching product-related pages, this stage still experienced the highest drop-off estimate (308 users), with a noticeable bounce rate of 2.5% — a sharp contrast to administrative and informational stages.

📌 **Insights:**

- Product pages are the core funnel area, but users often leave at this critical decision-making point.

- Low bounce rates in earlier stages suggest visitors are initially engaged — but something fails to convert this interest into action.

💡 **Business Implication:** Improving product page performance (speed, layout, CTAs, trust signals like reviews or badges) could significantly reduce lost opportunities.

![Drop-Off Estimate](Relevant_Charts/USERS%20DROP-OFF%20BY%20PAGE.png)
*Bar graph visualizing the drop-off estimates per page for users*


**2.** ***Do New vs. Returning Visitors Convert Differently?***

**Focus:** Visitor segmentation

**Metric Analyzed:** Conversion Rate by Visitor Type

Surprisingly, New Visitors recorded the highest conversion rate (24%), while Returning Visitors trailed behind at 13%.

📌 **Insights:**

- This suggests that many users make fast purchase decisions—perhaps influenced by urgency or well-targeted entry points.

- Returning visitors may be exploring more or comparing options, hence lower conversion.

💡 **Business Implication:** Leverage remarketing strategies (like email follow-ups or cart reminders) to nudge returning visitors further down the funnel.

![Visitor Segmentation](Relevant_Charts/Conversion%20Impact.png)
*The chart above shows the conversion patterns for new visitors versus returning visitors*

 **3.** ***Which Traffic Sources Bring the Most Valuable Visitors?***

**Focus:** Marketing channel efficiency

**Metric Analyzed:** Conversion Rate by Traffic Source
### 🛣️ Conversion Rates by Traffic Source

| Traffic Source           | Total Visits | Purchases Made | Conversion Rate (%) |
|--------------------------|--------------|----------------|----------------------|
| Affiliate Marketing      | 343          | 95             | 27.70                |
| Unknown/Others           | 198          | 50             | 25.25                |
| Organic Search           | 3913         | 847            | 21.65                |
| Social Media             | 260          | 56             | 21.54                |
| Push Notifications       | 450          | 90             | 20.00                |
| Retargeting Campaigns    | 247          | 47             | 19.03                |
| Referral                 | 1069         | 165            | 15.43                |
| Email Campaigns          | 444          | 53             | 11.94                |
| Direct                   | 2451         | 262            | 10.69                |
| Paid Ads (PPC/SEM)       | 2052         | 180            | 8.77                 |
| Native Advertising       | 738          | 43             | 5.83                 |

📌 **Insights:**

- Affiliate marketing and organic channels drive high-value traffic.

- Paid advertising channels like PPC/SEM (8.8%) and Native Ads (5.8%) underperform.

💡 **Business Implication:** Consider reallocating budget from low-converting paid channels to organic and affiliate partnerships for better ROI.

**4.** ***Do Users Who Don’t Purchase Share Any Time-Based Patterns?***

**Focus:** Time spent on product-related pages

**Metric Analyzed:** Non-conversion rate by time bracket

Sessions under 2 hours of product engagement had the highest non-conversion rate (84%), but even longer sessions (up to 10+ hours) did not guarantee conversion.

📌 **Insights:**

- Most users decide quickly — prolonged browsing doesn't strongly correlate with purchase.

- Extremely long browsing (8+ hours) had 100% non-conversion — possibly due to confusion, distraction, or abandonment.

💡 **Business Implication:** Focus on creating a frictionless buying experience within the first 1–2 hours of user interaction.

![Time Spent on Product-related pages](/Relevant_Charts/ENGAGED%20NON-BUYERS.png)
*Bar graph showing the non-conversion rate by time bracket with a focus on product pages*


 **5.** ***How Does Timing (Month, Weekend, Special Days) Affect Conversions?***

**Focus:** Temporal behavior analysis

**Metric Analyzed:** Monthly, weekly, and special day conversion patterns

### 🗓️ Conversion Rate by Month & Special Days

| Month      | Overall Conversion Rate (%) | Special Day Conversion Rate (%) |
|------------|------------------------------|----------------------------------|
| February   | 1.63                         | 2.53                             |
| March      | 10.07                        | —                                |
| May        | 10.85                        | 6.40                             |
| June       | 10.07                        | —                                |
| July       | 15.28                        | —                                |
| August     | 17.55                        | —                                |
| September  | 19.20                        | —                                |
| October    | 20.95                        | —                                |
| November   | 25.35                        | —                                |
| December   | 12.51                        | —                                |

ℹ️ The “—” symbol indicates that no special day conversion data was recorded for that month.

📌 **Insights:**

- Conversion peaks in Q4, with November (likely due to Black Friday/Cyber Monday) showing the highest rate.

- Weekend conversion rates were generally higher than weekday rates, especially in low-performing months like February.

- Interestingly, Special Days didn’t consistently drive higher conversion, suggesting that campaigns during these periods may need improvement.

💡 **Business Implication:** Focus promotional campaigns around high-performing months (Sept–Nov) and weekends, while re-evaluating special-day messaging to boost effectiveness.
![Weekdays vs Weekends Conversion Rate](/Relevant_Charts/Conversion%20Rates%20-%20Weekdays%20vs%20Weekends.png)
*The above chart represents the coparison between weekdays and weekends conversion rate*

## 📊 DASHBOARD SUMMARY
![Dashboard Image](/Dashboard/Dashboard.png)
*This shows the dashboard for online shoppers' sales funnel analysis*

The Online Shoppers' Sales Funnel Analysis dashboard provides a comprehensive overview of user behavior, conversion patterns, and drop-off points throughout the e-commerce funnel. It distills insights from over 12,330 unique sessions, identifying the key drivers and blockers of online sales.

🧠 **Key Metrics Overview**
- ***Total Sessions Analyzed:*** 12.33K

- ***Overall Conversion Rate:*** 15.47%

- ***Maximum Exit Rate (per page):*** 0.20

🔻 **User Drop-Off by Page**

A major highlight of the dashboard is the funnel drop-off visualization across different page categories:

- ***Product-Related Pages:*** 308 users dropped off — the largest drop-off stage.

- ***Administrative Pages:*** 55 users dropped off.

- ***Informational Pages:*** 24 users dropped off.

**📌 Takeaway:** 

The product stage, while the most visited, is where interest often fails to convert — signalling a critical point for optimization.

👥 **Conversion by Visitor Type**

***New Visitors:*** 24% conversion rate

***Other:*** 18%

***Returning Visitors:*** 13%

📌 **Takeaway:** 

New visitors are converting at a higher rate than returning users, highlighting the importance of first-impression strategies.


🌐 **High-Converting Traffic Sources**

The dashboard breaks down traffic source performance:

| Traffic Source      | Conversion Rate (%) |
| ------------------- | ------------------- |
| Affiliate Marketing | 27.7%               |
| Unknown/Others      | 25.25%              |
| Organic Search      | 21.65%              |
| Social Media        | 21.54%              |
| Push Notifications  | 20.00%              |

📌 **Takeaway:** 

Organic and affiliate sources bring in higher-intent visitors, while paid ads and native advertising underperform — suggesting potential reallocation of marketing spend.

🕒 **Product Page Duration vs Non-Conversions**

The dashboard visualizes non-buyers by the time they spent on product-related pages:

- Sessions lasting under 2 hours had the highest non-conversion rate (84%).

- Longer sessions (8–10 hours and above) saw 100% non-conversion, indicating diminishing returns in prolonged browsing.

📌 **Takeaway:** 

Speed and clarity of decision-making may be key. Extended browsing doesn’t necessarily equate to stronger intent.

📅 **Time-Based Conversion Patterns**

🗓️ **By Month:**
Top-performing months:

- ***November:*** 25.35%

- ***October:*** 20.95%

- ***September:*** 19.20%


🕔 **Weekday vs Weekend:**

- In most months, weekend conversion rates were higher than weekdays.

- ***Exception:*** Some months like August saw higher weekday conversions.

📌 **Takeaway:** The Q4 period is the most profitable, and weekends generally drive higher intent — valuable for campaign timing and budget planning.



## ✅RECOMMENDATIONS/OUTCOME
Based on the insights derived from the data analysis and dashboard, the following recommendations are made to solve the key business problem — high drop-off rates and suboptimal conversion across user journeys.

🔻 **1.** **Optimize Product-Related Pages to Reduce Drop-Off
Insight:** Product-related pages have the highest user drop-off (308 users) despite being the most visited.

**Implication:**  This is the critical decision-making stage — and users are bouncing before committing.

**Recommendation:**

- Improve page speed, layout, and responsiveness

- Add clear CTAs, product comparisons, trust badges, and social proof (e.g. reviews, testimonials)

- Reduce friction in navigating to checkout from product views

👥 **2.** **Segment & Nurture Returning Visitors**

**Insight:** New visitors convert at a higher rate (24%) than returning ones (13%).

**Implication:** Returning users may need more convincing or better re-engagement strategies.

**Recommendation:**

- Use personalized follow-ups, cart reminders, and email retargeting

- Create special offers or incentives for return visitors

- Analyze returning sessions to identify repeat pain points (e.g. unclear policies, pricing concerns)

🌐 **3.** **Reallocate Marketing Spend to High-Converting Channels**

**Insight:** Affiliate marketing and organic search outperform paid ads significantly in conversion rates.

**Implication:** ROI is low on some expensive channels like PPC and native advertising.

**Recommendation:**

- Increase investment in affiliate partnerships and SEO content

- Reassess and optimize low-performing channels before continuing ad spend

- Use insights to better target audiences on underperforming platforms

🕒 **4.** **Shorten the Path to Purchase** — Time is Not Commitment

**Insight:** 

The vast majority of purchases happen within the 2-4 hours of engagement. Longer sessions don’t equate to stronger intent — some of them had 100% non-conversion.

**Implication:** Users who linger too long may be confused, overwhelmed, or distracted.

**Recommendation:**

- Simplify the buying journey with fewer clicks to checkout

- Offer live chat support or nudges during prolonged sessions

- Use exit-intent popups with limited-time offers to prompt action

📆 **5.** **Maximize Campaigns Around High-Performing Time Periods**

**Insight:** Conversions peak in November, October, and September, and are generally higher on weekends.

**Implication:** Timing plays a significant role in buyer behavior.

**Recommendation:**

- Schedule major promotions, launches, or flash sales around Q4 and weekends

- Extend weekend promotions slightly into Mondays for lingering traffic

- Review special-day campaign effectiveness to improve targeting and design

🧩 **FINAL OUTCOME**

Through this analysis, we’ve identified not just where users drop off — but why they might be doing so, and what can be done to recover these lost opportunities. With strategic implementation of these recommendations, businesses can expect:

- 📈 Improved conversion rates

- 💸 Better ROI on marketing spend

- 🤝 More engaged visitors and shorter sales cycles

- 🧠 Smarter, data-driven decisions for future campaign planning

## 🎓WHAT I LEARNED
This project was a hands-on opportunity to move beyond theory and apply data analysis techniques to a real-world business problem. Here are some of my key takeaways:

💡 **1.** ***Translating Business Questions into Data-Driven Answers***

Instead of just running queries or building charts, I focused on framing each analysis around a specific business question — such as *“Where do most users drop off?”* or *“Which traffic sources are worth investing in?”* This helped me learn how to bridge the gap between data and business decision-making, which is a crucial skill for any data analyst.

📊 **2.** ***My First Real Project Using Power BI***

This was my first time using Power BI for data visualization in a full project — and it taught me a lot:

- How to design dashboards that communicate clearly to both technical and non-technical audiences

- How to use filters, cards, tables, and visual hierarchies to emphasize key insights

- How to keep the layout clean and business-friendly without overloading it

Though I initially struggled with organizing visuals and getting Power BI to sync with the metrics I needed, I was able to troubleshoot layout and filtering issues effectively. I also learned to export key visuals into reports/PDFs, which is important for stakeholder presentation.

🧹 **3.** ***Importance of Clean, Well-Labeled Data***

Cleaning the dataset helped me understand the impact of formatting — from converting coded values (e.g. OperatingSystems, VisitorType) to mapping categorical variables for clearer analysis. Presenting the data in human-readable terms made the insights more intuitive and useful, especially when creating visuals and summaries.

⚙️ **4.** ***Working with SQL in a Business Context***

I enhanced my ability to write efficient SQL queries tailored to answer real business questions. I also learned how to:

- Group, filter, and join data across different dimensions

- Use time-based groupings (e.g., monthly breakdowns, session durations)

- Convert raw metrics into meaningful KPIs (conversion rates, bounce estimates)

When one of my SQL queries gave me a misleading 100% in the monthly breakdown, I asked for help and learned to check my filters and denominators carefully — a subtle but important lesson.

💬 **5.** ***Communicating Data Stories Clearly***

Putting together the README made me realize the importance of not just analyzing the data, but explaining it well:

- Framing recommendations in plain language

- Showing visual and written evidence to back each point

- Designing for both analysts and business owners

This experience improved both my technical storytelling and my ability to communicate findings in a clear, structured, and insightful way.

🙌 **Final Reflection**

Overall, this project helped me integrate SQL querying, data visualization, and business insight generation into a cohesive workflow. I now feel more confident tackling real-life business problems and presenting insights in a way that drives decisions — not just reports numbers.