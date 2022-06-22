local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("lance.lsp.lsp-installer")
require("lance.lsp.handlers").setup()
