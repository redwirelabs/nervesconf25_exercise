defmodule Device.MixProject do
  use Mix.Project

  @app :device
  @version "1.0.0"
  @all_targets [:gate]

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.18",
      archives: [nerves_bootstrap: "~> 1.13"],
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      releases: [{@app, release()}],
      dialyzer: [
        list_unused_filters: true,
        plt_file: {:no_warn, plt_file_path()}
      ],
      preferred_cli_env: [
        espec: :test
      ],
      preferred_cli_target: [
        dialyzer: :gate,
        run: :host,
        test: :host
      ]
    ]
  end

  def application do
    [
      mod: {Device.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp aliases do
    [
      test: "espec"
    ]
  end

  defp deps do
    [
      # Dependencies for all targets
      {:dialyxir, "~> 1.4", only: :dev, runtime: false},
      {:espec, github: "antonmi/espec", ref: "36bf824", only: :test},
      {:modbux, "~> 0.3.14"},
      {:nerves, "~> 1.11", runtime: false},
      {:resolve, "~> 1.0"},
      {:shoehorn, "~> 0.9.2"},
      {:ring_logger, "~> 0.11.3"},
      {:toolshed, "~> 0.4.1"},

      # Allow Nerves.Runtime on host to support development, testing and CI.
      {:nerves_runtime, "~> 0.13.8"},

      # Dependencies for all targets except :host
      {:nerves_pack, "~> 0.7.1", targets: @all_targets},

      # Dependencies for specific targets
      {:nerves_system_iot_gate_imx8plus, "~> 0.3", runtime: false, targets: :gate}
    ]
  end

  def release do
    [
      overwrite: true,
      # Erlang distribution is not started automatically.
      # See https://hexdocs.pm/nerves_pack/readme.html#erlang-distribution
      cookie: "#{@app}_cookie",
      include_erts: &Nerves.Release.erts/0,
      steps: [&Nerves.Release.init/1, :assemble],
      strip_beams: Mix.env() == :prod or [keep: ["Docs"]]
    ]
  end

  defp plt_file_path do
    [Mix.Project.build_path(), "plt", "dialyxir.plt"]
    |> Path.join()
    |> Path.expand()
  end
end
