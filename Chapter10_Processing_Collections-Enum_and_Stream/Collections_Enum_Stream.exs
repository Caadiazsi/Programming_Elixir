defmodule Chapter10 do
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