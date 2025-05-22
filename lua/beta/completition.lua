return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = '*',
	config = function ()
		require("blink-cmp").setup({
			--INFO: See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = "default" },

			appearance = { nerd_font_variant = "mono" },
			completion = {
				documentation = {
					auto_show = true,
				},
			},
			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			-- TODO: below table is off, read the docs for blink and rewrite that table
			sources = {
				default = {
					"lsp", -- FIXME: if lsp is disabled blink crashes
					"path", -- paths in file system
					"snippets",
					"buffer", -- reuse words that you already typed
					"lazydev",
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					lsp = {
						name = "LSP",
						module = "blink.cmp.sources.lsp",
						opts = {}, -- Passed to the source directly, varies by source

						--- NOTE: All of these options may be functions to get dynamic behavior
						--- See the type definitions for more information
						enabled = true, -- Whether or not to enable the provider
						async = false, -- Whether we should show the completions before this provider returns, without waiting for it
						timeout_ms = 2000, -- How long to wait for the provider to return before showing completions and treating it as asynchronous
						transform_items = nil, -- Function to transform the items before they're returned
						should_show_items = true, -- Whether or not to show the items
						max_items = nil, -- Maximum number of items to display in the menu
						min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
						-- If this provider returns 0 items, it will fallback to these providers.
						-- If multiple providers fallback to the same provider, all of the providers must return 0 items for it to fallback
						fallbacks = {},
						score_offset = 0, -- Boost/penalize the score of the items
						override = nil, -- Override the source's functions
					},
				},
			},
			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = {
				implementation = "prefer_rust_with_warning"
			},
			endtend = { "sources.default" }
		});
	end
}
