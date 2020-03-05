

defmodule CliTest do
    import Issues.CLI, only: [parse_args: 1,
                            sort_into_descending_order: 1]
                            
    use ExUnit.Case
    doctest Issues
    
    test "sort descending orders the correct way" do
        result = sort_into_descending_order(fake_created_at_list(["c","a","b"]))
        issues = for issue <- result, do: Map.get(issue,"created_at")
        assert issues === ~w{ c b a }
    end

    defp fake_created_at_list(values) do
        for value <- values,
        do: %{"created_at" => value, "other_data" => "xxx"}
    end
end

