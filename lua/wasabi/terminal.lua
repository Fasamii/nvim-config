local function term_open(side, size)
	side = side or "bottom";

	if side == "bottom" or side == "top" then
		size = size or 20;
	else
		size = size or 70;
	end


	if side == "left" then
		vim.cmd("topleft vnew")
		vim.cmd("vertical resize " .. size)
	elseif side == "right" then
		vim.cmd("botright vnew")
		vim.cmd("vertical resize " .. size)
	elseif side == "top" then
		vim.cmd("topleft new")
		vim.cmd("resize " .. size)
	else -- bottom (default)
		vim.cmd("botright new")
		vim.cmd("resize " .. size)
	end

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

local function term_toggle(side, size)
	local buf = vim.api.nvim_get_current_buf();
	if vim.bo[buf].buftype == "terminal" then
		term_close();
	else
		term_open(side, size);
	end
end

require("wasabi.keymaps").term(term_toggle);
