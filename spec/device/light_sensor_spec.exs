defmodule Device.LightSensor.Test do
  use ESpec, async: false

  alias Device.LightSensor

  before do
    allow Device.Modbus
          |> to(
            accept :read, fn _id, _address, _count ->
              {:ok, [0, 1200]}
            end
          )

    {:ok, pid} = LightSensor.start_link(nil)

    {:shared, pid: pid}
  end

  it "periodically reads the luminance and puts it in a property table"
end
