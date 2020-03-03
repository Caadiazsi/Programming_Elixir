defmodule Chop do
    def guess(p1, (a..b)), do: guess(div((a+b),2),p1,(a..b))

    def guess(p1, number, range) when p1===number do 
        IO.puts "Is it #{p1}"
        IO.puts "It is #{p1}"
    end
    def guess(p1, number, (a..b)) when p1<number do
        IO.puts "Is it #{p1}" 
        guess(div((p1+b),2),number,(p1+1..b))
    end
    def guess(p1, number, (a..b)) when p1>number do
        IO.puts "Is it #{p1}" 
        guess(div((a+p1),2),number,a..p1-1)
    end
end