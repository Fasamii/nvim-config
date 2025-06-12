local terms = {};

local function term_open(side, size)
	local tab_id = vim.api.nvim_get_current_tabpage();

	side = side or "bottom";
	if side == "right" or side == "left" then
		size = size or 60;
	else
		size = size or 15;
	end

	local term_data = terms[tab_id];
	if term_data and vim.api.nvim_buf_is_valid(term_data.buf) then
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

		local new_buf = vim.api.nvim_get_current_buf()
		vim.cmd("buffer " .. term_data.buf)
		vim.cmd("bdelete " .. new_buf)
	else
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

		vim.cmd("terminal")

		local buf = vim.api.nvim_get_current_buf()

		terms[tab_id] = {
			buf = buf,
			win = vim.api.nvim_get_current_win()
		}

		-- CRITICAL SETTINGS TO PREVENT QUIT ISSUES
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.wo.signcolumn = "no"
		vim.bo[buf].swapfile = false
		vim.bo[buf].buflisted = false
		vim.bo[buf].bufhidden = "hide"

		vim.bo[buf].modified = false -- TODO: check it
	end
	terms[tab_id].win = vim.api.nvim_get_current_win()
	vim.cmd("startinsert")
end

local function term_close()
	local tab_id = vim.api.nvim_get_current_tabpage();
	local term_data = terms[tab_id];

	if term_data and term_data.win and vim.api.nvim_win_is_valid(term_data.win) then
		vim.api.nvim_win_close(term_data.win, false);
		term_data.win = nil;
	end
end

local function term_toggle(side, size)
	local tab_id = vim.api.nvim_get_current_tabpage();
	local term_data = terms[tab_id];

	-- Check if terminal window is currently visible
	if term_data and term_data.win and vim.api.nvim_win_is_valid(term_data.win) then
		term_close()
	else
		term_open(side, size)
	end
end

require("wasabi.keymaps").term(term_toggle);
