defmodule Device.IOModule do
  @moduledoc """
  Advantech ADAM-4150 digital I/O module
  """

  use GenServer

  alias Device.Modbus

  @modbus_id 2

  @doc """
  Start the I/O module.
  """
  @spec start_link(args :: any) :: GenServer.on_start()
  def start_link(_args) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl GenServer
  def init(_) do
    PropertyTable.subscribe(Sensors, ["light_sensor", "lux"])

    {:ok, nil}
  end

  @impl GenServer
  def handle_info(
        %PropertyTable.Event{
          table: Sensors,
          property: ["light_sensor", "lux"],
          value: lux
        },
        state
      ) do
    value = if lux < 60, do: 1, else: 0
    :ok = Modbus.write(@modbus_id, 16, value)
    PropertyTable.put(Sensors, ["io_module", "dio0"], value)

    {:noreply, state}
  end
end
