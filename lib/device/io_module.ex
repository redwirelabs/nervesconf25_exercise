defmodule Device.IOModule do
  @moduledoc """
  Advantech ADAM-4150 digital I/O module
  """

  use GenServer

  alias Device.Modbus

  @modbus_id 2

  def start_link(_args) do
  end

  @impl GenServer
  def init(_) do
  end
end
