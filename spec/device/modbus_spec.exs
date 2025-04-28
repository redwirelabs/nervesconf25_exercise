defmodule Device.Modbus.Test do
  use ESpec, async: false

  alias Device.Modbus

  before do
    {:ok, pid} = Modbus.start_link(nil)

    {:shared, pid: pid}
  end

  it "can read a Modbus register" do
    allow Modbux.Rtu.Master
          |> to(
            accept :request, fn _pid, {:rhr, 0, 1, 2} ->
              {:ok, [10, 11]}
            end
          )

    Modbus.read(0, 1, 2) |> should(eq {:ok, [10, 11]})
  end
end
