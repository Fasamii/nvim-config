require("nvim-treesitter.configs").setup({
	sync_install = true,
	auto_install = true,

	indent = { enable = true },

	additional_vim_regex_highlighting = false,
	highlight = {
		enable = true,
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
