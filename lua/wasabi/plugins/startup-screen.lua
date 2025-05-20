return {
	"goolord/alpha-nvim",
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local initCwd = vim.loop.cwd();

		local dashboard = require("alpha.themes.dashboard");
		dashboard.file_icons_provider = "devicons";

		dashboard.opts.layout = {
			-- { type = "padding", val = math.floor(vim.o.lines * 0.2) }, -- Adjust vertical centering
		 	-- dashboard.section.header,
			-- { type = "padding", val = (math.floor((vim.o.lines - 11) / 2)) },
			-- dashboard.section.buttons,
		 	-- { type = "padding", val = (vim.o.lines - (math.floor(vim.o.lines - 11) / 2) - 11) },
		 	-- dashboard.section.footer,
			{ type = "padding", val = math.floor((vim.o.lines - 11) / 2), },
			dashboard.section.buttons,
			{ type = "padding", val = vim.o.lines - math.floor((vim.o.lines - 11) / 2) - 11, },
			dashboard.section.footer,
		};

		dashboard.section.buttons.val = {
			dashboard.button( "n", "󰐖  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button( "o", "󰈚  Open file", ":Ex<CR>"),
			dashboard.button( "r", "󰛁  Recent files", ":Telescope oldfiles<CR>"),
			dashboard.button( "f", "󰛂  Find file local", function()
				require("telescope.builtin").find_files({ cwd = initCwd });
			end),
			dashboard.button( "g", "󰛍  Find file global", ":cd $HOME | Telescope find_files<CR>"),
			-- dashboard.button( "s", "󰒔  Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
			-- dashboard.button( "q", "󰅗  Quit NVIM", ":qa<CR>"),
		};

		require("alpha").setup(dashboard.opts);
	end,

}
