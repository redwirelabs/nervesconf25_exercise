defmodule Device.IOModule.Virtual do
  @moduledoc """
  Virtual digital I/O module
  """

  use GenServer

  require Logger

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
    PropertyTable.put(Sensors, ["io_module", "dio0"], value)

    dio_state = if value == 0, do: :off, else: :on
    Logger.info("DIO0: #{dio_state}")

    {:noreply, state}
  end
end
