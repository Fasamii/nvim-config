return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		triggers = {
			{ "<auto>", mode = "nixsotc"},
			{ "a", mode = { "n", "v" }},
		},
	},
}
