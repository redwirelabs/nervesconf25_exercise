defmodule Device.LightSensor.Virtual.Test do
  use ESpec, async: false

  alias Device.LightSensor.Virtual, as: LightSensor

  before do
    {:ok, pid} = LightSensor.start_link(nil)

    {:shared, pid: pid}
  end

  it "periodically reads the luminance and puts it in a property table"
end
