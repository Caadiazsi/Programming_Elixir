defmodule My do
  defmacro unless(condition, clauses) do
    do_clauses = Keyword.get(clauses, :do, nil)
    quote do
      if unquote(condition) do
        unquote(do_clauses)
      end
    end
  end
  defmacro times_n(n) do
    quote do
      def unquote(:"times_#{n}")(v) do
        unquote(n) * v
      end
    end
  end
end

defmodule Test do
  require My
  My.unless 1 == 1, do: IO.puts 1 + 1
  My.times_n(3)
  My.times_n(4)
end

IO.puts Test.times_3(4)
IO.puts Test.times_4(6)
