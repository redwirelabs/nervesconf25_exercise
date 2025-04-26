import Config

config :logger, backends: [RingLogger]

config :logger, :device, level: :debug

config :mdns_lite, services: []
