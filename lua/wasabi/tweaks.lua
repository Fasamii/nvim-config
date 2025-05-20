-- removes terminal padding (kitty) --
if vim.env.TERM == "xterm-kitty" then
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			vim.fn.system({
				"kitty",
				"@",
				"set-spacing",
				"padding=0",
				--"margin=0",
			});
		end,
	});

	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			vim.fn.system({
				"kitty",
				"@",
				"set-spacing",
				"padding=default",
				"margin=default",
			});
		end,
	});
end;
