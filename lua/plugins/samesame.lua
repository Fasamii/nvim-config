require("illuminate").configure({
	providers = {
		"lsp",
		"treesitter",
		"regex",
	},
	delay = 30,
	-- filetype_overrides: filetype specific overrides.
	-- The keys are strings to represent the filetype while the values are tables that
	-- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
	filetype_overrides = {},
	-- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
	filetypes_denylist = {
		"dirbuf",
		"dirvish",
		"fugitive",
	},
	-- under_cursor: whether or not to illuminate under the cursor
	under_cursor = true,
	-- large_file_cutoff: number of lines at which to use large_file_config
	-- The `under_cursor` option is disabled when this cutoff is hit
	large_file_cutoff = 10000,
	-- large_file_config: config to use for large files (based on large_file_cutoff).
	-- Supports the same keys passed to .configure
	-- If nil, vim-illuminate will be disabled for large files.
	large_file_overrides = nil,
	-- min_count_to_highlight: minimum number of matches required to perform highlighting
	min_count_to_highlight = 2,
	should_enable = function(_bufnr) return true end,
	-- case_insensitive_regex: sets regex case sensitivity
	case_insensitive_regex = false,
	-- disable_keymaps: disable default keymaps
	disable_keymaps = true,
})
