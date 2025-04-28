defmodule Device.IOModule.Test do
  use ESpec, async: false

  alias Device.IOModule
  alias Device.Modbus

  let :event,
    do: %PropertyTable.Event{
      table: Sensors,
      property: ["light_sensor", "lux"],
      value: lux(),
      timestamp: 2,
      previous_value: 0,
      previous_timestamp: 1
    }

  before do
    {:ok, pid} = IOModule.start_link(nil)

    {:shared, pid: pid}
  end

  let :lux, do: 10

  it "turns on the output when lux is low" do
    allow Modbus
          |> to(
            accept :write, fn _id, address, value ->
              expect(address |> to(eq 16))
              expect(value |> to(eq 1))

              :ok
            end
          )

    PropertyTable.subscribe(Sensors, ["io_module", "dio0"])

    send(IOModule, event())

    assert_receive(%PropertyTable.Event{
      table: Sensors,
      property: ["io_module", "dio0"],
      value: 1
    })

    expect(Modbus |> to(accepted(:write, :any)))
  end

  let :lux, do: 5000

  it "turns off the output when lux is high" do
    allow Modbus
          |> to(
            accept :write, fn _id, address, value ->
              expect(address |> to(eq 16))
              expect(value |> to(eq 0))

              :ok
            end
          )

    PropertyTable.subscribe(Sensors, ["io_module", "dio0"])

    send(IOModule, event())

    assert_receive(%PropertyTable.Event{
      table: Sensors,
      property: ["io_module", "dio0"],
      value: 0
    })

    expect(Modbus |> to(accepted(:write, :any)))
  end
end
