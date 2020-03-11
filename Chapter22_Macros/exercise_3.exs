defmodule Exercise3 do
    @operators %{ :+ => "add", :- => "minus", :* => "multiply", :/ => "divided by"}

    defmacro explain(expression) do
        Keyword.get(expression, :do, nil)
            |> explain_operation
            |> IO.puts
    end
    defp sentence(op, left, right) do
        case op do
            :/ -> "#{left} #{Map.get(@operators, op)} #{right}"
            :- -> "#{left} #{Map.get(@operators, op)} #{right}"
             _ -> "#{Map.get(@operators, op)} #{left} and #{right}" 
        end
    end
    defp explain_operation({op, _, [left, right]}) when is_number(left) and is_number(right) do
        sentence(op, left, right)
    end 
    defp explain_operation({op, _, [left, right]}) when not is_number(left) and not is_number(right) do
        explain_operation(left) <> ", then #{Map.get(@operators, op)} the result of" <> explain_operation(right)
    end
    defp explain_operation({op, _, [left, right]}) when not is_number(left) do
        explain_operation(left) <> " #{Map.get(@operators, op)} #{right}"
    end
    defp explain_operation({op, _, [left, right]}) when not is_number(right) do
        :/ -> "#{left} #{Map.get(@operators, op} the result of #{explain_operation(right)}"
         _ -> explain_operation(right) <> ", then #{Map.get(@operators, op)} #{left}"
    end
end

defmodule Test do
    import Exercise3
    explain do: 2 + 3
    explain do: (1 + 2) * (3 - 2)
    explain do: 5 + 6 * (6 / 2)
end