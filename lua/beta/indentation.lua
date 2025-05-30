return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
	config = function()

		local highlight = {
			"iblA",
			"iblB",
			"iblC",
		}

		local hooks = require "ibl.hooks"
		-- create the highlight groups in the highlight setup hook, so they are reset
		-- every time the colorscheme changes
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			-- vim.api.nvim_set_hl(0, "iblA", { bg = "#110100" })
			-- vim.api.nvim_set_hl(0, "iblB", { bg = "#05131d" })
			-- vim.api.nvim_set_hl(0, "iblC", { bg = "#0b171b" })
			vim.api.nvim_set_hl(0, "iblA", { bg = "#100000" })
			vim.api.nvim_set_hl(0, "iblB", { bg = "#031208" })
			vim.api.nvim_set_hl(0, "iblC", { bg = "#081017" })
		end)

		require("ibl").setup {
			indent = { highlight = highlight, char = "" },
			whitespace = {
				highlight = highlight,
				remove_blankline_trail = false,
			},
			scope = { enabled = false }, -- that underline showing what is the scope (buggy) 
		}
	end
}

