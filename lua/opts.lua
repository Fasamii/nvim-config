vim.g.mapleader = " ";
vim.g.maplocalleader = "//";

vim.opt.cursorline = true;

vim.opt.guicursor = "";
vim.opt.number = true;
vim.opt.relativenumber = true;
vim.opt.cmdheight = 0;

vim.opt.colorcolumn = "100";

vim.opt.expandtab = false;
vim.opt.tabstop = 6;
vim.opt.softtabstop = 6;
vim.opt.shiftwidth = 6;
vim.opt.autoindent = true;
vim.opt.smartindent = true;

vim.opt.wrap = true;
vim.opt.scrolloff = 999;
vim.opt.virtualedit = "block";
vim.opt.inccommand = "split"
vim.opt.splitbelow = true;
vim.opt.splitright = true;
vim.opt.signcolumn = "number"; -- TODO: read doc for that

vim.opt.termguicolors = true;
vim.opt.mouse = "a";
vim.g.editorconfig = true; -- TODO: read doc for that

vim.opt.undodir = os.getenv("HOME") .. "/.backup/nvim/undo";
vim.opt.undofile = true;
vim.opt.backupdir = os.getenv("HOME") .. "/.backup/nvim/backup";
vim.opt.backup = true;
vim.opt.directory = os.getenv("HOME") .. "/.backup/nvim/swap";
vim.opt.swapfile = true;

vim.g.netrw_banner = 0;
vim.g.netrw_liststyle = 3;
vim.g.netrw_tree_indentstr = "x ";

-- vim.g.netrw_tree_vert = "x";
vim.g.netrw_winsize = 8;
vim.g.netrw_sort_by = "name";

vim.g.netrw_localcopydircmd = "cp -r";
vim.g.netrw_localrmdir = "rm -r";
vim.g.netrw_fastbrowse = 1; -- 0: disable caching for slower browsing


-- vim.opt.isfname:append("@-@");
-- vim.opt.hlsearch = true;

-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"; -- TODO: move to plugin specific config

vim.opt.updatetime = 50;
vim.diagnostic.config({
	virtual_text = {
		severity = { max = vim.diagnostic.severity.WARN }
	},
	virtual_lines = {
		severity = { min = vim.diagnostic.severity.ERROR }
	},
	signs = false,
	underline = false,
	update_in_insert = false,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "solid",
		source = "always",
		header = "",
		prefix = "",
	},
});

-- TODO: move to debuger specific config
-- vim.fn.sign_define("DapBreakpoint", {
-- 	text = " ",
-- 	texthl = "DapBreakpoint",
-- 	linehl = "",
-- 	numhl = "",
-- });
--
-- vim.fn.sign_define("DapBreakpointCondition", {
-- 	text = " ",
-- 	texthl = "DapBreakpointCondition",
-- 	linehl = "",
-- 	numhl = "",
-- });
--
-- vim.fn.sign_define("DapLogPoint", {
-- 	text = "󰍃 ",
-- 	texthl = "DapLogPoint",
-- 	linehl = "",
-- 	numhl = "",
-- });
--
-- vim.fn.sign_define("DapStopped", {
-- 	text = "╳",
-- 	texthl = "DapStopped",
-- 	linehl = "",
-- 	numhl = "",
-- });
--
-- vim.fn.sign_define("DapBreakpointRejected", {
-- 	text = "╳",
-- 	texthl = "DapBreakpointRejected",
-- 	linehl = "",
-- 	numhl = "",
-- });
