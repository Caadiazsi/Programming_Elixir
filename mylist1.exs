defmodule MyList do
    def mapsum(a,func) do
        mapsum(a,0,func)
    end
    def mapsum([], value, _) do
        value
    end
    def mapsum([head|tail],value,func) do
        mapsum(tail,(value+func.(head)),func)
    end
    def maxlist([head|tail]) do
        maxlist(tail, head)
    end
    def maxlist([], a) do
        a
    end
    def maxlist([head|tail], max) when(head>max or head==max) do
        maxlist(tail, head)
    end
    def maxlist([head|tail], max) when(head<max) do
        maxlist(tail,max)
    end
    def wrapp (num) do
        num-24
    end
    def caesar(a,num) do
        caesar(a,[],num)
    end
    def caesar([],a,_) do
        a
    end
    def caesar([head|tail],a,num) when((head+num)<123)do
        caesar(tail,Enum.concat(a,[head+num]),num)
    end
    def caesar([head|tail],a,num) do
        caesar(tail,Enum.concat(a,[wrapp(head+num)]),num)
    end
    def span(from, to) do
        span([],from,to)
    end
    def span(a, from, to) when(from==to) do
        Enum.concat(a,[from])
    end
    def span(a,from, to) do
        span(Enum.concat(a,[from]),from+1,to)
    end
    def flatten([]) do
        []
    end
    def flatten([head|tail]) when is_list(head) do
        Enum.concat(flatten(head),flatten(tail))
    end
    def flatten([head|tail]) do
        Enum.concat([head],flatten(tail))
    end
    def dividers(n) do
        for x <- span(2,n-1),rem(n,x)==0 ,do: x
    end
    def primes(n) do
        for x <- span(2,n), Enum.empty?(dividers(n)), do: x
    end
    def prime(n) do
        for x <- span(2,n), Enum.empty?([]), do: x
    end
    def order_tax_management(tax_rates, order, destiny) do
        Map.put order :total_amount, order.net_amount+(order.net_amount*tax_rates.destiny)
    end
    def orders_tax_management(tax_rates, orders) do
        for order <- orders, Map.has_key?(tax_rates, order.ship_to) ,do: order_tax_management(tax_rates, order, order.ship_to)
    end
end

tax_rates = [NC: 0.075, TX: 0.08]

orders=[
    [id: 123, ship_to: :NC, net_amount: 100.00],
    [id: 124, ship_to: :OK, net_amount: 35.50],
    [id: 125, ship_to: :TX, net_amount: 24.00],
    [id: 126, ship_to: :TX, net_amount: 44.80],
    [id: 127, ship_to: :NC, net_amount: 25.00],
    [id: 128, ship_to: :MA, net_amount: 10.00],
    [id: 129, ship_to: :CA, net_amount: 102.00],
    [id: 130, ship_to: :NC, net_amount: 50.00]
]

MyList.orders_tax_management.(tax_rates, orders)

