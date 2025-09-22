local M = {}

function M.toggle_relativenumber()
  if vim.opt.relativenumber:get() then
    vim.opt.relativenumber = false
    print 'Relative line numbers disabled'
  else
    vim.opt.relativenumber = true
    print 'Relative line numbers enabled'
  end
end

function M.yank_relative_path()
  local relative_path = vim.fn.fnamemodify(vim.fn.expand '%:p', ':~:.')
  vim.fn.setreg('+', relative_path)
  vim.notify('Yanked relative path: ' .. relative_path, vim.log.levels.INFO)
end

function M.yank_relative_path_with_line()
  local relative_path = vim.fn.fnamemodify(vim.fn.expand '%:p', ':~:.')
  local line_number = vim.fn.line('.')
  local path_with_line = relative_path .. ':' .. line_number
  vim.fn.setreg('+', path_with_line)
  vim.notify('Yanked relative path with line: ' .. path_with_line, vim.log.levels.INFO)
end

return M

