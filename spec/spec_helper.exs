ESpec.configure(fn config ->
  config.before(fn tags ->
    {:shared, tags: tags}
  end)

  config.finally(fn shared ->
    PropertyTable.delete_matches(Sensors, [:_])

    if Process.alive?(shared[:pid]),
      do: GenServer.stop(shared[:pid])

    :ok
  end)
end)
