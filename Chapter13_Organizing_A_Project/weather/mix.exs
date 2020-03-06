defmodule Weather.MixProject do
  use Mix.Project

  def project do
    [
      app: :weather,
      escript: escript_config(),
      version: "0.1.0",
      name: "Weather Government USA",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:poison,             "~> 4.0"    },
      {:httpoison,          "~> 1.0.0"  },
      {:ex_doc,             "~> 0.21.3" },
      {:earmark,            "~> 1.4"    },
      {:elixir_xml_to_map,  "~> 0.1.2"  },
      {:erlsom,             "~>1.4"     }
    ]
  end
  defp escript_config do
    [
      main_module: Weather.WEA
    ]
  end
end
