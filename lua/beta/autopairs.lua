return {
	'windwp/nvim-autopairs',
	event = "InsertEnter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter"
	},
	config = function()
		local ap = require("nvim-autopairs");
		local rule = require("nvim-autopairs.rule");
		local ap_ts_conds = require("nvim-autopairs.ts-conds");

		ap.setup({
			enabled = function() return true end, -- control if auto-pairs should be enabled when attaching to a buffer -- you can take foo arg (buffer_number)
			disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input", "vim" },
			check_ts = true,
			ts_config = {
				-- TODO: check what below lines mean
				lua = { "string", "source" },
				javascript = { "template_string" },
				java = false,
			},

			disable_in_macro = true, -- disable when recording or executing a macro
			disable_in_visualblock = false, -- disable when insert after visual block mode
			disable_in_replace_mode = true,
			ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
			enable_moveright = true,
			enable_afterquote = true, -- add bracket pairs after quote
			enable_check_bracket_line = true, --- check bracket in same line
			enable_bracket_in_quote = true, --
			enable_abbr = false, -- trigger abbreviation
			break_undo = true, -- switch for basic rule break undo sequence
			map_cr = true,
			map_bs = true, -- map the <BS> key
			map_c_h = false, -- Map the <C-h> key to delete a pair
			map_c_w = false, -- map <c-w> to delete a pair if possible
			-- TODO: check what below code does
			fast_wrap = {
				map = "<M-e>", -- Alt+e to wrap pairs
				chars = { "{", "[", "(", '"', "'" },
				pattern = [=[[%'%"%)%>%]%)%}%,]]=],
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel",
				highlight_grey = "LineNr",
			},
		});

		-- TODO: check what code to the end of the file do and make similar things.
		--[[
		ap.add_rules({
			rule(" ", " ")
				:with_pair(function(opts)
				local pair = opts.line:sub(opts.col - 1, opts.col)
				return vim.tbl_contains({ "()", "[]", "{}" }, pair)
			end)
			:with_move(function(opts)
				return opts.prev_char:match(".%s") ~= nil
			end)
			:with_cr(function() -- you can use (opts)  with foo                         
				return false
			end)
			:with_del(function(opts)
				local col = vim.api.nvim_win_get_cursor(0)[2]
				local context = opts.line:sub(col - 1, col + 2)
				return vim.tbl_contains({ "(  )", "{  }", "[  ]" }, context)
			end),
		})

		ap.add_rules({
			-- Add space after function keyword in Lua
			rule("function", " ", "lua"):use_regex(true),
			-- Add rules for arrow functions in JavaScript/TypeScript
			rule("%(.*%)%s*%=>", " {}", { "typescript", "javascript", "typescriptreact", "javascriptreact" })
				:use_regex(true)
				:set_end_pair_length(2),
			-- Add rules for pairs inside comments
			rule("%(", "%)"):with_pair(ap_ts_conds.is_not_ts_node({ "comment" })),
			rule("{", "}"):with_pair(ap_ts_conds.is_not_ts_node({ "comment" })),
			rule("[", "]"):with_pair(ap_ts_conds.is_not_ts_node({ "comment" })),
			-- Skip if next character is inside a word
			rule("'", "'"):with_pair(function(opts)
			if opts.line:sub(opts.col + 1, opts.col + 1):match("%w") then
				return false
			end
				return true
			end),
		})

		-- Example of language-specific rules
		ap.add_rules({
			-- Markdown-specific rules
			rule("```", "```", "markdown"):with_pair(function()
				local line = vim.api.nvim_get_current_line()
				local col = vim.api.nvim_win_get_cursor(0)[2]
				return col > 2 and line:sub(col - 2, col - 1) == "``"
			end):set_end_pair_length(3),

			-- HTML/XML-specific rules
			rule("<", ">", { "html", "xml", "typescriptreact", "javascriptreact", "svelte", "vue" })
				:with_pair(ap_ts_conds.is_not_ts_node({ "comment", "string" }))
				:with_pair(function() -- you can use parameter (opts) in foo local col = vim.api.nvim_win_get_cursor(0)[2]
				local line = vim.api.nvim_get_current_line()
				local col = vim.api.nvim_win_get_cursor(0)[2]
				local prev_char = line:sub(col - 1, col - 1)
			-- Don't pair if it looks like a comparison operator or inside a comment
			if prev_char:match("%s") or prev_char:match("[=<>]") then
				return false
			end
				return true
			end),
		})
		]]--
	end
}
