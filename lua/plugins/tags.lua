require("todo-comments").setup({
		signs = true,
		sign_priority = 8,
		keywords = {
			FIX = {
				signs = false,
				icon = "󰅗 ",
				color = "err",
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "ERR" },
			},
			TODO = {
				signs = false,
				icon = " ",
				color = "warn",
				alt = { "LATER" },
			},
			IMPORTANT = {
				signs = false,
				icon = " ",
				color = "err",
			},
			WARN = {
				signs = false,
				icon = "󰀧 ",
				color = "warn",
				alt = { "WARNING", "XXX" }
			},
			DONE = {
				signs = false,
				icon = " ",
				color = "ok",
				alt = { "WARNING", "XXX" }
			},
			HACK = {
				signs = false,
				icon = "󰇟 ",
				color = "err",
			},
			NOTE = {
				icon = "󰞋 ",
				signs = false,
				color = "info",
				alt = { "INFO" },
			},
			PERF = {
				signs = false,
				icon = "󱕍 ",
				alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" }
			},
			TEST = {
				signs = false,
				icon = "󰿦 ",
				alt = { "TESTING", "PASSED", "FAILED" },
			},
		},
		gui_style = {
			fg = "BOLD", -- The gui style to use for the fg highlight group.
			bg = "BOLD", -- The gui style to use for the bg highlight group.
		},
		merge_keywords = true, -- when true, custom keywords will be merged with the defaults
		-- highlighting of the line containing the todo comment
		-- * before: highlights before the keyword (typically comment characters)
		-- * keyword: highlights of the keyword
		-- * after: highlights after the keyword (todo text)
		highlight = {
			multiline = true, -- enable multine todo comments
			multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
			multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
			before = "bg",    -- "fg" or "bg" or empty
			keyword = "bg",   -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
			after = "empty",  -- "fg" or "bg" or empty
			pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
			comments_only = true, -- uses treesitter to match keywords in comments only
			max_line_len = 400, -- ignore lines longer than this
			exclude = {},     -- list of file types to exclude highlighting
		},
		colors = {
			--TODO: tweaks colors e.g.: make TODO highlight darker.
			ok = { "DiagnosticOk", "Ok", "#00d75f" },
			err = { "DiagnosticError", "ErrorMsg", "Error", "#dc2626" },
			warn = { "DiagnosticWarn", "WarningMsg", "Warning", "#fbbf24" },
			info = { "DiagnosticInfo", "Info", "#2563eb" },
			default = { "Identifier", "#7c3aed" },
		},
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
			},
			-- regex that will be used to match keywords.
			-- don't replace the (KEYWORDS) placeholder
			pattern = [[\b(KEYWORDS):]], -- ripgrep regex
		},
});

require("keymaps").tags();
