defmodule MyString do
    def printable?(a) do
        List.ascii_printable?(a)
    end
    def anagram(a,b) do
        Enum.sort(a) == Enum.sort(b)
    end
    def basic_Calc(a) do
        [first|'+'|last] = a
        List.to_integer(first) + List.to_integer(last)
    end
end

IO.inspect(['cat'|'dog'])
# -> ['cat',100,111,103]
# Se arroja este resultado ya que se sigue la notacion [head|tail] en la cual la cabeza
# se considera un elemento unico mientras que la cola se considera como una lista mas.

IO. inspect(MyString.anagram('cat','dog'))
IO. inspect(MyString.anagram('roma','amor'))

