return {
	'saghen/blink.cmp',
	dependencies = { 'rafamadriz/friendly-snippets' },
	build = 'cargo build --release',
	opts = {
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = { preset = 'default' },

		appearance = { nerd_font_variant = 'mono' },

		completion = {
			documentation = {
				auto_show = true
			},
			menu = {
				scrollbar = true,
				draw = {
					columns = {{ "kind_icon" }, { "label", "label_description", gap = 1 }},
					components = {}
				}
			}
		},
		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" },
}
