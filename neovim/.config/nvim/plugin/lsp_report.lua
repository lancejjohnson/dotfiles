local M = {}

local function get_buffer_clients()
  print(vim.inspect(vim.lsp.buf_get_clients()))
end

return M
