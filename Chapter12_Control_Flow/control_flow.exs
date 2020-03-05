defmodule Chapter12 do
    def case_fizzbuzz(n) do
        case{rem(n,3),rem(n,5)} do
            {0,0} -> "FizzBuzz"
            {_,0} -> "Buzz"
            {0,_} -> "Fizz"
            {_,_} -> n
        end
    end
    ok! = fn
        {:ok, data} -> data
        data -> raise RuntimeError, message: inspect data
    end
end