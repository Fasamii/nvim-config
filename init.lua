require("config.remap");
require("config.options");
require("config.plugins");

vim.api.nvim_set_hl(0, "Normal", { bg = "none" });
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" });
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" });

-- trying to remove kitty spacing when entering nvim
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.fn.system({
			"kitty",
			"@",
			"set-spacing",
			"padding=0",
			--"margin=0",
		});
	end,
});
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		vim.fn.system({
			"kitty",
			"@",
			"set-spacing",
			"padding=default",
			"margin=default",
		});
	end,
});
