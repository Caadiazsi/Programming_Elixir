defprotocol Caesar do
    def encrypt(word, shift)
    def rot13(word)
end

defimpl Caesar, for: BitString  do
    defp encode(letter, n) when letter>=?a and letter<=?z do
        if letter + n > ?z do
            (letter + n) - ?z + 96
        else
            letter + n
        end
    end
    defp encode(letter, n) when letter>=?A and letter<=?Z do
        if letter + n > ?Z do
            (letter+n) - ?Z + 64
        else
            letter + n
        end
    end
    def encrypt(word, shift) do
        Enum.map(String.to_charlist(word), &(encode(&1, shift)))
            |> to_string
    end

    def rot13(word) do
        encrypt(word, 13)
    end
end

defimpl Caesar, for: List  do
    defp encode(letter, n) when letter>= ?a and letter<= ?z do
        if letter + n > ?z do
            (letter + n) - ?z + 96
        else
            letter + n
        end
    end
    defp encode(letter, n) when letter>=?A and letter<=?Z do
        if letter + n > ?Z do
            (letter+n) - ?Z + 64
        else
            letter + n
        end
    end
    defp encode(letter, n) do
        letter
    end
    defp convert(value) when is_number(value) do
        [value]
    end
    defp convert(value) when is_list(value) do
        value
    end
    defp convert(value) when is_bitstring(value) do
        String.to_charlist(value)
    end
    defp convert(value) do
        String.to_charlist(value)
    end
    def encrypt(list, shift) do
        Enum.reduce(list, [], &(&2 ++ convert(&1)))
            |> Enum.map(&(encode(&1, shift)))
            |> to_string()
    end
    def rot13(list) do
        encrypt(list, 13)
    end
end

IO.puts Caesar.rot13("nopqrstuvwxyz")
IO.puts Caesar.rot13('abcdefghijklm')
IO.puts Caesar.rot13([26, 'ab', "no"])