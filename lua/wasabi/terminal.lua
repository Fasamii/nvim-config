local function term_open(height)
	height = height or 20;
	vim.cmd("botright new");
	vim.cmd("resize " .. height);
	vim.cmd("terminal");
	vim.wo.number = false;
	vim.wo.relativenumber = false;
	vim.wo.signcolumn = "no";
	vim.cmd("startinsert");
end

local function term_close()
	local buf = vim.api.nvim_get_current_buf();
	if vim.bo[buf].buftype == "terminal" then
		vim.cmd("bdelete!");
	end
end

local function term_toggle()
	local buf = vim.api.nvim_get_current_buf();
	if vim.bo[buf].buftype == "terminal" then
		term_close();
	else
		term_open(20);
	end
end

local move = {};

require("wasabi.keymaps").term(term_toggle);
