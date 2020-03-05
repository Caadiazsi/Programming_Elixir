#Exercise_1_to_3
defmodule Times do
    def double(n), do: n * 2
    def triple(n), do: n*3
    def quadruple(n), do: double(n)*2
end

IO.inspect Times.triple(4)
IO.inspect Times.quadruple(2)

#Exercise_4
defmodule Sum do
    def suma(1), do: 1
    def suma(n), do: n+suma(n-1)
end

#Exercise_5
defmodule Gcd do
    def fun(x,0), do: x
    def fun(x,y), do: fun(y, rem(x,y)) 
end

#Exercise_6
defmodule Chop do
    def guess(p1, (a..b)), do: guess(div((a+b),2),p1,(a..b))

    def guess(p1, number, _) when p1===number do 
        IO.puts "Is it #{p1}"
        IO.puts "It is #{p1}"
    end
    def guess(p1, number, (_..b)) when p1<number do
        IO.puts "Is it #{p1}" 
        guess(div((p1+b),2),number,(p1+1..b))
    end
    def guess(p1, number, (a.._)) when p1>number do
        IO.puts "Is it #{p1}" 
        guess(div((a+p1),2),number,a..p1-1)
    end
end
IO.inspect Chop.guess(273,1..1000)

#Exercise_7
print = fn t -> IO.puts "\n" <> t end

:io.format("~.*.0f~n", [2, 2143.4])

IO.inspect System.get_env("PATH")

IO.inspect Path.extname("dave/test.exs")

IO.inspect System.cwd()

print.(inspect(Code.eval_string("a = [1, 2, 3, 4] ")))

System.cmd("echo",["hello"])

