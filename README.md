🚲 UrbanRoll: Bike-Share Analytics & Operations Intelligence

📖 Project Overview

This project demonstrates an end-to-end data analytics pipeline, covering the entire lifecycle from raw data processing to actionable business insights. I performed data extraction and transformation on a bike-share dataset using MySQL, followed by building an interactive dashboard to visualize operational trends, user behavior, and system performance.

The project highlights proficiency in database management, complex SQL transformations (CTEs, Window Functions), and translating technical data into meaningful operational visualizations.

🛠 Tech Stack

•Data Extraction & Transformation: MySQL (CTEs, Window Functions, Aggregations)
•Data Visualization: Tableau Dashboard
•Concepts: Exploratory Data Analysis (EDA), Net Flow Analysis, Cohort & Retention Tracking, Storytelling with Data

🚀 Pipeline & Methodology

1.Data Processing & Integrity (The Foundation)
•Database Extraction: Queried over 15,000 records across rides, stations, and users tables within the Project2_analytics database.
•Data Hygiene: Performed data validation checks for null values, false starts (short durations/zero distances), and outlier thresholds.
•Advanced Aggregations: Utilized Window Functions (such as LAG()) and Common Table Expressions (CTEs) to compute Month-over-Month (MoM) growth rates and station net flows.

2.Visualization & Insights (The Output)
•Tableau Dashboard: Developed an interactive dashboard to explore operational metrics, including the 24-hour demand curve, membership splits, and station net flow balances.

📊 Dashboard Preview

| Tableau Dashboard 
| :---: | 
| ![Tableau Dashboard](Images/Dashboard.png)

[Click here to explore the Interactive Tableau Dashboard](https://public.tableau.com/app/profile/attapol.singhprasert/viz/Analytic_rides/Dashboard1#1)

📑 Key Business Insights and recommendations 

1. Operational "Pulse": The Demand Dynamics
Our analysis of over 15,000 rides confirms that UrbanRoll is a primary tool for local transit.
•Peak Demand: We identified a "Double-Hump" trend, with a significant morning rush at 7:00 AM and a peak daily demand at 3:00 PM.
•Recommendation: Rebalancing crews should be active between 10:00 AM and 2:00 PM to ensure fleet availability for the critical afternoon peak.

2. The Subscriber vs. Casual Split
The data indicates two distinct user personas, each serving a unique role in our ecosystem:
•Casual (Explorer): This group represents our primary volume driver, accounting for 10,676 rides. They engage in longer, leisure-oriented trips with an average duration of 34.52 minutes.
•Subscriber (Commuter): These are our core, reliable daily users who prioritize efficiency, with shorter, predictable trips averaging 15 minutes.
•Recommendation: Launch a "Weekend Explorer" pass targeted at Casual users to further increase their usage frequency during off-peak hours.

3. The Rebalancing Crisis
Using Net Flow analysis, we identified stations that act as "Sinks" (excess bike accumulation) versus "Sources" (high demand/bike shortage areas).
•Top Sink: Amy Park St (Typically located in business districts, where bikes accumulate excessively as riders end their trips).
•Top Source: Jennifer Land St (Typically located in residential areas, where bikes are frequently in short supply as riders start their trips).
•Recommendation: Implement "Dynamic Incentives"—offer users a small discount for ending their rides at designated "Source" stations to proactively balance the fleet and reduce operational logistics.

4. Growth & Retention
Our Month-over-Month (MoM) analysis tracks our expansion progress.
•Observation: The initial 219.2% growth spike observed in February 2024 represents our successful market launch phase. Following this, the growth rate has transitioned into a steady stabilization phase.
•Insight: While Casual users drive our total ride volume, our "Power Users" (top 1%) remain the primary contributors to our long-term revenue stability.

## 📂 Project Structure
```text
attapol-data/
├── Data/
│   ├── rides.csv
│   ├── stations.csv
│   └── users.csv
├── Scripts/
│   └── analysis_rides_script.sql
├── images/
│   └── Dashboard.png
└── README.md

Feel free to explore the repository to view the SQL scripts used for the analytic process!