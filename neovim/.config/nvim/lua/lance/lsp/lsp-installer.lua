local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  vim.notify("Could not load nvim-lsp-installer")
  return
end

lsp_installer.settings({ log_level = vim.log.levels.DEBUG })

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  -- In the config I borrowed from David we called a function that returned a
  -- table and then set keys on that table using dot notation. Here we are
  -- building an initial table and then merging it with a table for specific
  -- language servers. So anything set via the dot notation can also be set by
  -- the new table.
  local opts = {
    on_attach = require("lance.lsp.handlers").on_attach,
    capabilities = require("lance.lsp.handlers").capabilities,
  }

  if server.name == "elixirls" then
    local server_opts = require("lance.lsp.settings.elixirls")
    opts = vim.tbl_deep_extend("force", server_opts, opts)
  end

  if server.name == "vimls" then
    local server_opts = require("lance.lsp.settings.vimls")
    opts = vim.tbl_deep_extend("force", server_opts, opts)
  end

  if server.name == "lua_ls" then
    local server_opts = require("lance.lsp.settings.lua_ls")
    opts = vim.tbl_deep_extend("force", server_opts, opts)
  end

  if server.name == 'sorbet' then
    -- print("checking for local sorbet")
    local local_sorbet_build = vim.fn.glob(vim.fn.environ().HOME.."/stripe/sorbet/bazel-bin/main/sorbet")
    if local_sorbet_build ~= "" then
      print("local sorbet")
      -- prefer a local build of sorbet if it's available
      opts.cmd = {
        local_sorbet_build,
        "--lsp",
        "--silence-dev-message",
        "--enable-all-experimental-lsp-features",
        "--enable-experimental-lsp-document-formatting-rubyfmt"
      }
    end
  end

  if server.name == 'solargraph' and vim.fn.glob("scripts/bin/typecheck") ~= "" then
    print("solargraph + scripts/bin/typecheck")
    opts.filetypes = {}
  end

  if server.name == 'solargraph' and vim.fn.glob("sorbet") ~= "" then
    print("solargraph + sorbet")
    opts.filetypes = {}
    -- elseif server.name == 'sorbet' and vim.fn.glob("scripts/bin/typecheck") ~= "" then
    --   print("sorbet + scripts/bin/typecheck")
    --   config.cmd = {
    --     "scripts/dev_productivity/while_pay_up_connected.sh",
    --     "pay",
    --     "exec",
    --     "scripts/bin/typecheck",
    --     "--lsp",
    --     "--enable-all-experimental-lsp-features",
    --     "--enable-experimental-lsp-document-formatting-rubyfmt"
    --   }
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)
