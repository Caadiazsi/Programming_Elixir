defmodule Sequence.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Sequence.Stash, %{ :current_number => 0, :delta => 1 }},
      {Sequence.Server, nil},
    ]

    opts = [strategy: :one_for_one, name: Sequence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
