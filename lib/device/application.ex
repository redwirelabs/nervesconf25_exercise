defmodule Device.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Device.Supervisor]

    children =
      [
        # {Device.Worker, arg}
        {PropertyTable, name: Sensors}
      ] ++ children(target(), env())

    Supervisor.start_link(children, opts)
  end

  defp children(:host, :test) do
    []
  end

  defp children(:host, _env) do
    [
      # {Device.Worker, arg}
      {Device.LightSensor.Virtual, nil},
      {Device.IOModule.Virtual, nil}
    ]
  end

  defp children(_target, _env) do
    [
      # {Device.Worker, arg}
      {Device.Modbus, nil},
      {Device.LightSensor, nil},
      {Device.IOModule, nil}
    ]
  end

  defp env() do
    Application.get_env(:device, :env)
  end

  defp target() do
    Application.get_env(:device, :target)
  end
end
