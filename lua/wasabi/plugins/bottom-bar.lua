-- TODO: make lualine span always entire window even with split screens
-- TODO: hide nvim line or lualine on startup screen
return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		options = {
			icons_enabled = true,
			theme = {
				normal = {
					a = "LL_N_A",
					b = "LL_N_B",
					c = "LL_N_C",
				},
				insert = {
					a = "LL_I_A",
					b = "LL_I_B",
					c = "LL_I_C",
				},
				visual = {
					a = "LL_V_A",
					b = "LL_V_B",
					c = "LL_V_C",
				},
				replace = {
					a = "LL_R_A",
					b = "LL_R_B",
					c = "LL_R_C",
				},
				command = {
					a = "LL_C_A",
					b = "LL_C_B",
					c = "LL_C_C",
				},
				inactive = {
					a = "LL_X_A",
					b = "LL_X_B",
					c = "LL_X_C",
				},
			},
			component_separators = { left = "", right = ""},
			section_separators = { left = "┃", right = "┃"},
			-- section_separators = { left = "◣", right = "◥"},
			-- section_separators = { left = "◣", right = "◢"},
			-- section_separators = { left = "◗", right = ""},
			-- section_separators = { left = "▶", right = "◀"},
			disabled_filetypes = {
				-- for startup screens
				"dashboard",
				"alpha",
				"statusline",
				"winbar",
			},
		},

		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 100,
			tabline = 100,
			winbar = 100,
		},

		sections = {
			lualine_a = {
				{
					"mode",
					icons_enabled = false,
					draw_empty = true,
					padding = 1,
					fmt = function(str, obj)
						return string.sub(str, 1, 1);
					end,
					on_click = function(clicksCount, btn, mod)
						print("haiiii :3");
					end,
				},
			},
			lualine_b = {
				"diagnostics",
				{
					-- ctrl - l <- to disable search
					"searchcount",
					maxcount = 999,
					timeout = 1,
				},
				"branch",
				{
					"diff",
					colored = true,
					diff_color = {
						added = "GitAdd",
						modified = "GitMod",
						removed = "GitDel",
					},
					symbols = {
						added = "+",
						modified = "~",
						removed = "-",
						source = false,
					},
				},
			},
			lualine_c = {
				{
					"filename",
					file_status = true,
					newfile_status = true,
					path = 4,
					symbols = {
						modified = "󰏬 ",
						readonly = "󰿋 ",
						unnamed = "no name",
						newfile = "󰐖 ",
					},
				},
			},

			lualine_x = {
				{
					"filetype",
					colored = true,
					icon_only = false,
					icon = { align = "left" },
					filetype_names = {
						alpha = "menu",
					},
				},
			},
			lualine_y = {
				{
					"encoding",
					show_bomb = false,
				},
			},
			lualine_z = {
				{
					"location",
					padding = { left = 1, right = 1},
				},
			},
		},

		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {"filename"},
			lualine_x = {"filetype"},
			lualine_y = {"encoding"},
			lualine_z = {}
		},

		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	}
}
