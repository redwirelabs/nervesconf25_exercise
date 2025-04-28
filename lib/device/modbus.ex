defmodule Device.Modbus do
  @moduledoc """
  Modbus connection manager and arbiter.
  """

  use GenServer

  defmodule State do
    @moduledoc false
    defstruct []
  end

  @doc """
  Start the Modbus connection.
  """
  def start_link(_args) do
  end

  @doc """
  Read a value from a holding register (`:rhr`).

  ## Params
  - `id` - Device ID
  - `address` - Starting register address
  - `count` - Number of registers to read, starting from and including `address`
  """
  def read(id, address, count) do
  end

  @doc """
  Write a value to a coil (`:fc`).
  """
  def write(id, address, value) do
  end

  @impl GenServer
  def init(_) do
  end

  @impl GenServer
  def terminate(_reason, state) do
  end
end
