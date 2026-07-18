# Retail Sales & Inventory Analytics — Power BI Solution

An end-to-end Power BI analytics solution for a three-branch Nigerian mobile phone retail business (Mbari, Owerri Main, Tetlow), built to diagnose declining sales, manage inventory risk, and monitor branch performance.

## Project status

Findings from this analysis: revenue is ₦3.57B across the tracked period, with one branch (Mbari) down 44.6% quarter-over-quarter, driven almost entirely by a 65.8% collapse in Huawei sales. Inventory analysis surfaces ₦227.9M tied up in overstocked SKUs and 36 SKUs at risk of stocking out before resupply arrives. Full detail is in [`docs/01_Business_Insights.md`](docs/01_Business_Insights.md).

## Repository structure

```
RetailAnalytics-PowerBI/
├── README.md                          — this file
├── LICENSE
├── data/                              — source CSVs (star schema inputs)
│   ├── Dim_Branch.csv
│   ├── Dim_Date.csv
│   ├── Dim_Month.csv
│   ├── Dim_Product.csv
│   ├── Fact_Inventory.csv
│   ├── Fact_Sales_Daily.csv
│   ├── Fact_Sales_Monthly.csv
│   └── Inventory_Snapshot.csv
├── power_query/                       — Power Query (M) scripts, one file per table
│   ├── Dim_Date.pq
│   ├── Dim_Branch.pq
│   ├── Dim_Product.pq
│   ├── Fact_Sales_Daily.pq
│   ├── Fact_Inventory.pq
│   └── Fact_Sales_Monthly.pq
├── dax/
│   └── DAX_Measures.md                — all measures, organized by dashboard page
├── theme/
│   └── RetailAnalytics_NavyGold_Theme.json  — Power BI report theme (navy/gold)
├── docs/
│   ├── 01_Business_Insights.md        — executive summary and findings
│   ├── 02_Data_Dictionary.md          — column-level definitions for every table
│   ├── 03_Data_Model.md               — star schema, relationships, grain
│   ├── 04_Dashboard_Design.md         — page layouts, cards, visuals, slicers
│   └── 05_Deployment_Guide.md         — Desktop → Service publishing, refresh, security
└── assets/
    └── monthly_revenue_by_branch.png  — reference chart (branch revenue trend)
```

## Quickstart

1. Clone or download this repository.
2. Open Power BI Desktop → **Get Data → Text/CSV** is *not* needed — instead use **Home → Transform Data → New Source → Blank Query**, open the Advanced Editor, and paste in each script from `power_query/` in turn.
3. Before running the scripts, create a text parameter named `FolderPath` pointing at your local `data/` folder (see `docs/05_Deployment_Guide.md`, Step 1).
4. Build the relationships listed in `docs/03_Data_Model.md`.
5. Paste the measures from `dax/DAX_Measures.md` into a dedicated `_Measures` table.
6. Apply the theme: **View → Themes → Browse for themes** → select `theme/RetailAnalytics_NavyGold_Theme.json`.
7. Build the four report pages per `docs/04_Dashboard_Design.md`.
8. Publish following `docs/05_Deployment_Guide.md`.

## Data sources

All data is synthetic/anonymized retail data covering three branches, two product categories (Mobile Phones, Phone Accessories), and nine brands, spanning July 2025–June 2026 at daily grain (21,011 transaction rows).

## License

See [`LICENSE`](LICENSE).

## Author

Francis Udochukwu Echebiri
