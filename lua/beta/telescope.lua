return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim", },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-tree/nvim-web-devicons", },
	},
	lazy = false,
	opts = {
		path_display = { "smart" },
		defaults = {
			border = true,
			color_devicons = true,
			borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			prompt_prefix = " ",
			layout_strategy = "flex",
			layout_config = {
				flex = { flip_columns = 100 },
				horizontal = {
					mirror = false,
					prompt_position = "bottom",
					preview_width = 0.55,
				},
				vertical = {
					mirror = false,
				},
				width = 0.85,
				height = 0.92,
				preview_cutoff = 120,
			},
			file_ignore_patterns = {
				"^%.git/",
				"^%.git$",
				"node_modules",
				".cache",
				"build",
			},
			vimgrep_arguments = {
				"rg",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
		},
	},
	config = function(_, opts)
		local plugin = require("telescope");
		plugin.load_extension("fzf");
		plugin.setup(opts);
		require("wasabi.keymaps").telescope();
	end
}
