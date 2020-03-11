defmodule Sequence.MixProject do
  use Mix.Project

  def project do
    [
      app: :sequence,
      version: "0.4.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Sequence.Application, []}
    ]
  end

  defp deps do
    [
      {:distillery, "~> 2.0.9", runtime: false},
    ]
  end
end
