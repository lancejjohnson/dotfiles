require("user.lsp.mason")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")

-- https://www.reddit.com/r/neovim/comments/14ecf5o/semantic_highlights_messing_with_todo_comments/
vim.api.nvim_set_hl(0, '@lsp.type.comment', {})
