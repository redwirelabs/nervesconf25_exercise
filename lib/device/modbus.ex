defmodule Device.Modbus do
  @moduledoc """
  Modbus connection manager and arbiter.
  """

  use GenServer

  defmodule State do
    @moduledoc false
    defstruct [
      :modbus_pid
    ]
  end

  @doc """
  Start the Modbus connection.
  """
  @spec start_link(args :: any) :: GenServer.on_start()
  def start_link(_args) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @doc """
  Read a value from a holding register (`:rhr`).

  ## Params
  - `id` - Device ID
  - `address` - Starting register address
  - `count` - Number of registers to read, starting from and including `address`
  """
  @spec read(id :: non_neg_integer, address :: non_neg_integer, count :: pos_integer) ::
          {:ok, list()} | {:error, String.t()}
  def read(id, address, count) do
    GenServer.call(__MODULE__, {:read, id, address, count})
  end

  @impl GenServer
  def init(_) do
    {:ok, modbus_pid} =
      Modbux.Rtu.Master.start_link(
        tty: "ttymxc0",
        timeout: 250,
        active: false,
        uart_opts: [speed: 9600]
      )

    state = %State{
      modbus_pid: modbus_pid
    }

    {:ok, state}
  end

  @impl GenServer
  def terminate(_reason, state) do
    if state.modbus_pid,
      do: Modbux.Rtu.Master.close(state.modbus_pid)
  end

  @impl GenServer
  def handle_call({:read, id, address, count}, _from, state) do
    response = Modbux.Rtu.Master.request(state.modbus_pid, {:rhr, id, address, count})

    {:reply, response, state}
  end
end
