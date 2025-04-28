defmodule Device.Modbus.Test do
  use ESpec, async: false

  alias Device.Modbus

  before do
    {:ok, pid} = Modbus.start_link(nil)

    {:shared, pid: pid}
  end

  it "can read a Modbus register"

  it "can write to a Modbus coil"
end
