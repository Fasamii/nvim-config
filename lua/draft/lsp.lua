return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "$3rd/luv/library", words = {" vim%.uv"}},
			},
		},
	}, {
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-lspconfig.nvim",
		},
	}, {
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					"lua_ls", "clangd", "rust_analyzer", "gopls", "pyright"
				},
			});
		end,
	}, {
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup();
		end,
	},
}
