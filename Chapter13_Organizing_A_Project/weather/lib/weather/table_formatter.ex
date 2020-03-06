defmodule Weather.TableFormatter do
    #import Enum
    #Format the information
    def print_table_for_columns(body, titles) do
        for {key, title} <- titles, do: IO.puts "#{title}: #{Map.get(body,key)}"
        #map_titles = %{}
        #corrected_map = %{}
        #for {key, value} <- titles, do: Map.put(map_titles,key, value)
        #for {key,_} <- titles, do: Map.put(Map.get(corrected_map,map_titles,key))
    end
end