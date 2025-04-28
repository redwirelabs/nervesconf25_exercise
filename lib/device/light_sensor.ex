defmodule Device.LightSensor do
  @moduledoc """
  Linovision IOT-S300LGT light sensor
  """

  use GenServer

  alias Device.Modbus

  defmodule State do
    @moduledoc false
    defstruct []
  end

  @modbus_id 1

  def start_link(_args) do
  end

  @impl GenServer
  def init(_) do
  end

  @impl GenServer
  def handle_info(:poll, state) do
  end
end
