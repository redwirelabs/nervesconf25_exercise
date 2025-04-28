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

  it "periodically reads the luminance and puts it in a property table" do
    # Wait until the polling interval has passed. For the tests, we
    # significantly speed up the polling interval to avoid slowing down
    # the tests.
    Process.sleep(20)

    PropertyTable.get(Sensors, ["light_sensor", "lux"])
    |> should(eq 1200)
  end
end
