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
    defp encode(letter, _n) do
        letter
    end
    def encrypt(word, shift) do
        Enum.map(String.to_charlist(word), &(encode(&1, shift)))
            |> to_string
    end

    def rot13(word) do
        encrypt(word, 13)
    end
end
defmodule Test do
    defp read_file() do
        File.stream!("./american-words.95")
    end
    def check(word_map) do
        keys = Map.keys(word_map)
        values = Map.valus(word_map)
        common = MapSet.intersection(MapSet.new(values), MapSet.new(keys))
        IO.puts "#{MapSet.size(common)} words"
        common
    end
    def rot13_words do
        read_file()
            |> Stream.map(fn word -> 
                            {word, Caesar.rot13(word)}end)
            |> Enum.into(%{})
            |> check
            |> inspect
            |> IO.puts
    end
end
