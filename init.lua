require("config.remap");
require("config.options");
require("config.plugins");

vim.api.nvim_set_hl(0, "Normal", { bg = "none" });
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" });
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" });

--[[
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.lsp.start({
			name = "clangd",
			cmd = {"/home/fasamii/workspace/download/clangd/clangd_19.1.2/bin/clangd"},
			root_dir = vim.fn.getcwd(),
		});
	end,
});
]]--
