return {
	{
		-- TODO: check what functionality besides selection highlight hlslens provide
		"kevinhwang91/nvim-hlslens",
		dependencies = { "petertriho/nvim-scrollbar" },
		config = function ()
			require("hlslens").setup({
				calm_down = true,
				nearest_only = true,
				override_lens = function() end, -- disables the lens
			})
		end
	}, {
		-- TODO: change hex vals of colors to highlight groups
		"petertriho/nvim-scrollbar",
		lazy = false,
		config = function ()
			require("scrollbar").setup({
				hide_if_all_visible = true,
				handle = {
					text = " ",
					blend = 80,
					highlight = "ScrollbarrHandle",
					color = nil,
					color_nr = nil,
					hide_if_all_visible = true,
				},
				marks = {
					Cursor = {
						text = "—",
						priority = 0,
						gui = nil,
						highlight = "ScrollbarrCursor",
						color = nil,
						color_nr = nil,
					},
					Misc = {
						text = { "-", "=" },
						priority = 6,
						gui = nil,
						highlight = "ScrollbarMisc",
						color = nil,
						color_nr = nil,
					},
					Search = {
						text = { "⠄", "⠔", "⠥" },
						priority = 1,
						gui = nil,
						highlight = "Search",
						color = nil,
						color_nr = nil,
					},
					Error = {
						text = { "⠐", "⠢" },
						priority = 2,
						gui = nil,
						highlight = "DiagnosticError",
						color = nil,
						color_nr = nil,
					},
					Warn = {
						text = { "-", "=" },
						priority = 3,
						gui = nil,
						highlight = "DiagnosticWarn",
						color = nil,
						color_nr = nil,
					},
					Info = {
						text = { "-", "=" },
						priority = 4,
						gui = nil,
						highlight = "DiagnosticInfo",
						color = nil,
						color_nr = nil,
					},
					Hint = {
						text = { "-", "=" },
						priority = 5,
						gui = nil,
						highlight = "DiagnosticHint",
						color = nil,
						color_nr = nil,
					 },
					GitAdd = {
						text = "",
						priority = 0,
						gui = nil,
						color = nil,
						cterm = nil,
						color_nr = nil, -- cterm
						highlight = "GitSignsAdd",
					},
					GitChange = {
						text = "",
						priority = 0,
						gui = nil,
						color = nil,
						cterm = nil,
						color_nr = nil, -- cterm
						highlight = "GitSignsChange",
					},
					GitDelete = {
						text = "",
						priority = 0,
						gui = nil,
						color = nil,
						cterm = nil,
						color_nr = nil, -- cterm
						highlight = "GitSignsDelete",
					},
				},

				excluded_buftypes = {
					"terminal",
					"alpha",
				},
				excluded_filetypes = {
					"dropbar_menu",
					"dropbar_menu_fzf",
					"DressingInput",
					"cmp_docs",
					"cmp_menu",
					"noice",
					"prompt",
					"TelescopePrompt",
					"alpha"
				},

				autocmd = {
					render = {
						"BufWinEnter",
						"TabEnter",
						"TermEnter",
						"WinEnter",
						"CmdwinLeave",
						"TextChanged",
						"VimResized",
						"WinScrolled",
					},
					clear = {
						"BufWinLeave",
						"TabLeave",
						"TermLeave",
						"WinLeave",
					},
				},

				handlers = {
					handle = true,
					cursor = true,
					search = true,
					diagnostic = true,
					gitsigns = false,
					ale = false,
				},

				-- example -- 
				-- require("scrollbar.handlers").register("my_marks", function(bufnr)
				-- 	return {
				-- 		{ line = 5, type = "Error" },
				-- 		{ line = 6, level = 2 },
				-- 		{ line = 4, text = "]", type = "Warn" },
				-- 	}
				-- end), 

			});

			require("scrollbar.handlers.search").setup({
				override_lens = function () end;
				build_position_cb = function (plist, _, _, _)
					require("scrollbar.handlers.search").handler.show(plist.start_pos);
				end;
			});
		end
	}
}
