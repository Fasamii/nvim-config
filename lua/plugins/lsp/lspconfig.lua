return {
	"neovim/nvim-lspconfig",
	dependencies = { "mason-lspconfig.nvim" },
	config = function(_, opts)
		local capabilities = require("blink.cmp").get_lsp_capabilities();
		local lspconfig = require("lspconfig");

		lspconfig["lua_ls"].setup({ capabilities = capabilities, })
	end,
}
