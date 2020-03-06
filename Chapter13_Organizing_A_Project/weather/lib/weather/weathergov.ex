defmodule Weather.WeatherGov do
    #import Enum, only: [map: 2]
    require Logger
    @user_agent [ {"Camilo", "Neia cadiazs@neia.com"}]
    @weather_url Application.get_env(:weather, :weather_url)
    
    def fetch (value) do
        Logger.info("Fetching weather in #{value}")
        weather_full_url(value)
            |>HTTPoison.get(@user_agent)
            |>handle_response
    end
    def weather_full_url(value) do
        "#{@weather_url}/#{value}.xml"
    end
    def handle_response({_, %{status_code: status_code, body: body}}) do
        Logger.info("Got response: status code= #{status_code}")
        Logger.debug(fn -> inspect(body) end)
        {
            status_code |> check_for_error(),
            body        |> XmlToMap.naive_map() 
        }
    end
    def data_filter(body, columns) do
        keys = Enum.map(columns, fn {c, _} -> c end)
        Enum.reduce(keys,%{}, fn key, acc -> Map.merge(acc,extract_data(body,key)) end)
    end
    defp extract_data(body,key) do
        Map.put(%{},key,Map.get(body, key))
    end
    defp check_for_error(200), do: :ok
    defp check_for_error(_), do: :error
end