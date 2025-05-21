return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects", },
	},
	config = function()
		require("nvim-treesitter.configs").setup ({
			ensure_installed = { "rust" },
			auto_install = true,
			highlight = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>si",
					node_incremental = "<leader>m",
					node_decremental = "<leader>l",
					scope_incremental = "<leader>s"
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
						["as"] = "@scope",
					},
					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "v",
						["@class.outer"] = "V",
					},
					include_surrounding_whitespace = true,
				},
			},
		})
	end,
}
