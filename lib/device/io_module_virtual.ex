defmodule Device.IOModule.Virtual do
  @moduledoc """
  Virtual digital I/O module
  """

  use GenServer

  require Logger

  def start_link(_args) do
  end

  @impl GenServer
  def init(_) do
  end
end
