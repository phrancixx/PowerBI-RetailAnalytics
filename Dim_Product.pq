let
    Source = Csv.Document(File.Contents(FolderPath & "Dim_Product.csv"), [Delimiter=",", Columns=8, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    ChangedType = Table.TransformColumnTypes(PromotedHeaders,{
        {"SKU", type text}, {"Branch", type text}, {"Category", type text},
        {"Brand", type text}, {"Product", type text},
        {"Unit Cost (NGN)", type number}, {"Unit Price (NGN)", Int64.Type},
        {"Lead Time (Days)", Int64.Type}
    })
in
    ChangedType
