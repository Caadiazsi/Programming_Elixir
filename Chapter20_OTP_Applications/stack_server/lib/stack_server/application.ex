defmodule StackServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, initial_stack) do
    # List all child processes to be supervised
    children = [
      { StackServer.Stash, initial_stack},
      { StackServer.Server, nil}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: StackServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
