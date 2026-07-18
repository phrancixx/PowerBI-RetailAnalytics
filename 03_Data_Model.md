# Data Model

## Design principle

A star schema with two fact tables at different grains sharing three conformed dimensions. `Fact_Sales_Monthly` and `Inventory_Snapshot` are deliberately excluded from the active model — see `02_Data_Dictionary.md` for why.

## Tables in the active model

**Fact tables**
- `Fact_Sales_Daily` — grain: one row per SKU per transaction day
- `Fact_Inventory` — grain: one row per SKU (current snapshot)

**Dimension tables**
- `Dim_Date` — one row per calendar day, marked as the model's official Date Table
- `Dim_Branch` — 3 branches
- `Dim_Product` — 138 SKUs with category/brand/cost/price/lead-time attributes

## Relationship diagram (text form)

```
                         ┌───────────────┐
                         │   Dim_Date    │
                         │  (Date Table) │
                         └───────┬───────┘
                                 │ 1:*  (Date)
                                 ▼
┌───────────────┐      ┌─────────────────────┐      ┌───────────────┐
│  Dim_Branch    │ 1:* │  Fact_Sales_Daily    │ *:1  │  Dim_Product   │
│  (3 branches)  │────▶│  (21,010 rows)       │◀─────│  (138 SKUs)    │
└───────┬────────┘      └─────────────────────┘      └───────┬────────┘
        │ 1:*                                                 │ 1:1
        ▼                                                      ▼
┌─────────────────────┐                              (same relationship,
│  Fact_Inventory      │◀─────────────────────────────  SKU is the key)
│  (138 rows)          │
└──────────────────────┘
```

## Relationship table

| From | To | Cardinality | Cross-filter direction | Active |
|---|---|---|---|---|
| `Dim_Date[Date]` | `Fact_Sales_Daily[Date]` | 1:* | Single | Yes |
| `Dim_Branch[Branch]` | `Fact_Sales_Daily[Branch]` | 1:* | Single | Yes |
| `Dim_Branch[Branch]` | `Fact_Inventory[Branch]` | 1:* | Single | Yes |
| `Dim_Product[SKU]` | `Fact_Sales_Daily[SKU]` | 1:* | Single | Yes |
| `Dim_Product[SKU]` | `Fact_Inventory[SKU]` | 1:1 | Single | Yes |

No relationship is defined directly between `Dim_Product` and `Dim_Branch` even though `Dim_Product` carries its own `Branch` column — that column is a descriptive attribute (each SKU is already branch-specific), not a join key. Adding a second relationship there would create an ambiguous filter path; it is intentionally left inactive/unused.

## Why this design

- **Conformed dimensions**: `Dim_Branch`, `Dim_Product`, and `Dim_Date` are shared across both fact tables, so a single Branch or Date slicer filters sales and inventory simultaneously.
- **Different grains, same star**: Sales are transactional (daily), inventory is a snapshot. Keeping them as separate fact tables — rather than forcing inventory into a daily grain it doesn't have — avoids fabricating history that doesn't exist in the source data.
- **SKU as the bridge, not Branch+Product composite**: Because SKU codes are already branch-specific in this dataset (e.g., SKU-3001/3002/3003 are the same phone model at three different branches), a single-column SKU relationship is sufficient and avoids composite-key relationships, which Power BI handles less cleanly.

## Data model checklist

1. Import all five active tables via the Power Query scripts in `power_query/`.
2. Mark `Dim_Date[Date]` as the Date Table (Table tools → Mark as Date Table).
3. Build the five relationships above in Model view.
4. Set `Dim_Branch`, `Dim_Product`, `Dim_Date` to **not** be summarizable by default (right-click columns → set summarization to "Don't summarize" on key columns) to avoid accidental SUM() on text-like IDs.
5. Hide foreign-key columns (`SKU`, `Branch` on fact tables) from Report view once relationships are built, to keep the field list clean for report authors.
