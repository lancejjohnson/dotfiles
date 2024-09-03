local colorscheme = "alucard"
vim.opt.termguicolors = true
vim.opt.background = "light"
vim.g.dracula_colorterm = 0

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
