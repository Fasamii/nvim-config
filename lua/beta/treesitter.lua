return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
	lazy = vim.fn.argc(-1) == 0,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function ()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"bash",
				"rust" ,
				"yaml",
				"toml",
				"lua",
				"json",
				"html",
				"regex",
				"markdown",
				"markdown_inline",
			},
			sync_install = false,
			auto_install = true,
			ignore_install = {},
			modules = {}, -- NOTE: this is considered outdated (added empty to silence lsp)

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			indent = { enable = true },

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>is",
					node_incremental = "<leader>ii",
					scope_incremental = "<leader>ic",
					node_decremental = "<leader>id",
				},
			},

			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
					include_surrounding_whitespace = true,
				},
			},
		});
	end
}
