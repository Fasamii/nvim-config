vim.opt.number = true;
vim.opt.relativenumber = true;

vim.opt.expandtab = false;
vim.opt.tabstop = 6;
vim.opt.softtabstop = 6;
vim.opt.shiftwidth = 6;

vim.opt.wrap = true;
vim.opt.scrolloff = 999;

vim.opt.virtualedit = "block";
vim.opt.inccommand = "split"

vim.opt.cmdheight = 0;
vim.opt.splitbelow = true;
vim.opt.splitright = true;
vim.opt.termguicolors = true;

vim.opt.cursorline = false;

vim.diagnostic.config({
	signs = false,
	virtual_text = true,
	virtual_lines = false,
});
