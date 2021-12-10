local M = {}
-- from lsp-installer: https://github.com/williamboman/nvim-lsp-installer/wiki/Advanced-Configuration#overriding-the-default-lsp-server-options
local lsp_installer = require "nvim-lsp-installer"
lsp_installer.settings({ log_level = vim.log.levels.DEBUG })

-- Servers to install by default:
local servers = {
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

-- Install default servers
for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- Copied from dbern. Don't know what this is really
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local on_attach = function(client)
  print('LSP Starting')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gk',  '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<c-space>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gp', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gs', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gw', '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.incoming_calls()<cr>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>go', '<cmd>lua vim.lsp.buf.outgoing_calls()<cr>', opts)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

  if client.resolved_capabilities.document_highlight == true then
    vim.api.nvim_command('augroup lsp_aucmds')
    vim.api.nvim_command('au CursorHold <buffer> lua vim.lsp.buf.document_highlight()')
    vim.api.nvim_command('au CursorMoved <buffer> lua vim.lsp.buf.clear_references()')
    vim.api.nvim_command('augroup END')
  end

  vim.api.nvim_command('setlocal omnifunc=v:lua.vim.lsp.omnifunc')
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  print("Hello, the server " .. server.name .. " is ready")
  local opts = {
    capabilities = capabilities,
    -- on_attach needs to be a func that accepts a client and defines stuff
    on_attach = on_attach,
  }

  -- (optional) Customize the options passed to the server
  -- if server.name == "tsserver" then
  --     opts.root_dir = function() ... end
  -- end
  --
  if server.name == "elixirls" then
    print("Doing someting with "..server.name)
    opts.settings = {
      elixirLS = {
        dialyzerEnabled = false,
        fetchDeps = false
      }
    }
    opts.on_init = function(client)
      client.notify("workspace/didChangeConfiguration")
      return true
    end
  end

  if server.name == "sumneko_lua" then
    opts.settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ';')
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          }
        }
      }
    }
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  --
  -- This needs to be called with the same config David is passing
  server:setup(opts)
end)

-- Another way to configure individual servers
-- local lsp_installer_servers = require'nvim-lsp-installer.servers'

-- local server_available, requested_server = lsp_installer_servers.get_server("rust_analyzer")
-- if server_available then
--   requested_server:on_ready(function ()
--     local opts = {}
--     requested_server:setup(opts)
--   end)
--   if not requested_server:is_installed() then
--     -- Queue the server to be installed
--     requested_server:install()
--   end
-- end


            -- local lspconfig = require('lspconfig')

            -- local servers = {
            --   -- dockerls = {},
            --   elixirls = {
            --     cmd = { "/opt/elixirls/language_server.sh" },
            --     settings = {
            --       elixirLS = {
            --         dialyzerEnabled = false,
            --         fetchDeps = false
            --       }
            --     },
            --     on_init = function(client)
            --       client.notify("workspace/didChangeConfiguration")
            --       return true
            --     end,
            --   },
            --   html = {
            --     filetypes = {"html", "eelixir", "eruby"}
            --   },
            --   jsonls = {},
            --   solargraph = {},
            --   sorbet = {
            --     cmd = { "srb", "tc", "--lsp" },
            --     filetypes = { "ruby" },
            --     root_dir = lspconfig.util.root_pattern('sorbet'),
            --   },
              -- sqlls = {
                --   cmd = {"sql-language-server", "up", "--method", "stdio"},
                -- },
                -- tailwindcss = {
                  --   cmd = { vim.loop.os_homedir().."/.cache/tailwindcss-intellisense/tailwindcss-language-server", "--stdio" },
                  -- },
                  -- tsserver = {},
                  -- vimls = {},
                  -- vuels = {},
                  -- yamlls = {},
                -- }

                -- local function make_on_attach(config)
                  --   return function(client)
                    --     print('LSP Starting')

                    --     local opts = { noremap = true, silent = true }
                    --     vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gk',  '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    --     vim.api.nvim_buf_set_keymap(0, 'n', '<c-space>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    --     vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    --     vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    --     vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gp', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    --     vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    --     vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gs', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', opts)
                    --     vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gw', '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', opts)
                    --     vim.api.nvim_buf_set_keymap(0, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    --     vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.incoming_calls()<cr>', opts)
                    --     vim.api.nvim_buf_set_keymap(0, 'n', '<leader>go', '<cmd>lua vim.lsp.buf.outgoing_calls()<cr>', opts)
                    --     vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

                    --     if client.resolved_capabilities.document_highlight == true then
                    --       vim.api.nvim_command('augroup lsp_aucmds')
                    --       vim.api.nvim_command('au CursorHold <buffer> lua vim.lsp.buf.document_highlight()')
                    --       vim.api.nvim_command('au CursorMoved <buffer> lua vim.lsp.buf.clear_references()')
                    --       vim.api.nvim_command('augroup END')
                    --     end

                    --     vim.api.nvim_command('setlocal omnifunc=v:lua.vim.lsp.omnifunc')
                    --   end
                    -- end

                    -- Add snippet support
                    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
                    -- capabilities.textDocument.completion.completionItem.snippetSupport = true
                    -- capabilities.textDocument.completion.completionItem.resolveSupport = {
                      --   properties = {
                        --     'documentation',
                        --     'detail',
                        --     'additionalTextEdits',
                        --   }
                        -- }

                        -- for server, config in pairs(servers) do
                        --   config.on_attach = make_on_attach(config)
                        --   config.capabilities = capabilities

                        --   if lsp_server == 'sorbet' and vim.fn.glob("scripts/bin/typecheck") ~= "" then
                        --     config.cmd = {
                          --       "scripts/dev_productivity/while_pay_up_connected.sh",
                          --       "pay",
                          --       "exec",
                          --       "scripts/bin/typecheck",
                          --       "--lsp",
                          --       "--enable-all-experimental-lsp-features",
                          --       "--enable-experimental-lsp-document-formatting-rubyfmt"
                          --     }
                          --   elseif server == 'solargraph' and vim.fn.glob("scripts/bin/typecheck") ~= "" then
                          --     config.filetypes = {}
                          --   elseif server == 'solargraph' and vim.fn.glob("sorbet") ~= "" then
                          --     config.filestypes = {}
                          --   elseif server == 'sorbet' then
                          --     local local_sorbet_build = vim.fn.glob(vim.fn.environ().HOME.."/stripe/sorbet/bazel-bin/main/sorbet")
                          --     if local_sorbet_build ~= "" then
                          --       -- prefer a local build of sorbet if it's available
                          --       config.cmd = {
                            --         local_sorbet_build,
                            --         "--lsp",
                            --         "--silence-dev-message",
                            --         "--enable-all-experimental-lsp-features",
                            --         "--enable-experimental-lsp-document-formatting-rubyfmt"
                            --       }
                            --     end
                            --   end

                            --   lspconfig[server].setup(config)
                            -- end

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

return M
