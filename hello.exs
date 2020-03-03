fizz_buzz = fn
    [0,0,_] -> "FizzBuzz"
    [0,_,_] -> "Fizz"
    [_,0,_] -> "Buzz"
    [_,_,a] -> a
end

fizz_buzz_n = fn
    a -> fizz_buzz.([rem(a,3),rem(a,5),a])
end
#IO.puts fizz_buzz_n.(10)
#IO.puts fizz_buzz_n.(11)
#IO.puts fizz_buzz_n.(12)
#IO.puts fizz_buzz_n.(13)
#IO.puts fizz_buzz_n.(14)
#IO.puts fizz_buzz_n.(15)
#IO.puts fizz_buzz_n.(16)

prefix = fn pre_string -> (fn post_string -> "#{pre_string} #{post_string}" end) end

#IO.puts prefix.("Elixir").("Rocks")

#Enum.map [1,2,3,4], &(&1 + 2)
#Enum.map[1,2,3,4], &(IO.inspect(&1))

defmodule Sum do
    def suma(1), do: 1
    def suma(n), do: n+suma(n-1)
end

defmodule Gcd do
    def fun(x,0), do: x
    def fun(x,y), do: fun(y, rem(x,y)) 
end


IO.puts io_lib.format("The number is : ~10.2f~n", [3.1435])

