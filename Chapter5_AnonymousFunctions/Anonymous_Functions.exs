#Exercise_1
list_concat = fn 
    [a,b],[c,d] -> [a,b,c,d]
end
IO.inspect list_concat.([:a,12],['a',[6,5]])

sum = fn
    {a,b,c} -> a+b+c 
end
IO.puts sum.({3,4,5})

pair_tuple_to_list = fn 
    {a,b}->[a,b]
end
IO.puts pair_tuple_to_list.({1234,5678})

#Exercise_2
fizz_buzz = fn
    [0,0,_] -> "FizzBuzz"
    [0,_,_] -> "Fizz"
    [_,0,_] -> "Buzz"
    [_,_,a] -> a
end

#Exercise_3
fizz_buzz_n = fn
    a -> fizz_buzz.([rem(a,3),rem(a,5),a])
end
IO.puts fizz_buzz_n.(10)
IO.puts fizz_buzz_n.(11)
IO.puts fizz_buzz_n.(12)
IO.puts fizz_buzz_n.(13)
IO.puts fizz_buzz_n.(14)
IO.puts fizz_buzz_n.(15)
IO.puts fizz_buzz_n.(16)

#Exercise_4
prefix = fn pre_string -> (fn post_string -> "#{pre_string} #{post_string}" end) end

IO.puts prefix.("Elixir").("Rocks")

#Exercise_5
IO.inspect Enum.map [1,2,3,4], &(&1 + 2)
Enum.map [1,2,3,4], &(IO.inspect(&1))




































