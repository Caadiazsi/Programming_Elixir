defmodule MyString do
    #Exercise_1
    def printable?(a) do
        Enum.each(a,&(&1>31 and &1<127))
    end

    #Exercise_2
    def anagram(a,b) do
        Enum.sum(a) == Enum.sum(b)
    end
    #Exercise_4
    def my_calc(a) do
        idx_operator = Enum.find_index(a, fn x -> x in [42,43,45,47] end)
        operator = Enum.at(a,idx_operator)
        {first , second} = Enum.split(a,idx_operator+1)
        first = List.to_integer(Enum.filter(first, fn x -> x>47 and x<58 end))
        second = List.to_integer(Enum.filter(second, fn x -> x>47 and x<58 end))
        cond do 
            operator == ?+ -> first + second
            operator == ?- -> first - second
            operator == ?* -> first * second
            operator == ?/ -> first / second  
        end
    end
    #Exercise_5
    def center([], _len) do
        []
    end
    def center_printer(str, len) do
        dif = len - String.length str
        bef = div(dif,2)
        aft = len-bef
        String.pad_leading(String.pad_trailing(str, aft), len)
    end
    def center([head|tail], len) do
        cond do
            String.length(head) == len -> [head|center(tail, len)]
            true -> [center_printer(head,len)|center(tail,len)]
        end
    end

    def center(strings) do
        max_len = String.length Enum.max_by(strings,&(String.length(&1)))
        news = center(strings,max_len)
        Enum.each(news, &(IO.puts &1))
    end
    #Exercise_6
    def my_each([],_func) do
        []
    end
    def my_each([head|tail],func) do
        [func.(head)|my_each(tail,func)]
    end
    def capitalize_sentences(sentences) do
        sentences 
            |> String.split(". ")
            |> Enum.map(&(String.capitalize(&1)))
            |> Enum.reduce(fn x, acc -> acc<>". "<>x end)
    end
    #Exercise_7
    def format_order([],_titles) do
        []
    end
    def format_order([head_order|tail_order],[head_title|tail_title]) do
        cond do
            head_title == "id" -> [String.to_integer(head_order)|format_order(tail_order,tail_title)] 
            head_title == "ship_to" -> [String.to_atom(head_order)|format_order(tail_order,tail_title)]
            head_title == "net_amount" -> [String.to_float(head_order)|format_order(tail_order,tail_title)]
        end
    end
    def formatter([],_titles) do
        []
    end
    def formatter([head|tail], titles) do
        [format_order(head, titles)|formatter(tail, titles)]
    end
    def order_format([],_a) do
        []
    end
    def order_format([order_head|order_tail], [titles_head|titles_tail]) do
        [{titles_head, order_head}|order_format(order_tail,titles_tail)]
    end
    def orders_list([],_a) do
        []
    end
    def orders_list([data_head|data_tail],atoms)do
        [order_format(data_head,atoms)|orders_list(data_tail,atoms)]
    end
    def tax_management() do
        {:ok, orders_file} = File.open("orders.txt", [:read, :utf8])
        head = IO.read(orders_file, :line)
                |> String.replace_suffix("\n","")
                |> String.split(",")
        data = orders_file
                |> IO.stream(:line)
                |> Enum.reduce(fn x, acc -> [acc]++[x] end)
                |> List.flatten()
                |> my_each(&(String.replace_suffix(&1,"\n","")))
                |> my_each(&(String.replace(&1,":","")))
                |> my_each(&(String.split(&1, ",")))
        atoms_head = my_each(head, &(String.to_atom(&1)))
        formatter(data,head)
            |>orders_list(atoms_head) 
    end
    def orders_tax_management(tax_rates) do
        orders = tax_management
        for order <- orders, do: order ++ [total_amount: order[:net_amount]*(1 + (tax_rates[order[:ship_to]]||0))]
    end
end
#1
IO.inspect(MyString.anagram('cat','dog'))
#2
IO.inspect(MyString.anagram('roma','amor'))

#Excercise_3
IO.inspect(['cat'|'dog'])
# -> ['cat',100,111,103]
# Se arroja este resultado ya que se sigue la notacion [head|tail] en la cual la cabeza
# se considera un elemento unico mientras que la cola se considera como una lista mas,
# en este caso en concreto la cabeza es 'cat' y la cola es 'dog'(100,111,103)

#Exercise_8
tax_rates = [NC: 0.075, TX: 0.08]

IO.inspect MyString.orders_tax_management(tax_rates)

