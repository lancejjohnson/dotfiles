-- Set tab width to 4 spaces
vim.opt_local.tabstop = 4 -- Width of a tab character
vim.opt_local.softtabstop = 4 -- Number of spaces a tab counts for when editing
vim.opt_local.shiftwidth = 4 -- Number of spaces to use for autoindent
vim.opt_local.expandtab = false -- Do not convert tabs to spaces (use actual tabs)

-- Optional additional Go-specific settings
vim.opt_local.formatoptions:append 'ro' -- Auto-continue comments

-- Optional: Go-specific formatting or linting settings
-- If using vim-go or gopls
vim.g.go_fmt_command = 'gopls' -- Use gopls for formatting
vim.g.go_fmt_autosave = 1 -- Format on save
