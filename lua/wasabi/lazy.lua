local enabled = true;

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
	end
end
vim.opt.rtp:prepend(lazypath);
vim.g.mapleader = " ";
vim.g.maplocalleader = "\\";

require("lazy").setup({
	spec = {
		{ import = "wasabi.plugins.dev-icons", enabled = enabled },
		{ import = "wasabi.plugins.bottom-bar", enabled = enabled },
		{ import = "wasabi.plugins.scrollbar", enabled = enabled },
		{ import = "wasabi.plugins.startup-screen", enabled = enabled },
		{ import = "wasabi.plugins.which-key", enabled = enabled },
		{ import = "draft.telescope", enabled = true },
		{ import = "draft.treesitter", enabled = true },
		{ import = "draft.colorizer", enabled = true },
		{ import = "draft.lsp", enabled = false },
		{ import = "draft.completition", enabled = false }, -- TODO: requires lsp to work -- can be fixed with if statement in blink sources
	},

});
