local status_ok, mason = pcall(require, "mason")
if not status_ok then
	vim.notify("could not require mason.nvim")
	return
end

local mason_settings = {
	ui = {
		border = "none",
	},
	log_level = vim.log.levels.INFO,
}

mason.setup(mason_settings)

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
	vim.notify("could not require mason-lspconfig")
	return
end
-- mason-lspconfig bridges the gap between mason and lspconfig.
-- It needs to be set up before using lspconfig.

local ensured_servers = {
	"bashls",
	"diagnosticls",
	"docker_compose_language_service",
	"dockerls",
	"elixirls",
  "gopls",
	"graphql",
	"html",
	"jsonls",
	"lua_ls",
  "pyright",
	"rust_analyzer",
	"solargraph",
	"tailwindcss",
	"terraformls",
	"tsserver",
	"yamlls",
}

mason_lspconfig.setup({
	-- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
	-- This setting has no relation with the `automatic_installation` setting.
	ensure_installed = ensured_servers,
	-- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
	-- This setting has no relation with the `ensure_installed` setting.
	-- Can either be:
	--   - false: Servers are not automatically installed.
	--   - true: All servers set up via lspconfig are automatically installed.
	--   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
	--       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
	automatic_installation = true,
})

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	vim.notify("could not require lspconfig")
	return
end

local opts = {}

for _, server in pairs(ensured_servers) do
	-- Universal options
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	-- User options for specific server
	local require_ok, user_server_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", user_server_opts, opts)
	end

	-- Configure the server with combined universal and user options
	lspconfig[server].setup(opts)
end
