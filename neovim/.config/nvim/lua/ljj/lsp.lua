local a = vim.api
local lspconfig = require('lspconfig')
local lua_lsp_bin

local servers = {
  -- dockerls = {},
  elixirls = {
    cmd = { "/opt/elixirls/language_server.sh" },
    settings = {
      elixirLS = {
        dialyzerEnabled = false,
        fetchDeps = false
      }
    },
    on_init = function(client)
      client.notify("workspace/didChangeConfiguration")
      return true
    end,
  },
  -- html = {
  --   cmd = { "html-languageserver", "--stdio" },
  --   filetypes = {"html", "eelixir", "eruby"}
  -- },
  -- jsonls = {},
  -- solargraph = {
  --   filetypes = {"ruby"}
  -- },
  -- sorbet = {
  --   cmd = { "srb", "tc", "--lsp" },
  --   filetypes = { "ruby" },
  --   root_dir = lspconfig.util.root_pattern('sorbet'),
  -- },
  -- sqlls = {
  --   cmd = {"sql-language-server", "up", "--method", "stdio"},
  -- },
  -- sumneko_lua = {
  --   cmd = { lua_lsp_bin, "-E", lua_lsp_root.."/main.lua" },
  --   settings = {
  --     Lua = {
  --       runtime = {
  --         version = 'LuaJIT',
  --         path = vim.split(package.path, ';')
  --       },
  --       diagnostics = {
  --         globals = {'vim'},
  --       },
  --       workspace = {
  --         library = {
  --           [vim.fn.expand('$VIMRUNTIME/lua')] = true,
  --           [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
  --         }
  --       },
  --     },
  --   },
  -- },
  -- tailwindcss = {
  --   cmd = { vim.loop.os_homedir().."/.cache/tailwindcss-intellisense/tailwindcss-language-server", "--stdio" },
  -- },
  -- tsserver = {},
  -- vimls = {},
  -- vuels = {},
  -- yamlls = {},
}

local function make_on_attach(config)
  return function(client)
    print('LSP Starting')

    local opts = { noremap = true, silent = true }
    a.nvim_buf_set_keymap(0, 'n', '<leader>gk',  '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    a.nvim_buf_set_keymap(0, 'n', '<c-space>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    a.nvim_buf_set_keymap(0, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    a.nvim_buf_set_keymap(0, 'n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    a.nvim_buf_set_keymap(0, 'n', '<leader>gp', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    a.nvim_buf_set_keymap(0, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    a.nvim_buf_set_keymap(0, 'n', '<leader>gs', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', opts)
    a.nvim_buf_set_keymap(0, 'n', '<leader>gw', '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', opts)
    a.nvim_buf_set_keymap(0, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    a.nvim_buf_set_keymap(0, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.incoming_calls()<cr>', opts)
    a.nvim_buf_set_keymap(0, 'n', '<leader>go', '<cmd>lua vim.lsp.buf.outgoing_calls()<cr>', opts)
    a.nvim_buf_set_keymap(0, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    if client.resolved_capabilities.document_highlight == true then
      a.nvim_command('augroup lsp_aucmds')
      a.nvim_command('au CursorHold <buffer> lua vim.lsp.buf.document_highlight()')
      a.nvim_command('au CursorMoved <buffer> lua vim.lsp.buf.clear_references()')
      a.nvim_command('augroup END')
    end

    a.nvim_command('setlocal omnifunc=v:lua.vim.lsp.omnifunc')
  end
end

-- Add snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

for server, config in pairs(servers) do
  config.on_attach = make_on_attach(config)
  config.capabilities = capabilities

  if lsp_server == 'sorbet' and vim.fn.glob("scripts/bin/typecheck") ~= "" then
    config.cmd = {
      "scripts/dev_productivity/while_pay_up_connected.sh",
      "pay",
      "exec",
      "scripts/bin/typecheck",
      "--lsp",
      "--enable-all-experimental-lsp-features",
      "--enable-experimental-lsp-document-formatting-rubyfmt"
    }
  elseif server == 'solargraph' and vim.fn.glob("scripts/bin/typecheck") ~= "" then
    config.filetypes = {}
  elseif server == 'solargraph' and vim.fn.glob("sorbet") ~= "" then
    config.filestypes = {}
  elseif server == 'sorbet' then
    local local_sorbet_build = vim.fn.glob(vim.fn.environ().HOME.."/stripe/sorbet/bazel-bin/main/sorbet")
    if local_sorbet_build ~= "" then
      -- prefer a local build of sorbet if it's available
      config.cmd = {
        local_sorbet_build,
        "--lsp",
        "--silence-dev-message",
        "--enable-all-experimental-lsp-features",
        "--enable-experimental-lsp-document-formatting-rubyfmt"
      }
    end
  end

  lspconfig[server].setup(config)
end

-- require('lspfuzzy').setup({})

-- require('colorizer').setup({
--   'css',
--   'scss',
--   'sass',
--   'javascript',
--   'html',
--   'lua',
--   'vim',
--   'conf',
--   'eelixir',
--   'erb'
-- })

local M = {}
return M

