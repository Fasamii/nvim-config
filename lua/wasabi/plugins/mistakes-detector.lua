return {
	"m4xshen/hardtime.nvim",
	lazy = false,
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		-- -- Disabling hints
		--
		-- disabled_keys = {
		-- 	["<Up>"] = false, -- Allow <Up> key
		-- 	["<Space>"] = { "n", "x" }, -- Disable <Space> key in normal and visual mode
		-- },
		-- disabled_filetypes = {
		-- 	lazy = false, -- Enable Hardtime in lazy filetype
		-- 	["dapui*"] = false, -- Enable Hardtime in filetype starting with dapui
		-- },
		--
		-- -- Making custom hints
		--
		-- hints = {
		-- 	["k%^"] = {
		-- 		message = function()
		-- 			return "Use - instead of k^" -- return the hint message you want to display
		-- 		end,
		-- 		length = 2,   -- the length of actual key strokes that matches this pattern
		-- 	},
		-- 	["d[tTfF].i"] = {   -- this matches d + {t/T/f/F} + {any character} + i
		-- 		message = function(keys) -- keys is a string of key strokes that matches the pattern
		-- 			return "Use " .. "c" .. keys:sub(2, 3) .. " instead of " .. keys
		-- 			-- example: Use ct( instead of dt(i
		-- 		end,
		-- 		length = 4,
		-- 	},
		-- }
	},
}
