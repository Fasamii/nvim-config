require("blink.cmp").setup({
	keymap = {
		preset = 'none',
		-- ['<S-Tab>'] = { 'select_prev', 'fallback' },
		-- ['<Tab>'] = { 'select_next', 'fallback' },
		['<Tab>'] = { 'select_and_accept' },
		-- ['<C-e>'] = { 'hide' },
		-- ['<C-Space>'] = { 'show' },
	},

	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = 'mono'
	},

	completion = {
		trigger = {
			show_on_keyword = true,
			show_on_trigger_character = true,
			show_on_accept_on_trigger_character = true,
		},

		ghost_text = {
			enabled = true,
		},

		menu = {
			enabled = false,
			auto_show = true
		},

		documentation = {
			auto_show = false,
			auto_show_delay_ms = 200
		},

		list = {
			selection = {
				preselect = true,
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
