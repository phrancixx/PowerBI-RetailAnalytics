let
    Source = Csv.Document(File.Contents(FolderPath & "Fact_Inventory.csv"), [Delimiter=",", Columns=4, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    ChangedType = Table.TransformColumnTypes(PromotedHeaders,{
        {"SKU", type text}, {"Branch", type text},
        {"Current Stock (Units)", Int64.Type}, {"Avg Daily Sales (Units)", type number}
    }),
    // Row-level Days of Supply, computed here so it is available even before DAX calculated columns are added
    AddedDaysOfSupply = Table.AddColumn(ChangedType, "Days of Supply", each
        if [Avg Daily Sales (Units)] = 0 then null
        else [Current Stock (Units)] / [Avg Daily Sales (Units)], type number)
in
    AddedDaysOfSupply
