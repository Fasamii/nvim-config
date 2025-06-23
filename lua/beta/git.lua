return {
	{

		"lewis6991/gitsigns.nvim",
		event = "BufReadPre", -- load when a buffer is read
		config = function()
			require("gitsigns").setup {
				-- Enable number‐column highlights
				numhl = true,

				-- Define which highlight groups to use for each hunk type
				signs = {
					add          = { text = "", numhl = "GitSignsAddNr" },
					change       = { text = "", numhl = "GitSignsChangeNr" },
					delete       = { text = "", numhl = "GitSignsDeleteNr" },
					topdelete    = { text = "", numhl = "GitSignsDeleteNr" },
					changedelete = { text = "", numhl = "GitSignsChangeNr" },
					untracked    = { text = "", numhl = "GitSignsAddNr" },
				},

				linehl = false,
				word_diff = false,
			}
		end
	},
}
