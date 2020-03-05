defmodule Chapter10 do
    def span(from, to) do
        span([],from,to)
    end
    def span(a, from, to) when(from==to) do
        Enum.concat(a,[from])
    end
    def span(a,from, to) do
        span(Enum.concat(a,[from]),from+1,to)
    end
    #Exercise_5
    def my_all?([],_func) do
        true
    end
    def my_all?([head, tail], func) do
        func.(head) and my_all?(tail, func) 
    end
    def my_each([],_func) do
        []
    end
    def my_each([head|tail],func) do
        [func.(head)|my_each(tail,func)]
    end
    def my_filter([],_func) do
        []
    end
    def my_filter([head|tail],func) do
        if func.(head) do
            [head|my_filter(tail,func)]
        else
            my_filter(tail,func)
        end
    end
    def my_take([],_n) do
        []
    end
    def my_take([],_n,_a) do
        []
    end
    def my_take(a,count) when(count != 0) do
        if count<0 do
            n = length(a) + count
            my_take(my_n_take(a,n,0),-1*count,0)
        else
            my_take(a,count,0)
        end
    end
    def my_n_take([],_count,_pos) do
        []
    end
    def my_n_take([head|tail],count,pos) do
        if (pos>=count) do
            [head|my_n_take(tail,count,pos+1)]
        else
            my_n_take(tail,count,pos+1)
        end
    end
    def my_take([head|tail],count, pos) do
        if(pos<count) do
            [head|my_take(tail,count,pos+1)]
        else
            []
        end
    end
    def my_split([],_n) do
        []
    end
    def my_split(a,0) do
        {[],a}
    end
    def my_split(a, idx) do
        if(idx>0) do
            if (idx>=length(a)) do
                {a,[]}
            else
                {my_take(a,idx),my_take(a,idx-length(a))}
            end
        else
            {my_take(a,length(a)+idx),my_take(a,idx)}
        end
    end
    #Exercise_6
    def flatten([]) do
        []
    end
    def flatten([head|tail]) when is_list(head) do
        Enum.concat(flatten(head),flatten(tail))
    end
    def flatten([head|tail]) do
        Enum.concat([head],flatten(tail))
    end
    #Exercise_7
    def dividers(n) when (n==2) do
        []
    end
    def dividers(n) when (n>2) do
        for x <- span(2,n-1),rem(n,x)==0 ,do: x
    end
    def prime(n) do
        Enum.empty?(dividers(n))
    end
    def primes(n) do
        for x <- span(2,n), Enum.empty?(dividers(x)), do: x
    end
    #Exercise_8
    def orders_tax_management(tax_rates, orders) do
        for order <- orders, do: order ++ [total_amount: order[:net_amount]*(1 + (tax_rates[order[:ship_to]]||0))]
    end
end


tax_rates = [NC: 0.075, TX: 0.08]

orders = [
    [id: 123, ship_to: :NC, net_amount: 100.00],
    [id: 124, ship_to: :OK, net_amount: 35.50],
    [id: 125, ship_to: :TX, net_amount: 24.00],
    [id: 126, ship_to: :TX, net_amount: 44.80],
    [id: 127, ship_to: :NC, net_amount: 25.00],
    [id: 128, ship_to: :MA, net_amount: 10.00],
    [id: 129, ship_to: :CA, net_amount: 102.00],
    [id: 130, ship_to: :NC, net_amount: 50.00]
]

IO.inspect Chapter10.orders_tax_management(tax_rates, orders)