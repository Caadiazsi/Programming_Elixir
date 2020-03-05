defmodule Issues.CLI do
    def process ({user,project, _count}) do
        Issues.GithubIssues.fetch(user, project)
            |> decode_response()
            |>sort_into_descending_order()
        end
    def sort_into_descending_order(list_of_issues) do
        list_of_issues
            |> Enum.sort(fn i1, i2 -> i1["created_at"] >= i2["created_at"] end)
    end
    def decode_response({:ok, body}) do 
        body
    end
    def decode_response({:error, error}) do
        IO.puts "Error fetching from Github: #{error["message"]}"
        System.halt(2)
    end
end
