return {
  	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
  	config = function()

		-- First, set up hlchunk with custom options for blank lines.
		require("hlchunk").setup({
			blank = {
				enable = true,
				chars = {
					" ",
				},
				style = {
					{ bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("cursorline")), "bg", "gui") },
					{ bg = "#222222", fg = "#222222" },
				},
			}
		})

-- Next, define the custom highlight group for blank lines.
-- Adjust the fg (foreground) and bg (background) values to your desired colors.
vim.api.nvim_set_hl(0, "HlchunkBlank", { fg = "#FF00FF", bg = "#1E1E1E", bold = true })


	end
}
