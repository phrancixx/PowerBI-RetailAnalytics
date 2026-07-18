let
    Source = Csv.Document(File.Contents(FolderPath & "Dim_Branch.csv"), [Delimiter=",", Columns=1, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    ChangedType = Table.TransformColumnTypes(PromotedHeaders,{{"Branch", type text}})
in
    ChangedType
