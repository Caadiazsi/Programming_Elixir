defmodule MyEnum do
    def each(map, function) do
        Enum.reduce(map, nil, fn n, _ ->
                                function.(n)
                                nil
                                end)
    end
    def filter(list, function) do
        Enum.reduce(list, [],   fn n, acc ->
                                    if function.(n) do
                                        [n|acc]
                                    else
                                        acc
                                    end
                                end)
    end
    def map(list, function) do
        Enum.reduce(list, [],   fn n, acc ->
                                    [function.(n)|acc]
                                end)
    end
end
