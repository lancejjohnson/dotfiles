return {
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false
    },
  },
  on_init = {
    function(client)
      vim.notify("Calling ElixirLS init function")
      client.notify("workspace/didChangeConfiguration")
      return true
    end,
  },
}
