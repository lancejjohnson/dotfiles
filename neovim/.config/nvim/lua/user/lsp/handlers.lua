local M = {}

-- TODO: backfill this to template
--
-- Possible signs:
-- DiagnosticSignError
  -- ""
  -- ""
  -- ""
  -- ""
  -- ""
  -- ""
  -- ""
  -- ""
  -- ""
  -- "ﮊ"
-- DiagnosticSignWarn
  -- ""
  -- ""
  -- ""
  -- ""
  -- ""
-- DiagnosticSignHint
  -- ""
  -- ""
  -- ""
  -- ""
-- DiagnosticSignInfo
  -- ""
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false, -- disable virtual text
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    -- toggling to true to see if I can see messages on hover
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

-- Automatically highlight text under cursor
local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)

  local buf_set_keymap = vim.api.nvim_buf_set_keymap

  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- These keymappings are inspired by [Follow my leader](http://vimcasts.org/blog/2014/02/follow-my-leader/) and Tim Pope's unimpaired.
  -- I've listed my mnemonics after the mapping.
  local opts = { noremap = true, silent = true }
  -- Doing things to the buffer
  buf_set_keymap(bufnr, "n", "cdf", "<cmd>lua vim.lsp.buf.format { async=true } <CR>", opts)           -- c[hange]d[ocument]f[ormatting]
  buf_set_keymap(bufnr, "n", "cdr", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)               -- c[hange]d[ocument]r[ange formatting]
  buf_set_keymap(bufnr, "n", "cdn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)                         -- c[hange]d[ocument]n[ame]

  -- Go places via the server
  buf_set_keymap(bufnr, "n", "csn",  "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)                    -- c[hange to]s[erver][defi]n[ition]
  buf_set_keymap(bufnr, "n", "csl",  "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)                   -- c[hange to]s[erver][dec]l[aration]
  buf_set_keymap(bufnr, "n", "csp",  "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)               -- c[hance to]s[erver][ty]p[e definition]

  -- Displaying things from the server in the Quickfix window
  buf_set_keymap(bufnr, "n", "dym", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)                 -- d[isplay]y[our][i]m[plemnation]
  buf_set_keymap(bufnr, "n", "dyi", "<Cmd>lua vim.lsp.buf.incoming_calls()<CR>", opts)                 -- d[isplay]y[our]i[ncoming calls]
  buf_set_keymap(bufnr, "n", "dyo", "<Cmd>lua vim.lsp.buf.outgoing_calls()<CR>", opts)                 -- d[isplay]y[our]o[utgoing calls]
  buf_set_keymap(bufnr, "n", "dyr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)                     -- d[isplay]y[our]r[eferences]
  buf_set_keymap(bufnr, "n", "dyw", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", opts)               -- d[isplay]y[our]w[orkspace symbols]
  buf_set_keymap(bufnr, "n", "dyd", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", opts)                -- d[isplay]y[our]d[ocument symbols]

  -- Displaying things in the buffer
  buf_set_keymap(bufnr, "n", "dya", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)                    -- d[isplay]y[our code]a[ctions]
  buf_set_keymap(bufnr, "n", "dyh", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)                          -- d[isplay]y[our]h[over message]
  buf_set_keymap(bufnr, "n", "dys", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)                 -- d[isplay]y[our]s[signature help]
  buf_set_keymap(bufnr, "n", "dyl", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = 'rounded' })<CR>", opts)   -- d[isplay]y[our]l[ine][diagnostics]

  -- From chris@machine, what is this?
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)

  -- Display diagnostic information
  buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.get_next()<CR>", opts)
  buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.get_prev()<CR>", opts)
  buf_set_keymap(bufnr, "n", "cdd", "<cmd>lua vim.diagnostic.disable()<CR>", opts)                     -- c[heck]d[iagnostics]d[isable]
  buf_set_keymap(bufnr, "n", "cde", "<cmd>lua vim.diagnostic.enable()<CR>", opts)                      -- c[heck]d[iagnostics]e[nable]
  buf_set_keymap(bufnr, "n", "cdh", "<cmd>lua vim.diagnostic.hide()<CR>", opts)                        -- c[heck]d[iagnostics]h[ide]
  buf_set_keymap(bufnr, "n", "cdq", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)                   -- c[heck]d[iagnostics]q[uickfix list]
  buf_set_keymap(bufnr, "n", "cds", "<cmd>lua vim.diagnostic.show()<CR>", opts)                        -- c[heck]d[iagnostics]s[how]

  -- vim already has builtin docs
  if vim.bo.ft ~= "vim" then buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts) end
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.document_formatting = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

-- TODO: I don't understand why chris@machine has the capabilities in this file
local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  vim.notify("could not require cmp_nvim_lsp")
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
