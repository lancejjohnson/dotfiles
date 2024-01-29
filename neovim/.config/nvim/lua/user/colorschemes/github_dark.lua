require('github-theme').setup({
  options = {
    dim_inactive = true,
    hide_nc_statusline = false,
  },
  groups = {
    all = {
      StatusLineNC = { bg = 'bg3', fg = 'fg2', sp = 'fg3' },
    },
  }
})

local colorscheme = "github_dark"

vim.opt.termguicolors = true

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
