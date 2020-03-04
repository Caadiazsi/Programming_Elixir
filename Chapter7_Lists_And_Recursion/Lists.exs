defmodule MyList do
    #Exercise_1
    def mapsum(a,func) do
        mapsum(a,0,func)
    end
    def mapsum([], value, _) do
        value
    end
    def mapsum([head|tail],value,func) do
        mapsum(tail,(value+func.(head)),func)
    end
    #Exercise_2
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
    #Exercise_3
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
    #Exercise_4
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
    # IMPLEMENTAR ESTO
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
end