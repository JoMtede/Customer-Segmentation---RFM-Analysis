
Customer Segmentation using RFM Analysis (R + Tableau)


Objective
Segment customers to improve targeting, retention, and revenue growth.

Dataset
Source  ("https://www.kaggle.com/datasets/carrie1/ecommerce-data")
Size (~4,300 customers)
Key fields: Customer ID, Purchase Date, Revenue

Methodology
Calculated Recency, Frequency, Monetary
Used quintiles (ntile) for scoring
Created RFM scores and segments using business rules.

Key Insights 
Largest segment: Lost (1,064 customers) → churn risk
Strong base: 1,900 Loyal + Champions → revenue drivers
Identified 299 At-Risk customers → retention opportunity
Strategy
The high proportion of Lost customers suggests a retention gap,
representing a key opportunity to recover revenue more cost-effectively than acquiring new customers
A strong base of Loyal and Champion customers provides a stable revenue foundation,
but requires ongoing engagement to prevent churn
Segment-driven strategies can significantly improve marketing ROI, customer retention, and overall revenue performance
Prioritize Champions and Loyal Customers (~1,900) with premium offers, bundles, and loyalty rewards to maximize customer lifetime value

Dashboard (Tableau)
KPI cards: Total Sales, Total Customers, Average Order Value
Revenue by Segment (bar chart)
Segment distribution overview
RFM heatmap
Customer segment treemap
## dashboard preview
<img width="2385" height="1514" alt="Screenshot 2026-05-03 at 20 16 59" src="https://github.com/user-attachments/assets/961003ab-27c4-401a-afdc-2dc263140f40" />
