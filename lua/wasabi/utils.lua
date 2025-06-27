local M = {};

function M.notify(msg, log_lvl, file)
	local ok, fidget = pcall(require, "fidget");
	if file then
		msg = "[" .. file .. "] " .. msg;
	end
	if ok then
		fidget.notify(msg, log_lvl);
	else
		vim.notify(msg, log_lvl);
	end
end

return M;
