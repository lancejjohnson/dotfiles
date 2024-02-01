local colorscheme = "dracula_pro"
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.g.dracula_colorterm = 1

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

