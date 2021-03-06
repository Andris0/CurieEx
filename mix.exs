defmodule Curie.MixProject do
  use Mix.Project

  def project do
    [
      app: :curie,
      version: "1.0.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Curie.Application, []},
      extra_applications: [:logger, :iex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.5.0-rc.2", only: [:dev, :test], runtime: false},
      {:nostrum, git: "https://github.com/Kraigie/nostrum.git"},
      {:logger_file_backend, "~> 0.0.10"},
      {:ecto, "~> 3.4"},
      {:ecto_sql, "~> 3.4"},
      {:jason, "~> 1.2"},
      {:postgrex, "~> 0.15.5"},
      {:floki, "~> 0.26.0"},
      {:timex, "~> 3.6"},
      {:deque, "~> 1.2"},
      {:crontab, "~> 1.1"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
