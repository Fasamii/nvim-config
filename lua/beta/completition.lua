return {
	"saghen/blink.cmp",
	lazy = false,
	event = "InsertEnter",
	version = '*',
	build = "cargo build --release",
	dependencies = { 
		"rafamadriz/friendly-snippets",
		{
			"saghen/blink.compat",
			optional = true,
			opts = {},
			version = "*",
		},
	},
	opts = {
		keymap = { preset = "default" },
		appearance = { 
			nerd_font_variant = "mono" 
		},
		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
			ghost_text = {
				enabled = vim.g.ai_cmp or false,
			},
		},
		sources = {
			default = {
				"lsp", 
				"path",
				"snippets",
				"buffer",
				"lazydev",
			},
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
	},
	opts_extend = { "sources.default" }
}
