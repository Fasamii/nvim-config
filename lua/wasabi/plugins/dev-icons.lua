  return {
	"nvim-tree/nvim-web-devicons",
	lazy = true,
	specs = {
		{ "echasnovski/mini.icons", enabled = false, optional = true },
	},
	opts = {
		color_icons = true,
		default = true,
		override = {
			zsh = { icon = "", color = "#428850", name  = "Zsh" },
		},
	},
}
