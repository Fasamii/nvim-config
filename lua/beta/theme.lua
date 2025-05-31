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

local function hl(group, style) vim.api.nvim_set_hl(0, group, style); end;

-- Basic editor highlights
hl("Normal", { fg = cp.white, bg = cp.bg });
hl("CursorLine", { bg = cp.black });
hl("CursorLineNr", { fg = cp.purple, bg = cp.bg, bold = true });
hl("LineNr", { fg = cp.white_dark, bg = cp.bg });
hl("Visual", { bg = cp.selection });
hl("Search", { bg = cp.search });
hl("IncSearch", { bg = cp.black_dimm, fg = cp.yellow });
hl("MatchParen", { fg = cp.black_dark, bold = true });
----------------
---- syntax ----
----------------
--------------
-- fallback --
--------------
-- Text
hl("Comment", { fg = cp.white_dark });
hl("PreCondit", { fg = cp.orange });
hl("SpecialChar", { fg = cp.violet });
hl("@text", { fg = cp.white }); -- Non-structured text
hl("@text.strong", { fg = cp.white, bold = true }); -- Bold text
hl("@text.emphasis", { fg = cp.white }); -- Emphasized text
hl("@text.underline", { fg = cp.white, underline = true }); -- Underlined text
hl("@text.strike", { fg = cp.white, strikethrough = true }); -- Strikethrough text
hl("@text.title", { fg = cp.white, bold = true }); -- Titles
hl("@text.literal", { fg = cp.white }); -- Literal or verbatim text
hl("@text.uri", { fg = cp.cyan, underline = true }); -- URIs (URLs, file paths, etc.)
hl("@text.math", { fg = cp.cyan }); -- Math environments
hl("@text.reference", { fg = cp.white }); -- References
hl("@text.environment", { fg = cp.white }); -- Text environments
hl("@text.environment.name", { fg = cp.white }); -- Text environment names
hl("@text.note", { fg = cp.white_dimm }); -- Notes
hl("@text.warning", { fg = cp.warning }); -- Warnings
hl("@text.danger", { fg = cp.error }); -- Danger alerts
hl("@text.diff.add", { fg = cp.util_lv1 }); -- Added text (for diffs)
hl("@text.diff.delete", { fg = cp.util_lv3 }); -- Deleted text (for diffs)
-- Function
hl("Function", { fg = cp.purple, bold = true });
hl("Label", { fg = cp.magneta });
-- Keyword
hl("Keyword", { fg = cp.cyan });
hl("Statment", { fg = cp.cyan });
hl("Conditional", { fg = cp.cyan });
hl("Repeat", { fg = cp.cyan });
hl("Exception", { fg = cp.cyan });
-- Identifier
hl("Identifier", { fg = cp.purple });
-- Statement
hl("Macro", { fg = cp.magneta });
hl("Define", { fg = cp.magneta });
hl("Include", { fg = cp.magneta });
-- Type
hl("Type", { fg = cp.yellow });
hl("Constant", { fg = cp.yellow, bold = true });
hl("Structure", { fg = cp.yellow, bold = true });
-- Literal
hl("Number", { fg = cp.red });
hl("Boolean", { fg = cp.red });
hl("Float", { fg = cp.red });
hl("Character", { fg = cp.red });
hl("String", { fg = cp.green });
-- Operator
hl("Operator", { fg = cp.cyan });
-- Delimiter
hl("Delimiter", { fg = cp.violet });
hl("MatchParen", { fg = cp.yellow, bold = true });
-- Diagnostic
hl("Error", { fg = cp.error });
hl("ErrorMsg", { fg = cp.error });
hl("Warning", { fg = cp.warning });
hl("WarningMsg", { fg = cp.warning });
----------------
-- Treesitter --
----------------
-- Text
hl("@comment", { fg = cp.white_dark });
hl("@comment.documentation", { fg = cp.white_dimm });
hl("@special.comment", { fg = cp.white_dark, bold = true });
hl("@preproc", { fg = cp.orange });
-- Keyword
hl("@keyword", { fg = cp.cyan });
hl("@keyword.function", { fg = cp.cyan });
hl("@keyword.operator", { fg = cp.cyan });
hl("@keyword.return", { fg = cp.cyan });
hl("@conditional", { fg = cp.cyan });
hl("@repeat", { fg = cp.cyan });
-- Statement
hl("@debug", { fg = cp.ornage });
hl("@statment", { fg = cp.violet });
hl("@include", { fg = cp.magneta });
hl("@define", { fg = cp.magneta });
hl("@macro", { fg = cp.magneta });
-- Identifier
hl("@identifier", { fg = cp.purple });
hl("@property", { fg = cp.purple }); -- Object properties -- TODO: check if that exists
hl("@symbol", { bg = cp.purple }); -- Symbols -- TODO: check if that exists
hl("@field", { fg = cp.purple }); -- Object and struct fields --TODO: check if that exists
hl("@variable", { fg = cp.purple });
hl("@variable.builtin", { fg = cp.purple, bold = true });
hl("@variable.property", { fg = cp.purple });
hl("@variable.parameter", { fg = cp.purple });
hl("@variable.function", { fg = cp.purple, bold = true });
-- Function
hl("@function", { fg = cp.purple, bold = true });
hl("@function.call", { fg = cp.purple, bold = true });
hl("@parameter", { fg = cp.purple });
hl("@method.call", { bg = cp.purple, bold = true });
hl("@method", { fg = cp.purple, bold = true });
hl("@constructor", { fg = cp.pink, bold = true }); --TODO: for some reason treesitter consider {} pretenses as constructors
hl("@label", { fg = cp.purple, bold = true });
-- Type
--
hl("@type", { fg = cp.yellow });
hl("@type.builtin", { fg = cp.yellow });
hl("@type.qualifier", { fg = cp.yellow });
hl("@type.definition", { bg = cp.yellow }); -- Type definitions 
hl("@storageclass", { fg = cp.yellow });
hl("@namespace", { fg = cp.yellow }); -- TODO: consider other color for constant
hl("@constant", { fg = cp.yellow, bold = true });
hl("@constant.builtin", { fg = cp.yellow, bold = true });
hl("@constant.macro", { fg = cp.magneta });
-- Lsp Type
hl("@lsp.type.structure", { fg = cp.yellow, bold = true });
-- Literal
hl("@null", { fg = cp.red });
hl("@string", { fg = cp.green });
hl("@string.regex", { fg = cp.magneta }); -- Regular expressions
hl("@string.escape", { fg = cp.magneta }); -- Escape sequences
hl("@string.special", { fg = cp.magneta }); -- Special strings
hl("@character", { fg = cp.red });
hl("@character.special", { fg = cp.red }); -- Special character
hl("@number", { fg = cp.red });
hl("@boolean", { fg = cp.red });
hl("@float", { fg = cp.red });
-- Punctuation
hl("@punctuation.bracket", { fg = cp.violet }); -- Brackets, braces, parentheses
hl("@punctuation.delimiter", { fg = cp.violet }); -- Delimiters (commas, colons, ...)
hl("@punctuation.special", { fg = cp.violet }); -- Special punctuation
-- Operator 
hl("@operator", { fg = cp.agneta });
-- -- util
hl("@error", { fg = cp.error });
hl("@none", { fg = cp.purple });
--------------
---- util ----
--------------
--------------
-- spelling --
--------------
hl("SpellBad", { undercurl = true, sp = cp.error });
hl("SpellCap", { undercurl = true, sp = cp.warning });
-- TODO: SpellLocal, SpellRare
------------
-- status --
------------
hl("Error", { fg = cp.error });
hl("ErrorMsg", { fg = cp.error });
hl("DiagnosticError", { fg = cp.error });

hl("Warn", { fg = cp.warn });
hl("WarningMsg", { fg = cp.warn });
hl("DiagnosticWarn", { fg = cp.warn });

hl("Info", { fg = cp.info });
hl("DiagnosticInfo", { fg = cp.info });
---------
-- git --
---------
hl("GitAdd", { fg = cp.util_lv1, bold = true });
hl("GitMod", { fg = cp.util_lv2, bold = true });
hl("GitRem", { fg = cp.util_lv3, bold = true });
------------------
-- status lines --
------------------
-- nvim builtin
hl("StatusLine", { bg = cp.black_dark, fg = cp.white });
hl("TabLineFill", { bg = cp.black_dark });
hl("TabLineSel", { bg = cp.black_dimm, fg = cp.magneta, bold = true });
hl("TabLine", { bg = cp.black_dark, fg = cp.violet });
-- lualine
hl("LL_N_A", { bg = cp.blue, fg = cp.bg_solid, bold = true });
hl("LL_N_B", { fg = cp.violet, bold = true });
hl("LL_N_C", { fg = cp.violet, bold = true });

hl("LL_I_A", { bg = cp.green, fg = cp.bg_solid, bold = true });
hl("LL_I_B", { fg = cp.violet, bold = true });
hl("LL_I_C", { fg = cp.violet, bold = true });

hl("LL_V_A", { bg = cp.yellow, fg = cp.bg_solid, bold = true });
hl("LL_V_B", { fg = cp.violet, bold = true });
hl("LL_V_C", { fg = cp.violet, bold = true });

hl("LL_R_A", { bg = cp.pink, fg = cp.bg_solid, bold = true });
hl("LL_R_B", { fg = cp.violet, bold = true });
hl("LL_R_C", { fg = cp.violet, bold = true });

hl("LL_C_A", { bg = cp.violet, fg = cp.bg_solid, bold = true });
hl("LL_C_B", { fg = cp.violet, bold = true });
hl("LL_C_C", { fg = cp.violet, bold = true });

hl("LL_X_A", { bg = cp.purple, fg = cp.bg_solid, bold = true });
hl("LL_X_B", { fg = cp.violet, bold = true });
hl("LL_X_C", { fg = cp.violet, bold = true });
---------------
-- which-key --
---------------
hl("WhichKey", { fg = cp.magneta, bold = true });
-- hl("WhichKeyBorder", { bg = cp.red });
hl("WhichKeyDesc", { fg = cp.purple });
hl("WhichKeyGroup", { fg = cp.cyan });
-- hl("WhichKeyIconGrey", { bg = cp.red });
-- hl("WhichKeyTitle", { bg = cp.red });
hl("WhichKeyNormal", { bg = cp.black_shadow });
-----------------
-- indentation --
-----------------
-- TODO: do the indentation highlights group (only if you decide to use indent plugin)
hl("Indent_A", { bg = cp.magneta });
hl("Indent_B", { bg = cp.magneta });
hl("Indent_C", { bg = cp.magneta });
hl("Indent_D", { bg = cp.magneta });
hl("Indent_E", { bg = cp.magneta });
hl("Indent_F", { bg = cp.magneta });
hl("Indent_G", { bg = cp.magneta });

--[[
hl("@conceal", { fg = cp.white }); -- Placeholder characters
]]--

return cp;
