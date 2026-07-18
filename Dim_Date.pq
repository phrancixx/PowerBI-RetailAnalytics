let
    Source = Csv.Document(File.Contents(FolderPath & "Dim_Date.csv"), [Delimiter=",", Columns=11, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    ChangedType = Table.TransformColumnTypes(PromotedHeaders,{
        {"Date", type date}, {"Year", Int64.Type}, {"MonthNumber", Int64.Type},
        {"MonthName", type text}, {"MonthYear", type text}, {"Quarter", type text},
        {"DayOfWeek", type text}, {"DayOfWeekNum", Int64.Type},
        {"IsMonday", type logical}, {"IsWeekend", type logical}, {"Half", type text}
    })
in
    ChangedType
