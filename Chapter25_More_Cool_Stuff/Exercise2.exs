defmodule VSigil do
    def sigil_v(lines, _opts) do
        lines
            |> String.trim_trailing
            |> String.split("\n")
            |> Enum.map(&String.split(&1, ","))
            |> Enum.map(&convert_numbers/1)
    end
    def convert_numbers(list) do
        list
            |> Enum.map(&convert_to_number/1)
    end

    def convert_to_number(string) do
        case Float.parse(string) do
            {number, _rest} -> number
            :error -> string
            _ -> string
        end
    end
end

defmodule Test do
    import VSigil
    def example do
        ~v"""
        1,2,3
        cat,dog
        """
    end
end

IO.inspect(Test.example)