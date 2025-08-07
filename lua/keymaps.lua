local M = {};

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yank",
	group = vim.api.nvim_create_augroup("Kickstart-highlihgt-yank", { clear = true, }),
	callback = function()
		vim.highlight.on_yank();
	end
});

vim.keymap.set("v", ">", ">gv", { desc = "indent right without removing highlight" });
vim.keymap.set("v", "<", "<gv", { desc = "indent left without removing highlight" });

-- vim.keymap.set("v", "<leader>gc", "<leader>gcgv", { desc = "toggle comment" });

-- quality of life
vim.keymap.set("v", "K", ":m '<-2<CR>gv-gv", { desc = "moves lines down in visual mode" });
vim.keymap.set("v", "J", ":m '>+1<CR>gv-gv", { desc = "moves lines down in visual mode" });

-- simplifying
vim.keymap.set("n", "<leader>p", "\"+p", { desc = "paste from system clipboard" });
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "copy to system clipboard" });

vim.keymap.set("n", "dr", "0D", { desc = "delete line without new line char" });

vim.keymap.set("n", "<leader>br", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word cursor is on globally" });


-- tabs
vim.keymap.set("n", "<leader>wn", "<cmd>tabnew<CR>", { desc = "create new tab" });
vim.keymap.set("n", "<leader>wd", "<cmd>tabclose<CR>", { desc = "close current tab" });
vim.keymap.set("n", "<leader>wl", "<cmd>tabn<CR>", { desc = "next tab" });
vim.keymap.set("n", "<leader>wh", "<cmd>tabp<CR>", { desc = "prev tab" });

-- split
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" });
vim.keymap.set("n", "<leader>sp", "<C-w>s", { desc = "split window horizontaly" });
vim.keymap.set("n", "<leader>sd", "<cmd>close<CR>", { desc = "close current split" });
vim.keymap.set("n", "<leader>sh", "<C-w>h", { desc = "Move to left split" });
vim.keymap.set("n", "<leader>sj", "<C-w>j", { desc = "Move to bottom split" });
vim.keymap.set("n", "<leader>sk", "<C-w>k", { desc = "Move to upper split" });
vim.keymap.set("n", "<leader>sl", "<C-w>l", { desc = "Move to right split" });

vim.keymap.set("n", "<leader>srh", "<C-w>>", { desc = "resize split window (left)" });
vim.keymap.set("n", "<leader>srl", "<C-w><", { desc = "resize split window (right)" });
vim.keymap.set("n", "<leader>srk", "<C-w>+", { desc = "resize split window (up)" });
vim.keymap.set("n", "<leader>srj", "<C-w>-", { desc = "resize split window (down)" });
vim.keymap.set("n", "<leader>sr=", "<C-w>=", { desc = "resize split window (left)" });

vim.keymap.set("n", "<leader>fo", vim.cmd.Ex, { desc = "open file explorer" });
vim.keymap.set("n", "<leader>fs", "<cmd>Lexplore<CR>", { desc = "open side version of netrw" });

function M.spell(toggle, suggest)
	vim.keymap.set("n", "zz", toggle, { noremap = true, silent = true, desc = "Toggle spell checking" });
	vim.keymap.set("n", "zn", function() vim.cmd("normal! ]s") end,
		{ noremap = true, silent = true, desc = "Next misspelled word" });
	vim.keymap.set("n", "zp", function() vim.cmd("normal! [s") end,
		{ noremap = true, silent = true, desc = "Previous misspelled word" });
	vim.keymap.set("n", "zr", function() vim.cmd("normal! zg") end,
		{ noremap = true, silent = true, desc = "Add word to dictionary" });
	vim.keymap.set("n", "zw", function() vim.cmd("normal! zw") end,
		{ noremap = true, silent = true, desc = "Mark word as incorrect" });
	vim.keymap.set("n", "zs", suggest,
		{ noremap = true, silent = true, nowait = true, desc = "Show spelling suggestions" });
end

function M.telescope()
	vim.keymap.set("n", "<leader>fp", "<cmd>Telescope find_files<CR>", { desc = "Find Files" });
	vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Find Files" });
	vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find Grep" });
	vim.keymap.set("n", "<leader>fa", "<cmd>Telescope find_files cwd=$HOME <CR>", { desc = "Find Global" });
	vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find Help" });
end

function M.tags(pick)
	vim.keymap.set("n", "<leader>tl", "<cmd>TodoTelescope<cr>", { desc = "list all labels" });
	vim.keymap.set("n", "<leader>tfl", "<cmd>TodoTelescope keywords=FIX,FIXME,BUG,FIXIT,ISSUE,ERR<cr>",
		{ desc = "list all FIXME labels" });
	vim.keymap.set("n", "<leader>ttl", "<cmd>TodoTelescope keywords=TODO,LATER<cr>", { desc = "list all TODO labels" });
	vim.keymap.set("n", "<leader>twl", "<cmd>TodoTelescope keywords=WARN,WARNING,XXX<cr>",
		{ desc = "list all WARN labels" });
	vim.keymap.set("n", "<leader>til", "<cmd>TodoTelescope keywords=NOTE,INFO<cr>", { desc = "list all NOTE labels" });
	vim.keymap.set("n", "<leader>tol", "<cmd>TodoTelescope keywords=PERF,OPTIM,PERFORMANCE,OPTIMIZE<cr>",
		{ desc = "list all PERF labels" });
	vim.keymap.set("n", "<leader>tel", "<cmd>TodoTelescope keywords=TEST,TESTING,PASSED,FAILED<cr>",
		{ desc = "list all TEST labels" });

	vim.keymap.set("n", "<leader>tn", function() require("todo-comments").jump_next() end, { desc = "Next label" });
	vim.keymap.set("n", "<leader>tp", function() require("todo-comments").jump_prev() end, { desc = "Previous label" });

	vim.keymap.set("n", "<leader>tfn",
		function() require("todo-comments").jump_next({ keywords = { "FIX", "FIXME", "BUG", "FIXIT", "ISSUE", "ERR" } }) end,
		{ desc = "Next FIXME label" });
	vim.keymap.set("n", "<leader>tfp",
		function() require("todo-comments").jump_prev({ keywords = { "FIX", "FIXME", "BUG", "FIXIT", "ISSUE", "ERR" } }) end,
		{ desc = "Prev FIXME label" });

	vim.keymap.set("n", "<leader>ttn",
		function() require("todo-comments").jump_next({ keywords = { "TODO", "LATER" } }) end,
		{ desc = "Next TODO label" });
	vim.keymap.set("n", "<leader>ttp",
		function() require("todo-comments").jump_prev({ keywords = { "TODO", "LATER" } }) end,
		{ desc = "Prev TODO label" });

	vim.keymap.set("n", "<leader>twn",
		function() require("todo-comments").jump_next({ keywords = { "WARN", "WARNING", "XXX" } }) end,
		{ desc = "Next WARN label" });
	vim.keymap.set("n", "<leader>twp",
		function() require("todo-comments").jump_prev({ keywords = { "WARN", "WARNING", "XXX" } }) end,
		{ desc = "Prev WARN label" });

	vim.keymap.set("n", "<leader>tin",
		function() require("todo-comments").jump_next({ keywords = { "NOTE", "INFO" } }) end,
		{ desc = "Next NOTE label" });
	vim.keymap.set("n", "<leader>tip",
		function() require("todo-comments").jump_prev({ keywords = { "NOTE", "INFO" } }) end,
		{ desc = "Prev NOTE label" });

	vim.keymap.set("n", "<leader>ton",
		function() require("todo-comments").jump_next({ keywords = { "PERF", "OPTIM", "PERFORMANCE", "OPTIMIZE" } }) end,
		{ desc = "Next PERF label" });
	vim.keymap.set("n", "<leader>top",
		function() require("todo-comments").jump_prev({ keywords = { "PERF", "OPTIM", "PERFORMANCE", "OPTIMIZE" } }) end,
		{ desc = "Prev PERF label" });

	vim.keymap.set("n", "<leader>ten",
		function() require("todo-comments").jump_next({ keywords = { "TEST", "TESTING", "PASSED", "FAILED" } }) end,
		{ desc = "Next TEST label" });
	vim.keymap.set("n", "<leader>tep",
		function() require("todo-comments").jump_prev({ keywords = { "TEST", "TESTING", "PASSED", "FAILED" } }) end,
		{ desc = "Prev TEST label" });
end

function M.lsp()
	vim.keymap.set("n", "ge", vim.diagnostic.open_float, { desc = "open lsp diagnostics" });
	vim.keymap.set("n", "gi", vim.lsp.buf.hover, { desc = "show hover info" });

	vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, { desc = "Format file" });
	vim.keymap.set("n", "<leader>lh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
		{ desc = "Toggle inlay hints" })

	-- TODO: change that keymaps or review these
	vim.keymap.set("n", "<leader>fd", vim.lsp.buf.definition,
		{ desc = "go to definition" });
	vim.keymap.set("n", "<leader>fu", vim.lsp.buf.references, { desc = "show references" });
	vim.keymap.set("n", "<leader>fD", vim.lsp.buf.declaration, { desc = "go to declaration" });
	vim.keymap.set("n", "<leader>fi", vim.lsp.buf.implementation, { desc = "go to implementation" });

	-- TODO: learn what rename is
	-- vim.keymap.set("n", "rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "rename symbol" }))
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code actions" });
end

function M.comment(api)
	-- TODO: make start comment and go to insert mode inside keymap
	vim.keymap.set("n", "<leader>/", function()
		api.toggle.linewise.current()
	end, { desc = "Comment" });

	vim.keymap.set("v", "<leader>/", function()
		local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
		vim.api.nvim_feedkeys(esc, "nx", false)
		api.toggle.linewise(vim.fn.visualmode())
	end, { desc = "Comment selection" });

	vim.keymap.set("n", "<leader>cb", function()
		api.toggle.blockwise.current()
	end, { desc = "Block comment" })

	vim.keymap.set("v", "<leader>cb", function()
		local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
		vim.api.nvim_feedkeys(esc, "nx", false)
		api.toggle.blockwise(vim.fn.visualmode())
	end, { desc = "Block comment selection" })

	vim.keymap.set("n", "<leader>co", function()
		api.insert.linewise.above()
	end, { desc = "Add comment above" })

	vim.keymap.set("n", "<leader>cO", function()
		api.insert.linewise.below()
	end, { desc = "Add comment below" })

	vim.keymap.set("n", "<leader>ca", function()
		api.insert.linewise.eol()
	end, { desc = "Add comment at end of line" })

	vim.keymap.set("n", "<leader>cj", function()
		api.toggle.linewise.current()
		vim.cmd("normal! j")
	end, { desc = "Comment line and move down" })

	vim.keymap.set("n", "<leader>ck", function()
		api.toggle.linewise.current()
		vim.cmd("normal! k")
	end, { desc = "Comment line and move up" })
end

function M.session()
	vim.keymap.set("n", "<leader>rs", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" });
end

return M;
