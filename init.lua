-- Removes kitty padding if using kitty
if vim.env.TERM == "xterm-kitty" then
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			vim.fn.system({
				"kitty",
				"@",
				"set-spacing",
				"padding=0",
			})
		end,
	})

	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			vim.fn.system({
				"kitty",
				"@",
				"set-spacing",
				"padding=default",
				"margin=default",
			})
		end,
	})
end

vim.pack.add({
	-- Color scheme
	{ src = "https://github.com/Fasamii/sobsob.nvim" },
	-- Basics
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	-- Telescope
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	-- Additional
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	-- session
	{ src = "https://github.com/rmagatti/auto-session" },
	-- Lsp
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	-- quality of life
	{ src = "https://github.com/RRethy/vim-illuminate" },
	{ src = "https://github.com/nacro90/numb.nvim" },
	-- completion
	{ src = "https://github.com/Saghen/blink.cmp" },
	-- markdow
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	-- rust specyfic
	{ src = "https://github.com/mrcjkb/rustaceanvim" },
})

vim.cmd.colorscheme("sobsob")

require("opts")
require("keymaps")
require("spell")

require("plugins.bottomline")
require("plugins.treesitter")
require("plugins.gitchanges")
require("plugins.tags")
require("plugins.session")
require("plugins.samesame")
require("numb").setup()
require("plugins.picker")
require("plugins.markdown")

require("mason").setup({
	ui = {
		icons = {
			package_installed = "󱗜",
			package_pending = "󰌴 ",
			package_unsinstalled = "󰅗",
		},
	},
})
require("mason-lspconfig").setup({
	automatic_installation = true,
	ensure_installed = { "lua_ls", "rust_analyzer", "codelldb" },
})
require("plugins.lsp")
vim.lsp.inlay_hint.enable(true)
require("keymaps").lsp()

require("plugins.completion")
