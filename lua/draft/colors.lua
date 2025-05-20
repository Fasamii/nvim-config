vim.o.background = "dark";
vim.cmd("highlight clear");
vim.g.colors_name = "sobsob";
local function hl(group, style) vim.api.nvim_set_hl(0, group, style); end;
local colors = {
	wildcharm = {
		white		= "#ffffff",
		white_dimm	=  "#d0d0d0",
		white_dark	=   "#8a8a8a",
		gray		= "#626262",
		gray_dimm	=  "#444444",
		gray_dark	=   "#2e2e2e",
		black		= "none",
		black_solid	= "#000000",
		
		red		= "#ff5f87",
		red_dimm	=  "#d7005f",
		red_dark	=   "#870000",
		green		= "#00d757", -- "example"
		green_black =  "#01b453", -- "example",
		green_dimm	=  "#5faf5f",


	},

	rainbow = {
		white		= "#ffffff",
		white_dark	=  "#c7c7c7",
		gray		= "#505468",
		gray_dark	=  "#363946",
		black		= "none",
		black_solid	= "#000000",
		
		candy 	= "#ff1a44",
		candy_dimm 	=  "#cc002f",
		candy_dark 	=   "#a30026",
		gum		= "#ff0099",
		gum_dimm	=  "#c10081",
		gum_dark	=   "#990065",
		violet	= "#de00ff",
		violet_dimm	=  "#a300c1",
		violet_dark	=   "#800090",
		sea		= "#0066ff",
		sea_dimm	=  "#004ec2",
		sea_dark	=   "#003d99",
		plasma	= "#00e5ff",
		plasma_dimm	=  "#00afc2",
		plasma_dark	=   "#008a99",
		glow		= "#26ff00",
		glow_dimm	=  "#1dc200",
		glow_dark	=   "#179900",
	},
};
local p = colors.rainbow;

-- Normal
hl("Normal", { bg = p.black, fg = p.white });
hl("NormalNC", { bg = p.black, fg = p.white_dark });
-- Side
hl("LineNr", { bg = p.black, fg = p.gray_dark});
hl("NonText", { bg = p.black, fg = p.gray_dark });

-- Basic's
hl("@comment", { fg = p.white_dark }); -- comments
hl("@error", { bg = p.candy }); -- Syntax/parser errors
hl("@none", { bg = p.glow }); -- No highlight (disable highlighting)
hl("@preproc", { bg = p.plasma }); -- Preprocessor directive's
hl("@define", { bg = p.plasma }); -- Preprocessor definitions
hl("@operator", { fg = p.white }); -- Operators
-- punctuation's
hl("@punctuation.delimiter", { bg = p.gum }); -- Delimiters (commas, colons, ...)
hl("@punctuation.bracket", { bg = p.violet }); -- Brackets, braces, parentheses
hl("@punctuation.special", { bg = p.sea }); -- Special punctuation
-- Literal's
hl("@string", { fg = p.glow }); -- String literals
hl("@string.regex", { fg = p.glow }); -- Regular expressions
hl("@string.escape", { fg = p.glow }); -- Escape sequences
hl("@string.special", { fg = p.glow }); -- Special strings
hl("@character", { bg = p.candy }); -- character literals
hl("@character.special", { bg = p.candy }); -- Special character
hl("@boolean", { bg = p.candy }); -- Boolean literals
hl("@number", { bg = p.sea}); -- Numeric literals
hl("@float",  { bg = p.plasma_dimm }); -- Floating-point literals
-- Keyword's
hl("@keyword", { fg = p.white }); -- Keywords
hl("@keyword.function", { fg = p.white }); -- Function Keyword
hl("@keyword.operator", { fg = p.white }) -- Operator keywords
hl("@keyword.return", { bg = p.glow_dark }); -- Return keyword
hl("@conditional", { bg = p.sea_dark }); -- Conditional keywords
hl("@repeat", { bg = p.candy }); -- Repeat/loop keywords
hl("@debug", { bg = p.candy }); -- Debugging statements 
hl("@include", { bg = p.candy }); -- include keywords
hl("@exception", { bg = p.candy }); -- Exception related keywords
-- Function's
hl("@function", { fg = p.white }); -- Function definitions
hl("@function.builtin", { fg = p.white }); -- Build-in functions
hl("@function.call", { fg = p.white }); -- Function calls
hl("@function.macro", { fg = p.white }); -- Macro functions
hl("@method", { bg = p.glow }); -- Method definitions
hl("@method.call", { bg = p.glow_dimm }); -- Method calls
hl("@constructor", { fg = p.white }); -- Constructor calls and definitions
hl("@parameter", { fg = p.white }); -- Function parameters
-- Types
hl("@type", { fg = p.white }); -- Type definitions and built-ins
hl("@type.builtin", { fg = p.white }); -- Build-in types
hl("@type.qualifier", { bg = p.candy }); -- Type qualifiers
hl("@type.definition", { bg = p.candy }); -- Type definitions 
hl("@storageclass", { bg = p.candy }); -- Storage class modifiers
hl("@field", { bg = p.candy }); -- Object and struct fields
hl("@property", { bg = p.candy }); -- Object properties
-- Identifiers
hl("@variable", { fg = p.white }); -- Variables
hl("@variable.builtin", { fg = p.white }); -- Built-in variables
hl("@constant", { fg = p.white }); -- Constants
hl("@constant.builtin", { fg = p.white }); -- Built-in constants
hl("@constant.macro", { fg = p.white }); -- Macro constants
hl("@namespace", { fg = p.white }); -- Namespaces
hl("@symbol", { fg = p.white }); -- Symbols
-- Text
hl("@text", { fg = p.white }) -- Non-structured text
hl("@text.strong", { fg = p.white }) -- Bold text
hl("@text.emphasis", { fg = p.white }) -- Emphasized text
hl("@text.underline", { fg = p.white }) -- Underlined text
hl("@text.strike", { fg = p.white }) -- Strikethrough text
hl("@text.title", { fg = p.white }) -- Titles
hl("@text.literal", { fg = p.white }) -- Literal or verbatim text
hl("@text.uri", { fg = p.white }) -- URIs (URLs, file paths, etc.)
hl("@text.math", { fg = p.white }) -- Math environments
hl("@text.reference", { fg = p.white }) -- References
hl("@text.environment", { fg = p.white }) -- Text environments
hl("@text.environment.name", { fg = p.white }) -- Text environment names
hl("@text.note", { fg = p.white }) -- Notes
hl("@text.warning", { fg = p.white }) -- Warnings
hl("@text.danger", { fg = p.white }) -- Danger alerts
hl("@text.diff.add", { fg = p.white }) -- Added text (for diffs)
hl("@text.diff.delete", { fg = p.white }) -- Deleted text (for diffs)
-- Tags
hl("tag", { fg = p.white }); -- Tags
hl("tag.attribute", { fg = p.white }); -- HTML tag attributes
hl("tag.delimiter", { fg = p.white }); -- Tag delimiters
-- Conceal
hl("@conceal", { fg = p.white }); -- Placeholder characters
-- Spell (idk how it works)
-- hl("@spell", {}); -- Spell checking
-- hl("@nospell", {}); -- Disable spell checking


vim.cmd("colorscheme wildcharm");
