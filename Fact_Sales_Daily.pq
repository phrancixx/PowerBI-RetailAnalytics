let
    Source = Csv.Document(File.Contents(FolderPath & "Fact_Sales_Daily.csv"), [Delimiter=",", Columns=5, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    ChangedType = Table.TransformColumnTypes(PromotedHeaders,{
        {"Date", type date}, {"SKU", type text}, {"Branch", type text},
        {"Units Sold", Int64.Type}, {"Revenue (NGN)", Int64.Type}
    })
in
    ChangedType
