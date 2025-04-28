defmodule Device.LightSensor.Virtual do
  @moduledoc """
  Virtual light sensor
  """

  use GenServer

  require Logger

  defmodule State do
    @moduledoc false
    defstruct []
  end

  def start_link(_args) do
  end

  @impl GenServer
  def init(_) do
  end

  @impl GenServer
  def handle_info(:poll, state) do
  end
end
