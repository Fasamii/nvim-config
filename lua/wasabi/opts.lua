vim.g.mapleader = " ";
vim.g.maplocalleader = " ";

vim.opt.guicursor = "";
vim.opt.cursorline = false;
vim.opt.number = true;
vim.opt.relativenumber = true;
vim.opt.cmdheight = 0;

vim.opt.expandtab = false;
vim.opt.tabstop = 6;
vim.opt.softtabstop = 6;
vim.opt.shiftwidth = 6;
vim.opt.autoindent = true; -- Check if you like it
vim.opt.smartindent = true; -- Check if you like it

-- vim.opt.colorcolumn = "100"; -- in case you need that stupid ruler

vim.opt.wrap = true;
vim.opt.scrolloff = 999;
vim.opt.virtualedit = "block";
vim.opt.inccommand = "split"
vim.opt.splitbelow = true;
vim.opt.splitright = true;
vim.opt.signcolumn = "number"; -- column on the left to display diagnostics

vim.opt.termguicolors = true;
vim.opt.mouse = "a";
vim.g.editorconfig = true;

vim.opt.undodir = os.getenv("HOME") .. "/.backup/nvim-undo";
vim.opt.undofile = true;
vim.opt.backupdir = os.getenv("HOME") .. "/.backup/nvim-backup";
vim.opt.backup = false;
vim.opt.directory = os.getenv("HOME") .. "/.backup/nvim-swap";
vim.opt.swapfile = true;

vim.opt.updatetime = 50;
vim.opt.isfname:append("@-@");

vim.opt.hlsearch = true;

vim.diagnostic.config({
	signs = false,
	virtual_text = false,
	virtual_lines = true,
});
