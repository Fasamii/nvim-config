  return {
	"nvim-tree/nvim-web-devicons",
	lazy = true,
	specs = {
		{ "echasnovski/mini.icons", enabled = false, optional = true },
	},
	opts = {
		color_icons = true,
		default = true,
		strct = true,
		variant = vim.o.background,

		--[[
		override = {
			lua = {
				icon = "󰊱 ",
				color = "#428850",
				cterm_color = "46",
				name  = "Lua"
			},
		},
		]]--

		-- NOTE: works only when strict is true
		override_by_filename = {
			[".gitignore"] = {
				icon = " ",
				color = "#f14e32",
				cterm_color = "196",
				name = "Gitignore"
			}
		},

		override_by_extension = {
			["log"] = {
				icon = " ",
				color = "#00ff77",
				cterm_color = "47",
				name = "Log"
			},
			["txt"] = {
				icon = " ",
				color = "#00ff77",
				cterm_color = "113",
				name = "Text"
			},
		},

		override_by_operating_system = {
			["apple"] = {
				icon = "",
				color = "#00000",
				cterm_color = "0",
				name = "Apple",
			},
			["linux"] = {
				icon = "󰌽 ",
				color = "#FFFF00",
				cterm_color = "226",
				name = "Apple",
			},
		},
	},
}
