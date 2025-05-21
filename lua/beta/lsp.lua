return {
	-- FIXME: do something with that lsp
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					"lua_ls", "clangd", "rust_analyzer", "gopls", "pyright"
				},
			});
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup();
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "$3rd/luv/library", words = {" vim%.uv"}},
			},
		},
	},
}
