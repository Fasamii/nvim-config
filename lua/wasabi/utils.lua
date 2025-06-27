local M = {};

function M.notify(msg, log_lvl, file)
	local ok, fidget = pcall(require, "fidget");
	if ok then
		if file then
			fidget.notify("[" .. file .. "] " .. msg, log_lvl);
		else
			fidget.notify(msg, log_lvl);
		end
	else
		if file then
			vim.notify("[" .. file .. "] " .. msg, log_lvl);
		else
			vim.notify(msg, log_lvl);
		end
	end
end

return M;
