defmodule Tracer do
    import IO.ANSI
    def dump_args(args) do
        args 
            |> Enum.map(&inspect/1) 
            |> Enum.join(", ")
    end

    def dump_defn(name, args) do
        "#{name}(#{dump_args(args)})"
    end

    defmacro def(definition = { name, _, args }, do: content) do
        quote do
            Kernel.def(unquote(definition)) do
                IO.puts [yellow(), "==> call:", light_blue(), " #{Tracer.dump_defn(unquote(name), unquote(args))}"]
                result = unquote(content)
                IO.puts [yellow(), "<== result:", green(), " #{result}", reset()]
                result
            end
        end
    end

    defmacro __using__(_opts) do
        quote do
            import Kernel, except: [def: 2]
            import unquote(__MODULE__), only: [def: 2]
        end
    end
end

defmodule Test do
    use Tracer
    def put_sum_three(a, b, c), do: IO.inspect(a+b+c)
    def add_list(list), do: Enum.reduce(list, 0, &(&1 + &2))
end

Test.put_sum_three(1, 2, 3)
Test.add_list([5, 6, 7, 8])
# When the function that was defined is called, then the result will be calculated
# and there will be no need to inquote the result in the line 15 as IO.puts will 
# be executed as well.