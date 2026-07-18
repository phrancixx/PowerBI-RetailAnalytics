# Dashboard Design

Four report pages, 16:9, theme applied from `theme/RetailAnalytics_NavyGold_Theme.json`. Global slicers synced across all pages except where noted.

## Page 1 — Executive Overview

**Cards (top row):**
- Total Revenue — `[Total Revenue]`
- Total Units Sold — `[Total Units Sold]`
- Average Order Value — `[Average Order Value]`
- Revenue % Change (3Mo) — `[Revenue % Change (3Mo)]`
- Active Branch Count — `[Active Branch Count]`

**Visuals:**
- Line chart: Revenue by Month, split by Branch (`Dim_Date[MonthYear]` on axis, `[Total Revenue]` on values, `Dim_Branch[Branch]` as legend)
- Clustered bar: Revenue by Category
- Donut: Revenue by Brand

## Page 2 — Branch Performance

**Cards:**
- Revenue by Branch — three side-by-side cards or a multi-row card
- Steepest Declining Branch — text card built from `[Steepest Declining Branch %]`
- Avg Order Value by Branch

**Visuals:**
- Clustered column: Monthly Revenue by Branch
- Matrix table: Branch × Category revenue
- KPI visual: Branch revenue trend vs. prior period (`[Revenue MoM %]` as the indicator, `[Total Revenue]` as the trend line)

## Page 3 — Inventory Management

**Cards:**
- Total SKUs — `[Total SKUs]`
- Stockout Risk SKUs — `[Stockout Risk SKUs]` (conditional formatting: red background if > 15)
- Overstocked SKUs — `[Overstocked SKUs]` (amber background if > 8)
- Capital Tied in Overstock (₦) — `[Capital Tied in Overstock (NGN)]`
- Reorder Risk SKUs — `[Reorder Risk SKUs]`

**Visuals:**
- Scatter plot: Days of Supply (x) vs. Avg Daily Sales (y), bubble size = Capital Tied, color = Stock Status
- Table: SKU-level detail (SKU, Branch, Brand, Product, Current Stock, Days of Supply, Stock Status) with conditional formatting — red text for "Stockout Risk", amber for "Overstocked"
- Bar chart: Capital Tied in Overstock, broken down by Branch and Brand

**Page-local slicer:** Stock Status (Stockout Risk / Overstocked / Healthy) — not synced globally, since it only applies to inventory-grain visuals.

## Page 4 — Brand & Category Drilldown

**Cards:**
- Brand with largest revenue decline — text card referencing the minimum of `[Brand Revenue % Change (3Mo)]`
- Huawei Revenue Share — `[Huawei Revenue Share]`

**Visuals:**
- Decomposition tree: Revenue by Branch → Category → Brand → Product
- Line chart: Huawei revenue trend by branch (isolates the anomaly identified in `01_Business_Insights.md`)

## Global Slicers (synced via View → Sync Slicers, Pages 1, 2, 4)

- Date range — `Dim_Date[Date]`, Between slicer, plus a Relative Date option for "last 3 months"
- Branch — `Dim_Branch[Branch]`
- Category — `Dim_Product[Category]`
- Brand — `Dim_Product[Brand]`

## Layout notes

- Header band across all pages: navy background (`#0A1F44`), gold accent rule (`#C9A227`), page title left-aligned, logo placeholder right-aligned.
- Card row height: fixed 100px, four-to-five cards per row, 12px gutter.
- Use the gold accent color only for the single most important number on each page (the "headline" metric) — everything else stays navy/gray, so the accent keeps its signal value.
