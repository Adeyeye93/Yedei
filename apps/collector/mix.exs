defmodule Collector.MixProject do
  use Mix.Project

  def project do
    [
      app: :collector,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :erlport]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # {:sibling_app_in_umbrella, in_umbrella: true}
      {:mime, "~> 2.0"},
      {:file_system, "~> 1.0", only: :test},
      {:html_sanitize_ex, "~> 1.4"},
      {:expletive, "~> 0.1.5"},
      {:briefly, "~> 0.5.1"},
      {:uuid, "~> 1.1"},
      {:erlport, "~> 0.11.0"}
    ]
  end
end
