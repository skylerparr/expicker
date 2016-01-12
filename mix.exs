defmodule Expicker.Mixfile do
  use Mix.Project

  def project do
    [app: :expicker,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :postgrex, :ecto]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:sfmt, "0.10.1"},
      {:ecto, "~> 1.1.1"},
      {:postgrex, ">= 0.0.0"},
      {:bson, "~> 0.4.4"},
      {:exactor, "~> 2.2.0"}
    ]
  end
end
