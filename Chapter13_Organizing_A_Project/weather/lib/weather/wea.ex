defmodule Weather.WEA do
    import Weather.TableFormatter, only: [print_table_for_columns: 2]
    @default_value "KDTO"
    @titles [
        { "location", "Location"},
        { "station_id", "Station"},
        { "observation_time", "Last Updated" },
        { "observation_time_rfc822", "Date" },
        { "weather", "Weather" },
        { "temperature_string", "Temperature" },
        { "dewpoint_string", "Dewpoint" },
        { "relative_humidity", "Relative Humdity" },
        { "wind_string", "Wind" },
        { "pressure_string", "MSL Pressure" },
        { "pressure_in", "Altimeter" },
    ]
    def get_Titles(), do: @titles
    def process({value}) do
        Weather.WeatherGov.fetch(value)
            |> decode_response()
            |> Map.get("current_observation")
            |> Weather.WeatherGov.data_filter(@titles)
            |> print_table_for_columns(@titles)
    end
    def decode_response({:ok, body}) do 
        body
    end
    def decode_response({:error, error}) do
        IO.puts "Error fetching from Weather.gov: #{error["message"]}"
        System.halt(2)
    end
    def parse_args(argv) do
        OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
            |> elem(1)
            |> args_to_internal_representation()
    end
    def args_to_internal_representation([city]) do
        {city}
    end
    def args_to_internal_representation(_) do
        :help
    end
    def args_to_internal_representation() do
        {@default_value}
    end
    def main(argv) do
        argv
            |> parse_args
            |> process
    end
end