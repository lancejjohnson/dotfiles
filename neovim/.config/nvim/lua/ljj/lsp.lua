local M = {}
-- from lsp-installer: https://github.com/williamboman/nvim-lsp-installer/wiki/Advanced-Configuration#overriding-the-default-lsp-server-options
local lsp_installer = require "nvim-lsp-installer"
lsp_installer.settings({ log_level = vim.log.levels.DEBUG })

local default_servers_to_install = {
  "bashls",
  "cssls",
  "diagnosticls",
  "dockerls",
  "elixirls",
  "graphql",
  "html",
  "jsonls",
  "rust_analyzer",
  "solargraph",
  "sorbet",
  "sqlls",
  "sumneko_lua",
  "tailwindcss",
  "tsserver",
  "vimls",
  "yamlls",
}

for _, name in pairs(default_servers_to_install) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

-- keymaps
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap("n", "<C-]>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "<Leader>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("n", "<Leader>fr", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  buf_set_keymap("n", "<Leader>gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "<Leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "<Leader>gi", "<Cmd>lua vim.lsp.buf.incoming_calls()<CR>", opts)
  buf_set_keymap("n", "<Leader>gk", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<Leader>go", "<Cmd>lua vim.lsp.buf.outgoing_calls()<CR>", opts)
  buf_set_keymap("n", "<Leader>gp", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<Leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<Leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<Leader>sh", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<Leader>vd", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "<Leader>vll", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<leader>gs", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", opts)
  buf_set_keymap("n", "<leader>gw", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

  -- vim already has builtin docs
  if vim.bo.ft ~= "vim" then buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts) end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end

  -- if client.resolved_capabilities.code_lens then
  --   vim.cmd [[
  --   augroup lsp_codelens
  --     autocmd! * <buffer>
  --     autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua require"lsp-codelens".buf_codelens_refresh()
  --   augroup END
  --   ]]
  -- end

  if client.server_capabilities.colorProvider then
    require("lsp-documentcolors").buf_attach(bufnr, { single_column = true })
  end
end

-- config that activates keymaps and enables snippet support
local function build_shared_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }
  -- capabilities.textDocument.colorProvider = { dynamicRegistration = false }
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local config = build_shared_config()

    if server.name == "elixirls" then
      config.settings = {
        elixirLS = {
          dialyzerEnabled = false,
          fetchDeps = false
        }
      }
      config.on_init = function(client)
        client.notify("workspace/didChangeConfiguration")
        return true
      end
    elseif server.name == 'solargraph' and vim.fn.glob("scripts/bin/typecheck") ~= "" then
      config.filetypes = {}
    elseif server.name == 'solargraph' and vim.fn.glob("sorbet") ~= "" then
      config.filestypes = {}
    elseif server.name == 'sorbet' and vim.fn.glob("scripts/bin/typecheck") ~= "" then
      config.cmd = {
        "scripts/dev_productivity/while_pay_up_connected.sh",
        "pay",
        "exec",
        "scripts/bin/typecheck",
        "--lsp",
        "--enable-all-experimental-lsp-features",
        "--enable-experimental-lsp-document-formatting-rubyfmt"
      }
    elseif server.name == 'sorbet' then
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
    elseif server.name == "sumneko_lua" then
      config.settings = {
        Lua = {
          runtime = {
            -- LuaJIT in the case of Neovim
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            },
          },
        },
      }
    elseif server.name == "vimls" then
      config.init_options = {
        isNeovim = true
      }
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(config)
end)

-- UI just like `:LspInfo` to show which capabilities each attached server has
vim.api.nvim_command("command! LspCapabilities lua require'lsp-capabilities'()")
vim.api.nvim_command("command! LspInspect lua print(vim.inspect(vim.lsp.buf_get_clients()))")


-- require('lspfuzzy').setup({})

return M
