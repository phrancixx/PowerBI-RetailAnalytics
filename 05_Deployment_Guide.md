# Deployment Guide

## Step 1 — Local build in Power BI Desktop

1. Install Power BI Desktop (free) from the Microsoft Store or microsoft.com/power-bi.
2. Create a new report, then `Home → Manage Parameters → New Parameter`:
   - Name: `FolderPath`, Type: Text, Current Value: the full local path to the `data/` folder (must end with a backslash, e.g. `C:\RetailAnalytics-PowerBI\data\`).
3. For each script in `power_query/`: `Home → Transform Data → New Source → Blank Query → Advanced Editor`, paste the script, rename the query to match the file name (e.g. `Dim_Date`), close and load.
4. For `Fact_Sales_Monthly`: after loading, right-click the query → uncheck **Enable load** (keep it in the model for reference queries only, not in the report).
5. Switch to Model view and build the five relationships from `docs/03_Data_Model.md`.
6. Mark `Dim_Date` as the Date Table.
7. Add the calculated columns and DAX measures from `dax/DAX_Measures.md`.
8. Apply the theme: `View → Themes → Browse for themes`, select `theme/RetailAnalytics_NavyGold_Theme.json`.
9. Build the four pages per `docs/04_Dashboard_Design.md`.
10. Run the validation checklist at the bottom of `dax/DAX_Measures.md` before moving on.

## Step 2 — Publish to Power BI Service

1. Sign in to Power BI Desktop with a Power BI account (Pro or Premium Per User license required to share outside a personal workspace).
2. `Home → Publish`, select the target workspace (create a dedicated workspace, e.g. "Retail Analytics — [Company]", if one doesn't exist).
3. Once published, open the report in the Service and pin key visuals to a Dashboard if a single-screen summary view is wanted in addition to the paginated report.

## Step 3 — Data refresh

Because the source is local CSV files, the Service needs the **On-premises Data Gateway** (personal or standard mode) to refresh on a schedule:

1. Install the gateway on a machine that always has access to the `data/` folder (or, better, move the CSVs to a shared location like SharePoint/OneDrive or a database before production use — local file paths are a fragile pattern for scheduled refresh).
2. In the Service: workspace → dataset → **Settings → Gateway connection**, map the `FolderPath` parameter to the gateway's data source.
3. Under **Scheduled refresh**, set a frequency appropriate to how often the branches export new sales/inventory data (daily is reasonable given the transactional grain).
4. For a longer-term production setup, replace the CSV source with a proper database (SQL Server, Azure SQL, Dataverse, or similar) and swap `Csv.Document(File.Contents(...))` in each M script for the equivalent database connector — the rest of the model, relationships, and DAX are unaffected by that swap.

## Step 4 — Security (Row-Level Security, optional)

If branch managers should only see their own branch's data:

1. `Modeling → Manage Roles → Create`, name it e.g. `BranchManager`.
2. On `Dim_Branch`, add a filter expression: `[Branch] = USERPRINCIPALNAME()` (requires a mapping table of email → branch, or a simpler static filter per role if there are only three branches — e.g. one role per branch with `[Branch] = "Mbari"`).
3. In the Service, under dataset **Security**, assign each branch manager's account to the matching role.
4. Test with `View as Roles` in Desktop before publishing.

## Step 5 — Sharing and governance

- Use **Apps** (workspace → Create app) rather than direct report sharing for a cleaner, versioned distribution to branch managers and executives.
- Set up a **Deployment Pipeline** (Premium feature) if you need separate Dev/Test/Prod stages as the model evolves.
- Document any future schema changes in a `CHANGELOG.md` at the repository root so downstream report edits stay traceable.

## Rollback

Keep the `.pbix` file version-controlled outside Git if possible (Git doesn't diff binary `.pbix` files meaningfully) — use Power BI's built-in version history in the Service, or manually archive dated copies, as the safety net for rollback.
