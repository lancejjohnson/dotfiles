local colorscheme = "nord"

vim.opt.termguicolors = true
vim.g.nord_bold = 0

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
