defmodule Device.LightSensor do
  @moduledoc """
  Linovision IOT-S300LGT light sensor
  """

  use GenServer

  alias Device.Modbus

  defmodule State do
    @moduledoc false
    defstruct [
      :timer_ref
    ]
  end

  @modbus_id 1

  if Application.compile_env!(:device, :env) == :test do
    @poll_interval_ms 1
  else
    @poll_interval_ms 200
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
    {:ok, [high_bytes, low_bytes]} = Modbus.read(@modbus_id, 0, 2)

    <<lux::unsigned-integer-size(32)>> = <<
      high_bytes::unsigned-integer-size(16),
      low_bytes::unsigned-integer-size(16)
    >>

    PropertyTable.put(Sensors, ["light_sensor", "lux"], lux)

    {:noreply, state}
  end
end
