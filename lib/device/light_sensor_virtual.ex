defmodule Device.LightSensor.Virtual do
  @moduledoc """
  Virtual light sensor
  """

  use GenServer

  require Logger

  defmodule State do
    @moduledoc false
    defstruct [
      :timer_ref
    ]
  end

  if Application.compile_env!(:device, :env) == :test do
    @poll_interval_ms 1
  else
    @poll_interval_ms 2000
  end

  @doc """
  Start the light sensor.
  """
  @spec start_link(args :: any) :: GenServer.on_start()
  def start_link(_args) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl GenServer
  def init(_) do
    timer_ref = :timer.send_interval(@poll_interval_ms, :poll)

    state = %State{
      timer_ref: timer_ref
    }

    {:ok, state}
  end

  @impl GenServer
  def handle_info(:poll, state) do
    lux = Enum.random(0..120)

    PropertyTable.put(Sensors, ["light_sensor", "lux"], lux)
    Logger.info("lux: #{lux}")

    {:noreply, state}
  end
end
