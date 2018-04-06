defmodule Family.Mixfile do
  use Mix.Project

  def project do
    [
      app: :family,
      version: "0.1.0",
      elixir: "~> 1.3",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test]
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
      {:excoveralls, "~> 0.8.1", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:credo, "~> 0.8.10", only: [:dev, :test], runtime: false}
    ]
  end
end
