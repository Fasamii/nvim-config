local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim";
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git";
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath });
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {});
		vim.fn.getchar();
		os.exit(1);
	end;
end;
vim.opt.rtp:prepend(lazypath);

require("lazy").setup({
	checker = {
		enabled = false,
		notify = true,
	},
	change_detection = {
		notify = false,
	},

	spec = {
		{ import = "wasabi.plugins.dev-icons", enabled = true },
		{ import = "wasabi.plugins.bottom-bar", enabled = true },
		{ import = "wasabi.plugins.scrollbar", enabled = true },
		{ import = "wasabi.plugins.lsp", enabled = true },
		{ import = "beta.startup-screen", enabled = true },
		{ import = "wasabi.plugins.which-key", enabled = true },
		{ import = "beta.telescope", enabled = true },
		{ import = "beta.same-highlight", enabled = true },
		{ import = "beta.treesitter", enabled = true },
		{ import = "beta.highlight-colors", enabled = true },
		{ import = "beta.autopairs", enabled = true },
		{ import = "beta.completition", enabled = true },
		{ import = "beta.labels", enabled = true },
		{ import = "beta.notifications", enabled = true },
		{ import = "beta.peek-line", enabled = true },
		{ import = "wasabi.plugins.mistakes-detector", enabled = true },
		{ import = "beta.session", enabled = true },
		{ import = "beta.undo-tree", enabled = true },
		{ import = "beta.trailspace", enabled = true },
	},
});
