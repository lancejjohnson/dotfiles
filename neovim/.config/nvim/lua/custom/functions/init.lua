local M = {}

function M.toggle_relativenumber()
  if vim.opt.relativenumber:get() then
    vim.opt.relativenumber = false
    print("Relative line numbers disabled")
  else
    vim.opt.relativenumber = true
    print("Relative line numbers enabled")
  end
end

return M