defmodule Weather.TableFormatter do
    import Enum, only: [each: 2, map: 2, map_join: 3, max: 1]
    #Format the information
    def content(_body, []) do
        []
    end
    def content(body, [{key, _title}|tail]) do
        [Map.get(body,key)|content(body,tail)]
    end
    def print_table_for_columns(body, titles) do
        with    columns = [ Enum.map(titles, fn {_,title} -> title end),content(body, titles)],
                columns_widths  = widths_of(columns),
                format          = format_for(columns_widths)
        do
            IO.puts separator(columns_widths)
            puts_in_columns(columns, format, columns_widths)
            #for {key, title} <- titles, do: IO.puts "#{title}: #{Map.get(body,key)}"
        end
    end
    def printable(str) when is_binary(str), do: str
    def printable(str), do: to_string(str)

    def widths_of(columns) do
        for column <- columns, do: column
                                        |> map(&String.length/1)
                                        |> max
    end
    def format_for(column_widths) do
        map_join(column_widths, " : ", fn width -> "~-#{width}s" end)<> "~n"
    end
    def separator(columns_widths) do
        map_join(columns_widths, "-+-", fn width -> List.duplicate("-",width)end)
    end
    def puts_in_columns(data_by_columns, format, columns_widths) do
        data_by_columns
            |> List.zip
            |> map(&Tuple.to_list/1)
            |> each(&puts_one_line_in_columns(&1, format,columns_widths))
    end
    def puts_one_line_in_columns(fields, format, columns_widths) do
        :io.format(format, fields)
        IO.puts separator(columns_widths)
    end
end