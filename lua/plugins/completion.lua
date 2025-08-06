require("blink.cmp").setup({
	keymap = {
		preset = 'none',
		['<C-p>'] = { 'select_prev', 'fallback' },
		['<C-n>'] = { 'select_next', 'fallback' },
		['<C-y>'] = { 'select_and_accept' },
		['<C-e>'] = { 'hide' },
		['<C-Space>'] = { 'show' },
	},

	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = 'mono'
	},

	completion = {
		trigger = {
			show_on_keyword = true, -- Show on typing keywords
			show_on_trigger_character = true, -- Show on trigger characters like '.'
			show_on_accept_on_trigger_character = true,
		},

		ghost_text = {
			enabled = true,
			show_with_menu = true -- Don't show ghost text when menu is open
		},

		menu = {
			auto_show = true, -- This prevents popup menus
			draw = {
				treesitter = { 'lsp' }
			}
		},

		documentation = {
			auto_show = false,
			auto_show_delay_ms = 200
		},

		list = {
			selection = {
				preselect = false,
				auto_insert = false
			}
		}
	},

	sources = {
		default = { 'lsp', 'path', 'buffer' }
	},

	signature = {
		enabled = false
	},
	fuzzy = { implementation = "lua" } -- TODO: change to "prefer_rust" for performance
});
