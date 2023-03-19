local colorscheme = "gruvbox"

vim.opt.termguicolors = true
vim.opt.bg = "light"
vim.g["gruvbox_bold"] = 0
vim.g["gruvbox_contrast_light"] = "hard"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
