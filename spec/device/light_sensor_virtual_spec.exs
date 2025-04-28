defmodule Device.LightSensor.Virtual.Test do
  use ESpec, async: false

  alias Device.LightSensor.Virtual, as: LightSensor

  before do
    {:ok, pid} = LightSensor.start_link(nil)

    {:shared, pid: pid}
  end

  it "periodically reads the luminance and puts it in a property table" do
    # Wait until the polling interval has passed. For the tests, we
    # significantly speed up the polling interval to avoid slowing down
    # the tests.
    Process.sleep(20)

    PropertyTable.get(Sensors, ["light_sensor", "lux"])
    |> should(be_integer())
  end
end
