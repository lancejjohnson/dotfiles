-- Modes: arguments to vim.api.nvim_set_keymap
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local set_keymap = vim.api.nvim_set_keymap

--Remap space as leader key
-- TODO: this should be in lua/lance/options
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Remove arrow navigation in Normal mode to force vim movement
------------------------------------------------------------
set_keymap("n", "<up>", "<nop>", opts)
set_keymap("n", "<down>", "<nop>", opts)
set_keymap("n", "<left>", "<nop>", opts)
set_keymap("n", "<right>", "<nop>", opts)
set_keymap("i", "<up>", "<nop>", opts)
set_keymap("i", "<down>", "<nop>", opts)
set_keymap("i", "<left>", "<nop>", opts)
set_keymap("i", "<right>", "<nop>", opts)

-- Remove F1 help as I hit by accident all the time
------------------------------------------------------------
set_keymap("n", "<F1>", "<nop>", opts)
set_keymap("i", "<F1>", "<nop>", opts)
set_keymap("v", "<F1>", "<nop>", opts)

-- Make movement behave in wraps
------------------------------------------------------------
set_keymap("n", "j", "gj", opts)
set_keymap("n", "k", "gk", opts)

-- Improve split navigation
------------------------------------------------------------
set_keymap("n", "gj", "<C-w>j", opts)
set_keymap("n", "gk", "<C-w>k", opts)
set_keymap("n", "gh", "<C-w>h", opts)
set_keymap("n", "gl", "<C-w>l", opts)

-- Resize windows
------------------------------------------------------------
set_keymap("", "<C-Up>", ":resize +2<CR>", opts)
set_keymap("", "<C-Down>", ":resize -2<CR>", opts)
set_keymap("", "<C-Left>", ":vertical resize -2<CR>", opts)
set_keymap("", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Speed up system clipboard
-- (http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/)
------------------------------------------------------------
set_keymap("v", "<Leader>y", "+y", opts)
set_keymap("v", "<Leader>d", "+d", opts)
set_keymap("v", "<Leader>p", "+p", opts)
set_keymap("v", "<Leader>P", "+P", opts)
set_keymap("n", "<Leader>p", "+p", opts)
set_keymap("n", "<Leader>P", "+p", opts)

-- Search
------------------------------------------------------------
set_keymap("n", "\\", ":Rg<Space>", opts) -- Search project
set_keymap("", "<Leader>\\", ":Rg <C-R><C-W><CR>", opts) -- Search project for word under cursor

-- Character inserts
------------------------------------------------------------
set_keymap("i", "<C-l>", "<Space>=><Space>", opts) -- Insert hash rocket

-- EasyAlign
------------------------------------------------------------
set_keymap("n", "ga", "<Plug>(EasyAlign)", opts)
set_keymap("x", "ga", "<Plug>(EasyAlign)", opts)
set_keymap("v", "<Leader><Bslash>", ":EasyAlign*<Bar><Enter>", opts) -- Align GitHub Flavored md tables

-- Elixir
------------------------------------------------------------
set_keymap("n", "<leader>m", ":MixFormat<CR>", opts)
set_keymap("i", "<c-p>", "|><space>", opts) -- Deprecated: prefer snippets
set_keymap("i",  "<c-f>", "fn<space>-><space>end", opts) -- Deprecated: prefer snippets

-- vim-test
------------------------------------------------------------
vim.cmd "let test#strategy = \"dispatch\""
vim.cmd "let test#go#runner = \"gotest\""
set_keymap("n", "<leader>T", ":TestNearest<CR>", opts)
set_keymap("n", "<leader>t", ":TestFile<CR>", opts)
set_keymap("n", "<leader>a", ":TestSuite<CR>", opts)
set_keymap("n", "<leader>l", ":TestLast<CR>", opts)
set_keymap("n", "<leader>g", ":TestVisit<CR>", opts)


-- Misc
------------------------------------------------------------
set_keymap("i", "jk", "<ESC>", opts) -- Esc with jk
set_keymap("", "<C-n>", ":nohl", opts) -- Turn off highlight after search
set_keymap("i", "<S-CR>", "<C-o><S-o>", opts) -- Shift enter adds new line above
set_keymap("n", "<Leader>f", ":<C-u>FZF<CR>", opts) -- Open FZF
set_keymap("n", "<Leader>S", ":StripWhitespace<CR>", opts)
set_keymap("n", "<Leader>c", "<c-w>c", opts) -- Close window easier
set_keymap("n", "<Leader>q", ":cclose", opts) -- Close window easier
set_keymap("n", "<Leader>w", ":w<CR>", opts) -- Save easier
set_keymap("n", ":W", ":w<CR>", opts) -- Save easier
set_keymap("", "<Leader>=", "gg=G''", opts) -- Re-indent the whole document

-- Chris config ------------------------------------------------------------

-- Toggle the Left Explorer
-- keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- -- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- -- Visual --
-- -- Stay in indent mode
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)

-- -- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("v", "p", '"_dP', opts)

-- -- Visual Block --
-- -- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- -- Terminal --
-- -- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
