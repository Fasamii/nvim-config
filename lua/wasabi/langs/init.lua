local M = {};

local function get_this_dir()
  local source = debug.getinfo(2, "S").source
  if source:sub(1, 1) == "@" then
    return vim.fn.fnamemodify(source:sub(2), ":h")
  end
end

function M.get_config_files(prefix)
	local notify = require("wasabi.utils").notify;

	local dirs = vim.fn.glob(
		get_this_dir() .. "/*"
	):gsub("[^\n]*init%.lua\n?", "");
	local paths = vim.split(
		dirs,
		'\n',
		{ trimempty = true }
	);

	local configs = {};

	for _, path in ipairs(paths) do
		local name = vim.fn.fnamemodify(path, ":t");
		path = path .. "/" .. prefix .. ".lua";

		if vim.fn.filereadable(path) ~= 1 then
			notify(
				prefix .. " config doesn't exist <" .. path .. ">",
				vim.log.levels.DEBUG,
				"langs/init.lua"
			);
		else
			local ok, config = pcall(dofile, path);
			if not ok then
				notify(
					"failed to get config for <" .. path .. ">",
					vim.log.levels.DEBUG,
					"langs/init.lua"
				);
			else
				configs[name] = config;
			end
		end
	end

	return configs;
end

return M;
