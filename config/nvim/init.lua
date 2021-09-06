--[[
  Resources:
  - https://icyphox.sh/blog/nvim-lua/
]]

-- vim.api.nvim_set_option()
local global = vim.o
-- vim.api.nvim_buf_set_option()
local buffer = vim.bo
-- vim.api.nvim_win_set_option()
local window = vim.wo

-- global settings
global.autoread = true
global.autowrite = true
global.backspace = 'indent,eol,start'
global.bg = 'dark'
-- global.colorscheme = 'nord'
global.encoding = 'utf-8'
global.hlsearch = true
global.ignorecase = true
-- global.scriptencoding = 'utf-8'
global.shiftround = true
global.smartcase = true
global.undodir = '~/.config/nvim/undodir'
global.visualbell = true
global.splitbelow = true
-- global.splitright= true
global.hidden = true


-- buffer settings
buffer.autoindent = true
buffer.expandtab = true
buffer.shiftwidth = 2
buffer.softtabstop = 2
buffer.spelllang = "en_us"
buffer.swapfile = false
buffer.syntax = "on"
buffer.tabstop = 2
buffer.undofile = true


-- window settings
window.number = true
window.relativenumber = true
window.wrap = false
-- window.colorscheme = 'nord'

