vim.cmd("highlight clear");
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset"); end;
vim.g.colors_name = "sobsob";
vim.o.background = "dark";
local cp = {
	bg_solid	= "#000000",
	bg		= "none",

	white		= "#d0d0d0",
	white_dimm	=  "#b3b3b3",
	white_dark	=   "#585858",

	black		= "#1a1a1a",
	black_dimm	= "#161618",
	black_dark	= "#0f0f12",
	black_shadow= "#080809",

	green		= "#00d75f",
	cyan		= "#00b3e5",
	blue		= "#569cd6",
	violet	= "#875fff",
	purple	= "#ff87ff",
	magneta	= "#d600c8",
	red		= "#ed3131",
	pink		= "#ff5fa3",
	yellow	= "#ffaf00",
	orange	= "#f26c0c",

	util_lv1	= "#f487b6",
	util_lv2	= "#9046cf",
	util_lv3	= "#cc59d2",


	error		= "#ff4081",
	warning	= "#ffaf00",
	info		= "#00b3e5",
	hint		= "#00d75f",

	border	= "#464647",
	selection	= "#264f78",
	search	= "#613214",
	match_paren	= "#007acc",
};

local function hi(group, style) vim.api.nvim_set_hl(0, group, style); end;

-- Basic editor highlights
hi("Normal", { fg = cp.white, bg = cp.bg });
hi("CursorLine", { bg = cp.black });
hi("CursorLineNr", { fg = cp.purple, bg = cp.bg, bold = true });
hi("LineNr", { fg = cp.white_dark, bg = cp.bg });
hi("Visual", { bg = cp.selection });
hi("Search", { bg = cp.search });
hi("IncSearch", { bg = cp.black_dimm, fg = cp.yellow });
hi("MatchParen", { fg = cp.black_dark, bold = true });
----------------
---- syntax ----
----------------
--------------
-- fallback --
--------------
-- Text
hi("Comment", { fg = cp.white_dark });
hi("PreCondit", { fg = cp.orange });
hi("SpecialChar", { fg = cp.violet });
hi("@text", { fg = cp.white }); -- Non-structured text
hi("@text.strong", { fg = cp.white, bold = true }); -- Bold text
hi("@text.emphasis", { fg = cp.white }); -- Emphasized text
hi("@text.underline", { fg = cp.white, underline = true }); -- Underlined text
hi("@text.strike", { fg = cp.white, strikethrough = true }); -- Strikethrough text
hi("@text.title", { fg = cp.white, bold = true }); -- Titles
hi("@text.literal", { fg = cp.white }); -- Literal or verbatim text
hi("@text.uri", { fg = cp.cyan, underline = true }); -- URIs (URLs, file paths, etc.)
hi("@text.math", { fg = cp.cyan }); -- Math environments
hi("@text.reference", { fg = cp.white }); -- References
hi("@text.environment", { fg = cp.white }); -- Text environments
hi("@text.environment.name", { fg = cp.white }); -- Text environment names
hi("@text.note", { fg = cp.white_dimm }); -- Notes
hi("@text.warning", { fg = cp.warning }); -- Warnings
hi("@text.danger", { fg = cp.error }); -- Danger alerts
hi("@text.diff.add", { fg = cp.util_lv1 }); -- Added text (for diffs)
hi("@text.diff.delete", { fg = cp.util_lv3 }); -- Deleted text (for diffs)
-- Function
hi("Function", { fg = cp.purple, bold = true });
hi("Label", { fg = cp.magneta });
-- Keyword
hi("Keyword", { fg = cp.cyan });
hi("Statment", { fg = cp.cyan });
hi("Conditional", { fg = cp.cyan });
hi("Repeat", { fg = cp.cyan });
hi("Exception", { fg = cp.cyan });
-- Identifier
hi("Identifier", { fg = cp.purple });
-- Statement
hi("Macro", { fg = cp.magneta });
hi("Define", { fg = cp.magneta });
hi("Include", { fg = cp.magneta });
-- Type
hi("Type", { fg = cp.yellow });
hi("Constant", { fg = cp.yellow, bold = true });
hi("Structure", { fg = cp.yellow, bold = true });
-- Literal
hi("Number", { fg = cp.red });
hi("Boolean", { fg = cp.red });
hi("Float", { fg = cp.red });
hi("Character", { fg = cp.red });
hi("String", { fg = cp.green });
-- Operator
hi("Operator", { fg = cp.cyan });
-- Delimiter
hi("Delimiter", { fg = cp.violet });
hi("MatchParen", { fg = cp.yellow, bold = true });
-- Diagnostic
hi("Error", { fg = cp.error, bold = true });
hi("ErrorMsg", { fg = cp.error, bold = true });
hi("Warning", { fg = cp.warning, bold = true });
hi("WarningMsg", { fg = cp.warning, bold = true });
----------------
-- Treesitter --
----------------
-- Text
hi("@comment", { fg = cp.white_dark });
hi("@comment.documentation", { fg = cp.white_dimm });
hi("@special.comment", { fg = cp.white_dark, bold = true });
hi("@comment.error", { fg = cp.error });
hi("@preproc", { fg = cp.orange });
-- Keyword
hi("@keyword", { fg = cp.cyan });
hi("@keyword.function", { fg = cp.cyan });
hi("@keyword.operator", { fg = cp.cyan });
hi("@keyword.return", { fg = cp.cyan });
hi("@conditional", { fg = cp.cyan });
hi("@repeat", { fg = cp.cyan });
-- Statement
hi("@debug", { fg = cp.ornage });
hi("@statment", { fg = cp.violet });
hi("@include", { fg = cp.magneta });
hi("@define", { fg = cp.magneta });
hi("@macro", { fg = cp.magneta });
-- Identifier
hi("@identifier", { fg = cp.purple });
hi("@property", { fg = cp.purple });
hi("@variable", { fg = cp.purple });
hi("@variable.builtin", { fg = cp.purple, bold = true });
hi("@variable.property", { fg = cp.purple });
hi("@variable.parameter", { fg = cp.purple });
hi("@variable.function", { fg = cp.purple, bold = true });
-- Function
hi("@function", { fg = cp.purple, bold = true });
hi("@function.call", { fg = cp.purple, bold = true });
hi("@parameter", { fg = cp.purple });
hi("@method.call", { bg = cp.purple, bold = true });
hi("@method", { fg = cp.purple, bold = true });
hi("@constructor", { fg = cp.pink, bold = true });
hi("@label", { fg = cp.purple, bold = true });
-- Type
hi("@type", { fg = cp.yellow });
hi("@type.builtin", { fg = cp.yellow });
hi("@type.qualifier", { fg = cp.yellow });
hi("@type.definition", { bg = cp.yellow });
hi("@storageclass", { fg = cp.yellow });
hi("@namespace", { fg = cp.yellow });
hi("@constant", { fg = cp.yellow, bold = true });
hi("@constant.builtin", { fg = cp.yellow, bold = true });
hi("@constant.macro", { fg = cp.magneta });
-- Lsp Type
hi("@lsp.type.structure", { fg = cp.yellow, bold = true });
-- Literal
hi("@null", { fg = cp.red });
hi("@string", { fg = cp.green });
hi("@string.regex", { fg = cp.magneta });
hi("@string.escape", { fg = cp.magneta });
hi("@string.special", { fg = cp.magneta });
hi("@character", { fg = cp.red });
hi("@character.special", { fg = cp.red });
hi("@number", { fg = cp.red });
hi("@boolean", { fg = cp.red });
hi("@float", { fg = cp.red });
-- Punctuation
hi("@punctuation.bracket", { fg = cp.violet }); -- Brackets, braces, parentheses
hi("@punctuation.delimiter", { fg = cp.violet }); -- Delimiters (commas, colons, ...)
hi("@punctuation.special", { fg = cp.violet }); -- Special punctuation
-- Operator 
hi("@operator", { fg = cp.magneta, bold = true }); --TODO: consider other color for operator
--------------
---- util ----
--------------
--------------
-- spelling --
--------------
hi("SpellBad", { undercurl = true, sp = cp.error, bold = true });
hi("SpellCap", { undercurl = true, sp = cp.warning });
hi("SpellRare", { bold = true }); --TODO: consider treating it the same as SpellBad
hi("SpellLocal", {});
------------
-- status --
------------
hi("Error", { fg = cp.error });
hi("ErrorMsg", { fg = cp.error });
hi("DiagnosticError", { fg = cp.error });

hi("Warn", { fg = cp.warn });
hi("WarningMsg", { fg = cp.warn });
hi("DiagnosticWarn", { fg = cp.warn });

hi("Info", { fg = cp.info });
hi("DiagnosticInfo", { fg = cp.info });
---------
-- git --
---------
hi("GitAdd", { fg = cp.util_lv1, bold = true });
hi("GitMod", { fg = cp.util_lv2, bold = true });
hi("GitRem", { fg = cp.util_lv3, bold = true });
------------------
-- status lines --
------------------
-- nvim builtin
hi("StatusLine", { bg = cp.black_dark, fg = cp.white });
hi("TabLineFill", { bg = cp.black_dark });
hi("TabLineSel", { bg = cp.black_dimm, fg = cp.magneta, bold = true });
hi("TabLine", { bg = cp.black_dark, fg = cp.violet });
-- lualine
hi("LL_N_A", { bg = cp.blue, fg = cp.bg_solid, bold = true });
hi("LL_N_B", { fg = cp.violet, bold = true });
hi("LL_N_C", { fg = cp.violet, bold = true });

hi("LL_I_A", { bg = cp.green, fg = cp.bg_solid, bold = true });
hi("LL_I_B", { fg = cp.violet, bold = true });
hi("LL_I_C", { fg = cp.violet, bold = true });

hi("LL_V_A", { bg = cp.yellow, fg = cp.bg_solid, bold = true });
hi("LL_V_B", { fg = cp.violet, bold = true });
hi("LL_V_C", { fg = cp.violet, bold = true });

hi("LL_R_A", { bg = cp.pink, fg = cp.bg_solid, bold = true });
hi("LL_R_B", { fg = cp.violet, bold = true });
hi("LL_R_C", { fg = cp.violet, bold = true });

hi("LL_C_A", { bg = cp.violet, fg = cp.bg_solid, bold = true });
hi("LL_C_B", { fg = cp.violet, bold = true });
hi("LL_C_C", { fg = cp.violet, bold = true });

hi("LL_X_A", { bg = cp.purple, fg = cp.bg_solid, bold = true });
hi("LL_X_B", { fg = cp.violet, bold = true });
hi("LL_X_C", { fg = cp.violet, bold = true });
---------------
-- which-key --
---------------
hi("WhichKey", { fg = cp.magneta, bold = true });
-- hi("WhichKeyBorder", { bg = cp.red });
hi("WhichKeyDesc", { fg = cp.purple });
hi("WhichKeyGroup", { fg = cp.cyan });
-- hi("WhichKeyIconGrey", { bg = cp.red });
-- hi("WhichKeyTitle", { bg = cp.red });
hi("WhichKeyNormal", { bg = cp.black_shadow });
