# Data Dictionary

Source: eight CSV files provided as the raw inputs for the model. All monetary values are in Nigerian Naira (NGN).

## Dim_Branch (3 rows)

| Column | Type | Description |
|---|---|---|
| Branch | Text | Branch name — Mbari, Owerri Main, or Tetlow |

## Dim_Date (365 rows)

| Column | Type | Description |
|---|---|---|
| Date | Date | Calendar date, one row per day, Jul 2025–Jun 2026 |
| Year | Whole number | Calendar year |
| MonthNumber | Whole number | Month number within the fiscal year sequence (1–12, starting July) |
| MonthName | Text | Three-letter month abbreviation (Jul, Aug, …) |
| MonthYear | Text | "YYYY-MM" key used to join to Dim_Month / Fact_Sales_Monthly |
| Quarter | Text | Fiscal quarter (Q1–Q4) |
| DayOfWeek | Text | Day name (Monday–Sunday) |
| DayOfWeekNum | Whole number | Numeric day-of-week index |
| IsMonday | True/False | Flag for Monday |
| IsWeekend | True/False | Flag for Saturday/Sunday |
| Half | Text | Half-year label ("H1 (Jul-Dec)" / "H2 (Jan-Jun)") |

## Dim_Month (12 rows)

| Column | Type | Description |
|---|---|---|
| MonthYear | Text | "YYYY-MM" key, matches Dim_Date and Fact_Sales_Monthly |
| Half | Text | Half-year label |
| MonthNumber | Whole number | Sequence number within the fiscal year |

*Only needed if a separate monthly-grain page is built off Fact_Sales_Monthly — not used in the primary model (see Section 1 of `03_Data_Model.md`).*

## Dim_Product (138 rows)

| Column | Type | Description |
|---|---|---|
| SKU | Text | Unique stock-keeping unit code — branch-specific (each branch carries its own SKU code for the same product) |
| Branch | Text | Branch this SKU is stocked at |
| Category | Text | Mobile Phones or Phone Accessories |
| Brand | Text | Manufacturer brand (Tecno, Huawei, Samsung, Infinix, Itel, Redmi, Oppo, Vivo, Generic) |
| Product | Text | Model/product name |
| Unit Cost (NGN) | Decimal | Cost to the business per unit |
| Unit Price (NGN) | Whole number | Retail selling price per unit |
| Lead Time (Days) | Whole number | Supplier lead time to restock this SKU |

## Fact_Inventory (138 rows)

| Column | Type | Description |
|---|---|---|
| SKU | Text | Foreign key to Dim_Product |
| Branch | Text | Foreign key to Dim_Branch |
| Current Stock (Units) | Whole number | Units on hand at snapshot time |
| Avg Daily Sales (Units) | Decimal | Trailing average daily sell-through rate |

Grain: one row per SKU (current snapshot, not time-series).

## Fact_Sales_Daily (21,010 rows)

| Column | Type | Description |
|---|---|---|
| Date | Date | Transaction date, foreign key to Dim_Date |
| SKU | Text | Foreign key to Dim_Product |
| Branch | Text | Foreign key to Dim_Branch |
| Units Sold | Whole number | Units sold on this date for this SKU |
| Revenue (NGN) | Whole number | Revenue generated on this date for this SKU |

Grain: one row per SKU per transaction day. Primary fact table for all time-series and revenue analysis.

## Fact_Sales_Monthly (1,656 rows)

| Column | Type | Description |
|---|---|---|
| MonthYear | Text | Foreign key to Dim_Month / Dim_Date |
| SKU | Text | Foreign key to Dim_Product |
| Branch | Text | Foreign key to Dim_Branch |
| Units Sold | Whole number | Units sold in this month for this SKU |
| Revenue (NGN) | Whole number | Revenue generated in this month for this SKU |

Grain: one row per SKU per month — a pre-aggregation of Fact_Sales_Daily. **Excluded from the active data model** to avoid double-counting; retained for validation only.

## Inventory_Snapshot (138 rows)

A flattened join of Fact_Inventory + Dim_Product (all inventory and product attributes in one table). **Excluded from the active data model** — everything in it is reachable through the Fact_Inventory → Dim_Product relationship. Kept as a convenience export for quick pivot-table checks outside Power BI.
