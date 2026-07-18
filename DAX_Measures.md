# DAX Measures & Calculated Columns

Create a dedicated measure table first: `Home → Enter Data → name it "_Measures" → Load` (an empty table with no rows is fine). Park every measure below there and set a Display Folder per page (right-click a measure → Properties → Display Folder) using the section headers as folder names.

---

## Calculated Columns (add in Data view before writing measures)

**On `Fact_Inventory`:**

```dax
Lead Time (Days) = RELATED(Dim_Product[Lead Time (Days)])
```

```dax
Reorder Risk Flag =
IF(
    Fact_Inventory[Days of Supply] < Fact_Inventory[Lead Time (Days)],
    "At Risk",
    "OK"
)
```

```dax
Stock Status =
SWITCH(
    TRUE(),
    Fact_Inventory[Days of Supply] < 14, "Stockout Risk",
    Fact_Inventory[Days of Supply] > 90, "Overstocked",
    "Healthy"
)
```

```dax
Capital Tied (NGN) = Fact_Inventory[Current Stock (Units)] * RELATED(Dim_Product[Unit Cost (NGN)])
```

---

## Folder: Executive Overview

```dax
Total Revenue = SUM(Fact_Sales_Daily[Revenue (NGN)])
```

```dax
Total Units Sold = SUM(Fact_Sales_Daily[Units Sold])
```

```dax
Average Order Value = DIVIDE([Total Revenue], [Total Units Sold])
```

```dax
Active Branch Count = DISTINCTCOUNT(Fact_Sales_Daily[Branch])
```

```dax
Revenue MoM % =
VAR CurrentRev = [Total Revenue]
VAR PriorRev = CALCULATE([Total Revenue], DATEADD(Dim_Date[Date], -1, MONTH))
RETURN DIVIDE(CurrentRev - PriorRev, PriorRev)
```

```dax
Revenue Last 3 Months =
CALCULATE([Total Revenue], DATESINPERIOD(Dim_Date[Date], MAX(Dim_Date[Date]), -3, MONTH))
```

```dax
Revenue Prior 3 Months =
CALCULATE(
    [Total Revenue],
    DATESINPERIOD(Dim_Date[Date], EDATE(MAX(Dim_Date[Date]), -3), -3, MONTH)
)
```

```dax
Revenue % Change (3Mo) =
DIVIDE([Revenue Last 3 Months] - [Revenue Prior 3 Months], [Revenue Prior 3 Months])
```

---

## Folder: Branch Performance

```dax
Branch Revenue % of Total =
DIVIDE([Total Revenue], CALCULATE([Total Revenue], ALL(Dim_Branch)))
```

```dax
Branch Rank by Revenue =
RANKX(ALL(Dim_Branch[Branch]), CALCULATE([Total Revenue]), , DESC)
```

```dax
Steepest Declining Branch % =
MINX(
    ALL(Dim_Branch[Branch]),
    CALCULATE([Revenue % Change (3Mo)])
)
```

```dax
Avg Order Value by Branch = DIVIDE([Total Revenue], [Total Units Sold])
```
*(Reuses the base measure — Power BI applies context transition automatically when this sits on a Branch-sliced visual; no branch-specific rewrite needed.)*

---

## Folder: Inventory Management

```dax
Total SKUs = DISTINCTCOUNT(Fact_Inventory[SKU])
```

```dax
Stockout Risk SKUs =
CALCULATE(DISTINCTCOUNT(Fact_Inventory[SKU]), Fact_Inventory[Stock Status] = "Stockout Risk")
```

```dax
Overstocked SKUs =
CALCULATE(DISTINCTCOUNT(Fact_Inventory[SKU]), Fact_Inventory[Stock Status] = "Overstocked")
```

```dax
Reorder Risk SKUs =
CALCULATE(DISTINCTCOUNT(Fact_Inventory[SKU]), Fact_Inventory[Reorder Risk Flag] = "At Risk")
```

```dax
Capital Tied in Overstock (NGN) =
CALCULATE(SUM(Fact_Inventory[Capital Tied (NGN)]), Fact_Inventory[Stock Status] = "Overstocked")
```

```dax
Total Inventory Value (NGN) = SUM(Fact_Inventory[Capital Tied (NGN)])
```

```dax
Avg Days of Supply = AVERAGE(Fact_Inventory[Days of Supply])
```

---

## Folder: Brand & Category Drilldown

```dax
Category Revenue % of Total =
DIVIDE([Total Revenue], CALCULATE([Total Revenue], ALL(Dim_Product[Category])))
```

```dax
Brand Revenue % Change (3Mo) =
DIVIDE(
    CALCULATE([Revenue Last 3 Months]) - CALCULATE([Revenue Prior 3 Months]),
    CALCULATE([Revenue Prior 3 Months])
)
```
*(Placed on a Brand-sliced visual, this returns each brand's own 3-month trend — Huawei renders as the clear outlier.)*

```dax
Huawei Revenue = CALCULATE([Total Revenue], Dim_Product[Brand] = "Huawei")
```

```dax
Huawei Revenue Share = DIVIDE([Huawei Revenue], [Total Revenue])
```

---

## Folder: Supporting

```dax
Avg Daily Revenue by Weekday =
AVERAGEX(VALUES(Dim_Date[Date]), [Total Revenue])
```
*(Place `Dim_Date[DayOfWeek]` on the axis to reproduce the Monday dip identified in the analysis.)*

---

## Validation checklist

After loading all measures, confirm:
- `[Total Revenue]` with no filters returns **₦3,574,837,300**
- `[Total Units Sold]` with no filters returns **35,647**
- `[Total SKUs]` returns **138**
