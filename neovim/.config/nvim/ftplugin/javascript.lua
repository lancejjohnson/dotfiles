if require('custom.functions').is_biome_project() then
  vim.opt_local.tabstop = 2 -- Width of a tab character
  vim.opt_local.softtabstop = 2 -- Number of spaces a tab counts for when editing
  vim.opt_local.shiftwidth = 2 -- Number of spaces to use for autoindent
  vim.opt_local.expandtab = false -- Do not convert tabs to spaces (use actual tabs)
end
