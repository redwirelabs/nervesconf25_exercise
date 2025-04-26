import Config

config :shoehorn, init: [:nerves_runtime]

config :nerves, :erlinit, update_clock: true

config :nerves,
  erlinit: [
    hostname_pattern: "%s"
  ]

config :vintage_net,
  regulatory_domain: "US",
  config: [
    {"eth0",
     %{
       type: VintageNetEthernet,
       ipv4: %{method: :dhcp}
     }}
    # {"wlan0", %{type: VintageNetWiFi}}
  ]

config :mdns_lite,
  hosts: [:hostname, "<%= app_name %>"],
  ttl: 120,
  services: [
    %{
      protocol: "ssh",
      transport: "tcp",
      port: 22
    }
  ]

keys =
  System.user_home!()
  |> Path.join(".ssh/id_{rsa,ecdsa,ed25519}.pub")
  |> Path.wildcard()

if keys == [],
  do:
    Mix.raise("""
    No SSH public keys found in ~/.ssh. An ssh authorized key is needed to
    log into the Nerves device and update firmware on it using ssh.
    See your project's config.exs for this error message.
    """)

config :nerves_ssh, authorized_keys: Enum.map(keys, &File.read!/1)
