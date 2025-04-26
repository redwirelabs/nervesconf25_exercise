# NervesConf US 2025 Exercise

This is the programming exercise hosted by [Redwire Labs](https://redwirelabs.com/) at [NervesConf US 2025](https://nervesconf.us/).

The main branch contains a working implementation. Check out the other branches as starting points to write your own implementation.

## Hardware

- [Compulab IOT-GATE-IMX8PLUS](https://www.compulab.com/products/iot-gateways/iot-gate-imx8plus-industrial-arm-iot-gateway/) embedded computer
- [Advantech ADAM-4150-C](https://buy.advantech.com/I-O-Devices-Communication/Remote-I-O-Modules-RS-485-I-O-Modules-Digital-l-O/model-ADAM-4150-C.htm) I/O module
- [Linovision IOT-S300LGT](https://linovision.com/collections/rs485-iot-sensors/products/rs485-light-sensor-with-illuminance-range?variant=44921743474908) light sensor

## Exercise

Write the firmware for a Nerves system controller that turns on digital I/O 0 when the light sensor detects that it is dark.
