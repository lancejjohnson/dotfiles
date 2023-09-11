return {
  settings = {
    elixirLS = {
      dialyzerEnabled = true,
      fetchDeps = true
    },
  },
  on_init = function(client)
      vim.notify("Calling ElixirLS init function")
      client.notify("workspace/didChangeConfiguration")
      return true
    end,
}
