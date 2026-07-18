// NOTE: In Power BI Desktop, right-click this query in the Queries pane and
// uncheck "Enable load" once created. This table is a pre-aggregation of
// Fact_Sales_Daily and is kept only for reconciliation/validation checks —
// it should never be loaded into the active data model alongside the daily
// fact table, or revenue totals will double count.

let
    Source = Csv.Document(File.Contents(FolderPath & "Fact_Sales_Monthly.csv"), [Delimiter=",", Columns=5, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    ChangedType = Table.TransformColumnTypes(PromotedHeaders,{
        {"MonthYear", type text}, {"SKU", type text}, {"Branch", type text},
        {"Units Sold", Int64.Type}, {"Revenue (NGN)", Int64.Type}
    })
in
    ChangedType
